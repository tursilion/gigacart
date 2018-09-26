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
    out_reset : out std_logic
  );
end gigacart;

architecture NetList of gigacart is

  signal out_adr_23XCOM : std_logic;
  signal out_adr_22XCOM : std_logic;
  signal ti_adr_15XPIN : std_logic;
  signal out_adr_21XCOM : std_logic;
  signal out_adr_20XCOM : std_logic;
  signal ti_data_7XPIN : std_logic;
  signal ti_data_7XCOM : std_logic;
  signal out_adr_19XCOM : std_logic;
  signal out_adr_18XCOM : std_logic;
  signal out_adr_26XCOM : std_logic;
  signal out_adr_17XCOM : std_logic;
  signal out_adr_16XCOM : std_logic;
  signal out_data_7XPIN : std_logic;
  signal out_adr_15XCOM : std_logic;
  signal ti_wePIN : std_logic;
  signal out_adr_14XCOM : std_logic;
  signal ti_romPIN : std_logic;
  signal out_adr_13XCOM : std_logic;
  signal ti_gselPIN : std_logic;
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
  signal ti_data_5XCOM : std_logic;
  signal ti_data_4XCOM : std_logic;
  signal ti_data_3XCOM : std_logic;
  signal ti_data_2XPIN : std_logic;
  signal ti_data_2XCOM : std_logic;
  signal ti_data_1XPIN : std_logic;
  signal ti_data_1XCOM : std_logic;
  signal ti_data_0XPIN : std_logic;
  signal ti_data_0XCOM : std_logic;
  signal out_adr_25XCOM : std_logic;
  signal out_adr_24XCOM : std_logic;
  signal out_resetQ : std_logic;
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
  signal ti_data_7X_OE : std_logic;
  signal ti_data_6X_OE : std_logic;
  signal ti_data_5X_OE : std_logic;
  signal ti_data_4X_OE : std_logic;
  signal ti_data_3X_OE : std_logic;
  signal ti_data_2X_OE : std_logic;
  signal ti_data_1X_OE : std_logic;
  signal ti_data_0X_OE : std_logic;
  signal T_0 : std_logic;
  signal out_reset_C : std_logic;
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
  signal N_77 : std_logic;
  signal T_1 : std_logic;
  signal T_2 : std_logic;
  signal T_3 : std_logic;
  signal T_4 : std_logic;
  signal grmadr_10_3_Xn_X1 : std_logic;
  signal grmadr_10_3_Xn_X2 : std_logic;
  signal grmadr_10_2_Xn : std_logic;
  signal grmadr_10_1_Xn : std_logic;
  signal grmadr_10_0_Xn_X1 : std_logic;
  signal grmadr_10_0_Xn_X2 : std_logic;
  signal grmadr_10_3_Xn : std_logic;
  signal grmadr_10_0_Xn : std_logic;
  signal out_reset_D : std_logic;
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
  signal T_19 : std_logic;
  signal T_20 : std_logic;
  signal T_21 : std_logic;
  signal T_22 : std_logic;
  signal T_23 : std_logic;
  signal T_24 : std_logic;
  signal T_25 : std_logic;
  signal T_26 : std_logic;
  signal T_27 : std_logic;
  signal T_28 : std_logic;
  signal T_29 : std_logic;
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
  signal T_49 : std_logic;
  signal T_50 : std_logic;
  signal T_51 : std_logic;
  signal T_52 : std_logic;
  signal T_53 : std_logic;
  signal T_54 : std_logic;
  signal T_55 : std_logic;
  signal T_56 : std_logic;
  signal T_57 : std_logic;
  signal T_58 : std_logic;
  signal T_59 : std_logic;
  signal T_60 : std_logic;
  signal T_61 : std_logic;
  signal T_62 : std_logic;
  signal T_63 : std_logic;
  signal T_64 : std_logic;
  signal T_65 : std_logic;
  signal T_66 : std_logic;
  signal T_67 : std_logic;
  signal T_68 : std_logic;
  signal T_69 : std_logic;
  signal T_70 : std_logic;
  signal T_71 : std_logic;
  signal T_72 : std_logic;
  signal T_73 : std_logic;
  signal T_74 : std_logic;
  signal T_75 : std_logic;
  signal GATE_ti_data_7X_OE_B : std_logic;
  signal GATE_ti_data_7X_OE_A : std_logic;
  signal GATE_ti_data_6X_OE_B : std_logic;
  signal GATE_ti_data_6X_OE_A : std_logic;
  signal GATE_ti_data_5X_OE_B : std_logic;
  signal GATE_ti_data_5X_OE_A : std_logic;
  signal GATE_ti_data_4X_OE_B : std_logic;
  signal GATE_ti_data_4X_OE_A : std_logic;
  signal GATE_ti_data_3X_OE_B : std_logic;
  signal GATE_ti_data_3X_OE_A : std_logic;
  signal GATE_ti_data_2X_OE_B : std_logic;
  signal GATE_ti_data_2X_OE_A : std_logic;
  signal GATE_ti_data_1X_OE_B : std_logic;
  signal GATE_ti_data_1X_OE_A : std_logic;
  signal GATE_ti_data_0X_OE_B : std_logic;
  signal GATE_ti_data_0X_OE_A : std_logic;
  signal GATE_inst_grmpage_D_A : std_logic;
  signal GATE_inst_grmpage_D_B : std_logic;
  signal GATE_inst_grmpage_CE_A : std_logic;
  signal GATE_latch_0_bus_CE_A : std_logic;
  signal GATE_latch_1_bus_CE_A : std_logic;
  signal GATE_latch_2_bus_CE_A : std_logic;
  signal GATE_latch_3_bus_CE_A : std_logic;
  signal GATE_latch_4_bus_CE_A : std_logic;
  signal GATE_latch_5_bus_CE_A : std_logic;
  signal GATE_latch_6_bus_CE_A : std_logic;
  signal GATE_latch_7_bus_CE_A : std_logic;
  signal GATE_latch_8_bus_CE_A : std_logic;
  signal GATE_latch_9_bus_CE_A : std_logic;
  signal GATE_latch_10_bus_CE_A : std_logic;
  signal GATE_latch_11_bus_CE_A : std_logic;
  signal GATE_latch_12_bus_CE_A : std_logic;
  signal GATE_latch_13_bus_CE_A : std_logic;
  signal GATE_grmadr_10_3_Xn_X2_A : std_logic;
  signal GATE_grmadr_10_0_Xn_X2_A : std_logic;
  signal GATE_T_5_A : std_logic;
  signal GATE_T_5_B : std_logic;
  signal GATE_T_6_A : std_logic;
  signal GATE_T_6_B : std_logic;
  signal GATE_T_7_DN : std_logic;
  signal GATE_T_8_A : std_logic;
  signal GATE_T_11_A : std_logic;
  signal GATE_T_11_B : std_logic;
  signal GATE_T_12_DN : std_logic;
  signal GATE_T_13_A : std_logic;
  signal GATE_T_16_DN : std_logic;
  signal GATE_T_17_A : std_logic;
  signal GATE_T_20_B : std_logic;
  signal GATE_T_20_A : std_logic;
  signal GATE_T_21_A : std_logic;
  signal GATE_T_24_B : std_logic;
  signal GATE_T_24_A : std_logic;
  signal GATE_T_25_A : std_logic;
  signal GATE_T_28_B : std_logic;
  signal GATE_T_28_A : std_logic;
  signal GATE_T_29_A : std_logic;
  signal GATE_T_32_B : std_logic;
  signal GATE_T_32_A : std_logic;
  signal GATE_T_33_A : std_logic;
  signal GATE_T_36_A : std_logic;
  signal GATE_T_38_B : std_logic;
  signal GATE_T_38_A : std_logic;
  signal GATE_T_39_A : std_logic;
  signal GATE_T_39_B : std_logic;
  signal GATE_T_40_A : std_logic;
  signal GATE_T_40_B : std_logic;
  signal GATE_T_42_A : std_logic;
  signal GATE_T_42_B : std_logic;
  signal GATE_T_43_A : std_logic;
  signal GATE_T_43_B : std_logic;
  signal GATE_T_46_A : std_logic;
  signal GATE_T_47_A : std_logic;
  signal GATE_T_48_A : std_logic;
  signal GATE_T_49_A : std_logic;
  signal GATE_T_51_A : std_logic;
  signal GATE_T_52_A : std_logic;
  signal GATE_T_53_A : std_logic;
  signal GATE_T_55_A : std_logic;
  signal GATE_T_55_B : std_logic;
  signal GATE_T_56_A : std_logic;
  signal GATE_T_56_B : std_logic;
  signal GATE_T_57_A : std_logic;
  signal GATE_T_57_B : std_logic;
  signal GATE_T_58_A : std_logic;
  signal GATE_T_58_B : std_logic;
  signal GATE_T_59_A : std_logic;
  signal GATE_T_59_B : std_logic;
  signal GATE_T_60_A : std_logic;
  signal GATE_T_60_B : std_logic;
  signal GATE_T_61_A : std_logic;
  signal GATE_T_61_B : std_logic;
  signal GATE_T_62_A : std_logic;
  signal GATE_T_62_B : std_logic;
  signal GATE_T_63_A : std_logic;
  signal GATE_T_63_B : std_logic;
  signal GATE_T_64_A : std_logic;
  signal GATE_T_64_B : std_logic;
  signal GATE_T_65_A : std_logic;
  signal GATE_T_65_B : std_logic;
  signal GATE_T_66_A : std_logic;
  signal GATE_T_66_B : std_logic;
  signal GATE_T_67_A : std_logic;
  signal GATE_T_67_B : std_logic;
  signal GATE_T_68_A : std_logic;
  signal GATE_T_68_B : std_logic;
  signal GATE_T_69_A : std_logic;
  signal GATE_T_69_B : std_logic;
  signal GATE_T_70_A : std_logic;
  signal GATE_T_70_B : std_logic;
  signal GATE_T_71_A : std_logic;
  signal GATE_T_71_B : std_logic;

begin
  OUT_out_adr_23_XI_1:   OBUF
 generic map( PULL => "Up")
 port map ( O=>out_adr(23), 
            I0=>out_adr_23XCOM );
  OUT_out_adr_22_XI_1:   OBUF
 generic map( PULL => "Up")
 port map ( O=>out_adr(22), 
            I0=>out_adr_22XCOM );
  IN_ti_adr_15_XI_1:   IBUF
 generic map( PULL => "Up")
 port map ( O=>ti_adr_15XPIN, 
            I0=>ti_adr(15) );
  OUT_out_adr_21_XI_1:   OBUF
 generic map( PULL => "Up")
 port map ( O=>out_adr(21), 
            I0=>out_adr_21XCOM );
  OUT_out_adr_20_XI_1:   OBUF
 generic map( PULL => "Up")
 port map ( O=>out_adr(20), 
            I0=>out_adr_20XCOM );
  OUT_ti_data_7_XI_1:   BI_DIR
 generic map( PULL => "Up")
 port map ( O=>ti_data_7XPIN, 
            I0=>ti_data_7XCOM, 
            IO=>ti_data(7), 
            OE=>ti_data_7X_OE );
  OUT_out_adr_19_XI_1:   OBUF
 generic map( PULL => "Up")
 port map ( O=>out_adr(19), 
            I0=>out_adr_19XCOM );
  OUT_out_adr_18_XI_1:   OBUF
 generic map( PULL => "Up")
 port map ( O=>out_adr(18), 
            I0=>out_adr_18XCOM );
  OUT_out_adr_26_XI_1:   OBUF
 generic map( PULL => "Up")
 port map ( O=>out_adr(26), 
            I0=>out_adr_26XCOM );
  OUT_out_adr_17_XI_1:   OBUF
 generic map( PULL => "Up")
 port map ( O=>out_adr(17), 
            I0=>out_adr_17XCOM );
  OUT_out_adr_16_XI_1:   OBUF
 generic map( PULL => "Up")
 port map ( O=>out_adr(16), 
            I0=>out_adr_16XCOM );
  IN_out_data_7_XI_1:   IBUF
 generic map( PULL => "Up")
 port map ( O=>out_data_7XPIN, 
            I0=>out_data(7) );
  OUT_out_adr_15_XI_1:   OBUF
 generic map( PULL => "Up")
 port map ( O=>out_adr(15), 
            I0=>out_adr_15XCOM );
  IN_ti_we_I_1:   IBUF
 generic map( PULL => "Up")
 port map ( O=>ti_wePIN, 
            I0=>ti_we );
  OUT_out_adr_14_XI_1:   OBUF
 generic map( PULL => "Up")
 port map ( O=>out_adr(14), 
            I0=>out_adr_14XCOM );
  IN_ti_rom_I_1:   IBUF
 generic map( PULL => "Up")
 port map ( O=>ti_romPIN, 
            I0=>ti_rom );
  OUT_out_adr_13_XI_1:   OBUF
 generic map( PULL => "Up")
 port map ( O=>out_adr(13), 
            I0=>out_adr_13XCOM );
  IN_ti_gsel_I_1:   IBUF
 generic map( PULL => "Up")
 port map ( O=>ti_gselPIN, 
            I0=>ti_gsel );
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
            OE=>ti_data_6X_OE );
  OUT_ti_data_5_XI_1:   BUFTH port map ( I0=>ti_data_5XCOM, 
            O=>ti_data(5), 
            OE=>ti_data_5X_OE );
  OUT_ti_data_4_XI_1:   BUFTH port map ( I0=>ti_data_4XCOM, 
            O=>ti_data(4), 
            OE=>ti_data_4X_OE );
  OUT_ti_data_3_XI_1:   BUFTH port map ( I0=>ti_data_3XCOM, 
            O=>ti_data(3), 
            OE=>ti_data_3X_OE );
  OUT_ti_data_2_XI_1:   BI_DIR
 generic map( PULL => "Up")
 port map ( O=>ti_data_2XPIN, 
            I0=>ti_data_2XCOM, 
            IO=>ti_data(2), 
            OE=>ti_data_2X_OE );
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
  OUT_out_adr_25_XI_1:   OBUF
 generic map( PULL => "Up")
 port map ( O=>out_adr(25), 
            I0=>out_adr_25XCOM );
  OUT_out_adr_24_XI_1:   OBUF
 generic map( PULL => "Up")
 port map ( O=>out_adr(24), 
            I0=>out_adr_24XCOM );
  OUT_out_reset_I_1:   OBUF
 generic map( PULL => "Up")
 port map ( O=>out_reset, 
            I0=>out_resetQ );
  FF_out_reset_I_1:   DFF port map ( D=>out_reset_D, 
            Q=>out_resetQ, 
            CLK=>out_reset_C );
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
  GATE_out_adr_23_XI_1:   OR2 port map ( O=>out_adr_23XCOM, 
            I1=>T_71, 
            I0=>latch_10_busQ );
  GATE_out_adr_22_XI_1:   OR2 port map ( O=>out_adr_22XCOM, 
            I1=>T_70, 
            I0=>latch_9_busQ );
  GATE_out_adr_21_XI_1:   OR2 port map ( O=>out_adr_21XCOM, 
            I1=>T_69, 
            I0=>latch_8_busQ );
  GATE_out_adr_20_XI_1:   OR2 port map ( O=>out_adr_20XCOM, 
            I1=>T_68, 
            I0=>latch_7_busQ );
  GATE_ti_data_7_XI_1:   BUFF port map ( I0=>out_data_0XPIN, 
            O=>ti_data_7XCOM );
  GATE_ti_data_7X_OE_I_3:   AND4 port map ( O=>ti_data_7X_OE, 
            I3=>inst_grmpageQ, 
            I2=>ti_wePIN, 
            I1=>GATE_ti_data_7X_OE_B, 
            I0=>GATE_ti_data_7X_OE_A );
  GATE_ti_data_7X_OE_I_2:   INV port map ( I0=>ti_adr_14XPIN, 
            O=>GATE_ti_data_7X_OE_B );
  GATE_ti_data_7X_OE_I_1:   INV port map ( I0=>ti_gselPIN, 
            O=>GATE_ti_data_7X_OE_A );
  GATE_out_adr_19_XI_1:   OR2 port map ( O=>out_adr_19XCOM, 
            I1=>T_67, 
            I0=>latch_6_busQ );
  GATE_out_adr_18_XI_1:   OR2 port map ( O=>out_adr_18XCOM, 
            I1=>T_66, 
            I0=>latch_5_busQ );
  GATE_out_adr_26_XI_1:   OR2 port map ( O=>out_adr_26XCOM, 
            I1=>T_65, 
            I0=>latch_13_busQ );
  GATE_out_adr_17_XI_1:   OR2 port map ( O=>out_adr_17XCOM, 
            I1=>T_64, 
            I0=>latch_4_busQ );
  GATE_out_adr_16_XI_1:   OR2 port map ( O=>out_adr_16XCOM, 
            I1=>T_63, 
            I0=>latch_3_busQ );
  GATE_out_adr_15_XI_1:   OR2 port map ( O=>out_adr_15XCOM, 
            I1=>T_62, 
            I0=>latch_2_busQ );
  GATE_out_adr_14_XI_1:   OR2 port map ( O=>out_adr_14XCOM, 
            I1=>T_61, 
            I0=>latch_1_busQ );
  GATE_out_adr_13_XI_1:   OR2 port map ( O=>out_adr_13XCOM, 
            I1=>T_60, 
            I0=>latch_0_busQ );
  GATE_out_adr_12_XI_1:   OR2 port map ( O=>out_adr_12XCOM, 
            I1=>T_59, 
            I0=>ti_adr_3XPIN );
  GATE_out_adr_11_XI_1:   OR2 port map ( O=>out_adr_11XCOM, 
            I1=>T_58, 
            I0=>ti_adr_4XPIN );
  GATE_out_adr_10_XI_1:   OR2 port map ( O=>out_adr_10XCOM, 
            I1=>T_57, 
            I0=>ti_adr_5XPIN );
  GATE_out_adr_9_XI_1:   OR2 port map ( O=>out_adr_9XCOM, 
            I1=>T_56, 
            I0=>ti_adr_6XPIN );
  GATE_out_adr_8_XI_1:   OR2 port map ( O=>out_adr_8XCOM, 
            I1=>T_55, 
            I0=>ti_adr_7XPIN );
  GATE_out_adr_7_XI_1:   OR4 port map ( I0=>T_32, 
            I1=>T_33, 
            O=>out_adr_7XCOM, 
            I2=>T_34, 
            I3=>T_35 );
  GATE_out_adr_6_XI_1:   OR4 port map ( I0=>T_28, 
            I1=>T_29, 
            O=>out_adr_6XCOM, 
            I2=>T_30, 
            I3=>T_31 );
  GATE_out_adr_5_XI_1:   OR4 port map ( I0=>T_24, 
            I1=>T_25, 
            O=>out_adr_5XCOM, 
            I2=>T_26, 
            I3=>T_27 );
  GATE_out_adr_4_XI_1:   OR4 port map ( I0=>T_20, 
            I1=>T_21, 
            O=>out_adr_4XCOM, 
            I2=>T_22, 
            I3=>T_23 );
  GATE_out_adr_3_XI_1:   OR4 port map ( I0=>T_16, 
            I1=>T_17, 
            O=>out_adr_3XCOM, 
            I2=>T_18, 
            I3=>T_19 );
  GATE_out_adr_2_XI_1:   OR4 port map ( I0=>T_12, 
            I1=>T_13, 
            O=>out_adr_2XCOM, 
            I2=>T_14, 
            I3=>T_15 );
  GATE_out_adr_1_XI_1:   OR2 port map ( O=>out_adr_1XCOM, 
            I1=>T_11, 
            I0=>ti_adr_14XPIN );
  GATE_out_adr_0_XI_1:   OR4 port map ( I0=>T_7, 
            I1=>T_8, 
            O=>out_adr_0XCOM, 
            I2=>T_9, 
            I3=>T_10 );
  GATE_ti_data_6_XI_1:   BUFF port map ( I0=>out_data_1XPIN, 
            O=>ti_data_6XCOM );
  GATE_ti_data_6X_OE_I_3:   AND4 port map ( O=>ti_data_6X_OE, 
            I3=>inst_grmpageQ, 
            I2=>ti_wePIN, 
            I1=>GATE_ti_data_6X_OE_B, 
            I0=>GATE_ti_data_6X_OE_A );
  GATE_ti_data_6X_OE_I_2:   INV port map ( I0=>ti_adr_14XPIN, 
            O=>GATE_ti_data_6X_OE_B );
  GATE_ti_data_6X_OE_I_1:   INV port map ( I0=>ti_gselPIN, 
            O=>GATE_ti_data_6X_OE_A );
  GATE_ti_data_5_XI_1:   BUFF port map ( I0=>out_data_2XPIN, 
            O=>ti_data_5XCOM );
  GATE_ti_data_5X_OE_I_3:   AND4 port map ( O=>ti_data_5X_OE, 
            I3=>inst_grmpageQ, 
            I2=>ti_wePIN, 
            I1=>GATE_ti_data_5X_OE_B, 
            I0=>GATE_ti_data_5X_OE_A );
  GATE_ti_data_5X_OE_I_2:   INV port map ( I0=>ti_adr_14XPIN, 
            O=>GATE_ti_data_5X_OE_B );
  GATE_ti_data_5X_OE_I_1:   INV port map ( I0=>ti_gselPIN, 
            O=>GATE_ti_data_5X_OE_A );
  GATE_ti_data_4_XI_1:   BUFF port map ( I0=>out_data_3XPIN, 
            O=>ti_data_4XCOM );
  GATE_ti_data_4X_OE_I_3:   AND4 port map ( O=>ti_data_4X_OE, 
            I3=>inst_grmpageQ, 
            I2=>ti_wePIN, 
            I1=>GATE_ti_data_4X_OE_B, 
            I0=>GATE_ti_data_4X_OE_A );
  GATE_ti_data_4X_OE_I_2:   INV port map ( I0=>ti_adr_14XPIN, 
            O=>GATE_ti_data_4X_OE_B );
  GATE_ti_data_4X_OE_I_1:   INV port map ( I0=>ti_gselPIN, 
            O=>GATE_ti_data_4X_OE_A );
  GATE_ti_data_3_XI_1:   BUFF port map ( I0=>out_data_4XPIN, 
            O=>ti_data_3XCOM );
  GATE_ti_data_3X_OE_I_3:   AND4 port map ( O=>ti_data_3X_OE, 
            I3=>inst_grmpageQ, 
            I2=>ti_wePIN, 
            I1=>GATE_ti_data_3X_OE_B, 
            I0=>GATE_ti_data_3X_OE_A );
  GATE_ti_data_3X_OE_I_2:   INV port map ( I0=>ti_adr_14XPIN, 
            O=>GATE_ti_data_3X_OE_B );
  GATE_ti_data_3X_OE_I_1:   INV port map ( I0=>ti_gselPIN, 
            O=>GATE_ti_data_3X_OE_A );
  GATE_ti_data_2_XI_1:   BUFF port map ( I0=>out_data_5XPIN, 
            O=>ti_data_2XCOM );
  GATE_ti_data_2X_OE_I_3:   AND4 port map ( O=>ti_data_2X_OE, 
            I3=>inst_grmpageQ, 
            I2=>ti_wePIN, 
            I1=>GATE_ti_data_2X_OE_B, 
            I0=>GATE_ti_data_2X_OE_A );
  GATE_ti_data_2X_OE_I_2:   INV port map ( I0=>ti_adr_14XPIN, 
            O=>GATE_ti_data_2X_OE_B );
  GATE_ti_data_2X_OE_I_1:   INV port map ( I0=>ti_gselPIN, 
            O=>GATE_ti_data_2X_OE_A );
  GATE_ti_data_1_XI_1:   BUFF port map ( I0=>out_data_6XPIN, 
            O=>ti_data_1XCOM );
  GATE_ti_data_1X_OE_I_3:   AND4 port map ( O=>ti_data_1X_OE, 
            I3=>inst_grmpageQ, 
            I2=>ti_wePIN, 
            I1=>GATE_ti_data_1X_OE_B, 
            I0=>GATE_ti_data_1X_OE_A );
  GATE_ti_data_1X_OE_I_2:   INV port map ( I0=>ti_adr_14XPIN, 
            O=>GATE_ti_data_1X_OE_B );
  GATE_ti_data_1X_OE_I_1:   INV port map ( I0=>ti_gselPIN, 
            O=>GATE_ti_data_1X_OE_A );
  GATE_ti_data_0_XI_1:   BUFF port map ( I0=>out_data_7XPIN, 
            O=>ti_data_0XCOM );
  GATE_ti_data_0X_OE_I_3:   AND4 port map ( O=>ti_data_0X_OE, 
            I3=>inst_grmpageQ, 
            I2=>ti_wePIN, 
            I1=>GATE_ti_data_0X_OE_B, 
            I0=>GATE_ti_data_0X_OE_A );
  GATE_ti_data_0X_OE_I_2:   INV port map ( I0=>ti_adr_14XPIN, 
            O=>GATE_ti_data_0X_OE_B );
  GATE_ti_data_0X_OE_I_1:   INV port map ( I0=>ti_gselPIN, 
            O=>GATE_ti_data_0X_OE_A );
  GATE_out_adr_25_XI_1:   OR2 port map ( O=>out_adr_25XCOM, 
            I1=>T_6, 
            I0=>latch_12_busQ );
  GATE_out_adr_24_XI_1:   OR2 port map ( O=>out_adr_24XCOM, 
            I1=>T_5, 
            I0=>latch_11_busQ );
  GATE_T_0_I_1:   NOR2 port map ( O=>T_0, 
            I1=>inst_grmpage_CE, 
            I0=>out_resetQ );
  GATE_out_reset_C_I_1:   INV port map ( I0=>ti_wePIN, 
            O=>out_reset_C );
  GATE_inst_grmpage_D_I_1:   INV port map ( I0=>grmadr_10_1_Xn, 
            O=>GATE_inst_grmpage_D_A );
  GATE_inst_grmpage_D_I_2:   INV port map ( I0=>grmadr_10_2_Xn, 
            O=>GATE_inst_grmpage_D_B );
  GATE_inst_grmpage_D_I_3:   AND3 port map ( O=>inst_grmpage_D, 
            I0=>grmadr_10_0_Xn, 
            I2=>GATE_inst_grmpage_D_A, 
            I1=>GATE_inst_grmpage_D_B );
  GATE_inst_grmpage_C_I_1:   INV port map ( I0=>ti_wePIN, 
            O=>inst_grmpage_C );
  GATE_inst_grmpage_CE_I_1:   AND2 port map ( O=>inst_grmpage_CE, 
            I1=>ti_adr_14XPIN, 
            I0=>GATE_inst_grmpage_CE_A );
  GATE_inst_grmpage_CE_I_2:   INV port map ( O=>GATE_inst_grmpage_CE_A, 
            I0=>ti_gselPIN );
  GATE_latch_0_bus_CE_I_1:   AND2 port map ( O=>latch_0_bus_CE, 
            I1=>ti_gselPIN, 
            I0=>GATE_latch_0_bus_CE_A );
  GATE_latch_0_bus_CE_I_2:   INV port map ( O=>GATE_latch_0_bus_CE_A, 
            I0=>ti_romPIN );
  GATE_latch_1_bus_CE_I_1:   AND2 port map ( O=>latch_1_bus_CE, 
            I1=>ti_gselPIN, 
            I0=>GATE_latch_1_bus_CE_A );
  GATE_latch_1_bus_CE_I_2:   INV port map ( O=>GATE_latch_1_bus_CE_A, 
            I0=>ti_romPIN );
  GATE_latch_2_bus_CE_I_1:   AND2 port map ( O=>latch_2_bus_CE, 
            I1=>ti_gselPIN, 
            I0=>GATE_latch_2_bus_CE_A );
  GATE_latch_2_bus_CE_I_2:   INV port map ( O=>GATE_latch_2_bus_CE_A, 
            I0=>ti_romPIN );
  GATE_latch_3_bus_CE_I_1:   AND2 port map ( O=>latch_3_bus_CE, 
            I1=>ti_gselPIN, 
            I0=>GATE_latch_3_bus_CE_A );
  GATE_latch_3_bus_CE_I_2:   INV port map ( O=>GATE_latch_3_bus_CE_A, 
            I0=>ti_romPIN );
  GATE_latch_4_bus_CE_I_1:   AND2 port map ( O=>latch_4_bus_CE, 
            I1=>ti_gselPIN, 
            I0=>GATE_latch_4_bus_CE_A );
  GATE_latch_4_bus_CE_I_2:   INV port map ( O=>GATE_latch_4_bus_CE_A, 
            I0=>ti_romPIN );
  GATE_latch_5_bus_CE_I_1:   AND2 port map ( O=>latch_5_bus_CE, 
            I1=>ti_gselPIN, 
            I0=>GATE_latch_5_bus_CE_A );
  GATE_latch_5_bus_CE_I_2:   INV port map ( O=>GATE_latch_5_bus_CE_A, 
            I0=>ti_romPIN );
  GATE_latch_6_bus_CE_I_1:   AND2 port map ( O=>latch_6_bus_CE, 
            I1=>ti_gselPIN, 
            I0=>GATE_latch_6_bus_CE_A );
  GATE_latch_6_bus_CE_I_2:   INV port map ( O=>GATE_latch_6_bus_CE_A, 
            I0=>ti_romPIN );
  GATE_latch_7_bus_CE_I_1:   AND2 port map ( O=>latch_7_bus_CE, 
            I1=>ti_gselPIN, 
            I0=>GATE_latch_7_bus_CE_A );
  GATE_latch_7_bus_CE_I_2:   INV port map ( O=>GATE_latch_7_bus_CE_A, 
            I0=>ti_romPIN );
  GATE_latch_8_bus_CE_I_1:   AND2 port map ( O=>latch_8_bus_CE, 
            I1=>ti_gselPIN, 
            I0=>GATE_latch_8_bus_CE_A );
  GATE_latch_8_bus_CE_I_2:   INV port map ( O=>GATE_latch_8_bus_CE_A, 
            I0=>ti_romPIN );
  GATE_latch_9_bus_CE_I_1:   AND2 port map ( O=>latch_9_bus_CE, 
            I1=>ti_gselPIN, 
            I0=>GATE_latch_9_bus_CE_A );
  GATE_latch_9_bus_CE_I_2:   INV port map ( O=>GATE_latch_9_bus_CE_A, 
            I0=>ti_romPIN );
  GATE_latch_10_bus_CE_I_1:   AND2 port map ( O=>latch_10_bus_CE, 
            I1=>ti_gselPIN, 
            I0=>GATE_latch_10_bus_CE_A );
  GATE_latch_10_bus_CE_I_2:   INV port map ( O=>GATE_latch_10_bus_CE_A, 
            I0=>ti_romPIN );
  GATE_latch_11_bus_CE_I_1:   AND2 port map ( O=>latch_11_bus_CE, 
            I1=>ti_gselPIN, 
            I0=>GATE_latch_11_bus_CE_A );
  GATE_latch_11_bus_CE_I_2:   INV port map ( O=>GATE_latch_11_bus_CE_A, 
            I0=>ti_romPIN );
  GATE_latch_12_bus_CE_I_1:   AND2 port map ( O=>latch_12_bus_CE, 
            I1=>ti_gselPIN, 
            I0=>GATE_latch_12_bus_CE_A );
  GATE_latch_12_bus_CE_I_2:   INV port map ( O=>GATE_latch_12_bus_CE_A, 
            I0=>ti_romPIN );
  GATE_latch_13_bus_CE_I_1:   AND2 port map ( O=>latch_13_bus_CE, 
            I1=>ti_gselPIN, 
            I0=>GATE_latch_13_bus_CE_A );
  GATE_latch_13_bus_CE_I_2:   INV port map ( O=>GATE_latch_13_bus_CE_A, 
            I0=>ti_romPIN );
  GATE_N_77_I_1:   AND3 port map ( O=>N_77, 
            I2=>T_73, 
            I1=>grmadr_10_3_Xn, 
            I0=>T_72 );
  GATE_T_1_I_1:   NOR2 port map ( O=>T_1, 
            I1=>T_1, 
            I0=>inst_grmpage_CE );
  GATE_T_2_I_1:   OR2 port map ( O=>T_2, 
            I1=>T_54, 
            I0=>T_53 );
  GATE_T_3_I_1:   OR3 port map ( O=>T_3, 
            I2=>T_51, 
            I1=>T_50, 
            I0=>T_52 );
  GATE_T_4_I_1:   OR4 port map ( I0=>T_46, 
            I1=>T_47, 
            O=>T_4, 
            I2=>T_48, 
            I3=>T_49 );
  GATE_grmadr_10_3_Xn_X1_I_1:   OR2 port map ( O=>grmadr_10_3_Xn_X1, 
            I1=>T_45, 
            I0=>inst_grmpage_CE );
  GATE_grmadr_10_3_Xn_X2_I_1:   AND2 port map ( O=>grmadr_10_3_Xn_X2, 
            I1=>grmadr_10_3_Xn, 
            I0=>GATE_grmadr_10_3_Xn_X2_A );
  GATE_grmadr_10_3_Xn_X2_I_2:   INV port map ( O=>GATE_grmadr_10_3_Xn_X2_A, 
            I0=>inst_grmpage_CE );
  GATE_grmadr_10_2_Xn_I_1:   OR3 port map ( O=>grmadr_10_2_Xn, 
            I2=>T_43, 
            I1=>T_42, 
            I0=>T_44 );
  GATE_grmadr_10_1_Xn_I_1:   OR4 port map ( I0=>T_38, 
            I1=>T_39, 
            O=>grmadr_10_1_Xn, 
            I2=>T_40, 
            I3=>T_41 );
  GATE_grmadr_10_0_Xn_X1_I_1:   OR2 port map ( O=>grmadr_10_0_Xn_X1, 
            I1=>T_37, 
            I0=>T_36 );
  GATE_grmadr_10_0_Xn_X2_I_1:   AND2 port map ( O=>grmadr_10_0_Xn_X2, 
            I1=>grmadr_10_0_Xn, 
            I0=>GATE_grmadr_10_0_Xn_X2_A );
  GATE_grmadr_10_0_Xn_X2_I_2:   INV port map ( O=>GATE_grmadr_10_0_Xn_X2_A, 
            I0=>inst_grmpage_CE );
  GATE_grmadr_10_3_Xn_I_1:   XOR2 port map ( O=>grmadr_10_3_Xn, 
            I1=>grmadr_10_3_Xn_X2, 
            I0=>grmadr_10_3_Xn_X1 );
  GATE_grmadr_10_0_Xn_I_1:   XOR2 port map ( O=>grmadr_10_0_Xn, 
            I1=>grmadr_10_0_Xn_X2, 
            I0=>grmadr_10_0_Xn_X1 );
  GATE_out_reset_D_I_1:   INV port map ( I0=>T_0, 
            O=>out_reset_D );
  GATE_T_5_I_1:   INV port map ( I0=>ti_adr_14XPIN, 
            O=>GATE_T_5_A );
  GATE_T_5_I_2:   INV port map ( I0=>ti_gselPIN, 
            O=>GATE_T_5_B );
  GATE_T_5_I_3:   AND3 port map ( O=>T_5, 
            I0=>inst_grmpageQ, 
            I2=>GATE_T_5_A, 
            I1=>GATE_T_5_B );
  GATE_T_6_I_1:   INV port map ( I0=>ti_adr_14XPIN, 
            O=>GATE_T_6_A );
  GATE_T_6_I_2:   INV port map ( I0=>ti_gselPIN, 
            O=>GATE_T_6_B );
  GATE_T_6_I_3:   AND3 port map ( O=>T_6, 
            I0=>inst_grmpageQ, 
            I2=>GATE_T_6_A, 
            I1=>GATE_T_6_B );
  GATE_T_7_I_1:   NOR4 port map ( I0=>ti_gselPIN, 
            I1=>ti_adr_14XPIN, 
            O=>T_7, 
            I2=>T_1, 
            I3=>GATE_T_7_DN );
  GATE_T_7_I_2:   INV port map ( I0=>inst_grmpageQ, 
            O=>GATE_T_7_DN );
  GATE_T_8_I_1:   AND2 port map ( O=>T_8, 
            I1=>ti_adr_15XPIN, 
            I0=>GATE_T_8_A );
  GATE_T_8_I_2:   INV port map ( O=>GATE_T_8_A, 
            I0=>inst_grmpageQ );
  GATE_T_9_I_1:   AND2 port map ( O=>T_9, 
            I1=>ti_adr_14XPIN, 
            I0=>ti_adr_15XPIN );
  GATE_T_10_I_1:   AND2 port map ( O=>T_10, 
            I1=>ti_gselPIN, 
            I0=>ti_adr_15XPIN );
  GATE_T_11_I_1:   INV port map ( I0=>T_2, 
            O=>GATE_T_11_A );
  GATE_T_11_I_2:   INV port map ( I0=>ti_gselPIN, 
            O=>GATE_T_11_B );
  GATE_T_11_I_3:   AND3 port map ( O=>T_11, 
            I0=>inst_grmpageQ, 
            I2=>GATE_T_11_A, 
            I1=>GATE_T_11_B );
  GATE_T_12_I_1:   NOR4 port map ( I0=>ti_gselPIN, 
            I1=>ti_adr_14XPIN, 
            O=>T_12, 
            I2=>T_3, 
            I3=>GATE_T_12_DN );
  GATE_T_12_I_2:   INV port map ( I0=>inst_grmpageQ, 
            O=>GATE_T_12_DN );
  GATE_T_13_I_1:   AND2 port map ( O=>T_13, 
            I1=>ti_adr_13XPIN, 
            I0=>GATE_T_13_A );
  GATE_T_13_I_2:   INV port map ( O=>GATE_T_13_A, 
            I0=>inst_grmpageQ );
  GATE_T_14_I_1:   AND2 port map ( O=>T_14, 
            I1=>ti_adr_13XPIN, 
            I0=>ti_adr_14XPIN );
  GATE_T_15_I_1:   AND2 port map ( O=>T_15, 
            I1=>ti_adr_13XPIN, 
            I0=>ti_gselPIN );
  GATE_T_16_I_1:   NOR4 port map ( I0=>ti_gselPIN, 
            I1=>ti_adr_14XPIN, 
            O=>T_16, 
            I2=>T_4, 
            I3=>GATE_T_16_DN );
  GATE_T_16_I_2:   INV port map ( I0=>inst_grmpageQ, 
            O=>GATE_T_16_DN );
  GATE_T_17_I_1:   AND2 port map ( O=>T_17, 
            I1=>ti_adr_12XPIN, 
            I0=>GATE_T_17_A );
  GATE_T_17_I_2:   INV port map ( O=>GATE_T_17_A, 
            I0=>inst_grmpageQ );
  GATE_T_18_I_1:   AND2 port map ( O=>T_18, 
            I1=>ti_adr_12XPIN, 
            I0=>ti_adr_14XPIN );
  GATE_T_19_I_1:   AND2 port map ( O=>T_19, 
            I1=>ti_adr_12XPIN, 
            I0=>ti_gselPIN );
  GATE_T_20_I_3:   AND4 port map ( O=>T_20, 
            I3=>grmadr_10_3_Xn, 
            I2=>inst_grmpageQ, 
            I1=>GATE_T_20_B, 
            I0=>GATE_T_20_A );
  GATE_T_20_I_2:   INV port map ( I0=>ti_adr_14XPIN, 
            O=>GATE_T_20_B );
  GATE_T_20_I_1:   INV port map ( I0=>ti_gselPIN, 
            O=>GATE_T_20_A );
  GATE_T_21_I_1:   AND2 port map ( O=>T_21, 
            I1=>ti_adr_11XPIN, 
            I0=>GATE_T_21_A );
  GATE_T_21_I_2:   INV port map ( O=>GATE_T_21_A, 
            I0=>inst_grmpageQ );
  GATE_T_22_I_1:   AND2 port map ( O=>T_22, 
            I1=>ti_adr_11XPIN, 
            I0=>ti_adr_14XPIN );
  GATE_T_23_I_1:   AND2 port map ( O=>T_23, 
            I1=>ti_adr_11XPIN, 
            I0=>ti_gselPIN );
  GATE_T_24_I_3:   AND4 port map ( O=>T_24, 
            I3=>grmadr_10_2_Xn, 
            I2=>inst_grmpageQ, 
            I1=>GATE_T_24_B, 
            I0=>GATE_T_24_A );
  GATE_T_24_I_2:   INV port map ( I0=>ti_adr_14XPIN, 
            O=>GATE_T_24_B );
  GATE_T_24_I_1:   INV port map ( I0=>ti_gselPIN, 
            O=>GATE_T_24_A );
  GATE_T_25_I_1:   AND2 port map ( O=>T_25, 
            I1=>ti_adr_10XPIN, 
            I0=>GATE_T_25_A );
  GATE_T_25_I_2:   INV port map ( O=>GATE_T_25_A, 
            I0=>inst_grmpageQ );
  GATE_T_26_I_1:   AND2 port map ( O=>T_26, 
            I1=>ti_adr_10XPIN, 
            I0=>ti_adr_14XPIN );
  GATE_T_27_I_1:   AND2 port map ( O=>T_27, 
            I1=>ti_adr_10XPIN, 
            I0=>ti_gselPIN );
  GATE_T_28_I_3:   AND4 port map ( O=>T_28, 
            I3=>grmadr_10_1_Xn, 
            I2=>inst_grmpageQ, 
            I1=>GATE_T_28_B, 
            I0=>GATE_T_28_A );
  GATE_T_28_I_2:   INV port map ( I0=>ti_adr_14XPIN, 
            O=>GATE_T_28_B );
  GATE_T_28_I_1:   INV port map ( I0=>ti_gselPIN, 
            O=>GATE_T_28_A );
  GATE_T_29_I_1:   AND2 port map ( O=>T_29, 
            I1=>ti_adr_9XPIN, 
            I0=>GATE_T_29_A );
  GATE_T_29_I_2:   INV port map ( O=>GATE_T_29_A, 
            I0=>inst_grmpageQ );
  GATE_T_30_I_1:   AND2 port map ( O=>T_30, 
            I1=>ti_adr_9XPIN, 
            I0=>ti_adr_14XPIN );
  GATE_T_31_I_1:   AND2 port map ( O=>T_31, 
            I1=>ti_adr_9XPIN, 
            I0=>ti_gselPIN );
  GATE_T_32_I_3:   AND4 port map ( O=>T_32, 
            I3=>grmadr_10_0_Xn, 
            I2=>inst_grmpageQ, 
            I1=>GATE_T_32_B, 
            I0=>GATE_T_32_A );
  GATE_T_32_I_2:   INV port map ( I0=>ti_adr_14XPIN, 
            O=>GATE_T_32_B );
  GATE_T_32_I_1:   INV port map ( I0=>ti_gselPIN, 
            O=>GATE_T_32_A );
  GATE_T_33_I_1:   AND2 port map ( O=>T_33, 
            I1=>ti_adr_8XPIN, 
            I0=>GATE_T_33_A );
  GATE_T_33_I_2:   INV port map ( O=>GATE_T_33_A, 
            I0=>inst_grmpageQ );
  GATE_T_34_I_1:   AND2 port map ( O=>T_34, 
            I1=>ti_adr_8XPIN, 
            I0=>ti_adr_14XPIN );
  GATE_T_35_I_1:   AND2 port map ( O=>T_35, 
            I1=>ti_adr_8XPIN, 
            I0=>ti_gselPIN );
  GATE_T_36_I_1:   AND4 port map ( O=>T_36, 
            I3=>grmadr_10_1_Xn, 
            I2=>grmadr_10_2_Xn, 
            I1=>N_77, 
            I0=>GATE_T_36_A );
  GATE_T_36_I_2:   INV port map ( I0=>inst_grmpage_CE, 
            O=>GATE_T_36_A );
  GATE_T_37_I_1:   AND2 port map ( O=>T_37, 
            I1=>inst_grmpage_CE, 
            I0=>ti_data_0XPIN );
  GATE_T_38_I_3:   AND4 port map ( O=>T_38, 
            I3=>grmadr_10_2_Xn, 
            I2=>N_77, 
            I1=>GATE_T_38_B, 
            I0=>GATE_T_38_A );
  GATE_T_38_I_2:   INV port map ( I0=>grmadr_10_1_Xn, 
            O=>GATE_T_38_B );
  GATE_T_38_I_1:   INV port map ( I0=>inst_grmpage_CE, 
            O=>GATE_T_38_A );
  GATE_T_39_I_1:   INV port map ( I0=>grmadr_10_2_Xn, 
            O=>GATE_T_39_A );
  GATE_T_39_I_2:   INV port map ( I0=>inst_grmpage_CE, 
            O=>GATE_T_39_B );
  GATE_T_39_I_3:   AND3 port map ( O=>T_39, 
            I0=>grmadr_10_1_Xn, 
            I2=>GATE_T_39_A, 
            I1=>GATE_T_39_B );
  GATE_T_40_I_1:   INV port map ( I0=>N_77, 
            O=>GATE_T_40_A );
  GATE_T_40_I_2:   INV port map ( I0=>inst_grmpage_CE, 
            O=>GATE_T_40_B );
  GATE_T_40_I_3:   AND3 port map ( O=>T_40, 
            I0=>grmadr_10_1_Xn, 
            I2=>GATE_T_40_A, 
            I1=>GATE_T_40_B );
  GATE_T_41_I_1:   AND2 port map ( O=>T_41, 
            I1=>inst_grmpage_CE, 
            I0=>ti_data_1XPIN );
  GATE_T_42_I_1:   INV port map ( I0=>grmadr_10_2_Xn, 
            O=>GATE_T_42_A );
  GATE_T_42_I_2:   INV port map ( I0=>inst_grmpage_CE, 
            O=>GATE_T_42_B );
  GATE_T_42_I_3:   AND3 port map ( O=>T_42, 
            I0=>N_77, 
            I2=>GATE_T_42_A, 
            I1=>GATE_T_42_B );
  GATE_T_43_I_1:   INV port map ( I0=>N_77, 
            O=>GATE_T_43_A );
  GATE_T_43_I_2:   INV port map ( I0=>inst_grmpage_CE, 
            O=>GATE_T_43_B );
  GATE_T_43_I_3:   AND3 port map ( O=>T_43, 
            I0=>grmadr_10_2_Xn, 
            I2=>GATE_T_43_A, 
            I1=>GATE_T_43_B );
  GATE_T_44_I_1:   AND2 port map ( O=>T_44, 
            I1=>inst_grmpage_CE, 
            I0=>ti_data_2XPIN );
  GATE_T_45_I_14:   NOR4 port map ( O=>T_45, 
            I3=>T_4, 
            I2=>T_3, 
            I1=>T_2, 
            I0=>T_1 );
  GATE_T_46_I_1:   INV port map ( I0=>T_4, 
            O=>GATE_T_46_A );
  GATE_T_46_I_2:   AND3 port map ( O=>T_46, 
            I2=>T_75, 
            I1=>T_74, 
            I0=>GATE_T_46_A );
  GATE_T_47_I_1:   INV port map ( I0=>inst_grmpage_CE, 
            O=>GATE_T_47_A );
  GATE_T_47_I_2:   AND3 port map ( O=>T_47, 
            I2=>T_3, 
            I1=>T_4, 
            I0=>GATE_T_47_A );
  GATE_T_48_I_1:   INV port map ( I0=>inst_grmpage_CE, 
            O=>GATE_T_48_A );
  GATE_T_48_I_2:   AND3 port map ( O=>T_48, 
            I2=>T_2, 
            I1=>T_4, 
            I0=>GATE_T_48_A );
  GATE_T_49_I_1:   INV port map ( I0=>inst_grmpage_CE, 
            O=>GATE_T_49_A );
  GATE_T_49_I_2:   AND3 port map ( O=>T_49, 
            I2=>T_1, 
            I1=>T_4, 
            I0=>GATE_T_49_A );
  GATE_T_50_I_14:   NOR4 port map ( O=>T_50, 
            I3=>T_3, 
            I2=>T_2, 
            I1=>T_1, 
            I0=>inst_grmpage_CE );
  GATE_T_51_I_1:   INV port map ( I0=>inst_grmpage_CE, 
            O=>GATE_T_51_A );
  GATE_T_51_I_2:   AND3 port map ( O=>T_51, 
            I2=>T_2, 
            I1=>T_3, 
            I0=>GATE_T_51_A );
  GATE_T_52_I_1:   INV port map ( I0=>inst_grmpage_CE, 
            O=>GATE_T_52_A );
  GATE_T_52_I_2:   AND3 port map ( O=>T_52, 
            I2=>T_1, 
            I1=>T_3, 
            I0=>GATE_T_52_A );
  GATE_T_53_I_1:   INV port map ( I0=>inst_grmpage_CE, 
            O=>GATE_T_53_A );
  GATE_T_53_I_2:   AND3 port map ( O=>T_53, 
            I2=>T_1, 
            I1=>T_2, 
            I0=>GATE_T_53_A );
  GATE_T_54_I_1:   NOR3 port map ( O=>T_54, 
            I2=>T_1, 
            I1=>inst_grmpage_CE, 
            I0=>T_2 );
  GATE_T_55_I_1:   INV port map ( I0=>ti_adr_14XPIN, 
            O=>GATE_T_55_A );
  GATE_T_55_I_2:   INV port map ( I0=>ti_gselPIN, 
            O=>GATE_T_55_B );
  GATE_T_55_I_3:   AND3 port map ( O=>T_55, 
            I0=>inst_grmpageQ, 
            I2=>GATE_T_55_A, 
            I1=>GATE_T_55_B );
  GATE_T_56_I_1:   INV port map ( I0=>ti_adr_14XPIN, 
            O=>GATE_T_56_A );
  GATE_T_56_I_2:   INV port map ( I0=>ti_gselPIN, 
            O=>GATE_T_56_B );
  GATE_T_56_I_3:   AND3 port map ( O=>T_56, 
            I0=>inst_grmpageQ, 
            I2=>GATE_T_56_A, 
            I1=>GATE_T_56_B );
  GATE_T_57_I_1:   INV port map ( I0=>ti_adr_14XPIN, 
            O=>GATE_T_57_A );
  GATE_T_57_I_2:   INV port map ( I0=>ti_gselPIN, 
            O=>GATE_T_57_B );
  GATE_T_57_I_3:   AND3 port map ( O=>T_57, 
            I0=>inst_grmpageQ, 
            I2=>GATE_T_57_A, 
            I1=>GATE_T_57_B );
  GATE_T_58_I_1:   INV port map ( I0=>ti_adr_14XPIN, 
            O=>GATE_T_58_A );
  GATE_T_58_I_2:   INV port map ( I0=>ti_gselPIN, 
            O=>GATE_T_58_B );
  GATE_T_58_I_3:   AND3 port map ( O=>T_58, 
            I0=>inst_grmpageQ, 
            I2=>GATE_T_58_A, 
            I1=>GATE_T_58_B );
  GATE_T_59_I_1:   INV port map ( I0=>ti_adr_14XPIN, 
            O=>GATE_T_59_A );
  GATE_T_59_I_2:   INV port map ( I0=>ti_gselPIN, 
            O=>GATE_T_59_B );
  GATE_T_59_I_3:   AND3 port map ( O=>T_59, 
            I0=>inst_grmpageQ, 
            I2=>GATE_T_59_A, 
            I1=>GATE_T_59_B );
  GATE_T_60_I_1:   INV port map ( I0=>ti_adr_14XPIN, 
            O=>GATE_T_60_A );
  GATE_T_60_I_2:   INV port map ( I0=>ti_gselPIN, 
            O=>GATE_T_60_B );
  GATE_T_60_I_3:   AND3 port map ( O=>T_60, 
            I0=>inst_grmpageQ, 
            I2=>GATE_T_60_A, 
            I1=>GATE_T_60_B );
  GATE_T_61_I_1:   INV port map ( I0=>ti_adr_14XPIN, 
            O=>GATE_T_61_A );
  GATE_T_61_I_2:   INV port map ( I0=>ti_gselPIN, 
            O=>GATE_T_61_B );
  GATE_T_61_I_3:   AND3 port map ( O=>T_61, 
            I0=>inst_grmpageQ, 
            I2=>GATE_T_61_A, 
            I1=>GATE_T_61_B );
  GATE_T_62_I_1:   INV port map ( I0=>ti_adr_14XPIN, 
            O=>GATE_T_62_A );
  GATE_T_62_I_2:   INV port map ( I0=>ti_gselPIN, 
            O=>GATE_T_62_B );
  GATE_T_62_I_3:   AND3 port map ( O=>T_62, 
            I0=>inst_grmpageQ, 
            I2=>GATE_T_62_A, 
            I1=>GATE_T_62_B );
  GATE_T_63_I_1:   INV port map ( I0=>ti_adr_14XPIN, 
            O=>GATE_T_63_A );
  GATE_T_63_I_2:   INV port map ( I0=>ti_gselPIN, 
            O=>GATE_T_63_B );
  GATE_T_63_I_3:   AND3 port map ( O=>T_63, 
            I0=>inst_grmpageQ, 
            I2=>GATE_T_63_A, 
            I1=>GATE_T_63_B );
  GATE_T_64_I_1:   INV port map ( I0=>ti_adr_14XPIN, 
            O=>GATE_T_64_A );
  GATE_T_64_I_2:   INV port map ( I0=>ti_gselPIN, 
            O=>GATE_T_64_B );
  GATE_T_64_I_3:   AND3 port map ( O=>T_64, 
            I0=>inst_grmpageQ, 
            I2=>GATE_T_64_A, 
            I1=>GATE_T_64_B );
  GATE_T_65_I_1:   INV port map ( I0=>ti_adr_14XPIN, 
            O=>GATE_T_65_A );
  GATE_T_65_I_2:   INV port map ( I0=>ti_gselPIN, 
            O=>GATE_T_65_B );
  GATE_T_65_I_3:   AND3 port map ( O=>T_65, 
            I0=>inst_grmpageQ, 
            I2=>GATE_T_65_A, 
            I1=>GATE_T_65_B );
  GATE_T_66_I_1:   INV port map ( I0=>ti_adr_14XPIN, 
            O=>GATE_T_66_A );
  GATE_T_66_I_2:   INV port map ( I0=>ti_gselPIN, 
            O=>GATE_T_66_B );
  GATE_T_66_I_3:   AND3 port map ( O=>T_66, 
            I0=>inst_grmpageQ, 
            I2=>GATE_T_66_A, 
            I1=>GATE_T_66_B );
  GATE_T_67_I_1:   INV port map ( I0=>ti_adr_14XPIN, 
            O=>GATE_T_67_A );
  GATE_T_67_I_2:   INV port map ( I0=>ti_gselPIN, 
            O=>GATE_T_67_B );
  GATE_T_67_I_3:   AND3 port map ( O=>T_67, 
            I0=>inst_grmpageQ, 
            I2=>GATE_T_67_A, 
            I1=>GATE_T_67_B );
  GATE_T_68_I_1:   INV port map ( I0=>ti_adr_14XPIN, 
            O=>GATE_T_68_A );
  GATE_T_68_I_2:   INV port map ( I0=>ti_gselPIN, 
            O=>GATE_T_68_B );
  GATE_T_68_I_3:   AND3 port map ( O=>T_68, 
            I0=>inst_grmpageQ, 
            I2=>GATE_T_68_A, 
            I1=>GATE_T_68_B );
  GATE_T_69_I_1:   INV port map ( I0=>ti_adr_14XPIN, 
            O=>GATE_T_69_A );
  GATE_T_69_I_2:   INV port map ( I0=>ti_gselPIN, 
            O=>GATE_T_69_B );
  GATE_T_69_I_3:   AND3 port map ( O=>T_69, 
            I0=>inst_grmpageQ, 
            I2=>GATE_T_69_A, 
            I1=>GATE_T_69_B );
  GATE_T_70_I_1:   INV port map ( I0=>ti_adr_14XPIN, 
            O=>GATE_T_70_A );
  GATE_T_70_I_2:   INV port map ( I0=>ti_gselPIN, 
            O=>GATE_T_70_B );
  GATE_T_70_I_3:   AND3 port map ( O=>T_70, 
            I0=>inst_grmpageQ, 
            I2=>GATE_T_70_A, 
            I1=>GATE_T_70_B );
  GATE_T_71_I_1:   INV port map ( I0=>ti_adr_14XPIN, 
            O=>GATE_T_71_A );
  GATE_T_71_I_2:   INV port map ( I0=>ti_gselPIN, 
            O=>GATE_T_71_B );
  GATE_T_71_I_3:   AND3 port map ( O=>T_71, 
            I0=>inst_grmpageQ, 
            I2=>GATE_T_71_A, 
            I1=>GATE_T_71_B );
  GATE_T_72_I_1:   NOR2 port map ( O=>T_72, 
            I1=>T_4, 
            I0=>T_3 );
  GATE_T_73_I_1:   NOR2 port map ( O=>T_73, 
            I1=>T_2, 
            I0=>T_1 );
  GATE_T_74_I_1:   NOR2 port map ( O=>T_74, 
            I1=>T_3, 
            I0=>T_2 );
  GATE_T_75_I_1:   NOR2 port map ( O=>T_75, 
            I1=>T_1, 
            I0=>inst_grmpage_CE );

end NetList;
