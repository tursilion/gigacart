-- This version removes the extra chip selects but instead supports GROM with NO paging!
-- GROM starts on the last page and gives us only 1k!!
-- ROM and GROM pages can safely overlap

-- Note that this version supports NO ROM enable on the flash (and not the 512MB mode either!)
-- It uses a different method for reset (releases on first !ROMS pulse)
-- The GROM is hard-wired to respond at the >8000 slot and is only 256 bytes long, repeating.
-- It maps to the last 256 bytes of the flash (all other bits are '1')
-- There's only one free output in the CPLD, it's full. Even adding the ROM output needs 2.

-- all values use bit 0 as the LSB, not the TI way
-- this one is not bidirectional on the ROM (output) side
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

ENTITY gigacart IS
	PORT (
		-- TI interface
		ti_adr   : IN STD_ULOGIC_VECTOR (15 DOWNTO 3);	-- (21,17,19,20,22,23,27,28,29,30,31,3,34) 13 bits (8k), TI order, 15 is LSB!
		ti_data  : INOUT STD_ULOGIC_VECTOR (7 DOWNTO 0);-- (9,10,11,12,9,10,11,14) 8 bits, TI order. 7 is LSB!
		ti_we    : IN STD_ULOGIC;			-- (16) write enable (active low)
		ti_rom   : IN STD_ULOGIC;			-- (15) ROM select (active low)
		ti_gsel  : IN STD_ULOGIC;			-- GROM select (Active low)

		-- flash interface
		out_adr  : OUT STD_ULOGIC_VECTOR (26 DOWNTO 0);	-- (97,84,49,50,53,54,55,56,58,66,67,69,70,71,72,78,79,98,59,60,65,64,61,80,81,100,99) 27 bits (128MB)
		out_data : IN STD_ULOGIC_VECTOR (7 DOWNTO 0);	-- (86,87,88,89,91,92,93,94) 8 bits
--		out_rom  : OUT STD_ULOGIC;			-- (85) ROM select (active low)
		out_reset: OUT STD_ULOGIC			-- (47) output to hold flash chips in reset at startup
	);
END gigacart;

ARCHITECTURE myarch OF gigacart IS
	SIGNAL latch   : STD_ULOGIC_VECTOR (13 DOWNTO 0) := "00000000000000";-- 14 bits of latch
	SIGNAL chip    : STD_ULOGIC_VECTOR (1 DOWNTO 0) := "00"; -- 2 bits of chip select
	SIGNAL bounce  : STD_ULOGIC := '0'; -- true to release reset on first ROMS access
	SIGNAL grmadr  : unsigned (0 TO 7) := "00000000"; -- 8 bits of GROM incrementing address (256 bytes! note inverted order for math)
	SIGNAL grmpage : STD_LOGIC := '0'; -- single bit - true when page is "100", else false
	SIGNAL grminc  : STD_ULOGIC := '0'; -- internal register to flag a post increment is needed
	SIGNAL gvalid  : STD_ULOGIC;	-- internal register to reuse valid test
BEGIN
	-- determine if GROM data is active by GROM select and internal address match and mode pin
	-- we respond only to the >8000 GROM by setting the single bit true or false when received
	gvalid <= (NOT ti_gsel) AND grmpage AND (NOT ti_adr(14));	-- ti_adr(14)='1' means address, not data

	-- output data from ROM on read, otherwise tristate data bus (bit inversion)
	ti_data(0) <= out_data(7) WHEN ((ti_rom = '0' OR gvalid = '1') AND ti_we = '1') ELSE ('Z'); -- MSB
	ti_data(1) <= out_data(6) WHEN ((ti_rom = '0' OR gvalid = '1') AND ti_we = '1') ELSE ('Z');
	ti_data(2) <= out_data(5) WHEN ((ti_rom = '0' OR gvalid = '1') AND ti_we = '1') ELSE ('Z');
	ti_data(3) <= out_data(4) WHEN ((ti_rom = '0' OR gvalid = '1') AND ti_we = '1') ELSE ('Z');
	ti_data(4) <= out_data(3) WHEN ((ti_rom = '0' OR gvalid = '1') AND ti_we = '1') ELSE ('Z');
	ti_data(5) <= out_data(2) WHEN ((ti_rom = '0' OR gvalid = '1') AND ti_we = '1') ELSE ('Z');
	ti_data(6) <= out_data(1) WHEN ((ti_rom = '0' OR gvalid = '1') AND ti_we = '1') ELSE ('Z');
	ti_data(7) <= out_data(0) WHEN ((ti_rom = '0' OR gvalid = '1') AND ti_we = '1') ELSE ('Z'); -- LSB

	-- numerous signals to handle on write
	-- we can't use blocks and guards... and whatever, cause
	-- we should use the rising edge process concept
	PROCESS (ti_we)
	BEGIN
		-- capture on rising edge of WE (if ROM is active)
		if (ti_rom='0' AND ti_we'EVENT AND ti_we='1') THEN
			-- we don�t capture the TI lsb because it ALWAYS
			-- changes due to the 16->8 bit multiplexer
			-- remember TI bit order - 0 is MSB
			latch(11) <= ti_adr(3); -- MSB
			latch(10) <= ti_adr(4);
			latch(9) <= ti_adr(5);
			latch(8) <= ti_adr(6);
			latch(7) <= ti_adr(7);
			latch(6) <= ti_adr(8);
			latch(5) <= ti_adr(9);
			latch(4) <= ti_adr(10);
			latch(3) <= ti_adr(11);
			latch(2) <= ti_adr(12);
			latch(1) <= ti_adr(13);
			latch(0) <= ti_adr(14); -- LSB

			latch(13) <= ti_data(6); -- MSB
			latch(12) <= ti_data(7); -- LSB

			-- two bits of chip select
			chip(1) <= ti_data(4); -- MSB
			chip(0) <= ti_data(5); -- LSB
		END IF;
	END PROCESS;

	-- handle the GROM address register writes
	-- ti_adr(14)='1' means address event, ti_we='0' means write
	PROCESS (ti_gsel)
	BEGIN
		-- So, GSEL falling edge, mode is address and write is active
		if (ti_gsel'EVENT AND ti_gsel='0' AND ti_adr(14)='1' AND ti_we='0') THEN
			-- 0 is MSB of adr
			-- the limited bits available makes this a little more complex...
			-- grmpage is true for '100'. Nothing else to shift up
			grmpage <= grmadr(0) AND (NOT grmadr(1)) AND (NOT grmadr(2));

			-- read the new byte into the LSB (no inversion here)
			-- hopefully the data bus is stable!
			-- we need all the bits, otherwise we can't calculate the grmpage...
			grmadr(0) <= ti_data(0);
			grmadr(1) <= ti_data(1);
			grmadr(2) <= ti_data(2);
			grmadr(3) <= ti_data(3);
			grmadr(4) <= ti_data(4);
			grmadr(5) <= ti_data(5);
			grmadr(6) <= ti_data(6);
			grmadr(7) <= ti_data(7);
		END IF;

		-- set increment flag on falling edge
		if (ti_gsel'EVENT and ti_gsel='0') THEN
			grminc <= NOT ti_adr(14);
		end if;

		-- check increment flag on rising edge
		IF (ti_gsel'event AND ti_gsel='1' AND grminc='1') THEN
			-- handle GROM address increment
			grmadr <= grmadr + 1;
			grminc <= '0';
		END IF;
	END PROCESS;

	-- handle the reset timer - we just come alive on first ROMS access
	PROCESS (ti_rom)
	BEGIN
		if (ti_rom'EVENT AND ti_rom='0') THEN
			bounce <= '1';
		end if;
	END PROCESS;

	-- handle addresses and select to the ROM chip
	out_adr(26 DOWNTO 13) <= ("11111111111111") WHEN (gvalid = '1') ELSE latch(13 DOWNTO 0);

	-- need to invert the rest... (8k of address space)
	out_adr(12) <= gvalid OR ti_adr(3);
	out_adr(11) <= gvalid OR ti_adr(4);
	out_adr(10) <= gvalid OR ti_adr(5);
	out_adr(9) <= gvalid OR ti_adr(6);
	out_adr(8) <= gvalid OR ti_adr(7);
	out_adr(7) <= grmadr(0) WHEN (gvalid = '1') ELSE ti_adr(8);
	out_adr(6) <= grmadr(1) WHEN (gvalid = '1') ELSE ti_adr(9);
	out_adr(5) <= grmadr(2) WHEN (gvalid = '1') ELSE ti_adr(10);
	out_adr(4) <= grmadr(3) WHEN (gvalid = '1') ELSE ti_adr(11);
	out_adr(3) <= grmadr(4) WHEN (gvalid = '1') ELSE ti_adr(12);
	out_adr(2) <= grmadr(5) WHEN (gvalid = '1') ELSE ti_adr(13);
	out_adr(1) <= grmadr(6) WHEN (gvalid = '1') ELSE ti_adr(14);
	out_adr(0) <= grmadr(7) WHEN (gvalid = '1') ELSE ti_adr(15);

	-- flash control lines
--	out_rom <= ti_rom AND (NOT gvalid);
	out_reset <= bounce;
END myarch;

