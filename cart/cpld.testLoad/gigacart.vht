
-- VHDL Test Bench Created from source file gigacart.vhd -- 09/23/18  23:52:15
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
		ti_adr : IN std_logic_vector(15 downto 3);
		ti_we : IN std_logic;
		ti_rom : IN std_logic;
		ti_gsel : IN std_logic;
		out_data : IN std_logic_vector(7 downto 0);    
		ti_data : INOUT std_logic_vector(7 downto 0);      
		out_adr : OUT std_logic_vector(26 downto 0);
		out_reset : OUT std_logic
		);
	END COMPONENT;

	SIGNAL ti_adr :  std_logic_vector(15 downto 3);
	SIGNAL ti_data :  std_logic_vector(7 downto 0);
	SIGNAL ti_we :  std_logic;
	SIGNAL ti_rom :  std_logic;
	SIGNAL ti_gsel :  std_logic;
	SIGNAL out_adr :  std_logic_vector(26 downto 0);
	SIGNAL out_data :  std_logic_vector(7 downto 0);
	SIGNAL out_reset :  std_logic;

BEGIN

	uut: gigacart PORT MAP(
		ti_adr => ti_adr,
		ti_data => ti_data,
		ti_we => ti_we,
		ti_rom => ti_rom,
		ti_gsel => ti_gsel,
		out_adr => out_adr,
		out_data => out_data,
		out_reset => out_reset
	);


-- *** Test Bench - User Defined Section ***
   tb : PROCESS
   BEGIN
      wait; -- will wait forever
   END PROCESS;
-- *** End Test Bench - User Defined Section ***

END;
