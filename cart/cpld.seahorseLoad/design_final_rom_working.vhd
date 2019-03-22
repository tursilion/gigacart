-- This version strips down to the bare minimum and adds control of the reset line of the flash

-- all values use bit 0 as the LSB, not the TI way
-- this one is not bidirectional on the ROM (output) side
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

ENTITY gigacart IS
	PORT (
		ti_adr : IN STD_ULOGIC_VECTOR (15 DOWNTO 3);	-- (21,17,19,20,22,23,27,28,29,30,31,3,34) 13 bits (8k), TI order, 15 is LSB!
		ti_data: INOUT STD_ULOGIC_VECTOR (7 DOWNTO 0);	-- (9,10,11,12,9,10,11,14) 8 bits, TI order. 7 is LSB!
		ti_we: IN STD_ULOGIC;				-- (16) write enable (active low)
		ti_rom: IN STD_ULOGIC;				-- (15) ROM select (active low)

		out_adr: OUT STD_ULOGIC_VECTOR (26 DOWNTO 0);	-- (97,84,49,50,53,54,55,56,58,66,67,69,70,71,72,78,79,98,59,60,65,64,61,80,81,100,99) 27 bits (128MB)
		out_data: IN STD_ULOGIC_VECTOR (7 DOWNTO 0);	-- (86,87,88,89,91,92,93,94) 8 bits
		out_rom: OUT STD_ULOGIC;			-- (85) ROM select (active low)
		out_we: OUT STD_ULOGIC;				-- (37) write enable (active low)
		out_reset: OUT STD_ULOGIC;			-- (47) output to hold flash chips in reset at startup
		out_rst2: OUT STD_ULOGIC;  -- dummy for prototype only

		-- these ones are used to support the 4 chip cart - up to 512MB
		-- I don’t intend to build one, but we have the pins ;)
		out_rom1: OUT STD_ULOGIC;			-- (41)
		out_rom2: OUT STD_ULOGIC;			-- (42)
		out_rom3: OUT STD_ULOGIC;			-- (43)
		out_rom4: OUT STD_ULOGIC );			-- (44)
	
		-- and that’s 64 I/O...
END gigacart;

ARCHITECTURE myarch OF gigacart IS
	SIGNAL latch : STD_ULOGIC_VECTOR (13 DOWNTO 0) := "00000000000000";-- 14 bits of latch
	SIGNAL chip : STD_ULOGIC_VECTOR (1 DOWNTO 0) := "00"; -- 2 bits of chip select
	SIGNAL bounce : STD_LOGIC_VECTOR (0 TO 6) := "0000000"; -- bits of delay (7 bits = 128 cycles)
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

	-- handle the reset timer
	PROCESS (ti_adr(15))
	BEGIN
		-- we just count LSB changes, in lieu of a timer (not we don't care if we're selected!)
		-- 128 changes should be plenty of time (hell, I think 1 change is long enough...)
		if (ti_adr(15)'event and ti_adr(15)='1') then
			if bounce="1111111" then
				bounce <= "1111111";
			else
				bounce <= bounce + 1;
			end if;
		end if;

	END PROCESS;

	-- handle addresses and select to the ROM chip
	-- these lines were previously debounced by external clock... but no more!

	-- the saved latch
	out_adr(26 DOWNTO 13) <= latch;

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

	-- control lines
	out_rom <= ti_rom;
	out_rom1 <= (chip(0) OR chip(1)) OR (ti_rom);
	out_rom2 <= ((not chip(0)) OR chip(1)) OR (ti_rom);
	out_rom3 <= (chip(0) OR (not chip(1))) OR (ti_rom);
	out_rom4 <= (not (chip(0) AND chip(1))) OR (ti_rom);
	out_we <= ti_we;
	out_reset <= bounce(0) and bounce(1) and bounce(2) and bounce(3) and bounce(4) and bounce(5) and bounce(6);
	out_rst2 <= bounce(0) and bounce(1) and bounce(2) and bounce(3) and bounce(4) and bounce(5) and bounce(6);
END myarch;

