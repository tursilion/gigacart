-- I don't know how to make this work in ispLEVER yet...
-- but it runs okay on edaplayground.com.

-- Testbench for gigacart
library IEEE;
use IEEE.std_logic_1164.all;
 
entity testbench is
-- empty
end testbench; 

architecture tb of testbench is

-- DUT component
component gigacart is
port(
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

		-- these ones are used to support the 4 chip cart - up to 512MB
		-- I don’t intend to build one, but we have the pins ;)
--		out_rom1: OUT STD_ULOGIC;
--		out_rom2: OUT STD_ULOGIC;
--		out_rom3: OUT STD_ULOGIC;
--		out_rom4: OUT STD_ULOGIC
);
end component;

signal adr_in : std_ulogic_vector(12 downto 0);
signal data_in : std_ulogic_vector(7 downto 0);
signal we_in : std_ulogic;
signal rom_in : std_ulogic;
signal gsel_in : std_ulogic;
signal out_adr_out:  STD_uLOGIC_VECTOR (26 DOWNTO 0);	-- 27 bits (128MB)
signal out_data_out:  STD_uLOGIC_VECTOR (7 DOWNTO 0);	-- 8 bits
signal out_reset_out:  STD_uLOGIC;			-- write enable (active low)

begin

  -- Connect DUT
  DUT: gigacart port map(adr_in,data_in,we_in,rom_in,gsel_in,out_adr_out,out_data_out,out_reset_out);

  process
  begin

    adr_in <= "0001000100011";
    data_in <= "00000000";
    we_in <= '1';
    rom_in <= '1';
    gsel_in <= '0';
    wait for 1 ns;
    
    rom_in <= '0';
    wait for 1 ns;
    
    we_in <= '0';
    wait for 1 ns;
      data_in <= "00000001";
      wait for 1 ns;
    we_in <= '1';
    wait for 1 ns;

    we_in <= '0';
    wait for 1 ns;
    data_in <= "00000010";
    wait for 1 ns;
    we_in <= '1';
    wait for 1 ns;

    we_in <= '0';
    wait for 1 ns;
    data_in <= "00000011";
    wait for 1 ns;
    we_in <= '1';
    wait for 1 ns;

    we_in <= '0';
    wait for 1 ns;
    data_in <= "00000100";
    wait for 1 ns;
    we_in <= '1';
    wait for 1 ns;

    we_in <= '0';
    wait for 1 ns;
    data_in <= "00001000";
    wait for 1 ns;
    we_in <= '1';
    wait for 1 ns;

    we_in <= '0';
    wait for 1 ns;
    data_in <= "00001100";
    wait for 1 ns;
    we_in <= '1';
    wait for 1 ns;

    we_in <= '0';
    wait for 1 ns;
	adr_in <= "0101010101010";
    wait for 1 ns;
    we_in <= '1';
    wait for 1 ns;

    adr_in <= "1111111111111";
    wait for 1 ns;

	adr_in <= "0000000000000";
    wait for 1 ns;
    
    rom_in <= '1';
    adr_in <= "1111111111111";
    wait for 1 ns;

	adr_in <= "0000000000000";
    wait for 1 ns;
    
    rom_in <= '0';
    adr_in <= "0101010101010";
    wait for 1 ns;
    
    rom_in <= '1';

	assert false report "Test done." severity note;
    wait;
  end process;
end tb;

