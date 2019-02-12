-- VHDL netlist-file
library mach;
use mach.components.all;

library ieee;
use ieee.std_logic_1164.all;
entity gigacart is
  port (
    out_adr : out std_logic_vector(26 downto 0);
    ti_adr : in std_logic_vector(15 downto 3);
    ti_data : inout std_logic_vector(7 downto 0);
    out_data : in std_logic_vector(7 downto 0);
    ti_we : in std_logic;
    ti_rom : in std_logic;
    ti_gsel : in std_logic;
    ti_gclk : in std_logic;
    out_reset : out std_logic
  );
end gigacart;

architecture NetList of gigacart is

  signal out_adr_6XCOM : std_logic;
  signal out_adr_5XCOM : std_logic;
  signal ti_adr_15XPIN : std_logic;
  signal out_adr_4XCOM : std_logic;
  signal out_adr_3XCOM : std_logic;
  signal ti_data_7XPIN : std_logic;
  signal ti_data_7XCOM : std_logic;
  signal out_adr_2XCOM : std_logic;
  signal out_adr_1XCOM : std_logic;
  signal out_adr_26XCOM : std_logic;
  signal out_adr_0XCOM : std_logic;
  signal out_data_6XPIN : std_logic;
  signal out_data_7XPIN : std_logic;
  signal out_data_5XPIN : std_logic;
  signal ti_wePIN : std_logic;
  signal out_data_4XPIN : std_logic;
  signal ti_romPIN : std_logic;
  signal out_data_3XPIN : std_logic;
  signal ti_gselPIN : std_logic;
  signal out_data_2XPIN : std_logic;
  signal ti_gclkPIN : std_logic;
  signal out_data_1XPIN : std_logic;
  signal out_data_0XPIN : std_logic;
  signal ti_adr_14XPIN : std_logic;
  signal ti_adr_13XPIN : std_logic;
  signal ti_adr_12XPIN : std_logic;
  signal ti_adr_11XPIN : std_logic;
  signal ti_adr_10XPIN : std_logic;
  signal ti_adr_9XPIN : std_logic;
  signal ti_adr_8XPIN : std_logic;
  signal ti_adr_7XPIN : std_logic;
  signal ti_adr_6XPIN : std_logic;
  signal ti_adr_5XPIN : std_logic;
  signal ti_adr_4XPIN : std_logic;
  signal ti_adr_3XPIN : std_logic;
  signal ti_data_6XPIN : std_logic;
  signal ti_data_6XCOM : std_logic;
  signal ti_data_5XPIN : std_logic;
  signal ti_data_5XCOM : std_logic;
  signal ti_data_4XPIN : std_logic;
  signal ti_data_4XCOM : std_logic;
  signal ti_data_3XPIN : std_logic;
  signal ti_data_3XCOM : std_logic;
  signal ti_data_2XPIN : std_logic;
  signal ti_data_2XCOM : std_logic;
  signal ti_data_1XPIN : std_logic;
  signal ti_data_1XCOM : std_logic;
  signal ti_data_0XPIN : std_logic;
  signal ti_data_0XCOM : std_logic;
  signal out_adr_25XCOM : std_logic;
  signal out_adr_24XCOM : std_logic;
  signal out_adr_23XCOM : std_logic;
  signal out_adr_22XCOM : std_logic;
  signal out_adr_21XCOM : std_logic;
  signal out_adr_20XCOM : std_logic;
  signal out_adr_19XCOM : std_logic;
  signal out_adr_18XCOM : std_logic;
  signal out_adr_17XCOM : std_logic;
  signal out_adr_16XCOM : std_logic;
  signal out_adr_15XCOM : std_logic;
  signal out_adr_14XCOM : std_logic;
  signal out_adr_13XCOM : std_logic;
  signal out_adr_12XCOM : std_logic;
  signal out_adr_11XCOM : std_logic;
  signal out_adr_10XCOM : std_logic;
  signal out_adr_9XCOM : std_logic;
  signal out_adr_8XCOM : std_logic;
  signal out_adr_7XCOM : std_logic;
  signal out_resetQ : std_logic;
  signal inst_gactiveQ : std_logic;
  signal inst_gvalidQ : std_logic;
  signal grmadr_1_busQ : std_logic;
  signal grmadr_2_busQ : std_logic;
  signal grmadr_0_busQ : std_logic;
  signal grmadr_3_busQ : std_logic;
  signal grmadr_4_busQ : std_logic;
  signal grmadr_5_busQ : std_logic;
  signal grmadr_6_busQ : std_logic;
  signal grmadr_7_busQ : std_logic;
  signal inst_grmpageQ : std_logic;
  signal latch_0_busQ : std_logic;
  signal latch_1_busQ : std_logic;
  signal latch_2_busQ : std_logic;
  signal latch_3_busQ : std_logic;
  signal latch_4_busQ : std_logic;
  signal latch_5_busQ : std_logic;
  signal latch_6_busQ : std_logic;
  signal latch_7_busQ : std_logic;
  signal latch_8_busQ : std_logic;
  signal latch_9_busQ : std_logic;
  signal latch_10_busQ : std_logic;
  signal latch_11_busQ : std_logic;
  signal latch_12_busQ : std_logic;
  signal latch_13_busQ : std_logic;
  signal T_0 : std_logic;
  signal T_1 : std_logic;
  signal T_2 : std_logic;
  signal T_3 : std_logic;
  signal T_4 : std_logic;
  signal T_5 : std_logic;
  signal T_6 : std_logic;
  signal T_7 : std_logic;
  signal T_8 : std_logic;
  signal T_9 : std_logic;
  signal T_10 : std_logic;
  signal T_11 : std_logic;
  signal T_12 : std_logic;
  signal T_13 : std_logic;
  signal T_14 : std_logic;
  signal T_15 : std_logic;
  signal T_16 : std_logic;
  signal T_17 : std_logic;
  signal T_18 : std_logic;
  signal out_reset_D : std_logic;
  signal out_reset_C : std_logic;
  signal inst_gactive_D : std_logic;
  signal T_19 : std_logic;
  signal inst_gactive_AR : std_logic;
  signal inst_gvalid_D : std_logic;
  signal T_20 : std_logic;
  signal T_21 : std_logic;
  signal inst_gvalid_AR : std_logic;
  signal T_22 : std_logic;
  signal grmadr_1_bus_CE : std_logic;
  signal T_23 : std_logic;
  signal grmadr_2_bus_CE : std_logic;
  signal T_24 : std_logic;
  signal grmadr_0_bus_CE : std_logic;
  signal T_25 : std_logic;
  signal grmadr_3_bus_CE : std_logic;
  signal T_26 : std_logic;
  signal grmadr_4_bus_CE : std_logic;
  signal T_27 : std_logic;
  signal grmadr_5_bus_CE : std_logic;
  signal T_28 : std_logic;
  signal grmadr_6_bus_CE : std_logic;
  signal T_29 : std_logic;
  signal grmadr_7_bus_CE : std_logic;
  signal inst_grmpage_D : std_logic;
  signal inst_grmpage_C : std_logic;
  signal inst_grmpage_CE : std_logic;
  signal latch_0_bus_CE : std_logic;
  signal latch_1_bus_CE : std_logic;
  signal latch_2_bus_CE : std_logic;
  signal latch_3_bus_CE : std_logic;
  signal latch_4_bus_CE : std_logic;
  signal latch_5_bus_CE : std_logic;
  signal latch_6_bus_CE : std_logic;
  signal latch_7_bus_CE : std_logic;
  signal latch_8_bus_CE : std_logic;
  signal latch_9_bus_CE : std_logic;
  signal latch_10_bus_CE : std_logic;
  signal latch_11_bus_CE : std_logic;
  signal latch_12_bus_CE : std_logic;
  signal latch_13_bus_CE : std_logic;
  signal ti_data_7X_OE : std_logic;
  signal inst_gactive_C : std_logic;
  signal inst_gvalid_C : std_logic;
  signal inst_gvalid_CE : std_logic;
  signal grmadr_1_bus_C : std_logic;
  signal grmadr_2_bus_C : std_logic;
  signal grmadr_0_bus_C : std_logic;
  signal grmadr_3_bus_C : std_logic;
  signal grmadr_4_bus_C : std_logic;
  signal grmadr_5_bus_C : std_logic;
  signal grmadr_6_bus_C : std_logic;
  signal grmadr_7_bus_C : std_logic;
  signal T_30 : std_logic;
  signal T_31 : std_logic;
  signal T_32 : std_logic;
  signal T_33 : std_logic;
  signal T_34 : std_logic;
  signal T_35 : std_logic;
  signal T_36 : std_logic;
  signal T_37 : std_logic;
  signal T_38 : std_logic;
  signal T_39 : std_logic;
  signal T_40 : std_logic;
  signal T_41 : std_logic;
  signal T_42 : std_logic;
  signal T_43 : std_logic;
  signal T_44 : std_logic;
  signal T_45 : std_logic;
  signal T_46 : std_logic;
  signal T_47 : std_logic;
  signal T_48 : std_logic;
  signal GATE_inst_gactive_D_A : std_logic;
  signal GATE_inst_gactive_D_B : std_logic;
  signal GATE_inst_gvalid_D_A : std_logic;
  signal GATE_inst_gvalid_D_B : std_logic;
  signal GATE_T_21_DN : std_logic;
  signal GATE_grmadr_1_bus_CE_A : std_logic;
  signal GATE_grmadr_2_bus_CE_A : std_logic;
  signal GATE_grmadr_0_bus_CE_A : std_logic;
  signal GATE_grmadr_3_bus_CE_A : std_logic;
  signal GATE_grmadr_4_bus_CE_A : std_logic;
  signal GATE_grmadr_5_bus_CE_A : std_logic;
  signal GATE_grmadr_6_bus_CE_A : std_logic;
  signal GATE_grmadr_7_bus_CE_A : std_logic;
  signal GATE_inst_grmpage_D_A : std_logic;
  signal GATE_inst_grmpage_D_B : std_logic;
  signal GATE_inst_grmpage_CE_A : std_logic;
  signal GATE_T_30_A : std_logic;
  signal GATE_T_32_A : std_logic;
  signal GATE_T_34_A : std_logic;
  signal GATE_T_36_A : std_logic;
  signal GATE_T_38_A : std_logic;
  signal GATE_T_40_A : std_logic;
  signal GATE_T_42_A : std_logic;
  signal GATE_T_44_A : std_logic;
  signal GATE_T_46_A : std_logic;
  signal GATE_T_48_A : std_logic;

begin
  OUT_out_adr_6_XI_1:   OBUF
 generic map( PULL => "Up")
 port map ( O=>out_adr(6), 
            I0=>out_adr_6XCOM );
  OUT_out_adr_5_XI_1:   OBUF
 generic map( PULL => "Up")
 port map ( O=>out_adr(5), 
            I0=>out_adr_5XCOM );
  IN_ti_adr_15_XI_1:   IBUF
 generic map( PULL => "Up")
 port map ( O=>ti_adr_15XPIN, 
            I0=>ti_adr(15) );
  OUT_out_adr_4_XI_1:   OBUF
 generic map( PULL => "Up")
 port map ( O=>out_adr(4), 
            I0=>out_adr_4XCOM );
  OUT_out_adr_3_XI_1:   OBUF
 generic map( PULL => "Up")
 port map ( O=>out_adr(3), 
            I0=>out_adr_3XCOM );
  OUT_ti_data_7_XI_1:   BI_DIR
 generic map( PULL => "Up")
 port map ( O=>ti_data_7XPIN, 
            I0=>ti_data_7XCOM, 
            IO=>ti_data(7), 
            OE=>ti_data_7X_OE );
  OUT_out_adr_2_XI_1:   OBUF
 generic map( PULL => "Up")
 port map ( O=>out_adr(2), 
            I0=>out_adr_2XCOM );
  OUT_out_adr_1_XI_1:   OBUF
 generic map( PULL => "Up")
 port map ( O=>out_adr(1), 
            I0=>out_adr_1XCOM );
  OUT_out_adr_26_XI_1:   OBUF
 generic map( PULL => "Up")
 port map ( O=>out_adr(26), 
            I0=>out_adr_26XCOM );
  OUT_out_adr_0_XI_1:   OBUF
 generic map( PULL => "Up")
 port map ( O=>out_adr(0), 
            I0=>out_adr_0XCOM );
  IN_out_data_6_XI_1:   IBUF
 generic map( PULL => "Up")
 port map ( O=>out_data_6XPIN, 
            I0=>out_data(6) );
  IN_out_data_7_XI_1:   IBUF
 generic map( PULL => "Up")
 port map ( O=>out_data_7XPIN, 
            I0=>out_data(7) );
  IN_out_data_5_XI_1:   IBUF
 generic map( PULL => "Up")
 port map ( O=>out_data_5XPIN, 
            I0=>out_data(5) );
  IN_ti_we_I_1:   IBUF
 generic map( PULL => "Up")
 port map ( O=>ti_wePIN, 
            I0=>ti_we );
  IN_out_data_4_XI_1:   IBUF
 generic map( PULL => "Up")
 port map ( O=>out_data_4XPIN, 
            I0=>out_data(4) );
  IN_ti_rom_I_1:   IBUF
 generic map( PULL => "Up")
 port map ( O=>ti_romPIN, 
            I0=>ti_rom );
  IN_out_data_3_XI_1:   IBUF
 generic map( PULL => "Up")
 port map ( O=>out_data_3XPIN, 
            I0=>out_data(3) );
  IN_ti_gsel_I_1:   IBUF
 generic map( PULL => "Up")
 port map ( O=>ti_gselPIN, 
            I0=>ti_gsel );
  IN_out_data_2_XI_1:   IBUF
 generic map( PULL => "Up")
 port map ( O=>out_data_2XPIN, 
            I0=>out_data(2) );
  IN_ti_gclk_I_1:   IBUF
 generic map( PULL => "Up")
 port map ( O=>ti_gclkPIN, 
            I0=>ti_gclk );
  IN_out_data_1_XI_1:   IBUF
 generic map( PULL => "Up")
 port map ( O=>out_data_1XPIN, 
            I0=>out_data(1) );
  IN_out_data_0_XI_1:   IBUF
 generic map( PULL => "Up")
 port map ( O=>out_data_0XPIN, 
            I0=>out_data(0) );
  IN_ti_adr_14_XI_1:   IBUF
 generic map( PULL => "Up")
 port map ( O=>ti_adr_14XPIN, 
            I0=>ti_adr(14) );
  IN_ti_adr_13_XI_1:   IBUF
 generic map( PULL => "Up")
 port map ( O=>ti_adr_13XPIN, 
            I0=>ti_adr(13) );
  IN_ti_adr_12_XI_1:   IBUF
 generic map( PULL => "Up")
 port map ( O=>ti_adr_12XPIN, 
            I0=>ti_adr(12) );
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
  OUT_ti_data_6_XI_1:   BI_DIR
 generic map( PULL => "Up")
 port map ( O=>ti_data_6XPIN, 
            I0=>ti_data_6XCOM, 
            IO=>ti_data(6), 
            OE=>ti_data_7X_OE );
  OUT_ti_data_5_XI_1:   BI_DIR
 generic map( PULL => "Up")
 port map ( O=>ti_data_5XPIN, 
            I0=>ti_data_5XCOM, 
            IO=>ti_data(5), 
            OE=>ti_data_7X_OE );
  OUT_ti_data_4_XI_1:   BI_DIR
 generic map( PULL => "Up")
 port map ( O=>ti_data_4XPIN, 
            I0=>ti_data_4XCOM, 
            IO=>ti_data(4), 
            OE=>ti_data_7X_OE );
  OUT_ti_data_3_XI_1:   BI_DIR
 generic map( PULL => "Up")
 port map ( O=>ti_data_3XPIN, 
            I0=>ti_data_3XCOM, 
            IO=>ti_data(3), 
            OE=>ti_data_7X_OE );
  OUT_ti_data_2_XI_1:   BI_DIR
 generic map( PULL => "Up")
 port map ( O=>ti_data_2XPIN, 
            I0=>ti_data_2XCOM, 
            IO=>ti_data(2), 
            OE=>ti_data_7X_OE );
  OUT_ti_data_1_XI_1:   BI_DIR
 generic map( PULL => "Up")
 port map ( O=>ti_data_1XPIN, 
            I0=>ti_data_1XCOM, 
            IO=>ti_data(1), 
            OE=>ti_data_7X_OE );
  OUT_ti_data_0_XI_1:   BI_DIR
 generic map( PULL => "Up")
 port map ( O=>ti_data_0XPIN, 
            I0=>ti_data_0XCOM, 
            IO=>ti_data(0), 
            OE=>ti_data_7X_OE );
  OUT_out_adr_25_XI_1:   OBUF
 generic map( PULL => "Up")
 port map ( O=>out_adr(25), 
            I0=>out_adr_25XCOM );
  OUT_out_adr_24_XI_1:   OBUF
 generic map( PULL => "Up")
 port map ( O=>out_adr(24), 
            I0=>out_adr_24XCOM );
  OUT_out_adr_23_XI_1:   OBUF
 generic map( PULL => "Up")
 port map ( O=>out_adr(23), 
            I0=>out_adr_23XCOM );
  OUT_out_adr_22_XI_1:   OBUF
 generic map( PULL => "Up")
 port map ( O=>out_adr(22), 
            I0=>out_adr_22XCOM );
  OUT_out_adr_21_XI_1:   OBUF
 generic map( PULL => "Up")
 port map ( O=>out_adr(21), 
            I0=>out_adr_21XCOM );
  OUT_out_adr_20_XI_1:   OBUF
 generic map( PULL => "Up")
 port map ( O=>out_adr(20), 
            I0=>out_adr_20XCOM );
  OUT_out_adr_19_XI_1:   OBUF
 generic map( PULL => "Up")
 port map ( O=>out_adr(19), 
            I0=>out_adr_19XCOM );
  OUT_out_adr_18_XI_1:   OBUF
 generic map( PULL => "Up")
 port map ( O=>out_adr(18), 
            I0=>out_adr_18XCOM );
  OUT_out_adr_17_XI_1:   OBUF
 generic map( PULL => "Up")
 port map ( O=>out_adr(17), 
            I0=>out_adr_17XCOM );
  OUT_out_adr_16_XI_1:   OBUF
 generic map( PULL => "Up")
 port map ( O=>out_adr(16), 
            I0=>out_adr_16XCOM );
  OUT_out_adr_15_XI_1:   OBUF
 generic map( PULL => "Up")
 port map ( O=>out_adr(15), 
            I0=>out_adr_15XCOM );
  OUT_out_adr_14_XI_1:   OBUF
 generic map( PULL => "Up")
 port map ( O=>out_adr(14), 
            I0=>out_adr_14XCOM );
  OUT_out_adr_13_XI_1:   OBUF
 generic map( PULL => "Up")
 port map ( O=>out_adr(13), 
            I0=>out_adr_13XCOM );
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
  OUT_out_reset_I_1:   OBUF
 generic map( PULL => "Up")
 port map ( O=>out_reset, 
            I0=>out_resetQ );
  FF_out_reset_I_1:   DFF port map ( D=>out_reset_D, 
            Q=>out_resetQ, 
            CLK=>out_reset_C );
  FF_inst_gactive_I_1:   DFFRH port map ( Q=>inst_gactiveQ, 
            R=>inst_gactive_AR, 
            CLK=>inst_gactive_C, 
            D=>inst_gactive_D );
  FF_inst_gvalid_I_1:   DFFCRH port map ( Q=>inst_gvalidQ, 
            R=>inst_gvalid_AR, 
            CLK=>inst_gvalid_C, 
            CE=>inst_gvalid_CE, 
            D=>inst_gvalid_D );
  FF_grmadr_1_bus_I_1:   DFFC port map ( D=>ti_data_1XPIN, 
            CE=>grmadr_1_bus_CE, 
            Q=>grmadr_1_busQ, 
            CLK=>grmadr_1_bus_C );
  FF_grmadr_2_bus_I_1:   DFFC port map ( D=>ti_data_2XPIN, 
            CE=>grmadr_2_bus_CE, 
            Q=>grmadr_2_busQ, 
            CLK=>grmadr_2_bus_C );
  FF_grmadr_0_bus_I_1:   DFFC port map ( D=>ti_data_0XPIN, 
            CE=>grmadr_0_bus_CE, 
            Q=>grmadr_0_busQ, 
            CLK=>grmadr_0_bus_C );
  FF_grmadr_3_bus_I_1:   DFFC port map ( D=>ti_data_3XPIN, 
            CE=>grmadr_3_bus_CE, 
            Q=>grmadr_3_busQ, 
            CLK=>grmadr_3_bus_C );
  FF_grmadr_4_bus_I_1:   DFFC port map ( D=>ti_data_4XPIN, 
            CE=>grmadr_4_bus_CE, 
            Q=>grmadr_4_busQ, 
            CLK=>grmadr_4_bus_C );
  FF_grmadr_5_bus_I_1:   DFFC port map ( D=>ti_data_5XPIN, 
            CE=>grmadr_5_bus_CE, 
            Q=>grmadr_5_busQ, 
            CLK=>grmadr_5_bus_C );
  FF_grmadr_6_bus_I_1:   DFFC port map ( D=>ti_data_6XPIN, 
            CE=>grmadr_6_bus_CE, 
            Q=>grmadr_6_busQ, 
            CLK=>grmadr_6_bus_C );
  FF_grmadr_7_bus_I_1:   DFFC port map ( D=>ti_data_7XPIN, 
            CE=>grmadr_7_bus_CE, 
            Q=>grmadr_7_busQ, 
            CLK=>grmadr_7_bus_C );
  FF_inst_grmpage_I_1:   DFFC port map ( D=>inst_grmpage_D, 
            CE=>inst_grmpage_CE, 
            Q=>inst_grmpageQ, 
            CLK=>inst_grmpage_C );
  FF_latch_0_bus_I_1:   DFFC port map ( D=>ti_adr_14XPIN, 
            CE=>latch_0_bus_CE, 
            Q=>latch_0_busQ, 
            CLK=>ti_wePIN );
  FF_latch_1_bus_I_1:   DFFC port map ( D=>ti_adr_13XPIN, 
            CE=>latch_1_bus_CE, 
            Q=>latch_1_busQ, 
            CLK=>ti_wePIN );
  FF_latch_2_bus_I_1:   DFFC port map ( D=>ti_adr_12XPIN, 
            CE=>latch_2_bus_CE, 
            Q=>latch_2_busQ, 
            CLK=>ti_wePIN );
  FF_latch_3_bus_I_1:   DFFC port map ( D=>ti_adr_11XPIN, 
            CE=>latch_3_bus_CE, 
            Q=>latch_3_busQ, 
            CLK=>ti_wePIN );
  FF_latch_4_bus_I_1:   DFFC port map ( D=>ti_adr_10XPIN, 
            CE=>latch_4_bus_CE, 
            Q=>latch_4_busQ, 
            CLK=>ti_wePIN );
  FF_latch_5_bus_I_1:   DFFC port map ( D=>ti_adr_9XPIN, 
            CE=>latch_5_bus_CE, 
            Q=>latch_5_busQ, 
            CLK=>ti_wePIN );
  FF_latch_6_bus_I_1:   DFFC port map ( D=>ti_adr_8XPIN, 
            CE=>latch_6_bus_CE, 
            Q=>latch_6_busQ, 
            CLK=>ti_wePIN );
  FF_latch_7_bus_I_1:   DFFC port map ( D=>ti_adr_7XPIN, 
            CE=>latch_7_bus_CE, 
            Q=>latch_7_busQ, 
            CLK=>ti_wePIN );
  FF_latch_8_bus_I_1:   DFFC port map ( D=>ti_adr_6XPIN, 
            CE=>latch_8_bus_CE, 
            Q=>latch_8_busQ, 
            CLK=>ti_wePIN );
  FF_latch_9_bus_I_1:   DFFC port map ( D=>ti_adr_5XPIN, 
            CE=>latch_9_bus_CE, 
            Q=>latch_9_busQ, 
            CLK=>ti_wePIN );
  FF_latch_10_bus_I_1:   DFFC port map ( D=>ti_adr_4XPIN, 
            CE=>latch_10_bus_CE, 
            Q=>latch_10_busQ, 
            CLK=>ti_wePIN );
  FF_latch_11_bus_I_1:   DFFC port map ( D=>ti_adr_3XPIN, 
            CE=>latch_11_bus_CE, 
            Q=>latch_11_busQ, 
            CLK=>ti_wePIN );
  FF_latch_12_bus_I_1:   DFFC port map ( D=>ti_data_7XPIN, 
            CE=>latch_12_bus_CE, 
            Q=>latch_12_busQ, 
            CLK=>ti_wePIN );
  FF_latch_13_bus_I_1:   DFFC port map ( D=>ti_data_6XPIN, 
            CE=>latch_13_bus_CE, 
            Q=>latch_13_busQ, 
            CLK=>ti_wePIN );
  GATE_out_adr_6_XI_1:   OR2 port map ( O=>out_adr_6XCOM, 
            I1=>T_48, 
            I0=>T_47 );
  GATE_out_adr_5_XI_1:   OR2 port map ( O=>out_adr_5XCOM, 
            I1=>T_46, 
            I0=>T_45 );
  GATE_out_adr_4_XI_1:   OR2 port map ( O=>out_adr_4XCOM, 
            I1=>T_44, 
            I0=>T_43 );
  GATE_out_adr_3_XI_1:   OR2 port map ( O=>out_adr_3XCOM, 
            I1=>T_42, 
            I0=>T_41 );
  GATE_ti_data_7_XI_1:   BUFF port map ( I0=>out_data_0XPIN, 
            O=>ti_data_7XCOM );
  GATE_out_adr_2_XI_1:   OR2 port map ( O=>out_adr_2XCOM, 
            I1=>T_38, 
            I0=>T_37 );
  GATE_out_adr_1_XI_1:   OR2 port map ( O=>out_adr_1XCOM, 
            I1=>T_36, 
            I0=>T_35 );
  GATE_T_0_I_1:   NOR2 port map ( O=>T_0, 
            I1=>latch_13_busQ, 
            I0=>inst_gvalidQ );
  GATE_out_adr_0_XI_1:   OR2 port map ( O=>out_adr_0XCOM, 
            I1=>T_34, 
            I0=>T_33 );
  GATE_ti_data_6_XI_1:   BUFF port map ( I0=>out_data_1XPIN, 
            O=>ti_data_6XCOM );
  GATE_ti_data_5_XI_1:   BUFF port map ( I0=>out_data_2XPIN, 
            O=>ti_data_5XCOM );
  GATE_ti_data_4_XI_1:   BUFF port map ( I0=>out_data_3XPIN, 
            O=>ti_data_4XCOM );
  GATE_ti_data_3_XI_1:   BUFF port map ( I0=>out_data_4XPIN, 
            O=>ti_data_3XCOM );
  GATE_ti_data_2_XI_1:   BUFF port map ( I0=>out_data_5XPIN, 
            O=>ti_data_2XCOM );
  GATE_ti_data_1_XI_1:   BUFF port map ( I0=>out_data_6XPIN, 
            O=>ti_data_1XCOM );
  GATE_ti_data_0_XI_1:   BUFF port map ( I0=>out_data_7XPIN, 
            O=>ti_data_0XCOM );
  GATE_T_1_I_1:   NOR2 port map ( O=>T_1, 
            I1=>latch_12_busQ, 
            I0=>inst_gvalidQ );
  GATE_T_2_I_1:   NOR2 port map ( O=>T_2, 
            I1=>latch_11_busQ, 
            I0=>inst_gvalidQ );
  GATE_T_3_I_1:   NOR2 port map ( O=>T_3, 
            I1=>latch_10_busQ, 
            I0=>inst_gvalidQ );
  GATE_T_4_I_1:   NOR2 port map ( O=>T_4, 
            I1=>latch_9_busQ, 
            I0=>inst_gvalidQ );
  GATE_T_5_I_1:   NOR2 port map ( O=>T_5, 
            I1=>latch_8_busQ, 
            I0=>inst_gvalidQ );
  GATE_T_6_I_1:   NOR2 port map ( O=>T_6, 
            I1=>latch_7_busQ, 
            I0=>inst_gvalidQ );
  GATE_T_7_I_1:   NOR2 port map ( O=>T_7, 
            I1=>latch_6_busQ, 
            I0=>inst_gvalidQ );
  GATE_T_8_I_1:   NOR2 port map ( O=>T_8, 
            I1=>latch_5_busQ, 
            I0=>inst_gvalidQ );
  GATE_T_9_I_1:   NOR2 port map ( O=>T_9, 
            I1=>latch_4_busQ, 
            I0=>inst_gvalidQ );
  GATE_T_10_I_1:   NOR2 port map ( O=>T_10, 
            I1=>latch_3_busQ, 
            I0=>inst_gvalidQ );
  GATE_T_11_I_1:   NOR2 port map ( O=>T_11, 
            I1=>latch_2_busQ, 
            I0=>inst_gvalidQ );
  GATE_T_12_I_1:   NOR2 port map ( O=>T_12, 
            I1=>latch_1_busQ, 
            I0=>inst_gvalidQ );
  GATE_T_13_I_1:   NOR2 port map ( O=>T_13, 
            I1=>latch_0_busQ, 
            I0=>inst_gvalidQ );
  GATE_T_14_I_1:   NOR2 port map ( O=>T_14, 
            I1=>inst_gvalidQ, 
            I0=>ti_adr_3XPIN );
  GATE_T_15_I_1:   NOR2 port map ( O=>T_15, 
            I1=>inst_gvalidQ, 
            I0=>ti_adr_4XPIN );
  GATE_T_16_I_1:   NOR2 port map ( O=>T_16, 
            I1=>inst_gvalidQ, 
            I0=>ti_adr_5XPIN );
  GATE_T_17_I_1:   NOR2 port map ( O=>T_17, 
            I1=>inst_gvalidQ, 
            I0=>ti_adr_6XPIN );
  GATE_T_18_I_1:   NOR2 port map ( O=>T_18, 
            I1=>inst_gvalidQ, 
            I0=>ti_adr_7XPIN );
  GATE_out_adr_7_XI_1:   OR2 port map ( O=>out_adr_7XCOM, 
            I1=>T_32, 
            I0=>T_31 );
  GATE_out_reset_D_I_1:   OR2 port map ( O=>out_reset_D, 
            I1=>T_30, 
            I0=>out_resetQ );
  GATE_out_reset_C_I_1:   INV port map ( I0=>ti_wePIN, 
            O=>out_reset_C );
  GATE_inst_gactive_D_I_1:   INV port map ( I0=>ti_adr_14XPIN, 
            O=>GATE_inst_gactive_D_A );
  GATE_inst_gactive_D_I_2:   INV port map ( I0=>ti_gselPIN, 
            O=>GATE_inst_gactive_D_B );
  GATE_inst_gactive_D_I_3:   AND3 port map ( O=>inst_gactive_D, 
            I0=>inst_grmpageQ, 
            I2=>GATE_inst_gactive_D_A, 
            I1=>GATE_inst_gactive_D_B );
  GATE_T_19_I_1:   NOR2 port map ( O=>T_19, 
            I1=>ti_gclkPIN, 
            I0=>ti_gselPIN );
  GATE_inst_gactive_AR_I_1:   AND2 port map ( O=>inst_gactive_AR, 
            I1=>ti_gclkPIN, 
            I0=>ti_gselPIN );
  GATE_inst_gvalid_D_I_1:   INV port map ( I0=>ti_adr_14XPIN, 
            O=>GATE_inst_gvalid_D_A );
  GATE_inst_gvalid_D_I_2:   INV port map ( I0=>ti_gselPIN, 
            O=>GATE_inst_gvalid_D_B );
  GATE_inst_gvalid_D_I_3:   AND3 port map ( O=>inst_gvalid_D, 
            I0=>inst_grmpageQ, 
            I2=>GATE_inst_gvalid_D_A, 
            I1=>GATE_inst_gvalid_D_B );
  GATE_T_20_I_1:   NOR2 port map ( O=>T_20, 
            I1=>ti_gclkPIN, 
            I0=>ti_gselPIN );
  GATE_T_21_I_1:   NOR4 port map ( I0=>ti_gselPIN, 
            I1=>ti_adr_14XPIN, 
            O=>T_21, 
            I2=>inst_gactiveQ, 
            I3=>GATE_T_21_DN );
  GATE_T_21_I_2:   INV port map ( I0=>inst_grmpageQ, 
            O=>GATE_T_21_DN );
  GATE_inst_gvalid_AR_I_1:   AND2 port map ( O=>inst_gvalid_AR, 
            I1=>ti_gclkPIN, 
            I0=>ti_gselPIN );
  GATE_T_22_I_1:   AND2 port map ( O=>T_22, 
            I1=>inst_gvalidQ, 
            I0=>ti_wePIN );
  GATE_grmadr_1_bus_CE_I_1:   AND2 port map ( O=>grmadr_1_bus_CE, 
            I1=>ti_adr_14XPIN, 
            I0=>GATE_grmadr_1_bus_CE_A );
  GATE_grmadr_1_bus_CE_I_2:   INV port map ( O=>GATE_grmadr_1_bus_CE_A, 
            I0=>ti_gselPIN );
  GATE_T_23_I_1:   AND2 port map ( O=>T_23, 
            I1=>inst_gvalidQ, 
            I0=>ti_wePIN );
  GATE_grmadr_2_bus_CE_I_1:   AND2 port map ( O=>grmadr_2_bus_CE, 
            I1=>ti_adr_14XPIN, 
            I0=>GATE_grmadr_2_bus_CE_A );
  GATE_grmadr_2_bus_CE_I_2:   INV port map ( O=>GATE_grmadr_2_bus_CE_A, 
            I0=>ti_gselPIN );
  GATE_T_24_I_1:   AND2 port map ( O=>T_24, 
            I1=>inst_gvalidQ, 
            I0=>ti_wePIN );
  GATE_grmadr_0_bus_CE_I_1:   AND2 port map ( O=>grmadr_0_bus_CE, 
            I1=>ti_adr_14XPIN, 
            I0=>GATE_grmadr_0_bus_CE_A );
  GATE_grmadr_0_bus_CE_I_2:   INV port map ( O=>GATE_grmadr_0_bus_CE_A, 
            I0=>ti_gselPIN );
  GATE_T_25_I_1:   AND2 port map ( O=>T_25, 
            I1=>inst_gvalidQ, 
            I0=>ti_wePIN );
  GATE_grmadr_3_bus_CE_I_1:   AND2 port map ( O=>grmadr_3_bus_CE, 
            I1=>ti_adr_14XPIN, 
            I0=>GATE_grmadr_3_bus_CE_A );
  GATE_grmadr_3_bus_CE_I_2:   INV port map ( O=>GATE_grmadr_3_bus_CE_A, 
            I0=>ti_gselPIN );
  GATE_T_26_I_1:   AND2 port map ( O=>T_26, 
            I1=>inst_gvalidQ, 
            I0=>ti_wePIN );
  GATE_grmadr_4_bus_CE_I_1:   AND2 port map ( O=>grmadr_4_bus_CE, 
            I1=>ti_adr_14XPIN, 
            I0=>GATE_grmadr_4_bus_CE_A );
  GATE_grmadr_4_bus_CE_I_2:   INV port map ( O=>GATE_grmadr_4_bus_CE_A, 
            I0=>ti_gselPIN );
  GATE_T_27_I_1:   AND2 port map ( O=>T_27, 
            I1=>inst_gvalidQ, 
            I0=>ti_wePIN );
  GATE_grmadr_5_bus_CE_I_1:   AND2 port map ( O=>grmadr_5_bus_CE, 
            I1=>ti_adr_14XPIN, 
            I0=>GATE_grmadr_5_bus_CE_A );
  GATE_grmadr_5_bus_CE_I_2:   INV port map ( O=>GATE_grmadr_5_bus_CE_A, 
            I0=>ti_gselPIN );
  GATE_T_28_I_1:   AND2 port map ( O=>T_28, 
            I1=>inst_gvalidQ, 
            I0=>ti_wePIN );
  GATE_grmadr_6_bus_CE_I_1:   AND2 port map ( O=>grmadr_6_bus_CE, 
            I1=>ti_adr_14XPIN, 
            I0=>GATE_grmadr_6_bus_CE_A );
  GATE_grmadr_6_bus_CE_I_2:   INV port map ( O=>GATE_grmadr_6_bus_CE_A, 
            I0=>ti_gselPIN );
  GATE_T_29_I_1:   AND2 port map ( O=>T_29, 
            I1=>inst_gvalidQ, 
            I0=>ti_wePIN );
  GATE_grmadr_7_bus_CE_I_1:   AND2 port map ( O=>grmadr_7_bus_CE, 
            I1=>ti_adr_14XPIN, 
            I0=>GATE_grmadr_7_bus_CE_A );
  GATE_grmadr_7_bus_CE_I_2:   INV port map ( O=>GATE_grmadr_7_bus_CE_A, 
            I0=>ti_gselPIN );
  GATE_inst_grmpage_D_I_1:   INV port map ( I0=>grmadr_2_busQ, 
            O=>GATE_inst_grmpage_D_A );
  GATE_inst_grmpage_D_I_2:   INV port map ( I0=>grmadr_1_busQ, 
            O=>GATE_inst_grmpage_D_B );
  GATE_inst_grmpage_D_I_3:   AND3 port map ( O=>inst_grmpage_D, 
            I0=>grmadr_0_busQ, 
            I2=>GATE_inst_grmpage_D_A, 
            I1=>GATE_inst_grmpage_D_B );
  GATE_inst_grmpage_C_I_1:   INV port map ( I0=>ti_wePIN, 
            O=>inst_grmpage_C );
  GATE_inst_grmpage_CE_I_1:   AND2 port map ( O=>inst_grmpage_CE, 
            I1=>ti_adr_14XPIN, 
            I0=>GATE_inst_grmpage_CE_A );
  GATE_inst_grmpage_CE_I_2:   INV port map ( O=>GATE_inst_grmpage_CE_A, 
            I0=>ti_gselPIN );
  GATE_latch_0_bus_CE_I_1:   INV port map ( I0=>ti_romPIN, 
            O=>latch_0_bus_CE );
  GATE_latch_1_bus_CE_I_1:   INV port map ( I0=>ti_romPIN, 
            O=>latch_1_bus_CE );
  GATE_latch_2_bus_CE_I_1:   INV port map ( I0=>ti_romPIN, 
            O=>latch_2_bus_CE );
  GATE_latch_3_bus_CE_I_1:   INV port map ( I0=>ti_romPIN, 
            O=>latch_3_bus_CE );
  GATE_latch_4_bus_CE_I_1:   INV port map ( I0=>ti_romPIN, 
            O=>latch_4_bus_CE );
  GATE_latch_5_bus_CE_I_1:   INV port map ( I0=>ti_romPIN, 
            O=>latch_5_bus_CE );
  GATE_latch_6_bus_CE_I_1:   INV port map ( I0=>ti_romPIN, 
            O=>latch_6_bus_CE );
  GATE_latch_7_bus_CE_I_1:   INV port map ( I0=>ti_romPIN, 
            O=>latch_7_bus_CE );
  GATE_latch_8_bus_CE_I_1:   INV port map ( I0=>ti_romPIN, 
            O=>latch_8_bus_CE );
  GATE_latch_9_bus_CE_I_1:   INV port map ( I0=>ti_romPIN, 
            O=>latch_9_bus_CE );
  GATE_latch_10_bus_CE_I_1:   INV port map ( I0=>ti_romPIN, 
            O=>latch_10_bus_CE );
  GATE_latch_11_bus_CE_I_1:   INV port map ( I0=>ti_romPIN, 
            O=>latch_11_bus_CE );
  GATE_latch_12_bus_CE_I_1:   INV port map ( I0=>ti_romPIN, 
            O=>latch_12_bus_CE );
  GATE_latch_13_bus_CE_I_1:   INV port map ( I0=>ti_romPIN, 
            O=>latch_13_bus_CE );
  GATE_ti_data_7X_OE_I_1:   OR2 port map ( O=>ti_data_7X_OE, 
            I1=>T_40, 
            I0=>T_39 );
  GATE_out_adr_26_XI_1:   INV port map ( I0=>T_0, 
            O=>out_adr_26XCOM );
  GATE_out_adr_25_XI_1:   INV port map ( I0=>T_1, 
            O=>out_adr_25XCOM );
  GATE_out_adr_24_XI_1:   INV port map ( I0=>T_2, 
            O=>out_adr_24XCOM );
  GATE_out_adr_23_XI_1:   INV port map ( I0=>T_3, 
            O=>out_adr_23XCOM );
  GATE_out_adr_22_XI_1:   INV port map ( I0=>T_4, 
            O=>out_adr_22XCOM );
  GATE_out_adr_21_XI_1:   INV port map ( I0=>T_5, 
            O=>out_adr_21XCOM );
  GATE_out_adr_20_XI_1:   INV port map ( I0=>T_6, 
            O=>out_adr_20XCOM );
  GATE_out_adr_19_XI_1:   INV port map ( I0=>T_7, 
            O=>out_adr_19XCOM );
  GATE_out_adr_18_XI_1:   INV port map ( I0=>T_8, 
            O=>out_adr_18XCOM );
  GATE_out_adr_17_XI_1:   INV port map ( I0=>T_9, 
            O=>out_adr_17XCOM );
  GATE_out_adr_16_XI_1:   INV port map ( I0=>T_10, 
            O=>out_adr_16XCOM );
  GATE_out_adr_15_XI_1:   INV port map ( I0=>T_11, 
            O=>out_adr_15XCOM );
  GATE_out_adr_14_XI_1:   INV port map ( I0=>T_12, 
            O=>out_adr_14XCOM );
  GATE_out_adr_13_XI_1:   INV port map ( I0=>T_13, 
            O=>out_adr_13XCOM );
  GATE_out_adr_12_XI_1:   INV port map ( I0=>T_14, 
            O=>out_adr_12XCOM );
  GATE_out_adr_11_XI_1:   INV port map ( I0=>T_15, 
            O=>out_adr_11XCOM );
  GATE_out_adr_10_XI_1:   INV port map ( I0=>T_16, 
            O=>out_adr_10XCOM );
  GATE_out_adr_9_XI_1:   INV port map ( I0=>T_17, 
            O=>out_adr_9XCOM );
  GATE_out_adr_8_XI_1:   INV port map ( I0=>T_18, 
            O=>out_adr_8XCOM );
  GATE_inst_gactive_C_I_1:   INV port map ( I0=>T_19, 
            O=>inst_gactive_C );
  GATE_inst_gvalid_C_I_1:   INV port map ( I0=>T_20, 
            O=>inst_gvalid_C );
  GATE_inst_gvalid_CE_I_1:   INV port map ( I0=>T_21, 
            O=>inst_gvalid_CE );
  GATE_grmadr_1_bus_C_I_1:   INV port map ( I0=>T_22, 
            O=>grmadr_1_bus_C );
  GATE_grmadr_2_bus_C_I_1:   INV port map ( I0=>T_23, 
            O=>grmadr_2_bus_C );
  GATE_grmadr_0_bus_C_I_1:   INV port map ( I0=>T_24, 
            O=>grmadr_0_bus_C );
  GATE_grmadr_3_bus_C_I_1:   INV port map ( I0=>T_25, 
            O=>grmadr_3_bus_C );
  GATE_grmadr_4_bus_C_I_1:   INV port map ( I0=>T_26, 
            O=>grmadr_4_bus_C );
  GATE_grmadr_5_bus_C_I_1:   INV port map ( I0=>T_27, 
            O=>grmadr_5_bus_C );
  GATE_grmadr_6_bus_C_I_1:   INV port map ( I0=>T_28, 
            O=>grmadr_6_bus_C );
  GATE_grmadr_7_bus_C_I_1:   INV port map ( I0=>T_29, 
            O=>grmadr_7_bus_C );
  GATE_T_30_I_1:   AND2 port map ( O=>T_30, 
            I1=>ti_adr_14XPIN, 
            I0=>GATE_T_30_A );
  GATE_T_30_I_2:   INV port map ( O=>GATE_T_30_A, 
            I0=>ti_gselPIN );
  GATE_T_31_I_1:   AND2 port map ( O=>T_31, 
            I1=>grmadr_0_busQ, 
            I0=>inst_gvalidQ );
  GATE_T_32_I_1:   AND2 port map ( O=>T_32, 
            I1=>ti_adr_8XPIN, 
            I0=>GATE_T_32_A );
  GATE_T_32_I_2:   INV port map ( O=>GATE_T_32_A, 
            I0=>inst_gvalidQ );
  GATE_T_33_I_1:   AND2 port map ( O=>T_33, 
            I1=>grmadr_7_busQ, 
            I0=>inst_gvalidQ );
  GATE_T_34_I_1:   AND2 port map ( O=>T_34, 
            I1=>ti_adr_15XPIN, 
            I0=>GATE_T_34_A );
  GATE_T_34_I_2:   INV port map ( O=>GATE_T_34_A, 
            I0=>inst_gvalidQ );
  GATE_T_35_I_1:   AND2 port map ( O=>T_35, 
            I1=>grmadr_6_busQ, 
            I0=>inst_gvalidQ );
  GATE_T_36_I_1:   AND2 port map ( O=>T_36, 
            I1=>ti_adr_14XPIN, 
            I0=>GATE_T_36_A );
  GATE_T_36_I_2:   INV port map ( O=>GATE_T_36_A, 
            I0=>inst_gvalidQ );
  GATE_T_37_I_1:   AND2 port map ( O=>T_37, 
            I1=>grmadr_5_busQ, 
            I0=>inst_gvalidQ );
  GATE_T_38_I_1:   AND2 port map ( O=>T_38, 
            I1=>ti_adr_13XPIN, 
            I0=>GATE_T_38_A );
  GATE_T_38_I_2:   INV port map ( O=>GATE_T_38_A, 
            I0=>inst_gvalidQ );
  GATE_T_39_I_1:   AND2 port map ( O=>T_39, 
            I1=>inst_gvalidQ, 
            I0=>ti_wePIN );
  GATE_T_40_I_1:   AND2 port map ( O=>T_40, 
            I1=>ti_wePIN, 
            I0=>GATE_T_40_A );
  GATE_T_40_I_2:   INV port map ( O=>GATE_T_40_A, 
            I0=>ti_romPIN );
  GATE_T_41_I_1:   AND2 port map ( O=>T_41, 
            I1=>grmadr_4_busQ, 
            I0=>inst_gvalidQ );
  GATE_T_42_I_1:   AND2 port map ( O=>T_42, 
            I1=>ti_adr_12XPIN, 
            I0=>GATE_T_42_A );
  GATE_T_42_I_2:   INV port map ( O=>GATE_T_42_A, 
            I0=>inst_gvalidQ );
  GATE_T_43_I_1:   AND2 port map ( O=>T_43, 
            I1=>grmadr_3_busQ, 
            I0=>inst_gvalidQ );
  GATE_T_44_I_1:   AND2 port map ( O=>T_44, 
            I1=>ti_adr_11XPIN, 
            I0=>GATE_T_44_A );
  GATE_T_44_I_2:   INV port map ( O=>GATE_T_44_A, 
            I0=>inst_gvalidQ );
  GATE_T_45_I_1:   AND2 port map ( O=>T_45, 
            I1=>grmadr_2_busQ, 
            I0=>inst_gvalidQ );
  GATE_T_46_I_1:   AND2 port map ( O=>T_46, 
            I1=>ti_adr_10XPIN, 
            I0=>GATE_T_46_A );
  GATE_T_46_I_2:   INV port map ( O=>GATE_T_46_A, 
            I0=>inst_gvalidQ );
  GATE_T_47_I_1:   AND2 port map ( O=>T_47, 
            I1=>grmadr_1_busQ, 
            I0=>inst_gvalidQ );
  GATE_T_48_I_1:   AND2 port map ( O=>T_48, 
            I1=>ti_adr_9XPIN, 
            I0=>GATE_T_48_A );
  GATE_T_48_I_2:   INV port map ( O=>GATE_T_48_A, 
            I0=>inst_gvalidQ );

end NetList;
