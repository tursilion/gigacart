-- GigaCart CPLD by Mike Brent aka Tursi
-- This is the programmable load - the latch is on GROM and
-- we can do writes.

-- A console mod is required:
-- Block the GROM Select pin on the cartridge port
-- Tie a jumper between this pin and the 74LS138 select for >E000
-- This gives us two address ranges for the cartridge:
-- >6000, which accesses normally (including writes for setting the latch)
-- >E000, which passes through specified writes only

-- Latch has two extra bits which as the byte mask:
-- 10 means send the MSB only (>08)
-- 01 means send the LSB only (>04)
-- 11 means send them both
-- This will allow both a fast buffer fill, and the specific unlock patterns to work
-- these come from the data bits >04 and >08, like the old ROM select bits
-- Finally, one more bit is used as the flash reset latch (>10)


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
		out_data : INOUT STD_ULOGIC_VECTOR (7 DOWNTO 0);-- (86,87,88,89,91,92,93,94) 8 bits
		out_reset: OUT STD_ULOGIC := '0';		-- (47) output to hold flash chips in reset at startup (initial value ignored)
        	out_we   : OUT STD_ULOGIC := '1';   	    	-- WE output to the flash - overloads out_rom4
		out_oe	 : OUT STD_ULOGIC := '0';		-- OE output to the flash - uses spare pin
		out_ce   : OUT STD_ULOGIC := '1'		-- CE output to the flash - overloads out_rom3
	);
END gigacart;

ARCHITECTURE myarch OF gigacart IS
-- flash chip interface
	SIGNAL wordmask: STD_ULOGIC_VECTOR (1 DOWNTO 0) := "00"; -- 2 bits of word mask: 1 is MSB, 0 is LSB
	SIGNAL dataout : STD_ULOGIC; -- := '0'; -- true when we should enable flash data output
	SIGNAL resetout : STD_ULOGIC;           -- latches reset line from the program

-- rom emulation
	SIGNAL latch   : STD_ULOGIC_VECTOR (13 DOWNTO 0) := "00000000000000";-- 14 bits of latch
 
BEGIN
	-- check whether we should gate flash data onto the TI data bus
	-- !WE is delayed on our hardware... so there may be brief conflict
	-- we only allow reads when the word mask is 00, this prevents read-before-write
 	-- from screwing up unlock sequences.
	dataout <= ti_we when (ti_rom = '0') AND (wordmask(1) = '0') AND (wordmask(0) ='0') ELSE ('0');

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
			IF (ti_rom='0' AND ti_adr(15)='0') THEN
				-- we dont capture the TI lsb because it ALWAYS
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
	
				-- two extra bits come from the data bus
				latch(13) <= ti_data(6); -- MSB
				latch(12) <= ti_data(7); -- LSB
	
				-- two bits of word enable
				wordmask(1) <= ti_data(4); -- MSB
				wordmask(0) <= ti_data(5); -- LSB

				-- one bit of reset
				resetout <= ti_data(3);
			END IF;
		END IF;
	END PROCESS;

	-- handle addresses to the ROM chip (which is always enabled)
	out_adr(26 DOWNTO 13) <= latch(13 DOWNTO 0) ;

	-- need to invert the rest... (8k of address space)
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
	out_adr(0) <= ti_adr(15);	-- LSB

	-- output on the flash data lines when appropriate
	-- this is an actual write to the flash triggered from >E000
	-- on my modified console, not a standard GROM access
	-- collect data from the TI data bus (we can set the conditions on the control lines only)
	out_data(0) <= ti_data(7) WHEN (out_we = '0') ELSE ('Z'); -- MSB
	out_data(1) <= ti_data(6) WHEN (out_we = '0') ELSE ('Z');
	out_data(2) <= ti_data(5) WHEN (out_we = '0') ELSE ('Z');
	out_data(3) <= ti_data(4) WHEN (out_we = '0') ELSE ('Z');
	out_data(4) <= ti_data(3) WHEN (out_we = '0') ELSE ('Z');
	out_data(5) <= ti_data(2) WHEN (out_we = '0') ELSE ('Z');
	out_data(6) <= ti_data(1) WHEN (out_we = '0') ELSE ('Z');
	out_data(7) <= ti_data(0) WHEN (out_we = '0') ELSE ('Z'); -- LSB

	-- flash control lines
	-- reset is manually controlled by software in this mode
	out_reset <= resetout;
	-- flash should output data when dataout is true only
	out_oe <= not dataout;
	-- flash chip select on read or write
	out_ce <= out_oe AND out_we;
	-- write enable only when we're writing to gsel on the appropriate byte
	out_we <= not ( (not ti_gsel) AND (not ti_we) AND ( (ti_adr(15) and wordmask(0) ) or (not ti_adr(15) and wordmask(1)) ));
END myarch;

