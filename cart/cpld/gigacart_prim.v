// Verilog netlist produced by program LSE :  version Diamond Version 0.0.0
// Netlist written on Wed Oct 10 01:00:19 2018
//
// Verilog Description of module gigacart
//

module gigacart (ti_adr, ti_data, ti_we, ti_rom, ti_gsel, ti_gclk, 
            out_adr, out_data, out_reset);   // design.vhd(21[8:16])
    input [15:3]ti_adr;   // design.vhd(24[3:9])
    inout [7:0]ti_data;   // design.vhd(25[3:10])
    input ti_we;   // design.vhd(26[3:8])
    input ti_rom;   // design.vhd(27[3:9])
    input ti_gsel;   // design.vhd(28[3:10])
    input ti_gclk;   // design.vhd(29[3:10])
    output [26:0]out_adr;   // design.vhd(32[3:10])
    input [7:0]out_data;   // design.vhd(33[3:11])
    output out_reset;   // design.vhd(35[3:12])
    
    wire ti_we_c /* synthesis is_clock=1, SET_AS_NETWORK=ti_we_c */ ;   // design.vhd(26[3:8])
    wire ti_gclk_c /* synthesis is_clock=1 */ ;   // design.vhd(29[3:10])
    wire gvalid /* synthesis is_clock=1, SET_AS_NETWORK=gvalid */ ;   // design.vhd(52[9:15])
    wire ti_gclk_N_54 /* synthesis is_inv_clock=1, SET_AS_NETWORK=ti_gclk_N_54, is_clock=1 */ ;   // design.vhd(51[9:16])
    
    wire n431, out_reset_c, ti_adr_c_15, ti_adr_c_14, ti_adr_c_13, 
        ti_adr_c_12, ti_adr_c_11, ti_adr_c_10, ti_adr_c_9, ti_adr_c_8, 
        ti_adr_c_7, ti_adr_c_6, ti_adr_c_5, ti_adr_c_4, ti_adr_c_3, 
        gnd, n457, n487, n489, n392, n459, n477, n385, ti_rom_c, 
        ti_gsel_c, out_adr_c_26, out_adr_c_25, out_adr_c_24, out_adr_c_23, 
        out_adr_c_22, out_adr_c_21, out_adr_c_20, out_adr_c_19, out_adr_c_18, 
        out_adr_c_17, out_adr_c_16, out_adr_c_15, out_adr_c_14, out_adr_c_13, 
        out_adr_c_12, out_adr_c_11, out_adr_c_10, out_adr_c_9, out_adr_c_8, 
        out_adr_c_7, out_adr_c_6, out_adr_c_5, out_adr_c_4, out_adr_c_3, 
        out_adr_c_2, out_adr_c_1, out_adr_c_0, out_data_c_7, out_data_c_6, 
        out_data_c_5, out_data_c_4, out_data_c_3, out_data_c_2, out_data_c_1, 
        out_data_c_0, n456, dataout;
    wire [13:0]latch;   // design.vhd(46[9:14])
    wire [0:7]grmadr;   // design.vhd(49[9:15])
    
    wire grmpage, gactive, gadd, gactive_N_52, n444, n448, ti_adr_14__N_44, 
        n377, n437, n475, ti_rom_N_24, n474, ti_data_out_7, n453, 
        n451, n490, n472, n447, n483, n7, n9, n314, n484, 
        ti_we_N_35, grmadr_0__N_33, n446, n436, n219, n105, n106, 
        n107, n108, n109, n110, n111, n112, n435, n286, n481, 
        n471, n443, n469, n413, n468, n466;
    wire [7:0]grmadr_0__N_15;
    
    wire n216, n399, n465, ti_data_out_6, n492, ti_data_out_5, n493, 
        ti_data_out_4, ti_data_out_3, ti_data_out_2, ti_data_out_1, 
        ti_data_out_0, n454, n463, n420, n462, n480, n460, n478, 
        n486, n450, n406;
    
    BI_DIR ti_data_pad_5 (.O(ti_data_out_5), .I0(out_data_c_2), .IO(ti_data[5]), 
           .OE(dataout));   // C:/ispLEVER_Classic2_0/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(67[8:14])
    DFF gvalid_103 (.Q(gvalid), .D(n7), .CLK(ti_gclk_N_54));   // design.vhd(60[3] 80[10])
    DFFC grmadr_i7 (.Q(grmadr[7]), .D(grmadr_0__N_15[0]), .CLK(gvalid), 
         .CE(n286)) /* synthesis lse_init_val=0 */ ;   // design.vhd(146[3] 178[10])
    DFFC gadd_108 (.Q(gadd), .D(n219), .CLK(gvalid), .CE(n286));   // design.vhd(146[3] 178[10])
    DFFC grmpage_105 (.Q(grmpage), .D(n436), .CLK(gvalid), .CE(grmadr_0__N_33));   // design.vhd(146[3] 178[10])
    DFF gactive_102 (.Q(gactive), .D(gactive_N_52), .CLK(ti_gclk_N_54)) /* synthesis lse_init_val=0 */ ;   // design.vhd(60[3] 80[10])
    DFFC latch_i0_i6 (.Q(latch[6]), .D(ti_adr_c_8), .CLK(ti_we_c), .CE(ti_rom_N_24)) /* synthesis lse_init_val=0 */ ;   // design.vhd(102[3] 128[10])
    DFFC latch_i0_i13 (.Q(latch[13]), .D(ti_data_out_6), .CLK(ti_we_c), 
         .CE(ti_rom_N_24)) /* synthesis lse_init_val=0 */ ;   // design.vhd(102[3] 128[10])
    DFFC latch_i0_i12 (.Q(latch[12]), .D(ti_data_out_7), .CLK(ti_we_c), 
         .CE(ti_rom_N_24)) /* synthesis lse_init_val=0 */ ;   // design.vhd(102[3] 128[10])
    DFFC latch_i0_i11 (.Q(latch[11]), .D(ti_adr_c_3), .CLK(ti_we_c), .CE(ti_rom_N_24)) /* synthesis lse_init_val=0 */ ;   // design.vhd(102[3] 128[10])
    DFFC latch_i0_i10 (.Q(latch[10]), .D(ti_adr_c_4), .CLK(ti_we_c), .CE(ti_rom_N_24)) /* synthesis lse_init_val=0 */ ;   // design.vhd(102[3] 128[10])
    DFFC latch_i0_i9 (.Q(latch[9]), .D(ti_adr_c_5), .CLK(ti_we_c), .CE(ti_rom_N_24)) /* synthesis lse_init_val=0 */ ;   // design.vhd(102[3] 128[10])
    DFFC latch_i0_i5 (.Q(latch[5]), .D(ti_adr_c_9), .CLK(ti_we_c), .CE(ti_rom_N_24)) /* synthesis lse_init_val=0 */ ;   // design.vhd(102[3] 128[10])
    BI_DIR ti_data_pad_6 (.O(ti_data_out_6), .I0(out_data_c_1), .IO(ti_data[6]), 
           .OE(dataout));   // C:/ispLEVER_Classic2_0/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(67[8:14])
    BI_DIR ti_data_pad_7 (.O(ti_data_out_7), .I0(out_data_c_0), .IO(ti_data[7]), 
           .OE(dataout));   // C:/ispLEVER_Classic2_0/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(67[8:14])
    DFFC latch_i0_i4 (.Q(latch[4]), .D(ti_adr_c_10), .CLK(ti_we_c), .CE(ti_rom_N_24)) /* synthesis lse_init_val=0 */ ;   // design.vhd(102[3] 128[10])
    BI_DIR ti_data_pad_4 (.O(ti_data_out_4), .I0(out_data_c_3), .IO(ti_data[4]), 
           .OE(dataout));   // C:/ispLEVER_Classic2_0/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(67[8:14])
    BI_DIR ti_data_pad_3 (.O(ti_data_out_3), .I0(out_data_c_4), .IO(ti_data[3]), 
           .OE(dataout));   // C:/ispLEVER_Classic2_0/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(67[8:14])
    DFFC latch_i0_i3 (.Q(latch[3]), .D(ti_adr_c_11), .CLK(ti_we_c), .CE(ti_rom_N_24)) /* synthesis lse_init_val=0 */ ;   // design.vhd(102[3] 128[10])
    BI_DIR ti_data_pad_2 (.O(ti_data_out_2), .I0(out_data_c_5), .IO(ti_data[2]), 
           .OE(dataout));   // C:/ispLEVER_Classic2_0/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(67[8:14])
    DFFC latch_i0_i2 (.Q(latch[2]), .D(ti_adr_c_12), .CLK(ti_we_c), .CE(ti_rom_N_24)) /* synthesis lse_init_val=0 */ ;   // design.vhd(102[3] 128[10])
    BI_DIR ti_data_pad_1 (.O(ti_data_out_1), .I0(out_data_c_6), .IO(ti_data[1]), 
           .OE(dataout));   // C:/ispLEVER_Classic2_0/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(67[8:14])
    DFFC latch_i0_i1 (.Q(latch[1]), .D(ti_adr_c_13), .CLK(ti_we_c), .CE(ti_rom_N_24)) /* synthesis lse_init_val=0 */ ;   // design.vhd(102[3] 128[10])
    BI_DIR ti_data_pad_0 (.O(ti_data_out_0), .I0(out_data_c_7), .IO(ti_data[0]), 
           .OE(dataout));   // C:/ispLEVER_Classic2_0/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(67[8:14])
    DFFC latch_i0_i0 (.Q(latch[0]), .D(ti_adr_c_14), .CLK(ti_we_c), .CE(ti_rom_N_24)) /* synthesis lse_init_val=0 */ ;   // design.vhd(102[3] 128[10])
    OBUF out_adr_pad_26 (.O(out_adr[26]), .I0(out_adr_c_26));   // C:/ispLEVER_Classic2_0/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(270[8:12])
    DFFC latch_i0_i8 (.Q(latch[8]), .D(ti_adr_c_6), .CLK(ti_we_c), .CE(ti_rom_N_24)) /* synthesis lse_init_val=0 */ ;   // design.vhd(102[3] 128[10])
    OBUF out_adr_pad_25 (.O(out_adr[25]), .I0(out_adr_c_25));   // C:/ispLEVER_Classic2_0/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(270[8:12])
    OBUF out_adr_pad_24 (.O(out_adr[24]), .I0(out_adr_c_24));   // C:/ispLEVER_Classic2_0/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(270[8:12])
    OBUF out_adr_pad_23 (.O(out_adr[23]), .I0(out_adr_c_23));   // C:/ispLEVER_Classic2_0/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(270[8:12])
    OBUF out_adr_pad_22 (.O(out_adr[22]), .I0(out_adr_c_22));   // C:/ispLEVER_Classic2_0/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(270[8:12])
    OBUF out_adr_pad_21 (.O(out_adr[21]), .I0(out_adr_c_21));   // C:/ispLEVER_Classic2_0/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(270[8:12])
    OBUF out_adr_pad_20 (.O(out_adr[20]), .I0(out_adr_c_20));   // C:/ispLEVER_Classic2_0/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(270[8:12])
    OBUF out_adr_pad_19 (.O(out_adr[19]), .I0(out_adr_c_19));   // C:/ispLEVER_Classic2_0/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(270[8:12])
    OBUF out_adr_pad_18 (.O(out_adr[18]), .I0(out_adr_c_18));   // C:/ispLEVER_Classic2_0/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(270[8:12])
    OBUF out_adr_pad_17 (.O(out_adr[17]), .I0(out_adr_c_17));   // C:/ispLEVER_Classic2_0/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(270[8:12])
    OBUF out_adr_pad_16 (.O(out_adr[16]), .I0(out_adr_c_16));   // C:/ispLEVER_Classic2_0/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(270[8:12])
    OBUF out_adr_pad_15 (.O(out_adr[15]), .I0(out_adr_c_15));   // C:/ispLEVER_Classic2_0/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(270[8:12])
    OBUF out_adr_pad_14 (.O(out_adr[14]), .I0(out_adr_c_14));   // C:/ispLEVER_Classic2_0/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(270[8:12])
    OBUF out_adr_pad_13 (.O(out_adr[13]), .I0(out_adr_c_13));   // C:/ispLEVER_Classic2_0/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(270[8:12])
    OBUF out_adr_pad_12 (.O(out_adr[12]), .I0(out_adr_c_12));   // C:/ispLEVER_Classic2_0/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(270[8:12])
    OBUF out_adr_pad_11 (.O(out_adr[11]), .I0(out_adr_c_11));   // C:/ispLEVER_Classic2_0/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(270[8:12])
    OBUF out_adr_pad_10 (.O(out_adr[10]), .I0(out_adr_c_10));   // C:/ispLEVER_Classic2_0/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(270[8:12])
    OBUF out_adr_pad_9 (.O(out_adr[9]), .I0(out_adr_c_9));   // C:/ispLEVER_Classic2_0/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(270[8:12])
    OBUF out_adr_pad_8 (.O(out_adr[8]), .I0(out_adr_c_8));   // C:/ispLEVER_Classic2_0/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(270[8:12])
    OBUF out_adr_pad_7 (.O(out_adr[7]), .I0(out_adr_c_7));   // C:/ispLEVER_Classic2_0/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(270[8:12])
    OBUF out_adr_pad_6 (.O(out_adr[6]), .I0(out_adr_c_6));   // C:/ispLEVER_Classic2_0/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(270[8:12])
    OBUF out_adr_pad_5 (.O(out_adr[5]), .I0(out_adr_c_5));   // C:/ispLEVER_Classic2_0/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(270[8:12])
    OBUF out_adr_pad_4 (.O(out_adr[4]), .I0(out_adr_c_4));   // C:/ispLEVER_Classic2_0/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(270[8:12])
    OBUF out_adr_pad_3 (.O(out_adr[3]), .I0(out_adr_c_3));   // C:/ispLEVER_Classic2_0/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(270[8:12])
    OBUF out_adr_pad_2 (.O(out_adr[2]), .I0(out_adr_c_2));   // C:/ispLEVER_Classic2_0/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(270[8:12])
    OBUF out_adr_pad_1 (.O(out_adr[1]), .I0(out_adr_c_1));   // C:/ispLEVER_Classic2_0/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(270[8:12])
    OBUF out_adr_pad_0 (.O(out_adr[0]), .I0(out_adr_c_0));   // C:/ispLEVER_Classic2_0/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(270[8:12])
    OBUF out_reset_pad (.O(out_reset), .I0(out_reset_c));   // C:/ispLEVER_Classic2_0/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(270[8:12])
    IBUF ti_adr_pad_15 (.O(ti_adr_c_15), .I0(ti_adr[15]));   // C:/ispLEVER_Classic2_0/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(186[8:12])
    IBUF ti_adr_pad_14 (.O(ti_adr_c_14), .I0(ti_adr[14]));   // C:/ispLEVER_Classic2_0/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(186[8:12])
    IBUF ti_adr_pad_13 (.O(ti_adr_c_13), .I0(ti_adr[13]));   // C:/ispLEVER_Classic2_0/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(186[8:12])
    IBUF ti_adr_pad_12 (.O(ti_adr_c_12), .I0(ti_adr[12]));   // C:/ispLEVER_Classic2_0/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(186[8:12])
    IBUF ti_adr_pad_11 (.O(ti_adr_c_11), .I0(ti_adr[11]));   // C:/ispLEVER_Classic2_0/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(186[8:12])
    IBUF ti_adr_pad_10 (.O(ti_adr_c_10), .I0(ti_adr[10]));   // C:/ispLEVER_Classic2_0/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(186[8:12])
    IBUF ti_adr_pad_9 (.O(ti_adr_c_9), .I0(ti_adr[9]));   // C:/ispLEVER_Classic2_0/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(186[8:12])
    IBUF ti_adr_pad_8 (.O(ti_adr_c_8), .I0(ti_adr[8]));   // C:/ispLEVER_Classic2_0/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(186[8:12])
    IBUF ti_adr_pad_7 (.O(ti_adr_c_7), .I0(ti_adr[7]));   // C:/ispLEVER_Classic2_0/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(186[8:12])
    IBUF ti_adr_pad_6 (.O(ti_adr_c_6), .I0(ti_adr[6]));   // C:/ispLEVER_Classic2_0/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(186[8:12])
    IBUF ti_adr_pad_5 (.O(ti_adr_c_5), .I0(ti_adr[5]));   // C:/ispLEVER_Classic2_0/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(186[8:12])
    IBUF ti_adr_pad_4 (.O(ti_adr_c_4), .I0(ti_adr[4]));   // C:/ispLEVER_Classic2_0/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(186[8:12])
    IBUF ti_adr_pad_3 (.O(ti_adr_c_3), .I0(ti_adr[3]));   // C:/ispLEVER_Classic2_0/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(186[8:12])
    IBUF ti_we_pad (.O(ti_we_c), .I0(ti_we));   // C:/ispLEVER_Classic2_0/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(186[8:12])
    IBUF ti_rom_pad (.O(ti_rom_c), .I0(ti_rom));   // C:/ispLEVER_Classic2_0/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(186[8:12])
    IBUF ti_gsel_pad (.O(ti_gsel_c), .I0(ti_gsel));   // C:/ispLEVER_Classic2_0/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(186[8:12])
    IBUF ti_gclk_pad (.O(ti_gclk_c), .I0(ti_gclk));   // C:/ispLEVER_Classic2_0/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(186[8:12])
    IBUF out_data_pad_7 (.O(out_data_c_7), .I0(out_data[7]));   // C:/ispLEVER_Classic2_0/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(186[8:12])
    IBUF out_data_pad_6 (.O(out_data_c_6), .I0(out_data[6]));   // C:/ispLEVER_Classic2_0/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(186[8:12])
    IBUF out_data_pad_5 (.O(out_data_c_5), .I0(out_data[5]));   // C:/ispLEVER_Classic2_0/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(186[8:12])
    IBUF out_data_pad_4 (.O(out_data_c_4), .I0(out_data[4]));   // C:/ispLEVER_Classic2_0/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(186[8:12])
    IBUF out_data_pad_3 (.O(out_data_c_3), .I0(out_data[3]));   // C:/ispLEVER_Classic2_0/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(186[8:12])
    IBUF out_data_pad_2 (.O(out_data_c_2), .I0(out_data[2]));   // C:/ispLEVER_Classic2_0/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(186[8:12])
    IBUF out_data_pad_1 (.O(out_data_c_1), .I0(out_data[1]));   // C:/ispLEVER_Classic2_0/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(186[8:12])
    IBUF out_data_pad_0 (.O(out_data_c_0), .I0(out_data[0]));   // C:/ispLEVER_Classic2_0/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(186[8:12])
    DFFC grmadr_i6 (.Q(grmadr[6]), .D(grmadr_0__N_15[1]), .CLK(gvalid), 
         .CE(n286)) /* synthesis lse_init_val=0 */ ;   // design.vhd(146[3] 178[10])
    DFFC grmadr_i5 (.Q(grmadr[5]), .D(grmadr_0__N_15[2]), .CLK(gvalid), 
         .CE(n286)) /* synthesis lse_init_val=0 */ ;   // design.vhd(146[3] 178[10])
    DFFC grmadr_i4 (.Q(grmadr[4]), .D(grmadr_0__N_15[3]), .CLK(gvalid), 
         .CE(n286)) /* synthesis lse_init_val=0 */ ;   // design.vhd(146[3] 178[10])
    DFFC grmadr_i3 (.Q(grmadr[3]), .D(grmadr_0__N_15[4]), .CLK(gvalid), 
         .CE(n286)) /* synthesis lse_init_val=0 */ ;   // design.vhd(146[3] 178[10])
    DFFC grmadr_i2 (.Q(grmadr[2]), .D(grmadr_0__N_15[5]), .CLK(gvalid), 
         .CE(n286)) /* synthesis lse_init_val=0 */ ;   // design.vhd(146[3] 178[10])
    DFFC grmadr_i1 (.Q(grmadr[1]), .D(grmadr_0__N_15[6]), .CLK(gvalid), 
         .CE(n286)) /* synthesis lse_init_val=0 */ ;   // design.vhd(146[3] 178[10])
    DFFC grmadr_i0 (.Q(grmadr[0]), .D(grmadr_0__N_15[7]), .CLK(gvalid), 
         .CE(n286)) /* synthesis lse_init_val=0 */ ;   // design.vhd(146[3] 178[10])
    INV i264 (.O(n219), .I0(grmadr_0__N_33));
    INV i279 (.O(n314), .I0(ti_gsel_c));
    GND i412 (.X(gnd));
    OR2 i422 (.O(out_adr_c_6), .I0(n451), .I1(n450));
    INV i413 (.O(n443), .I0(ti_we_c));
    INV i416 (.O(n446), .I0(gvalid));
    DFFC latch_i0_i7 (.Q(latch[7]), .D(ti_adr_c_7), .CLK(ti_we_c), .CE(ti_rom_N_24)) /* synthesis lse_init_val=0 */ ;   // design.vhd(102[3] 128[10])
    INV i414 (.O(n444), .I0(ti_adr_c_14));
    INV ti_we_I_0_112 (.O(ti_we_N_35), .I0(ti_we_c));
    INV ti_rom_I_0 (.O(ti_rom_N_24), .I0(ti_rom_c));
    INV ti_adr_14__I_0 (.O(ti_adr_14__N_44), .I0(ti_adr_c_14));
    INV ti_gclk_I_0 (.O(ti_gclk_N_54), .I0(ti_gclk_c));
    VCC i2 (.X(out_reset_c));
    INV i407 (.O(n435), .I0(n437));
    OR2 i425 (.O(out_adr_c_5), .I0(n454), .I1(n453));
    OR2 i288 (.O(out_adr_c_13), .I0(gvalid), .I1(latch[0]));
    AND2 i445 (.O(n475), .I0(ti_adr_c_14), .I1(ti_data_out_6));
    XOR2 i351 (.O(n111), .I0(n377), .I1(grmadr[6]));
    AND2 i448 (.O(n478), .I0(ti_adr_c_14), .I1(ti_data_out_5));
    OR2 i443 (.O(grmadr_0__N_15[0]), .I0(n472), .I1(n471));
    OR2 i419 (.O(out_adr_c_7), .I0(n448), .I1(n447));
    AND2 i427 (.O(n457), .I0(gvalid), .I1(grmadr[3]));
    AND2 i367 (.O(n399), .I0(n392), .I1(grmadr[4]));
    AND2 grmadr_0__I_1 (.O(grmadr_0__N_33), .I0(ti_adr_c_14), .I1(ti_we_N_35));
    AND2 i418 (.O(n448), .I0(gvalid), .I1(grmadr[0]));
    AND2 i417 (.O(n447), .I0(n446), .I1(ti_adr_c_8));
    AND2 i424 (.O(n454), .I0(gvalid), .I1(grmadr[2]));
    XOR2 i343 (.O(n112), .I0(gadd), .I1(grmadr[7]));
    AND2 i129 (.O(n216), .I0(grmadr_0__N_33), .I1(grmadr[2]));
    AND2 i451 (.O(n481), .I0(ti_adr_c_14), .I1(ti_data_out_4));
    AND2 i463 (.O(n493), .I0(ti_adr_c_14), .I1(ti_data_out_0));
    OR2 i461 (.O(grmadr_0__N_15[6]), .I0(n490), .I1(n489));
    AND2 i353 (.O(n385), .I0(n377), .I1(grmadr[6]));
    OR2 i289 (.O(out_adr_c_14), .I0(gvalid), .I1(latch[1]));
    OR2 gvalid_I_0_113_i1 (.O(out_adr_c_8), .I0(ti_adr_c_7), .I1(gvalid));
    AND2 i460 (.O(n490), .I0(ti_adr_c_14), .I1(ti_data_out_1));
    AND2 i420 (.O(n450), .I0(n446), .I1(ti_adr_c_9));
    AND2 i423 (.O(n453), .I0(n446), .I1(ti_adr_c_10));
    AND2 i426 (.O(n456), .I0(n446), .I1(ti_adr_c_11));
    AND2 i429 (.O(n459), .I0(n446), .I1(ti_adr_c_12));
    AND2 i432 (.O(n462), .I0(n446), .I1(ti_adr_c_13));
    AND2 i435 (.O(n465), .I0(n446), .I1(ti_adr_c_14));
    AND2 i438 (.O(n468), .I0(n446), .I1(ti_adr_c_15));
    AND2 i441 (.O(n471), .I0(ti_adr_14__N_44), .I1(n112));
    AND2 i360 (.O(n392), .I0(n385), .I1(grmadr[5]));
    AND2 i442 (.O(n472), .I0(ti_adr_c_14), .I1(ti_data_out_7));
    OR2 gvalid_I_0_113_i2 (.O(out_adr_c_9), .I0(ti_adr_c_6), .I1(gvalid));
    OR2 gvalid_I_0_113_i3 (.O(out_adr_c_10), .I0(ti_adr_c_5), .I1(gvalid));
    OR2 gvalid_I_0_113_i4 (.O(out_adr_c_11), .I0(ti_adr_c_4), .I1(gvalid));
    OR2 gvalid_I_0_113_i5 (.O(out_adr_c_12), .I0(ti_adr_c_3), .I1(gvalid));
    AND2 i388 (.O(n420), .I0(n413), .I1(grmadr[1]));
    OR2 i440 (.O(out_adr_c_0), .I0(n469), .I1(n468));
    AND2 i439 (.O(n469), .I0(gvalid), .I1(grmadr[7]));
    AND4 i3 (.O(n431), .I0(n314), .I1(gvalid), .I2(grmpage), .I3(ti_adr_14__N_44));
    AND2 i1 (.O(n436), .I0(n435), .I1(grmadr[0]));
    OR2 i437 (.O(out_adr_c_1), .I0(n466), .I1(n465));
    AND2 i436 (.O(n466), .I0(gvalid), .I1(grmadr[6]));
    OR2 i406 (.O(n437), .I0(grmadr[1]), .I1(n216));
    OR2 i434 (.O(out_adr_c_2), .I0(n463), .I1(n462));
    AND2 i1_adj_1 (.O(dataout), .I0(n9), .I1(ti_we_c));
    AND2 i1_adj_2 (.O(n7), .I0(gactive), .I1(n314));
    OR2 i1_adj_3 (.O(n9), .I0(ti_rom_N_24), .I1(n431));
    OR2 i1_adj_4 (.O(gactive_N_52), .I0(n314), .I1(gvalid));
    AND2 i345 (.O(n377), .I0(gadd), .I1(grmadr[7]));
    OR2 i449 (.O(grmadr_0__N_15[2]), .I0(n478), .I1(n477));
    AND2 i433 (.O(n463), .I0(gvalid), .I1(grmadr[5]));
    OR2 i431 (.O(out_adr_c_3), .I0(n460), .I1(n459));
    AND2 i430 (.O(n460), .I0(gvalid), .I1(grmadr[4]));
    OR2 i428 (.O(out_adr_c_4), .I0(n457), .I1(n456));
    OR2 i290 (.O(out_adr_c_15), .I0(gvalid), .I1(latch[2]));
    OR2 i291 (.O(out_adr_c_16), .I0(gvalid), .I1(latch[3]));
    OR2 i292 (.O(out_adr_c_17), .I0(gvalid), .I1(latch[4]));
    OR2 i293 (.O(out_adr_c_18), .I0(gvalid), .I1(latch[5]));
    OR2 i294 (.O(out_adr_c_19), .I0(gvalid), .I1(latch[6]));
    OR2 i295 (.O(out_adr_c_20), .I0(gvalid), .I1(latch[7]));
    OR2 i296 (.O(out_adr_c_21), .I0(gvalid), .I1(latch[8]));
    OR2 i297 (.O(out_adr_c_22), .I0(gvalid), .I1(latch[9]));
    OR2 i298 (.O(out_adr_c_23), .I0(gvalid), .I1(latch[10]));
    OR2 i299 (.O(out_adr_c_24), .I0(gvalid), .I1(latch[11]));
    OR2 i300 (.O(out_adr_c_25), .I0(gvalid), .I1(latch[12]));
    OR2 i301 (.O(out_adr_c_26), .I0(gvalid), .I1(latch[13]));
    OR2 i415 (.O(n286), .I0(n444), .I1(n443));
    AND2 i444 (.O(n474), .I0(ti_adr_14__N_44), .I1(n111));
    OR2 i458 (.O(grmadr_0__N_15[5]), .I0(n487), .I1(n486));
    AND2 i447 (.O(n477), .I0(ti_adr_14__N_44), .I1(n110));
    AND2 i457 (.O(n487), .I0(ti_adr_c_14), .I1(ti_data_out_2));
    AND2 i450 (.O(n480), .I0(ti_adr_14__N_44), .I1(n109));
    OR2 i455 (.O(grmadr_0__N_15[4]), .I0(n484), .I1(n483));
    AND2 i453 (.O(n483), .I0(ti_adr_14__N_44), .I1(n108));
    AND2 i454 (.O(n484), .I0(ti_adr_c_14), .I1(ti_data_out_3));
    AND2 i456 (.O(n486), .I0(ti_adr_14__N_44), .I1(n107));
    OR2 i452 (.O(grmadr_0__N_15[3]), .I0(n481), .I1(n480));
    AND2 i459 (.O(n489), .I0(ti_adr_14__N_44), .I1(n106));
    OR2 i446 (.O(grmadr_0__N_15[1]), .I0(n475), .I1(n474));
    AND2 i462 (.O(n492), .I0(ti_adr_14__N_44), .I1(n105));
    AND2 i421 (.O(n451), .I0(gvalid), .I1(grmadr[1]));
    XOR2 i393 (.O(n105), .I0(n420), .I1(grmadr[0]));
    XOR2 i386 (.O(n106), .I0(n413), .I1(grmadr[1]));
    XOR2 i379 (.O(n107), .I0(n406), .I1(grmadr[2]));
    AND2 i374 (.O(n406), .I0(n399), .I1(grmadr[3]));
    XOR2 i372 (.O(n108), .I0(n399), .I1(grmadr[3]));
    XOR2 i365 (.O(n109), .I0(n392), .I1(grmadr[4]));
    XOR2 i358 (.O(n110), .I0(n385), .I1(grmadr[5]));
    AND2 i381 (.O(n413), .I0(n406), .I1(grmadr[2]));
    OR2 i464 (.O(grmadr_0__N_15[7]), .I0(n493), .I1(n492));
    
endmodule
//
// Verilog Description of module INV
// module not written out since it is a black-box. 
//

//
// Verilog Description of module GND
// module not written out since it is a black-box. 
//

//
// Verilog Description of module OR2
// module not written out since it is a black-box. 
//

//
// Verilog Description of module VCC
// module not written out since it is a black-box. 
//

//
// Verilog Description of module AND2
// module not written out since it is a black-box. 
//

//
// Verilog Description of module XOR2
// module not written out since it is a black-box. 
//

//
// Verilog Description of module AND4
// module not written out since it is a black-box. 
//

