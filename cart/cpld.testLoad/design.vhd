-- GigaCart CPLD by Mike Brent aka Tursi

-- This is just a simple test load that echoes addresses back to allow easy test of
-- TI address and data lines. It also copies the TI GROM select to ROM1,
-- GROM active (>8xxx) to ROM2 (this is also flash reset)
-- Also TI GROMCLK to ROM3 and TI_WE to ROM4
-- However, to do all this it drops the latch.

-- This is for the rev 1 cart, before all the lines moved around. So the flash is
-- assumed to be always active. If it's useful we can update it later.

-- I am currently spacing things along with the GROMCLK... I am not convinced it's really
-- necessary but having both valid and active signals is nice for this spacing. Without
-- the timing delays the GROM is pretty unstable on hardware, so it's as good a clock as any

-- This version removes the extra chip selects but instead supports GROM with NO paging!
-- ROM and GROM pages can safely overlap
-- GROM is the last 256 bytes of the flash, and answers at >8000 (really >8000->9FFF)
-- This provides enough room to write some GPL code to boot a ROM cart. :)

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
		out_rom1 : OUT STD_ULOGIC;			-- ROM select 1 (active low)
		out_rom2 : OUT STD_ULOGIC;			-- ROM select 2 (active low)
		out_rom3 : OUT STD_ULOGIC;			-- ROM select 3 (active low)
		out_rom4 : OUT STD_ULOGIC;			-- ROM select 4 (active low)
		out_reset: OUT STD_ULOGIC := '0'		-- (47) output to hold flash chips in reset at startup (initial value ignored)
	);
END gigacart;

ARCHITECTURE myarch OF gigacart IS
-- flash chip interface
--	SIGNAL chip    : STD_ULOGIC_VECTOR (1 DOWNTO 0) := "00"; -- 2 bits of chip select
--	SIGNAL bounce  : STD_ULOGIC := '0'; -- true to release reset after min 35uS
	SIGNAL dataout : STD_ULOGIC; -- := '0'; -- true when we should enable flash data output

-- rom emulation
--	SIGNAL latch   : STD_ULOGIC_VECTOR (13 DOWNTO 0) := "00000000000000";-- 14 bits of latch

-- grom emulation
	SIGNAL grmadr  : unsigned (0 TO 7) := "00000000"; -- 8 bits of GROM mapped address (256 bytes! note inverted order for math)
	SIGNAL grmpage : STD_ULOGIC := '0'; -- single bit - true when page is "100", else false
	SIGNAL gactive : STD_ULOGIC := '0'; -- single bit used to delay gvalid (grom cycle is active)
	SIGNAL gvalid  : STD_ULOGIC := '0'; -- internal register to reuse valid test (we are acting on grom cycle)
	SIGNAL gadd    : STD_ULOGIC;
BEGIN
	-- determine if GROM data is active by GROM select and internal address match and mode pin
	-- we respond only to the >8000 GROM by setting the single bit true or false when received
	-- ti_adr(14)='1' means address, not data, 
	PROCESS (ALL)
	BEGIN
		if (falling_edge(ti_gclk)) then
			-- this used to be a lot of discrete logic, but the
			-- idea is to use gvalid as a delayed GROM control line,
			-- and gactive is just a bit to delay, clocked on GROMCLK.
			-- The signals look something like this:
			-- !GROMSEL  11100000000111  (active low)
			-- gactive   00011111111100  (active high)
			-- gvalid    00001111111000  (Active high)
			gactive <= (NOT ti_gsel OR gvalid);
			gvalid <= (gactive AND NOT ti_gsel);

		END IF;
	END PROCESS;
 
	-- check whether we should gate flash data onto the TI data bus
	-- !WE is delayed on our hardware... so there may be brief conflict
	-- Could we delay? Without a clock?
	dataout <= ti_we when ((gvalid = '1' AND grmpage='1' AND ti_gsel='0' AND ti_adr(14)='0') OR ti_rom = '0') ELSE ('0');

	-- output data from ROM on read, otherwise tristate data bus (bit inversion)
	ti_data(0) <= '0' WHEN ((dataout = '1') AND (ti_adr(15) = '0')) ELSE ti_adr(8) WHEN ((dataout = '1') AND ( ti_adr(15) = '1')) ELSE ('Z'); -- MSB
	ti_data(1) <= '0' WHEN ((dataout = '1') AND ( ti_adr(15) ='0')) ELSE ti_adr(9) WHEN ((dataout = '1') AND ( ti_adr(15)='1')) ELSE ('Z');
	ti_data(2) <= '0' WHEN ((dataout = '1') AND (ti_adr(15) ='0')) ELSE ti_adr(10) WHEN ((dataout = '1') AND ( ti_adr(15)='1')) ELSE ('Z');
	ti_data(3) <= ti_adr(3) WHEN ((dataout = '1') AND ( ti_adr(15) ='0')) ELSE ti_adr(11) WHEN ((dataout = '1') AND ( ti_adr(15)='1')) ELSE ('Z');
	ti_data(4) <= ti_adr(4) WHEN ((dataout = '1') AND ( ti_adr(15) ='0')) ELSE ti_adr(12) WHEN ((dataout = '1') AND ( ti_adr(15)='1')) ELSE ('Z');
	ti_data(5) <= ti_adr(5) WHEN ((dataout = '1') AND ( ti_adr(15) ='0')) ELSE ti_adr(13) WHEN ((dataout = '1') AND ( ti_adr(15)='1')) ELSE ('Z');
	ti_data(6) <= ti_adr(6) WHEN ((dataout = '1') AND ( ti_adr(15) ='0')) ELSE ti_adr(14) WHEN ((dataout = '1') AND ( ti_adr(15)='1')) ELSE ('Z');
	ti_data(7) <= ti_adr(7) WHEN ((dataout = '1') AND ( ti_adr(15) ='0')) ELSE ti_adr(15) WHEN ((dataout = '1') AND ( ti_adr(15)='1')) ELSE ('Z'); -- LSB

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
		-- Since there will be real GROMs in the system to deal with address readback,
		-- we can skip all that circuitry. We do need autoincrement to run GPL though.
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

				-- was originally first GROM write, which I expected to be 139 cycles/46uS,
				-- but I was still getting incomplete flash reset. Classic99 reports it's only
				-- 113 cycles, so 33.9uS. And with 5% clock slip, could be as fast as 32uS.
				-- We need 35uS, and apparently it's serious about that. First time the TI
				-- has been /too fast/...
				-- this releases the reset line to the flash chip, never goes low again
				-- this doesn't work in real life - the tools see it stuck 'on' and never force
				-- the initial '0' value.
				--bounce <= '1';

				-- don't increment before the next access
				gadd <= '0';
			ELSIF ti_adr(14)='0' THEN
				-- add the increment value (1 or 0)
				grmadr <= grmadr + gadd;
				-- okay to increment on the next access
				gadd <= '1';
			END IF;
		END IF;
	END PROCESS;

	-- handle addresses to the ROM chip (which is always enabled)
	out_adr(26 DOWNTO 13) <= (others => '1') WHEN (gvalid = '1') ELSE (others => '0') ;

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
	-- using grmpage means the flash is reset any time we are not selected in GROM,
	-- but this seems (bizarrely) to actually work... need to test access times a bit
	-- looks like the single-byte GROM tests are about 16-18uS long, datasheet says
	-- it needs 200ns after a reset. We'll just keep testing.
	out_reset <= grmpage;

	-- It also copies the TI GROM select to ROM1
	out_rom1 <= ti_gsel;
	-- GROM active (>8xxx) to ROM2 (this is also flash reset)
	out_rom2 <= grmpage;
	-- TI GROMCLK to ROM3
	out_rom3 <= ti_gclk;
	-- TI_WE to ROM4
	out_rom4 <= ti_we;

END myarch;

