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
		ti_adr : IN STD_ULOGIC_VECTOR (12 DOWNTO 0);	-- 13 bits (8k), invert for TI
		ti_data: INOUT STD_ULOGIC_VECTOR (7 DOWNTO 0);	-- 8 bits, invert for TI
		ti_we: IN STD_ULOGIC;				-- write enable (active low)
		ti_rom: IN STD_ULOGIC;				-- ROM select (active low)

		out_adr: OUT STD_ULOGIC_VECTOR (26 DOWNTO 0);	-- 27 bits (128MB)
		out_data: IN STD_ULOGIC_VECTOR (7 DOWNTO 0);	-- 8 bits
		out_rom: OUT STD_ULOGIC;			-- ROM select (active low)
		out_we: OUT STD_ULOGIC;			-- write enable (active low)

		-- these ones are used to support the 4 chip cart - up to 512MB
		-- I don’t intend to build one, but we have the pins ;)
		out_rom1: OUT STD_ULOGIC;
		out_rom2: OUT STD_ULOGIC;
		out_rom3: OUT STD_ULOGIC;
		out_rom4: OUT STD_ULOGIC);
end component;

signal adr_in : std_logic_vector(12 downto 0);
signal data_in : std_logic_vector(7 downto 0);
signal we_in : std_logic;
signal rom_in : std_logic;
signal out_adr_out:  STD_LOGIC_VECTOR (26 DOWNTO 0);	-- 27 bits (128MB)
signal out_data_out:  STD_LOGIC_VECTOR (7 DOWNTO 0);	-- 8 bits
signal out_rom_out:  STD_LOGIC;			-- ROM select (active low)
signal out_we_out:  STD_LOGIC;			-- write enable (active low)

signal out_rom1_out:  STD_LOGIC;
signal out_rom2_out:  STD_LOGIC;
signal out_rom3_out:  STD_LOGIC;
signal out_rom4_out:  STD_LOGIC;

begin

  -- Connect DUT
  DUT: gigacart port map(adr_in,data_in,we_in,rom_in,out_adr_out,out_data_out, out_rom_out,out_we_out,out_rom1_out,out_rom2_out,out_rom3_out,out_rom4_out);

  process
  begin

	adr_in <= "0001000100011";
    data_in <= "00000000";
    we_in <= '1';
    rom_in <= '1';
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

