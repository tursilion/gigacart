MODEL
MODEL_VERSION "1.0";
DESIGN "gigacart";
DATE "Sat Sep 29 18:16:15 2018";
VENDOR "Lattice Semiconductor Corporation";
PROGRAM "STAMP Model Generator";

/* port name and type */
INPUT out_data_0;
INPUT out_data_1;
INPUT out_data_2;
INPUT out_data_3;
INPUT out_data_4;
INPUT out_data_5;
INPUT out_data_6;
INPUT out_data_7;
INPUT ti_adr_3;
INPUT ti_adr_4;
INPUT ti_adr_5;
INPUT ti_adr_6;
INPUT ti_adr_7;
INPUT ti_adr_8;
INPUT ti_adr_9;
INPUT ti_adr_10;
INPUT ti_adr_11;
INPUT ti_adr_12;
INPUT ti_adr_13;
INPUT ti_adr_14;
INPUT ti_adr_15;
INPUT ti_gclk;
INPUT ti_gsel;
INPUT ti_rom;
INPUT ti_we;
OUTPUT out_adr_0;
OUTPUT out_adr_1;
OUTPUT out_adr_2;
OUTPUT out_adr_3;
OUTPUT out_adr_4;
OUTPUT out_adr_5;
OUTPUT out_adr_6;
OUTPUT out_adr_7;
OUTPUT out_adr_8;
OUTPUT out_adr_9;
OUTPUT out_adr_10;
OUTPUT out_adr_11;
OUTPUT out_adr_12;
OUTPUT out_adr_13;
OUTPUT out_adr_14;
OUTPUT out_adr_15;
OUTPUT out_adr_16;
OUTPUT out_adr_17;
OUTPUT out_adr_18;
OUTPUT out_adr_19;
OUTPUT out_adr_20;
OUTPUT out_adr_21;
OUTPUT out_adr_22;
OUTPUT out_adr_23;
OUTPUT out_adr_24;
OUTPUT out_adr_25;
OUTPUT out_adr_26;
OUTPUT out_reset;
INOUT ti_data_0;
INOUT ti_data_1;
INOUT ti_data_2;
INOUT ti_data_3;
INOUT ti_data_4;
INOUT ti_data_5;
INOUT ti_data_6;
INOUT ti_data_7;

/* timing arc definitions */
out_data_0_ti_data_7_delay: DELAY out_data_0 ti_data_7;
out_data_1_ti_data_6_delay: DELAY out_data_1 ti_data_6;
out_data_2_ti_data_5_delay: DELAY out_data_2 ti_data_5;
out_data_3_ti_data_4_delay: DELAY out_data_3 ti_data_4;
out_data_4_ti_data_3_delay: DELAY out_data_4 ti_data_3;
out_data_5_ti_data_2_delay: DELAY out_data_5 ti_data_2;
out_data_6_ti_data_1_delay: DELAY out_data_6 ti_data_1;
out_data_7_ti_data_0_delay: DELAY out_data_7 ti_data_0;
ti_adr_14_out_adr_1_delay: DELAY ti_adr_14 out_adr_1;
ti_adr_3_out_adr_12_delay: DELAY ti_adr_3 out_adr_12;
ti_adr_5_out_adr_10_delay: DELAY ti_adr_5 out_adr_10;
ti_adr_7_out_adr_8_delay: DELAY ti_adr_7 out_adr_8;
ti_adr_8_out_adr_7_delay: DELAY ti_adr_8 out_adr_7;
ti_adr_10_out_adr_5_delay: DELAY ti_adr_10 out_adr_5;
ti_adr_11_out_adr_4_delay: DELAY ti_adr_11 out_adr_4;
ti_adr_13_out_adr_2_delay: DELAY ti_adr_13 out_adr_2;
ti_adr_4_out_adr_11_delay: DELAY ti_adr_4 out_adr_11;
ti_adr_6_out_adr_9_delay: DELAY ti_adr_6 out_adr_9;
ti_adr_9_out_adr_6_delay: DELAY ti_adr_9 out_adr_6;
ti_adr_12_out_adr_3_delay: DELAY ti_adr_12 out_adr_3;
ti_adr_15_out_adr_0_delay: DELAY ti_adr_15 out_adr_0;
ti_gsel_out_adr_0_delay: DELAY ti_gsel out_adr_0;
ti_gsel_out_adr_1_delay: DELAY ti_gsel out_adr_1;
ti_gsel_out_adr_2_delay: DELAY ti_gsel out_adr_2;
ti_gsel_out_adr_3_delay: DELAY ti_gsel out_adr_3;
ti_gsel_out_adr_4_delay: DELAY ti_gsel out_adr_4;
ti_gsel_out_adr_5_delay: DELAY ti_gsel out_adr_5;
ti_gsel_out_adr_6_delay: DELAY ti_gsel out_adr_6;
ti_gsel_out_adr_7_delay: DELAY ti_gsel out_adr_7;
ti_gsel_out_adr_8_delay: DELAY ti_gsel out_adr_8;
ti_gsel_out_adr_9_delay: DELAY ti_gsel out_adr_9;
ti_gsel_out_adr_10_delay: DELAY ti_gsel out_adr_10;
ti_gsel_out_adr_11_delay: DELAY ti_gsel out_adr_11;
ti_gsel_out_adr_12_delay: DELAY ti_gsel out_adr_12;
ti_gsel_out_adr_13_delay: DELAY ti_gsel out_adr_13;
ti_gsel_out_adr_14_delay: DELAY ti_gsel out_adr_14;
ti_gsel_out_adr_15_delay: DELAY ti_gsel out_adr_15;
ti_gsel_out_adr_16_delay: DELAY ti_gsel out_adr_16;
ti_gsel_out_adr_17_delay: DELAY ti_gsel out_adr_17;
ti_gsel_out_adr_18_delay: DELAY ti_gsel out_adr_18;
ti_gsel_out_adr_19_delay: DELAY ti_gsel out_adr_19;
ti_gsel_out_adr_20_delay: DELAY ti_gsel out_adr_20;
ti_gsel_out_adr_21_delay: DELAY ti_gsel out_adr_21;
ti_gsel_out_adr_22_delay: DELAY ti_gsel out_adr_22;
ti_gsel_out_adr_23_delay: DELAY ti_gsel out_adr_23;
ti_gsel_out_adr_24_delay: DELAY ti_gsel out_adr_24;
ti_gsel_out_adr_25_delay: DELAY ti_gsel out_adr_25;
ti_gsel_out_adr_26_delay: DELAY ti_gsel out_adr_26;
ti_we_out_adr_7_delay: DELAY ti_we out_adr_7;
ti_we_out_adr_16_delay: DELAY ti_we out_adr_16;
ti_we_out_adr_17_delay: DELAY ti_we out_adr_17;
ti_we_out_adr_24_delay: DELAY ti_we out_adr_24;
ti_we_out_adr_25_delay: DELAY ti_we out_adr_25;
ti_we_out_adr_26_delay: DELAY ti_we out_adr_26;
ti_we_out_adr_0_delay: DELAY ti_we out_adr_0;
ti_we_out_adr_1_delay: DELAY ti_we out_adr_1;
ti_we_out_adr_2_delay: DELAY ti_we out_adr_2;
ti_we_out_adr_3_delay: DELAY ti_we out_adr_3;
ti_we_out_adr_4_delay: DELAY ti_we out_adr_4;
ti_we_out_adr_5_delay: DELAY ti_we out_adr_5;
ti_we_out_adr_6_delay: DELAY ti_we out_adr_6;
ti_we_out_adr_13_delay: DELAY ti_we out_adr_13;
ti_we_out_adr_14_delay: DELAY ti_we out_adr_14;
ti_we_out_adr_15_delay: DELAY ti_we out_adr_15;
ti_we_out_adr_18_delay: DELAY ti_we out_adr_18;
ti_we_out_adr_19_delay: DELAY ti_we out_adr_19;
ti_we_out_adr_20_delay: DELAY ti_we out_adr_20;
ti_we_out_adr_21_delay: DELAY ti_we out_adr_21;
ti_we_out_adr_22_delay: DELAY ti_we out_adr_22;
ti_we_out_adr_23_delay: DELAY ti_we out_adr_23;
ti_we_out_reset_delay: DELAY ti_we out_reset;

/* timing check arc definitions */
ti_data_1_ti_we_setup: SETUP(POSEDGE) ti_data_1 ti_we;
ti_data_1_ti_we_hold: HOLD(POSEDGE) ti_data_1 ti_we;
ti_data_2_ti_we_setup: SETUP(POSEDGE) ti_data_2 ti_we;
ti_data_2_ti_we_hold: HOLD(POSEDGE) ti_data_2 ti_we;
ti_data_3_ti_we_setup: SETUP(POSEDGE) ti_data_3 ti_we;
ti_data_3_ti_we_hold: HOLD(POSEDGE) ti_data_3 ti_we;
ti_data_4_ti_we_setup: SETUP(POSEDGE) ti_data_4 ti_we;
ti_data_4_ti_we_hold: HOLD(POSEDGE) ti_data_4 ti_we;
ti_data_5_ti_we_setup: SETUP(POSEDGE) ti_data_5 ti_we;
ti_data_5_ti_we_hold: HOLD(POSEDGE) ti_data_5 ti_we;
ti_data_6_ti_we_setup: SETUP(POSEDGE) ti_data_6 ti_we;
ti_data_6_ti_we_hold: HOLD(POSEDGE) ti_data_6 ti_we;
ti_data_7_ti_we_setup: SETUP(POSEDGE) ti_data_7 ti_we;
ti_data_7_ti_we_hold: HOLD(POSEDGE) ti_data_7 ti_we;
ti_data_0_ti_we_setup: SETUP(POSEDGE) ti_data_0 ti_we;
ti_data_0_ti_we_hold: HOLD(POSEDGE) ti_data_0 ti_we;
ti_adr_14_ti_we_setup: SETUP(POSEDGE) ti_adr_14 ti_we;
ti_adr_14_ti_we_hold: HOLD(POSEDGE) ti_adr_14 ti_we;
ti_adr_5_ti_we_setup: SETUP(POSEDGE) ti_adr_5 ti_we;
ti_adr_5_ti_we_hold: HOLD(POSEDGE) ti_adr_5 ti_we;
ti_adr_7_ti_we_setup: SETUP(POSEDGE) ti_adr_7 ti_we;
ti_adr_7_ti_we_hold: HOLD(POSEDGE) ti_adr_7 ti_we;
ti_adr_8_ti_we_setup: SETUP(POSEDGE) ti_adr_8 ti_we;
ti_adr_8_ti_we_hold: HOLD(POSEDGE) ti_adr_8 ti_we;
ti_adr_13_ti_we_setup: SETUP(POSEDGE) ti_adr_13 ti_we;
ti_adr_13_ti_we_hold: HOLD(POSEDGE) ti_adr_13 ti_we;
ti_adr_4_ti_we_setup: SETUP(POSEDGE) ti_adr_4 ti_we;
ti_adr_4_ti_we_hold: HOLD(POSEDGE) ti_adr_4 ti_we;
ti_adr_6_ti_we_setup: SETUP(POSEDGE) ti_adr_6 ti_we;
ti_adr_6_ti_we_hold: HOLD(POSEDGE) ti_adr_6 ti_we;
ti_adr_9_ti_we_setup: SETUP(POSEDGE) ti_adr_9 ti_we;
ti_adr_9_ti_we_hold: HOLD(POSEDGE) ti_adr_9 ti_we;
ti_adr_12_ti_we_setup: SETUP(POSEDGE) ti_adr_12 ti_we;
ti_adr_12_ti_we_hold: HOLD(POSEDGE) ti_adr_12 ti_we;
ti_adr_14_ti_gclk_setup: SETUP(POSEDGE) ti_adr_14 ti_gclk;
ti_adr_14_ti_gclk_hold: HOLD(POSEDGE) ti_adr_14 ti_gclk;
ti_gsel_ti_gclk_setup: SETUP(POSEDGE) ti_gsel ti_gclk;
ti_gsel_ti_gclk_hold: HOLD(POSEDGE) ti_gsel ti_gclk;
ti_adr_3_ti_we_setup: SETUP(POSEDGE) ti_adr_3 ti_we;
ti_adr_3_ti_we_hold: HOLD(POSEDGE) ti_adr_3 ti_we;
ti_adr_10_ti_we_setup: SETUP(POSEDGE) ti_adr_10 ti_we;
ti_adr_10_ti_we_hold: HOLD(POSEDGE) ti_adr_10 ti_we;
ti_adr_11_ti_we_setup: SETUP(POSEDGE) ti_adr_11 ti_we;
ti_adr_11_ti_we_hold: HOLD(POSEDGE) ti_adr_11 ti_we;
ti_gsel_ti_we_setup: SETUP(POSEDGE) ti_gsel ti_we;
ti_gsel_ti_we_hold: HOLD(POSEDGE) ti_gsel ti_we;

ENDMODEL
