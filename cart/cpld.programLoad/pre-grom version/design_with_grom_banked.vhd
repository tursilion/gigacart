-- This version removes the extra chip selects but instead supports GROM paging
-- GROM starts on the last page and banks on 64k blocks (though only 40k is available)
-- ROM and GROM pages can safely overlap

-- untested - this doesn't fit in my CPLD. Pin ti_gsel was never allocated a pin on the constraint editor either.
-- It uses 91 logic functions, and my limit was 64. No big deal!

-- all values use bit 0 as the LSB, not the TI way
-- this one is not bidirectional on the ROM (output) side
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

ENTITY gigacart IS
	PORT (
		ti_adr : IN STD_ULOGIC_VECTOR (15 DOWNTO 3);	-- (21,17,19,20,22,23,27,28,29,30,31,3,34) 13 bits (8k), TI order, 15 is LSB!
		ti_data: INOUT STD_ULOGIC_VECTOR (7 DOWNTO 0);	-- (9,10,11,12,9,10,11,14) 8 bits, TI order. 7 is LSB!
		ti_we: IN STD_ULOGIC;				-- (16) write enable (active low)
		ti_rom: IN STD_ULOGIC;				-- (15) ROM select (active low)

		ti_gsel: IN STD_ULOGIC;				-- GROM select (Active low)

		out_adr: OUT STD_ULOGIC_VECTOR (26 DOWNTO 0);	-- (97,84,49,50,53,54,55,56,58,66,67,69,70,71,72,78,79,98,59,60,65,64,61,80,81,100,99) 27 bits (128MB)
		out_data: IN STD_ULOGIC_VECTOR (7 DOWNTO 0);	-- (86,87,88,89,91,92,93,94) 8 bits
		out_rom: OUT STD_ULOGIC;			-- (85) ROM select (active low)
		out_we: OUT STD_ULOGIC;				-- (37) write enable (active low)
		out_reset: OUT STD_ULOGIC;			-- (47) output to hold flash chips in reset at startup
		out_rst2: OUT STD_ULOGIC  -- dummy for prototype only
	);
END gigacart;

ARCHITECTURE myarch OF gigacart IS
	SIGNAL latch : STD_ULOGIC_VECTOR (13 DOWNTO 0) := "00000000000000";-- 14 bits of latch
	SIGNAL bounce : unsigned (0 TO 6) := "0000000"; -- bits of delay (7 bits = 128 cycles)
	SIGNAL grmpage : STD_ULOGIC_VECTOR (2 DOWNTO 0) := "000"; -- 3 bits of GROM address match
	SIGNAL grmadr : unsigned (0 TO 12) := "0000000000000"; -- 13 bits of GROM incrementing address (note inverted order for math)
	SIGNAL grmlatch : STD_ULOGIC_VECTOR (10 DOWNTO 0) := "11111111111"; -- 11 bits of GROM bank switch latch (start on last page)
	SIGNAL gvalid : STD_ULOGIC;	-- internal register to reuse valid test
BEGIN
	-- determine if GROM data is active by GROM select and internal address match and mode pin
	-- we handle all GROM except the first three (000, 001 and 010)
	gvalid <= (NOT ti_gsel) AND (grmpage(2) OR (grmpage(1) AND grmpage(0))) AND (NOT ti_adr(14));

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
			-- we don’t capture the TI lsb because it ALWAYS
			-- changes due to the 16->8 bit multiplexer
			-- remember TI bit order - 0 is MSB
			IF (ti_data(0) = '1') THEN
				-- set the MSB, that writes the GROM latch with 11 bits of address
				grmlatch(10) <= ti_adr(4); -- MSB
				grmlatch(9) <= ti_adr(5);
				grmlatch(8) <= ti_adr(6);
				grmlatch(7) <= ti_adr(7);
				grmlatch(6) <= ti_adr(8);
				grmlatch(5) <= ti_adr(9);
				grmlatch(4) <= ti_adr(10);
				grmlatch(3) <= ti_adr(11);
				grmlatch(2) <= ti_adr(12);
				grmlatch(1) <= ti_adr(13);
				grmlatch(0) <= ti_adr(14); -- LSB
			ELSE
				-- if not set, then capture 14 bits of ROM latch
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
			END IF;
		END IF;
	END PROCESS;

	-- handle the GROM address register writes
	PROCESS (ti_gsel)
	BEGIN
		if (ti_gsel'EVENT AND ti_gsel='0' AND ti_adr(14)='1' AND ti_we='0') THEN
			-- shift LSB into the MSB and page register
			grmpage(0) <= grmadr(5);
			grmpage(1) <= grmadr(6);
			grmpage(2) <= grmadr(7);
			grmadr(0) <= grmadr(8);
			grmadr(1) <= grmadr(9);
			grmadr(2) <= grmadr(10);
			grmadr(3) <= grmadr(11);
			grmadr(4) <= grmadr(12);

			--read the new byte into the LSB (no inversion here)
			grmadr(5) <= ti_data(0);
			grmadr(6) <= ti_data(1);
			grmadr(7) <= ti_data(2);
			grmadr(8) <= ti_data(3);
			grmadr(9) <= ti_data(4);
			grmadr(10) <= ti_data(5);
			grmadr(11) <= ti_data(6);
			grmadr(12) <= ti_data(7);
		END IF;

		IF (ti_gsel'event AND ti_gsel='1') THEN
			-- handle GROM address increment
			grmadr <= grmadr + 1;
		END IF;
	END PROCESS;

	-- handle the reset timer
	PROCESS (ti_adr(15))
	BEGIN
		-- we just count LSB changes, in lieu of a timer (not we don't care if we're selected!)
		-- 128 changes should be plenty of time (hell, I think 1 change is long enough...)
		if (ti_adr(15)'event and ti_adr(15)='1') then
			if bounce/="1111111" then
				bounce <= bounce + 1;
			end if;
		end if;
	END PROCESS;

	-- handle addresses and select to the ROM chip
	-- these lines were previously debounced by external clock... but no more!
	out_adr(26 DOWNTO 16) <= grmlatch WHEN (gvalid = '1' AND ti_adr(14) = '0' AND ti_we = '1') ELSE latch(13 DOWNTO 3);
	out_adr(15 DOWNTO 13) <= grmpage  WHEN (gvalid = '1' AND ti_adr(14) = '0' AND ti_we = '1') ELSE latch(2 DOWNTO 0);

	-- need to invert the rest...
	out_adr(12) <= grmadr(0) WHEN (gvalid = '1' AND ti_adr(14) = '0' AND ti_we = '1') ELSE ti_adr(3);
	out_adr(11) <= grmadr(1) WHEN (gvalid = '1' AND ti_adr(14) = '0' AND ti_we = '1') ELSE ti_adr(4);
	out_adr(10) <= grmadr(2) WHEN (gvalid = '1' AND ti_adr(14) = '0' AND ti_we = '1') ELSE ti_adr(5);
	out_adr(9) <= grmadr(3) WHEN (gvalid = '1' AND ti_adr(14) = '0' AND ti_we = '1') ELSE ti_adr(6);
	out_adr(8) <= grmadr(4) WHEN (gvalid = '1' AND ti_adr(14) = '0' AND ti_we = '1') ELSE ti_adr(7);
	out_adr(7) <= grmadr(5) WHEN (gvalid = '1' AND ti_adr(14) = '0' AND ti_we = '1') ELSE ti_adr(8);
	out_adr(6) <= grmadr(6) WHEN (gvalid = '1' AND ti_adr(14) = '0' AND ti_we = '1') ELSE ti_adr(9);
	out_adr(5) <= grmadr(7) WHEN (gvalid = '1' AND ti_adr(14) = '0' AND ti_we = '1') ELSE ti_adr(10);
	out_adr(4) <= grmadr(8) WHEN (gvalid = '1' AND ti_adr(14) = '0' AND ti_we = '1') ELSE ti_adr(11);
	out_adr(3) <= grmadr(9) WHEN (gvalid = '1' AND ti_adr(14) = '0' AND ti_we = '1') ELSE ti_adr(12);
	out_adr(2) <= grmadr(10) WHEN (gvalid = '1' AND ti_adr(14) = '0' AND ti_we = '1') ELSE ti_adr(13);
	out_adr(1) <= grmadr(11) WHEN (gvalid = '1' AND ti_adr(14) = '0' AND ti_we = '1') ELSE ti_adr(14);
	out_adr(0) <= grmadr(12) WHEN (gvalid = '1' AND ti_adr(14) = '0' AND ti_we = '1') ELSE ti_adr(15);

	-- control lines
	out_rom <= ti_rom AND (NOT gvalid);
	out_we <= ti_we;
	out_reset <= bounce(0) and bounce(1) and bounce(2) and bounce(3) and bounce(4) and bounce(5) and bounce(6);
	out_rst2 <= bounce(0) and bounce(1) and bounce(2) and bounce(3) and bounce(4) and bounce(5) and bounce(6);
END myarch;

