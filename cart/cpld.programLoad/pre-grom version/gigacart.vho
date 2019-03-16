-- VHDL netlist-file
library mach;
use mach.components.all;

library ieee;
use ieee.std_logic_1164.all;
entity gigacart is
  port (
    ti_data : inout std_logic_vector(7 downto 0);
    ti_adr : in std_logic_vector(12 downto 0);
    out_data : in std_logic_vector(7 downto 0);
    ti_we : in std_logic;
    ti_rom : in std_logic;
    out_rom : out std_logic;
    out_we : out std_logic;
    out_rom1 : out std_logic;
    out_rom2 : out std_logic;
    out_rom3 : out std_logic;
    out_rom4 : out std_logic;
    out_adr : out std_logic_vector(26 downto 0)
  );
end gigacart;

architecture NetList of gigacart is

  signal ti_data_3XPIN : std_logic;
  signal ti_data_3XCOM : std_logic;
  signal ti_data_2XPIN : std_logic;
  signal ti_data_2XCOM : std_logic;
  signal ti_adr_12XPIN : std_logic;
  signal ti_data_1XPIN : std_logic;
  signal ti_data_1XCOM : std_logic;
  signal ti_data_0XPIN : std_logic;
  signal ti_data_0XCOM : std_logic;
  signal ti_data_7XCOM : std_logic;
  signal out_data_7XPIN : std_logic;
  signal ti_wePIN : std_logic;
  signal ti_romPIN : std_logic;
  signal out_romCOM : std_logic;
  signal out_weCOM : std_logic;
  signal out_rom1COM : std_logic;
  signal out_rom2COM : std_logic;
  signal out_rom3COM : std_logic;
  signal out_rom4COM : std_logic;
  signal out_adr_12XCOM : std_logic;
  signal out_adr_11XCOM : std_logic;
  signal out_adr_10XCOM : std_logic;
  signal out_adr_9XCOM : std_logic;
  signal out_adr_8XCOM : std_logic;
  signal out_adr_7XCOM : std_logic;
  signal out_adr_6XCOM : std_logic;
  signal out_adr_5XCOM : std_logic;
  signal out_adr_4XCOM : std_logic;
  signal out_adr_3XCOM : std_logic;
  signal out_adr_2XCOM : std_logic;
  signal out_adr_1XCOM : std_logic;
  signal out_adr_0XCOM : std_logic;
  signal out_data_6XPIN : std_logic;
  signal out_data_5XPIN : std_logic;
  signal out_data_4XPIN : std_logic;
  signal out_data_3XPIN : std_logic;
  signal out_data_2XPIN : std_logic;
  signal out_data_1XPIN : std_logic;
  signal out_data_0XPIN : std_logic;
  signal ti_adr_11XPIN : std_logic;
  signal ti_adr_10XPIN : std_logic;
  signal ti_adr_9XPIN : std_logic;
  signal ti_adr_8XPIN : std_logic;
  signal ti_adr_7XPIN : std_logic;
  signal ti_adr_6XPIN : std_logic;
  signal ti_adr_5XPIN : std_logic;
  signal ti_adr_4XPIN : std_logic;
  signal ti_adr_3XPIN : std_logic;
  signal ti_adr_2XPIN : std_logic;
  signal ti_adr_1XPIN : std_logic;
  signal ti_adr_0XPIN : std_logic;
  signal ti_data_6XCOM : std_logic;
  signal ti_data_5XCOM : std_logic;
  signal ti_data_4XCOM : std_logic;
  signal out_adr_25XQ : std_logic;
  signal out_adr_24XQ : std_logic;
  signal out_adr_26XQ : std_logic;
  signal out_adr_23XQ : std_logic;
  signal out_adr_22XQ : std_logic;
  signal out_adr_21XQ : std_logic;
  signal out_adr_20XQ : std_logic;
  signal out_adr_19XQ : std_logic;
  signal out_adr_18XQ : std_logic;
  signal out_adr_17XQ : std_logic;
  signal out_adr_16XQ : std_logic;
  signal out_adr_15XQ : std_logic;
  signal out_adr_14XQ : std_logic;
  signal out_adr_13XQ : std_logic;
  signal chip_0_busQ : std_logic;
  signal chip_1_busQ : std_logic;
  signal ti_data_3X_OE : std_logic;
  signal ti_data_2X_OE : std_logic;
  signal ti_data_1X_OE : std_logic;
  signal ti_data_0X_OE : std_logic;
  signal ti_data_7X_OE : std_logic;
  signal T_0 : std_logic;
  signal T_1 : std_logic;
  signal T_2 : std_logic;
  signal T_3 : std_logic;
  signal ti_data_6X_OE : std_logic;
  signal ti_data_5X_OE : std_logic;
  signal ti_data_4X_OE : std_logic;
  signal out_adr_25X_CE : std_logic;
  signal out_adr_24X_CE : std_logic;
  signal out_adr_26X_CE : std_logic;
  signal out_adr_23X_CE : std_logic;
  signal out_adr_22X_CE : std_logic;
  signal out_adr_21X_CE : std_logic;
  signal out_adr_20X_CE : std_logic;
  signal out_adr_19X_CE : std_logic;
  signal out_adr_18X_CE : std_logic;
  signal out_adr_17X_CE : std_logic;
  signal out_adr_16X_CE : std_logic;
  signal out_adr_15X_CE : std_logic;
  signal out_adr_14X_CE : std_logic;
  signal out_adr_13X_CE : std_logic;
  signal chip_0_bus_CE : std_logic;
  signal chip_1_bus_CE : std_logic;
  signal GATE_ti_data_3X_OE_A : std_logic;
  signal GATE_ti_data_2X_OE_A : std_logic;
  signal GATE_ti_data_1X_OE_A : std_logic;
  signal GATE_ti_data_0X_OE_A : std_logic;
  signal GATE_ti_data_7X_OE_A : std_logic;
  signal GATE_T_1_A : std_logic;
  signal GATE_T_1_B : std_logic;
  signal GATE_T_2_A : std_logic;
  signal GATE_T_2_B : std_logic;
  signal GATE_T_3_A : std_logic;
  signal GATE_ti_data_6X_OE_A : std_logic;
  signal GATE_ti_data_5X_OE_A : std_logic;
  signal GATE_ti_data_4X_OE_A : std_logic;

begin
  OUT_ti_data_3_XI_1:   BI_DIR
 generic map( PULL => "Up")
 port map ( O=>ti_data_3XPIN, 
            I0=>ti_data_3XCOM, 
            IO=>ti_data(3), 
            OE=>ti_data_3X_OE );
  OUT_ti_data_2_XI_1:   BI_DIR
 generic map( PULL => "Up")
 port map ( O=>ti_data_2XPIN, 
            I0=>ti_data_2XCOM, 
            IO=>ti_data(2), 
            OE=>ti_data_2X_OE );
  IN_ti_adr_12_XI_1:   IBUF
 generic map( PULL => "Up")
 port map ( O=>ti_adr_12XPIN, 
            I0=>ti_adr(12) );
  OUT_ti_data_1_XI_1:   BI_DIR
 generic map( PULL => "Up")
 port map ( O=>ti_data_1XPIN, 
            I0=>ti_data_1XCOM, 
            IO=>ti_data(1), 
            OE=>ti_data_1X_OE );
  OUT_ti_data_0_XI_1:   BI_DIR
 generic map( PULL => "Up")
 port map ( O=>ti_data_0XPIN, 
            I0=>ti_data_0XCOM, 
            IO=>ti_data(0), 
            OE=>ti_data_0X_OE );
  OUT_ti_data_7_XI_1:   BUFTH port map ( I0=>ti_data_7XCOM, 
            O=>ti_data(7), 
            OE=>ti_data_7X_OE );
  IN_out_data_7_XI_1:   IBUF
 generic map( PULL => "Up")
 port map ( O=>out_data_7XPIN, 
            I0=>out_data(7) );
  IN_ti_we_I_1:   IBUF
 generic map( PULL => "Up")
 port map ( O=>ti_wePIN, 
            I0=>ti_we );
  IN_ti_rom_I_1:   IBUF
 generic map( PULL => "Up")
 port map ( O=>ti_romPIN, 
            I0=>ti_rom );
  OUT_out_rom_I_1:   OBUF
 generic map( PULL => "Up")
 port map ( O=>out_rom, 
            I0=>out_romCOM );
  OUT_out_we_I_1:   OBUF
 generic map( PULL => "Up")
 port map ( O=>out_we, 
            I0=>out_weCOM );
  OUT_out_rom1_I_1:   OBUF
 generic map( PULL => "Up")
 port map ( O=>out_rom1, 
            I0=>out_rom1COM );
  OUT_out_rom2_I_1:   OBUF
 generic map( PULL => "Up")
 port map ( O=>out_rom2, 
            I0=>out_rom2COM );
  OUT_out_rom3_I_1:   OBUF
 generic map( PULL => "Up")
 port map ( O=>out_rom3, 
            I0=>out_rom3COM );
  OUT_out_rom4_I_1:   OBUF
 generic map( PULL => "Up")
 port map ( O=>out_rom4, 
            I0=>out_rom4COM );
  OUT_out_adr_12_XI_1:   OBUF
 generic map( PULL => "Up")
 port map ( O=>out_adr(12), 
            I0=>out_adr_12XCOM );
  OUT_out_adr_11_XI_1:   OBUF
 generic map( PULL => "Up")
 port map ( O=>out_adr(11), 
            I0=>out_adr_11XCOM );
  OUT_out_adr_10_XI_1:   OBUF
 generic map( PULL => "Up")
 port map ( O=>out_adr(10), 
            I0=>out_adr_10XCOM );
  OUT_out_adr_9_XI_1:   OBUF
 generic map( PULL => "Up")
 port map ( O=>out_adr(9), 
            I0=>out_adr_9XCOM );
  OUT_out_adr_8_XI_1:   OBUF
 generic map( PULL => "Up")
 port map ( O=>out_adr(8), 
            I0=>out_adr_8XCOM );
  OUT_out_adr_7_XI_1:   OBUF
 generic map( PULL => "Up")
 port map ( O=>out_adr(7), 
            I0=>out_adr_7XCOM );
  OUT_out_adr_6_XI_1:   OBUF
 generic map( PULL => "Up")
 port map ( O=>out_adr(6), 
            I0=>out_adr_6XCOM );
  OUT_out_adr_5_XI_1:   OBUF
 generic map( PULL => "Up")
 port map ( O=>out_adr(5), 
            I0=>out_adr_5XCOM );
  OUT_out_adr_4_XI_1:   OBUF
 generic map( PULL => "Up")
 port map ( O=>out_adr(4), 
            I0=>out_adr_4XCOM );
  OUT_out_adr_3_XI_1:   OBUF
 generic map( PULL => "Up")
 port map ( O=>out_adr(3), 
            I0=>out_adr_3XCOM );
  OUT_out_adr_2_XI_1:   OBUF
 generic map( PULL => "Up")
 port map ( O=>out_adr(2), 
            I0=>out_adr_2XCOM );
  OUT_out_adr_1_XI_1:   OBUF
 generic map( PULL => "Up")
 port map ( O=>out_adr(1), 
            I0=>out_adr_1XCOM );
  OUT_out_adr_0_XI_1:   OBUF
 generic map( PULL => "Up")
 port map ( O=>out_adr(0), 
            I0=>out_adr_0XCOM );
  IN_out_data_6_XI_1:   IBUF
 generic map( PULL => "Up")
 port map ( O=>out_data_6XPIN, 
            I0=>out_data(6) );
  IN_out_data_5_XI_1:   IBUF
 generic map( PULL => "Up")
 port map ( O=>out_data_5XPIN, 
            I0=>out_data(5) );
  IN_out_data_4_XI_1:   IBUF
 generic map( PULL => "Up")
 port map ( O=>out_data_4XPIN, 
            I0=>out_data(4) );
  IN_out_data_3_XI_1:   IBUF
 generic map( PULL => "Up")
 port map ( O=>out_data_3XPIN, 
            I0=>out_data(3) );
  IN_out_data_2_XI_1:   IBUF
 generic map( PULL => "Up")
 port map ( O=>out_data_2XPIN, 
            I0=>out_data(2) );
  IN_out_data_1_XI_1:   IBUF
 generic map( PULL => "Up")
 port map ( O=>out_data_1XPIN, 
            I0=>out_data(1) );
  IN_out_data_0_XI_1:   IBUF
 generic map( PULL => "Up")
 port map ( O=>out_data_0XPIN, 
            I0=>out_data(0) );
  IN_ti_adr_11_XI_1:   IBUF
 generic map( PULL => "Up")
 port map ( O=>ti_adr_11XPIN, 
            I0=>ti_adr(11) );
  IN_ti_adr_10_XI_1:   IBUF
 generic map( PULL => "Up")
 port map ( O=>ti_adr_10XPIN, 
            I0=>ti_adr(10) );
  IN_ti_adr_9_XI_1:   IBUF
 generic map( PULL => "Up")
 port map ( O=>ti_adr_9XPIN, 
            I0=>ti_adr(9) );
  IN_ti_adr_8_XI_1:   IBUF
 generic map( PULL => "Up")
 port map ( O=>ti_adr_8XPIN, 
            I0=>ti_adr(8) );
  IN_ti_adr_7_XI_1:   IBUF
 generic map( PULL => "Up")
 port map ( O=>ti_adr_7XPIN, 
            I0=>ti_adr(7) );
  IN_ti_adr_6_XI_1:   IBUF
 generic map( PULL => "Up")
 port map ( O=>ti_adr_6XPIN, 
            I0=>ti_adr(6) );
  IN_ti_adr_5_XI_1:   IBUF
 generic map( PULL => "Up")
 port map ( O=>ti_adr_5XPIN, 
            I0=>ti_adr(5) );
  IN_ti_adr_4_XI_1:   IBUF
 generic map( PULL => "Up")
 port map ( O=>ti_adr_4XPIN, 
            I0=>ti_adr(4) );
  IN_ti_adr_3_XI_1:   IBUF
 generic map( PULL => "Up")
 port map ( O=>ti_adr_3XPIN, 
            I0=>ti_adr(3) );
  IN_ti_adr_2_XI_1:   IBUF
 generic map( PULL => "Up")
 port map ( O=>ti_adr_2XPIN, 
            I0=>ti_adr(2) );
  IN_ti_adr_1_XI_1:   IBUF
 generic map( PULL => "Up")
 port map ( O=>ti_adr_1XPIN, 
            I0=>ti_adr(1) );
  IN_ti_adr_0_XI_1:   IBUF
 generic map( PULL => "Up")
 port map ( O=>ti_adr_0XPIN, 
            I0=>ti_adr(0) );
  OUT_ti_data_6_XI_1:   BUFTH port map ( I0=>ti_data_6XCOM, 
            O=>ti_data(6), 
            OE=>ti_data_6X_OE );
  OUT_ti_data_5_XI_1:   BUFTH port map ( I0=>ti_data_5XCOM, 
            O=>ti_data(5), 
            OE=>ti_data_5X_OE );
  OUT_ti_data_4_XI_1:   BUFTH port map ( I0=>ti_data_4XCOM, 
            O=>ti_data(4), 
            OE=>ti_data_4X_OE );
  OUT_out_adr_25_XI_1:   OBUF
 generic map( PULL => "Up")
 port map ( O=>out_adr(25), 
            I0=>out_adr_25XQ );
  OUT_out_adr_24_XI_1:   OBUF
 generic map( PULL => "Up")
 port map ( O=>out_adr(24), 
            I0=>out_adr_24XQ );
  OUT_out_adr_26_XI_1:   OBUF
 generic map( PULL => "Up")
 port map ( O=>out_adr(26), 
            I0=>out_adr_26XQ );
  OUT_out_adr_23_XI_1:   OBUF
 generic map( PULL => "Up")
 port map ( O=>out_adr(23), 
            I0=>out_adr_23XQ );
  OUT_out_adr_22_XI_1:   OBUF
 generic map( PULL => "Up")
 port map ( O=>out_adr(22), 
            I0=>out_adr_22XQ );
  OUT_out_adr_21_XI_1:   OBUF
 generic map( PULL => "Up")
 port map ( O=>out_adr(21), 
            I0=>out_adr_21XQ );
  OUT_out_adr_20_XI_1:   OBUF
 generic map( PULL => "Up")
 port map ( O=>out_adr(20), 
            I0=>out_adr_20XQ );
  OUT_out_adr_19_XI_1:   OBUF
 generic map( PULL => "Up")
 port map ( O=>out_adr(19), 
            I0=>out_adr_19XQ );
  OUT_out_adr_18_XI_1:   OBUF
 generic map( PULL => "Up")
 port map ( O=>out_adr(18), 
            I0=>out_adr_18XQ );
  OUT_out_adr_17_XI_1:   OBUF
 generic map( PULL => "Up")
 port map ( O=>out_adr(17), 
            I0=>out_adr_17XQ );
  OUT_out_adr_16_XI_1:   OBUF
 generic map( PULL => "Up")
 port map ( O=>out_adr(16), 
            I0=>out_adr_16XQ );
  OUT_out_adr_15_XI_1:   OBUF
 generic map( PULL => "Up")
 port map ( O=>out_adr(15), 
            I0=>out_adr_15XQ );
  OUT_out_adr_14_XI_1:   OBUF
 generic map( PULL => "Up")
 port map ( O=>out_adr(14), 
            I0=>out_adr_14XQ );
  OUT_out_adr_13_XI_1:   OBUF
 generic map( PULL => "Up")
 port map ( O=>out_adr(13), 
            I0=>out_adr_13XQ );
  FF_out_adr_25_XI_1:   DFFC port map ( D=>ti_data_0XPIN, 
            CE=>out_adr_25X_CE, 
            Q=>out_adr_25XQ, 
            CLK=>ti_wePIN );
  FF_out_adr_24_XI_1:   DFFC port map ( D=>ti_adr_12XPIN, 
            CE=>out_adr_24X_CE, 
            Q=>out_adr_24XQ, 
            CLK=>ti_wePIN );
  FF_out_adr_26_XI_1:   DFFC port map ( D=>ti_data_1XPIN, 
            CE=>out_adr_26X_CE, 
            Q=>out_adr_26XQ, 
            CLK=>ti_wePIN );
  FF_out_adr_23_XI_1:   DFFC port map ( D=>ti_adr_11XPIN, 
            CE=>out_adr_23X_CE, 
            Q=>out_adr_23XQ, 
            CLK=>ti_wePIN );
  FF_out_adr_22_XI_1:   DFFC port map ( D=>ti_adr_10XPIN, 
            CE=>out_adr_22X_CE, 
            Q=>out_adr_22XQ, 
            CLK=>ti_wePIN );
  FF_out_adr_21_XI_1:   DFFC port map ( D=>ti_adr_9XPIN, 
            CE=>out_adr_21X_CE, 
            Q=>out_adr_21XQ, 
            CLK=>ti_wePIN );
  FF_out_adr_20_XI_1:   DFFC port map ( D=>ti_adr_8XPIN, 
            CE=>out_adr_20X_CE, 
            Q=>out_adr_20XQ, 
            CLK=>ti_wePIN );
  FF_out_adr_19_XI_1:   DFFC port map ( D=>ti_adr_7XPIN, 
            CE=>out_adr_19X_CE, 
            Q=>out_adr_19XQ, 
            CLK=>ti_wePIN );
  FF_out_adr_18_XI_1:   DFFC port map ( D=>ti_adr_6XPIN, 
            CE=>out_adr_18X_CE, 
            Q=>out_adr_18XQ, 
            CLK=>ti_wePIN );
  FF_out_adr_17_XI_1:   DFFC port map ( D=>ti_adr_5XPIN, 
            CE=>out_adr_17X_CE, 
            Q=>out_adr_17XQ, 
            CLK=>ti_wePIN );
  FF_out_adr_16_XI_1:   DFFC port map ( D=>ti_adr_4XPIN, 
            CE=>out_adr_16X_CE, 
            Q=>out_adr_16XQ, 
            CLK=>ti_wePIN );
  FF_out_adr_15_XI_1:   DFFC port map ( D=>ti_adr_3XPIN, 
            CE=>out_adr_15X_CE, 
            Q=>out_adr_15XQ, 
            CLK=>ti_wePIN );
  FF_out_adr_14_XI_1:   DFFC port map ( D=>ti_adr_2XPIN, 
            CE=>out_adr_14X_CE, 
            Q=>out_adr_14XQ, 
            CLK=>ti_wePIN );
  FF_out_adr_13_XI_1:   DFFC port map ( D=>ti_adr_1XPIN, 
            CE=>out_adr_13X_CE, 
            Q=>out_adr_13XQ, 
            CLK=>ti_wePIN );
  FF_chip_0_bus_I_1:   DFFC port map ( D=>ti_data_2XPIN, 
            CE=>chip_0_bus_CE, 
            Q=>chip_0_busQ, 
            CLK=>ti_wePIN );
  FF_chip_1_bus_I_1:   DFFC port map ( D=>ti_data_3XPIN, 
            CE=>chip_1_bus_CE, 
            Q=>chip_1_busQ, 
            CLK=>ti_wePIN );
  GATE_ti_data_3_XI_1:   BUFF port map ( I0=>out_data_3XPIN, 
            O=>ti_data_3XCOM );
  GATE_ti_data_3X_OE_I_1:   AND2 port map ( O=>ti_data_3X_OE, 
            I1=>ti_wePIN, 
            I0=>GATE_ti_data_3X_OE_A );
  GATE_ti_data_3X_OE_I_2:   INV port map ( O=>GATE_ti_data_3X_OE_A, 
            I0=>ti_romPIN );
  GATE_ti_data_2_XI_1:   BUFF port map ( I0=>out_data_2XPIN, 
            O=>ti_data_2XCOM );
  GATE_ti_data_2X_OE_I_1:   AND2 port map ( O=>ti_data_2X_OE, 
            I1=>ti_wePIN, 
            I0=>GATE_ti_data_2X_OE_A );
  GATE_ti_data_2X_OE_I_2:   INV port map ( O=>GATE_ti_data_2X_OE_A, 
            I0=>ti_romPIN );
  GATE_ti_data_1_XI_1:   BUFF port map ( I0=>out_data_1XPIN, 
            O=>ti_data_1XCOM );
  GATE_ti_data_1X_OE_I_1:   AND2 port map ( O=>ti_data_1X_OE, 
            I1=>ti_wePIN, 
            I0=>GATE_ti_data_1X_OE_A );
  GATE_ti_data_1X_OE_I_2:   INV port map ( O=>GATE_ti_data_1X_OE_A, 
            I0=>ti_romPIN );
  GATE_ti_data_0_XI_1:   BUFF port map ( I0=>out_data_0XPIN, 
            O=>ti_data_0XCOM );
  GATE_ti_data_0X_OE_I_1:   AND2 port map ( O=>ti_data_0X_OE, 
            I1=>ti_wePIN, 
            I0=>GATE_ti_data_0X_OE_A );
  GATE_ti_data_0X_OE_I_2:   INV port map ( O=>GATE_ti_data_0X_OE_A, 
            I0=>ti_romPIN );
  GATE_ti_data_7_XI_1:   BUFF port map ( I0=>out_data_7XPIN, 
            O=>ti_data_7XCOM );
  GATE_ti_data_7X_OE_I_1:   AND2 port map ( O=>ti_data_7X_OE, 
            I1=>ti_wePIN, 
            I0=>GATE_ti_data_7X_OE_A );
  GATE_ti_data_7X_OE_I_2:   INV port map ( O=>GATE_ti_data_7X_OE_A, 
            I0=>ti_romPIN );
  GATE_out_rom_I_1:   BUFF port map ( I0=>ti_romPIN, 
            O=>out_romCOM );
  GATE_out_we_I_1:   BUFF port map ( I0=>ti_wePIN, 
            O=>out_weCOM );
  GATE_T_0_I_1:   NOR3 port map ( O=>T_0, 
            I2=>chip_0_busQ, 
            I1=>ti_romPIN, 
            I0=>chip_1_busQ );
  GATE_T_1_I_1:   INV port map ( I0=>chip_1_busQ, 
            O=>GATE_T_1_A );
  GATE_T_1_I_2:   INV port map ( I0=>ti_romPIN, 
            O=>GATE_T_1_B );
  GATE_T_1_I_3:   AND3 port map ( O=>T_1, 
            I0=>chip_0_busQ, 
            I2=>GATE_T_1_A, 
            I1=>GATE_T_1_B );
  GATE_T_2_I_1:   INV port map ( I0=>chip_0_busQ, 
            O=>GATE_T_2_A );
  GATE_T_2_I_2:   INV port map ( I0=>ti_romPIN, 
            O=>GATE_T_2_B );
  GATE_T_2_I_3:   AND3 port map ( O=>T_2, 
            I0=>chip_1_busQ, 
            I2=>GATE_T_2_A, 
            I1=>GATE_T_2_B );
  GATE_T_3_I_1:   INV port map ( I0=>ti_romPIN, 
            O=>GATE_T_3_A );
  GATE_T_3_I_2:   AND3 port map ( O=>T_3, 
            I2=>chip_0_busQ, 
            I1=>chip_1_busQ, 
            I0=>GATE_T_3_A );
  GATE_out_adr_12_XI_1:   BUFF port map ( I0=>ti_adr_12XPIN, 
            O=>out_adr_12XCOM );
  GATE_out_adr_11_XI_1:   BUFF port map ( I0=>ti_adr_11XPIN, 
            O=>out_adr_11XCOM );
  GATE_out_adr_10_XI_1:   BUFF port map ( I0=>ti_adr_10XPIN, 
            O=>out_adr_10XCOM );
  GATE_out_adr_9_XI_1:   BUFF port map ( I0=>ti_adr_9XPIN, 
            O=>out_adr_9XCOM );
  GATE_out_adr_8_XI_1:   BUFF port map ( I0=>ti_adr_8XPIN, 
            O=>out_adr_8XCOM );
  GATE_out_adr_7_XI_1:   BUFF port map ( I0=>ti_adr_7XPIN, 
            O=>out_adr_7XCOM );
  GATE_out_adr_6_XI_1:   BUFF port map ( I0=>ti_adr_6XPIN, 
            O=>out_adr_6XCOM );
  GATE_out_adr_5_XI_1:   BUFF port map ( I0=>ti_adr_5XPIN, 
            O=>out_adr_5XCOM );
  GATE_out_adr_4_XI_1:   BUFF port map ( I0=>ti_adr_4XPIN, 
            O=>out_adr_4XCOM );
  GATE_out_adr_3_XI_1:   BUFF port map ( I0=>ti_adr_3XPIN, 
            O=>out_adr_3XCOM );
  GATE_out_adr_2_XI_1:   BUFF port map ( I0=>ti_adr_2XPIN, 
            O=>out_adr_2XCOM );
  GATE_out_adr_1_XI_1:   BUFF port map ( I0=>ti_adr_1XPIN, 
            O=>out_adr_1XCOM );
  GATE_out_adr_0_XI_1:   BUFF port map ( I0=>ti_adr_0XPIN, 
            O=>out_adr_0XCOM );
  GATE_ti_data_6_XI_1:   BUFF port map ( I0=>out_data_6XPIN, 
            O=>ti_data_6XCOM );
  GATE_ti_data_6X_OE_I_1:   AND2 port map ( O=>ti_data_6X_OE, 
            I1=>ti_wePIN, 
            I0=>GATE_ti_data_6X_OE_A );
  GATE_ti_data_6X_OE_I_2:   INV port map ( O=>GATE_ti_data_6X_OE_A, 
            I0=>ti_romPIN );
  GATE_ti_data_5_XI_1:   BUFF port map ( I0=>out_data_5XPIN, 
            O=>ti_data_5XCOM );
  GATE_ti_data_5X_OE_I_1:   AND2 port map ( O=>ti_data_5X_OE, 
            I1=>ti_wePIN, 
            I0=>GATE_ti_data_5X_OE_A );
  GATE_ti_data_5X_OE_I_2:   INV port map ( O=>GATE_ti_data_5X_OE_A, 
            I0=>ti_romPIN );
  GATE_ti_data_4_XI_1:   BUFF port map ( I0=>out_data_4XPIN, 
            O=>ti_data_4XCOM );
  GATE_ti_data_4X_OE_I_1:   AND2 port map ( O=>ti_data_4X_OE, 
            I1=>ti_wePIN, 
            I0=>GATE_ti_data_4X_OE_A );
  GATE_ti_data_4X_OE_I_2:   INV port map ( O=>GATE_ti_data_4X_OE_A, 
            I0=>ti_romPIN );
  GATE_out_adr_25X_CE_I_1:   INV port map ( I0=>ti_romPIN, 
            O=>out_adr_25X_CE );
  GATE_out_adr_24X_CE_I_1:   INV port map ( I0=>ti_romPIN, 
            O=>out_adr_24X_CE );
  GATE_out_adr_26X_CE_I_1:   INV port map ( I0=>ti_romPIN, 
            O=>out_adr_26X_CE );
  GATE_out_adr_23X_CE_I_1:   INV port map ( I0=>ti_romPIN, 
            O=>out_adr_23X_CE );
  GATE_out_adr_22X_CE_I_1:   INV port map ( I0=>ti_romPIN, 
            O=>out_adr_22X_CE );
  GATE_out_adr_21X_CE_I_1:   INV port map ( I0=>ti_romPIN, 
            O=>out_adr_21X_CE );
  GATE_out_adr_20X_CE_I_1:   INV port map ( I0=>ti_romPIN, 
            O=>out_adr_20X_CE );
  GATE_out_adr_19X_CE_I_1:   INV port map ( I0=>ti_romPIN, 
            O=>out_adr_19X_CE );
  GATE_out_adr_18X_CE_I_1:   INV port map ( I0=>ti_romPIN, 
            O=>out_adr_18X_CE );
  GATE_out_adr_17X_CE_I_1:   INV port map ( I0=>ti_romPIN, 
            O=>out_adr_17X_CE );
  GATE_out_adr_16X_CE_I_1:   INV port map ( I0=>ti_romPIN, 
            O=>out_adr_16X_CE );
  GATE_out_adr_15X_CE_I_1:   INV port map ( I0=>ti_romPIN, 
            O=>out_adr_15X_CE );
  GATE_out_adr_14X_CE_I_1:   INV port map ( I0=>ti_romPIN, 
            O=>out_adr_14X_CE );
  GATE_out_adr_13X_CE_I_1:   INV port map ( I0=>ti_romPIN, 
            O=>out_adr_13X_CE );
  GATE_chip_0_bus_CE_I_1:   INV port map ( I0=>ti_romPIN, 
            O=>chip_0_bus_CE );
  GATE_chip_1_bus_CE_I_1:   INV port map ( I0=>ti_romPIN, 
            O=>chip_1_bus_CE );
  GATE_out_rom1_I_1:   INV port map ( I0=>T_0, 
            O=>out_rom1COM );
  GATE_out_rom2_I_1:   INV port map ( I0=>T_1, 
            O=>out_rom2COM );
  GATE_out_rom3_I_1:   INV port map ( I0=>T_2, 
            O=>out_rom3COM );
  GATE_out_rom4_I_1:   INV port map ( I0=>T_3, 
            O=>out_rom4COM );

end NetList;
