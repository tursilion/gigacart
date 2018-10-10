-- increment works, but it increments too early (so the address is off by 1), and it takes one
-- too many MCs, so doesn't fit just yet.

-- I am currently spacing things along with the GROMCLK... I am not convinced it's really
-- necessary but having both valid and active signals is nice for this spacing.

-- This version removes the extra chip selects but instead supports GROM with NO paging!
-- ROM and GROM pages can safely overlap

-- Note that this version supports NO ROM enable on the flash (and not the 512MB mode either!)
-- It uses a different method for reset (releases on first GROM address write)
-- The GROM is hard-wired to respond at the >8000 slot and is only 256 bytes long, repeating.
-- It maps to the last 256 bytes of the flash (all other bits are '1')

-- this one is not bidirectional on the ROM (output) side
LIBRARY ieee;
USE ieee.std_logic_1164.all;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
USE ieee.numeric_std.all;

ENTITY gigacart IS
	PORT (
		-- TI interface
		ti_adr   : IN STD_ULOGIC_VECTOR (15 DOWNTO 3);	-- (21,17,19,20,22,23,27,28,29,30,31,3,34) 13 bits (8k), TI order, 15 is LSB!
		ti_data  : INOUT STD_ULOGIC_VECTOR (7 DOWNTO 0);-- (9,10,11,12,9,10,11,14) 8 bits, TI order. 7 is LSB!
		ti_we    : IN STD_ULOGIC;			-- (16) write enable (active low)
		ti_rom   : IN STD_ULOGIC;			-- (15) ROM select (active low)
		ti_gsel  : IN STD_ULOGIC;			-- (44) GROM select (Active low)
		ti_gclk	 : IN STD_ULOGIC;			-- (36) GROM clock

		-- flash interface ("out" really means "flash")
		out_adr  : OUT STD_ULOGIC_VECTOR (26 DOWNTO 0);	-- (97,84,49,50,53,54,55,56,58,66,67,69,70,71,72,78,79,98,59,60,65,64,61,80,81,100,99) 27 bits (128MB)
		out_data : IN STD_ULOGIC_VECTOR (7 DOWNTO 0);	-- (86,87,88,89,91,92,93,94) 8 bits
--		out_rom  : OUT STD_ULOGIC;			-- (85) ROM select (active low)
		out_reset: OUT STD_ULOGIC			-- (47) output to hold flash chips in reset at startup
	);
END gigacart;

ARCHITECTURE myarch OF gigacart IS
-- flash chip interface
--	SIGNAL chip    : STD_ULOGIC_VECTOR (1 DOWNTO 0) := "00"; -- 2 bits of chip select
	SIGNAL bounce  : STD_ULOGIC := '0'; -- true to release reset after min 35uS
	SIGNAL dataout : STD_ULOGIC; -- := '0'; -- true when we should enable flash data output

-- rom emulation
	SIGNAL latch   : STD_ULOGIC_VECTOR (13 DOWNTO 0) := "00000000000000";-- 14 bits of latch

-- grom emulation
	SIGNAL grmadr  : unsigned (0 TO 7) := "00000000"; -- 8 bits of GROM mapped address (256 bytes! note inverted order for math)
	SIGNAL grmpage : STD_ULOGIC := '0'; -- single bit - true when page is "100", else false
	SIGNAL gactive : STD_ULOGIC := '0'; -- single bit used to delay gvalid (grom cycle is active)
	SIGNAL gvalid  : STD_ULOGIC := '0'; -- internal register to reuse valid test (we are acting on grom cycle)
BEGIN
	-- determine if GROM data is active by GROM select and internal address match and mode pin
	-- we respond only to the >8000 GROM by setting the single bit true or false when received
	-- ti_adr(14)='1' means address, not data, 
	PROCESS (ALL)
	BEGIN
		if (falling_edge(ti_gclk)) then
			if (ti_gsel='0') THEN
				IF (gactive = '1') THEN
					gvalid <= '1';
				ELSE
					gactive <= '1';
				END IF;
--			ELSE
--				gvalid <= '0';
--				gactive <= '0';
			END IF;
			IF (ti_gsel = '1') THEN
--				gvalid <= '0'; -- this slower teardown is important for some reason...
--				gactive <= '0';
				IF (gvalid = '0') THEN
					gactive <= '0';
				ELSE
					gvalid <= '0';
				END IF;
			END IF;
		END IF;
	END PROCESS;

	-- check whether we should gate flash data onto the TI data bus
	-- !WE is delayed on our hardware... so there may be brief conflict
	-- Could we delay? Without a clock?
	dataout <= ti_we when ((gvalid = '1' AND grmpage='1' AND ti_gsel='0' AND ti_adr(14)='0') OR ti_rom = '0') ELSE ('0');

	-- output data from ROM on read, otherwise tristate data bus (bit inversion)
	ti_data(0) <= out_data(7) WHEN (dataout = '1') ELSE ('Z'); -- MSB
	ti_data(1) <= out_data(6) WHEN (dataout = '1') ELSE ('Z');
	ti_data(2) <= out_data(5) WHEN (dataout = '1') ELSE ('Z');
	ti_data(3) <= out_data(4) WHEN (dataout = '1') ELSE ('Z');
	ti_data(4) <= out_data(3) WHEN (dataout = '1') ELSE ('Z');
	ti_data(5) <= out_data(2) WHEN (dataout = '1') ELSE ('Z');
	ti_data(6) <= out_data(1) WHEN (dataout = '1') ELSE ('Z');
	ti_data(7) <= out_data(0) WHEN (dataout = '1') ELSE ('Z'); -- LSB

	-- handle the ROM latch on write
	PROCESS (ALL)
	BEGIN
		-- capture on rising edge of WE (if ROM is active)
		IF (rising_edge(ti_we)) THEN
			IF (ti_rom='0') THEN
				-- we dont capture the TI lsb because it ALWAYS
				-- changes due to the 16->8 bit multiplexer
				-- remember TI bit order - 0 is MSB
--				latch(11) <= ti_adr(3); -- MSB
--				latch(10) <= ti_adr(4);
--				latch(9) <= ti_adr(5);
--				latch(8) <= ti_adr(6);
--				latch(7) <= ti_adr(7);
--				latch(6) <= ti_adr(8);
--				latch(5) <= ti_adr(9);
--				latch(4) <= ti_adr(10);
--				latch(3) <= ti_adr(11);
--				latch(2) <= ti_adr(12);
--				latch(1) <= ti_adr(13);
--				latch(0) <= ti_adr(14); -- LSB
	
				-- two extra bits come from the data bus
--				latch(13) <= ti_data(6); -- MSB
--				latch(12) <= ti_data(7); -- LSB
	
				-- two bits of chip select (for 512MB mode over 4 chips)
	--			chip(1) <= ti_data(4); -- MSB
	--			chip(0) <= ti_data(5); -- LSB
			END IF;
		END IF;
	END PROCESS;

	-- handle the GROM address write (two bytes)
	PROCESS (ALL)
	BEGIN
		-- ti_adr(14)='1' means address event, ti_we='0' means write
		-- cart hardware means that the WE falling edge is always after GSEL falls
		-- this is not necessarily true in the console (in fact it isn't)
 
		-- So, GSEL falling edge, mode is address and write is active to write address
		-- Addresses are written MSB first, addresses are shifted up as written
		-- We don't have enough logic space to check the write address vs read address,
		-- so writes to either space would trigger here. The OS shouldn't do any though.
		-- Technically, also, GROMs should auto-increment their address bus. However,
		-- the console ROM ALWAYS writes the GROM address and does not rely on this
		-- auto-increment (strictly, the address readback assumes it). Since there will
		-- be real GROMs in the system to deal with that part, we can skip all that circuitry.
		IF (rising_edge(gvalid)) THEN
			IF (ti_we='0' AND ti_adr(14)='1') THEN
				-- the limited bits available makes this a little more complex...
				-- grmpage is true for '100'. Nothing else to shift up
				grmpage <= (grmadr(0)) AND (NOT grmadr(1)) AND (NOT grmadr(2));
	
				-- writing least significant byte, we need to cache this
				-- read the new byte into the LSB (no inversion here)
				-- hopefully the data bus is stable!
				-- we need all the bits, otherwise we can't calculate the grmpage...
				grmadr(0) <= ti_data(0); -- MSB
				grmadr(1) <= ti_data(1);
				grmadr(2) <= ti_data(2);
				grmadr(3) <= ti_data(3);
				grmadr(4) <= ti_data(4);
				grmadr(5) <= ti_data(5);
				grmadr(6) <= ti_data(6);
				grmadr(7) <= ti_data(7); -- LSB
	
				-- while we're here, the first GROM address write is about 139 cycles
				-- or 46uS from reset, which meets the reset requirement of 35uS
				-- and also actually happens on 99/4 and v2.2 machines, unlike ROMS.
				-- this releases the reset line to the flash chip. We're still a long
				-- time from first access, easily meeting the 200ns post-reset requirement.
				bounce <= '1';
			ELSIF ti_adr(14)='0' THEN
				grmadr <= grmadr + 1;
			END IF;
		END IF;
-- TODO: enabling this breaks everything - GROM doesn't work at all anymore
--		IF (falling_edge(gactive)) THEN
--			grmadr <= grmadr + 1;
--		ELSE
--			grmadr <= grmadr;
--		END IF;
	END PROCESS;

	-- handle addresses to the ROM chip (which is always enabled)
	out_adr(26 DOWNTO 13) <= (others => '1') WHEN (gvalid = '1') ELSE latch(13 DOWNTO 0) ;

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
	out_adr(0) <= grmadr(7) WHEN (gvalid = '1') ELSE ti_adr(15);	-- LSB

	-- flash control lines
	out_reset <= bounce;
END myarch;

