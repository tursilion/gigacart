library ieee;
use ieee.std_logic_1164.all;

	-- Add your library and packages declaration here ...

entity gigacart_tb is
end gigacart_tb;

architecture TB_ARCHITECTURE of gigacart_tb is
	-- Component declaration of the tested unit
	component gigacart
	port(
		ti_adr : in STD_ULOGIC_VECTOR(12 downto 0);
		ti_data : inout STD_ULOGIC_VECTOR(7 downto 0);
		ti_we : in STD_ULOGIC;
		ti_rom : in STD_ULOGIC;
		out_adr : out STD_ULOGIC_VECTOR(26 downto 0);
		out_data : in STD_ULOGIC_VECTOR(7 downto 0);
		out_rom : out STD_ULOGIC;
		out_we : out STD_ULOGIC;
		out_rom1 : out STD_ULOGIC;
		out_rom2 : out STD_ULOGIC;
		out_rom3 : out STD_ULOGIC;
		out_rom4 : out STD_ULOGIC );
	end component;

	-- Stimulus signals - signals mapped to the input and inout ports of tested entity
	signal ti_adr : STD_ULOGIC_VECTOR(12 downto 0);
	signal ti_we : STD_ULOGIC;
	signal ti_rom : STD_ULOGIC;
	signal out_data : STD_ULOGIC_VECTOR(7 downto 0);
	signal ti_data : STD_ULOGIC_VECTOR(7 downto 0);
	-- Observed signals - signals mapped to the output ports of tested entity
	signal out_adr : STD_ULOGIC_VECTOR(26 downto 0);
	signal out_rom : STD_ULOGIC;
	signal out_we : STD_ULOGIC;
	signal out_rom1 : STD_ULOGIC;
	signal out_rom2 : STD_ULOGIC;
	signal out_rom3 : STD_ULOGIC;
	signal out_rom4 : STD_ULOGIC;

	-- Add your code here ...

begin

	-- Unit Under Test port map
	UUT : gigacart
		port map (
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

	-- Add your stimulus here ...

end TB_ARCHITECTURE;

configuration TESTBENCH_FOR_gigacart of gigacart_tb is
	for TB_ARCHITECTURE
		for UUT : gigacart
			use entity work.gigacart(myarch);
		end for;
	end for;
end TESTBENCH_FOR_gigacart;

