-- this version is just as simple as can be and doesn't worry about
-- things like signal debounce to the flash, and does not require a clock

-- all values bit bit 0 as the LSB, not the TI way
-- this one is not bidirectional on the ROM (output) side
LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY gigacart IS
	PORT (
		ti_adr : IN STD_ULOGIC_VECTOR (15 DOWNTO 3);	-- 13 bits (8k), TI order, 15 is LSB!
		ti_data: INOUT STD_ULOGIC_VECTOR (7 DOWNTO 0);	-- 8 bits, TI order. 7 is LSB!
		ti_we: IN STD_ULOGIC;				-- write enable (active low)
		ti_rom: IN STD_ULOGIC;				-- ROM select (active low)

		-- clock not used in this design, but left so I don't need to change the pin constraints
		in_clk: IN STD_ULOGIC;				-- clock for debouncing adr (50MHz, 20nS, so wait for 2 clocks)

		out_adr: OUT STD_ULOGIC_VECTOR (26 DOWNTO 0);	-- 27 bits (128MB)
		out_data: IN STD_ULOGIC_VECTOR (7 DOWNTO 0);	-- 8 bits
		out_rom: OUT STD_ULOGIC;			-- ROM select (active low)
		out_we: OUT STD_ULOGIC;			-- write enable (active low) PIN 35 - replace with clock input?

		-- these ones are used to support the 4 chip cart - up to 512MB
		-- I don’t intend to build one, but we have the pins ;)
		out_rom1: OUT STD_ULOGIC;
		out_rom2: OUT STD_ULOGIC;
		out_rom3: OUT STD_ULOGIC;
		out_rom4: OUT STD_ULOGIC );
	
		-- and that’s 64 I/O...
END gigacart;

ARCHITECTURE myarch OF gigacart IS
	SIGNAL latch : STD_ULOGIC_VECTOR (13 DOWNTO 0) := "00000000000000";-- 14 bits of latch
	SIGNAL chip : STD_ULOGIC_VECTOR (1 DOWNTO 0) := "00"; -- 2 bits of chip select
BEGIN
	-- output data from ROM on read, otherwise tristate data bus (bit inversion)
	ti_data(0) <= out_data(7) WHEN (ti_rom = '0' AND ti_we = '1') ELSE ('Z'); -- MSB
	ti_data(1) <= out_data(6) WHEN (ti_rom = '0' AND ti_we = '1') ELSE ('Z');
	ti_data(2) <= out_data(5) WHEN (ti_rom = '0' AND ti_we = '1') ELSE ('Z');
	ti_data(3) <= out_data(4) WHEN (ti_rom = '0' AND ti_we = '1') ELSE ('Z');
	ti_data(4) <= out_data(3) WHEN (ti_rom = '0' AND ti_we = '1') ELSE ('Z');
	ti_data(5) <= out_data(2) WHEN (ti_rom = '0' AND ti_we = '1') ELSE ('Z');
	ti_data(6) <= out_data(1) WHEN (ti_rom = '0' AND ti_we = '1') ELSE ('Z');
	ti_data(7) <= out_data(0) WHEN (ti_rom = '0' AND ti_we = '1') ELSE ('Z'); -- LSB

	-- numerous signals to handle on write
	-- we can't use blocks and guards... and whatever, cause
	-- we should use the rising edge process concept
	PROCESS (ti_rom, ti_we)
	BEGIN
		-- capture on rising edge of WE (if ROM is active)
		if (ti_rom='0' AND ti_we'EVENT AND ti_we='1') THEN
			-- we don’t capture the TI lsb because it ALWAYS
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

	-- invert the TI address bus (15 downto 3)
	out_adr(12) <= ti_adr(3);
	out_adr(11) <= ti_adr(4);
	out_adr(10) <= ti_adr(5);
	out_adr(9) <= ti_adr(6);
	out_adr(8) <= ti_adr(7);
	out_adr(7) <= ti_adr(8);
	out_adr(6) <= ti_adr(9);
	out_adr(5) <= ti_adr(10);
	out_adr(4) <= ti_adr(11);
	out_adr(3) <= ti_adr(12);
	out_adr(2) <= ti_adr(13);
	out_adr(1) <= ti_adr(14);
	out_adr(0) <= ti_adr(15);
	
	-- the saved latch
	out_adr(26 DOWNTO 13) <= latch;

	-- control signals
	out_rom <= ti_rom;			-- for all chips (or single chip)
	out_rom1 <= (chip(0) OR chip(1));	-- for chip 1
	out_rom2 <= ((not chip(0)) OR chip(1)); -- for chip 2
	out_rom3 <= (chip(0) OR (not chip(1))); -- for chip 3
	out_rom4 <= (not (chip(0) AND chip(1))); --for chip 4
	out_we <= ti_we;			-- write enable (untested)

END myarch;

