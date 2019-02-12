
-- VHDL Test Bench Created from source file gigacart.vhd -- 02/11/18  01:56:41
--
-- Notes: 
-- 1) This testbench template has been automatically generated using types
-- std_logic and std_logic_vector for the ports of the unit under test.
-- Lattice recommends that these types always be used for the top-level
-- I/O of a design in order to guarantee that the testbench will bind
-- correctly to the timing (post-route) simulation model.
-- 2) To use this template as your testbench, change the filename to any
-- name of your choice with the extension .vhd, and use the "source->import"
-- menu in the ispLEVER Project Navigator to import the testbench.
-- Then edit the user defined section below, adding code to generate the 
-- stimulus for your design.
--
LIBRARY ieee;
LIBRARY generics;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
USE generics.components.ALL;

ENTITY testbench IS
END testbench;

ARCHITECTURE behavior OF testbench IS 

	COMPONENT gigacart
	PORT(
		ti_adr : IN std_logic_vector(12 downto 0);
		ti_we : IN std_logic;
		ti_rom : IN std_logic;
		out_data : IN std_logic_vector(7 downto 0);    
		ti_data : INOUT std_logic_vector(7 downto 0);      
		out_adr : OUT std_logic_vector(26 downto 0);
		out_rom : OUT std_logic;
		out_we : OUT std_logic;
		out_rom1 : OUT std_logic;
		out_rom2 : OUT std_logic;
		out_rom3 : OUT std_logic;
		out_rom4 : OUT std_logic
		);
	END COMPONENT;

	SIGNAL ti_adr :  std_logic_vector(12 downto 0);
	SIGNAL ti_data :  std_logic_vector(7 downto 0);
	SIGNAL ti_we :  std_logic;
	SIGNAL ti_rom :  std_logic;
	SIGNAL out_adr :  std_logic_vector(26 downto 0);
	SIGNAL out_data :  std_logic_vector(7 downto 0);
	SIGNAL out_rom :  std_logic;
	SIGNAL out_we :  std_logic;
	SIGNAL out_rom1 :  std_logic;
	SIGNAL out_rom2 :  std_logic;
	SIGNAL out_rom3 :  std_logic;
	SIGNAL out_rom4 :  std_logic;

BEGIN

	uut: gigacart PORT MAP(
		ti_adr => ti_adr,
		ti_data => ti_data,
		ti_we => ti_we,
		ti_rom => ti_rom,
		out_adr => out_adr,
		out_data => out_data,
		out_rom => out_rom,
		out_we => out_we,
		out_rom1 => out_rom1,
		out_rom2 => out_rom2,
		out_rom3 => out_rom3,
		out_rom4 => out_rom4
	);


-- *** Test Bench - User Defined Section ***
   tb : PROCESS
   BEGIN
      wait; -- will wait forever
   END PROCESS;
-- *** End Test Bench - User Defined Section ***

END;
