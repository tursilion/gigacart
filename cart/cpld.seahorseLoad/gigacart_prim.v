// Verilog netlist produced by program LSE :  version Diamond Version 0.0.0
// Netlist written on Tue Mar 19 20:21:19 2019
//
// Verilog Description of module gigacart
//

module gigacart (ti_adr, ti_data, ti_we, ti_rom, ti_gsel, ti_gclk, 
            out_adr, out_data, out_we, out_reset);   // design.vhd(24[8:16])
    input [15:3]ti_adr;   // design.vhd(27[3:9])
    inout [7:0]ti_data;   // design.vhd(28[3:10])
    input ti_we;   // design.vhd(29[3:8])
    input ti_rom;   // design.vhd(30[3:9])
    input ti_gsel;   // design.vhd(31[3:10])
    input ti_gclk;   // design.vhd(32[3:10])
    output [26:0]out_adr;   // design.vhd(35[3:10])
    input [7:0]out_data;   // design.vhd(36[3:11])
    output out_we;   // design.vhd(41[3:9])
    output out_reset;   // design.vhd(43[3:12])
    
    wire ti_we_c /* synthesis is_clock=1, SET_AS_NETWORK=ti_we_c */ ;   // design.vhd(29[3:8])
    wire ti_gclk_c /* synthesis is_clock=1 */ ;   // design.vhd(32[3:10])
    wire gvalid /* synthesis is_clock=1, SET_AS_NETWORK=gvalid */ ;   // design.vhd(60[9:15])
    wire ti_gclk_N_53 /* synthesis is_inv_clock=1, SET_AS_NETWORK=ti_gclk_N_53, is_clock=1 */ ;   // design.vhd(59[9:16])
    
    wire out_we_c, ti_adr_c_15, ti_adr_c_14, ti_adr_c_13, ti_adr_c_12, 
        ti_adr_c_11, ti_adr_c_10, ti_adr_c_9, ti_adr_c_8, ti_adr_c_7, 
        ti_adr_c_6, ti_adr_c_5, ti_adr_c_4, ti_adr_c_3, n427, n421, 
        n419, n418, n416, n424, n425, n415, ti_rom_c, ti_gsel_c, 
        out_adr_c_26, out_adr_c_25, out_adr_c_24, out_adr_c_23, out_adr_c_22, 
        out_adr_c_21, out_adr_c_20, out_adr_c_19, out_adr_c_18, out_adr_c_17, 
        out_adr_c_16, out_adr_c_15, out_adr_c_14, out_adr_c_13, out_adr_c_12, 
        out_adr_c_11, out_adr_c_10, out_adr_c_9, out_adr_c_8, out_adr_c_7, 
        out_adr_c_6, out_adr_c_5, out_adr_c_4, out_adr_c_3, out_adr_c_2, 
        out_adr_c_1, out_adr_c_0, out_data_c_7, out_data_c_6, out_data_c_5, 
        out_data_c_4, out_data_c_3, out_data_c_2, out_data_c_1, out_data_c_0, 
        out_reset_c, dataout;
    wire [13:0]latch;   // design.vhd(54[9:14])
    wire [0:7]grmadr;   // design.vhd(57[9:15])
    
    wire gactive, gadd, gactive_N_51, n220, ti_gsel_N_48, ti_adr_14__N_50, 
        n387, n413, dataout_N_44, ti_rom_N_24, dataout_N_43, n412, 
        n410, n339, n331, n400, n346, n406, n398, n403, gnd, 
        n367, n360, n374, n409, ti_we_N_35, grmadr_0__N_33, n394, 
        n391, n433, n218, n105, n106, n107, n108, n109, n110, 
        n111, n112, n212, n353, n422, n282, n407, n404, n388, 
        n397;
    wire [7:0]grmadr_0__N_15;
    
    wire n396, ti_data_out_6, n436, ti_data_out_7, n437, ti_data_out_5, 
        n439, ti_data_out_4, n440, ti_data_out_3, n442, ti_data_out_2, 
        n443, ti_data_out_1, ti_data_out_0, n428, n401, n430, n393, 
        n434, n431;
    
    DFFC grmpage_103 (.Q(out_reset_c), .D(n388), .CLK(gvalid), .CE(grmadr_0__N_33));   // design.vhd(149[3] 186[10])
    DFFC grmadr_i7 (.Q(grmadr[7]), .D(grmadr_0__N_15[0]), .CLK(gvalid), 
         .CE(n282)) /* synthesis lse_init_val=0 */ ;   // design.vhd(149[3] 186[10])
    DFFC gadd_105 (.Q(gadd), .D(n220), .CLK(gvalid), .CE(n282));   // design.vhd(149[3] 186[10])
    DFFC latch_i0_i0 (.Q(latch[0]), .D(ti_adr_c_14), .CLK(ti_we_c), .CE(ti_rom_N_24)) /* synthesis lse_init_val=0 */ ;   // design.vhd(107[3] 133[10])
    DFF gactive_100 (.Q(gactive), .D(gactive_N_51), .CLK(ti_gclk_N_53)) /* synthesis lse_init_val=0 */ ;   // design.vhd(68[3] 79[10])
    DFFC grmadr_i6 (.Q(grmadr[6]), .D(grmadr_0__N_15[1]), .CLK(gvalid), 
         .CE(n282)) /* synthesis lse_init_val=0 */ ;   // design.vhd(149[3] 186[10])
    BI_DIR ti_data_pad_6 (.O(ti_data_out_6), .I0(out_data_c_1), .IO(ti_data[6]), 
           .OE(dataout));   // C:/ispLEVER_Classic2_0/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(67[8:14])
    BI_DIR ti_data_pad_7 (.O(ti_data_out_7), .I0(out_data_c_0), .IO(ti_data[7]), 
           .OE(dataout));   // C:/ispLEVER_Classic2_0/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(67[8:14])
    BI_DIR ti_data_pad_5 (.O(ti_data_out_5), .I0(out_data_c_2), .IO(ti_data[5]), 
           .OE(dataout));   // C:/ispLEVER_Classic2_0/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(67[8:14])
    BI_DIR ti_data_pad_4 (.O(ti_data_out_4), .I0(out_data_c_3), .IO(ti_data[4]), 
           .OE(dataout));   // C:/ispLEVER_Classic2_0/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(67[8:14])
    BI_DIR ti_data_pad_3 (.O(ti_data_out_3), .I0(out_data_c_4), .IO(ti_data[3]), 
           .OE(dataout));   // C:/ispLEVER_Classic2_0/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(67[8:14])
    BI_DIR ti_data_pad_2 (.O(ti_data_out_2), .I0(out_data_c_5), .IO(ti_data[2]), 
           .OE(dataout));   // C:/ispLEVER_Classic2_0/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(67[8:14])
    BI_DIR ti_data_pad_1 (.O(ti_data_out_1), .I0(out_data_c_6), .IO(ti_data[1]), 
           .OE(dataout));   // C:/ispLEVER_Classic2_0/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(67[8:14])
    BI_DIR ti_data_pad_0 (.O(ti_data_out_0), .I0(out_data_c_7), .IO(ti_data[0]), 
           .OE(dataout));   // C:/ispLEVER_Classic2_0/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(67[8:14])
    OBUF out_adr_pad_26 (.O(out_adr[26]), .I0(out_adr_c_26));   // C:/ispLEVER_Classic2_0/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(270[8:12])
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
    OBUF out_we_pad (.O(out_we), .I0(out_we_c));   // C:/ispLEVER_Classic2_0/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(270[8:12])
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
    DFFC grmadr_i5 (.Q(grmadr[5]), .D(grmadr_0__N_15[2]), .CLK(gvalid), 
         .CE(n282)) /* synthesis lse_init_val=0 */ ;   // design.vhd(149[3] 186[10])
    DFFC grmadr_i4 (.Q(grmadr[4]), .D(grmadr_0__N_15[3]), .CLK(gvalid), 
         .CE(n282)) /* synthesis lse_init_val=0 */ ;   // design.vhd(149[3] 186[10])
    DFFC grmadr_i3 (.Q(grmadr[3]), .D(grmadr_0__N_15[4]), .CLK(gvalid), 
         .CE(n282)) /* synthesis lse_init_val=0 */ ;   // design.vhd(149[3] 186[10])
    DFFC grmadr_i2 (.Q(grmadr[2]), .D(grmadr_0__N_15[5]), .CLK(gvalid), 
         .CE(n282)) /* synthesis lse_init_val=0 */ ;   // design.vhd(149[3] 186[10])
    DFFC grmadr_i1 (.Q(grmadr[1]), .D(grmadr_0__N_15[6]), .CLK(gvalid), 
         .CE(n282)) /* synthesis lse_init_val=0 */ ;   // design.vhd(149[3] 186[10])
    DFFC grmadr_i0 (.Q(grmadr[0]), .D(grmadr_0__N_15[7]), .CLK(gvalid), 
         .CE(n282)) /* synthesis lse_init_val=0 */ ;   // design.vhd(149[3] 186[10])
    DFFC latch_i0_i1 (.Q(latch[1]), .D(ti_adr_c_13), .CLK(ti_we_c), .CE(ti_rom_N_24)) /* synthesis lse_init_val=0 */ ;   // design.vhd(107[3] 133[10])
    DFFC latch_i0_i2 (.Q(latch[2]), .D(ti_adr_c_12), .CLK(ti_we_c), .CE(ti_rom_N_24)) /* synthesis lse_init_val=0 */ ;   // design.vhd(107[3] 133[10])
    DFFC latch_i0_i3 (.Q(latch[3]), .D(ti_adr_c_11), .CLK(ti_we_c), .CE(ti_rom_N_24)) /* synthesis lse_init_val=0 */ ;   // design.vhd(107[3] 133[10])
    DFFC latch_i0_i4 (.Q(latch[4]), .D(ti_adr_c_10), .CLK(ti_we_c), .CE(ti_rom_N_24)) /* synthesis lse_init_val=0 */ ;   // design.vhd(107[3] 133[10])
    DFFC latch_i0_i5 (.Q(latch[5]), .D(ti_adr_c_9), .CLK(ti_we_c), .CE(ti_rom_N_24)) /* synthesis lse_init_val=0 */ ;   // design.vhd(107[3] 133[10])
    DFFC latch_i0_i6 (.Q(latch[6]), .D(ti_adr_c_8), .CLK(ti_we_c), .CE(ti_rom_N_24)) /* synthesis lse_init_val=0 */ ;   // design.vhd(107[3] 133[10])
    DFFC latch_i0_i7 (.Q(latch[7]), .D(ti_adr_c_7), .CLK(ti_we_c), .CE(ti_rom_N_24)) /* synthesis lse_init_val=0 */ ;   // design.vhd(107[3] 133[10])
    DFFC latch_i0_i8 (.Q(latch[8]), .D(ti_adr_c_6), .CLK(ti_we_c), .CE(ti_rom_N_24)) /* synthesis lse_init_val=0 */ ;   // design.vhd(107[3] 133[10])
    DFFC latch_i0_i9 (.Q(latch[9]), .D(ti_adr_c_5), .CLK(ti_we_c), .CE(ti_rom_N_24)) /* synthesis lse_init_val=0 */ ;   // design.vhd(107[3] 133[10])
    DFFC latch_i0_i10 (.Q(latch[10]), .D(ti_adr_c_4), .CLK(ti_we_c), .CE(ti_rom_N_24)) /* synthesis lse_init_val=0 */ ;   // design.vhd(107[3] 133[10])
    DFFC latch_i0_i11 (.Q(latch[11]), .D(ti_adr_c_3), .CLK(ti_we_c), .CE(ti_rom_N_24)) /* synthesis lse_init_val=0 */ ;   // design.vhd(107[3] 133[10])
    DFFC latch_i0_i12 (.Q(latch[12]), .D(ti_data_out_7), .CLK(ti_we_c), 
         .CE(ti_rom_N_24)) /* synthesis lse_init_val=0 */ ;   // design.vhd(107[3] 133[10])
    DFFC latch_i0_i13 (.Q(latch[13]), .D(ti_data_out_6), .CLK(ti_we_c), 
         .CE(ti_rom_N_24)) /* synthesis lse_init_val=0 */ ;   // design.vhd(107[3] 133[10])
    INV i364 (.O(n396), .I0(gvalid));
    INV i359 (.O(n387), .I0(n391));
    AND2 i365 (.O(n397), .I0(n396), .I1(ti_adr_c_8));
    GND i360 (.X(gnd));
    INV i257 (.O(n220), .I0(grmadr_0__N_33));
    DFF gvalid_101 (.Q(gvalid), .D(n218), .CLK(ti_gclk_N_53));   // design.vhd(68[3] 79[10])
    INV i361 (.O(n393), .I0(ti_we_c));
    INV ti_we_I_0_110 (.O(ti_we_N_35), .I0(ti_we_c));
    INV i362 (.O(n394), .I0(ti_adr_c_14));
    INV ti_rom_I_0 (.O(ti_rom_N_24), .I0(ti_rom_c));
    INV ti_adr_14__I_0 (.O(ti_adr_14__N_50), .I0(ti_adr_c_14));
    INV ti_gsel_I_0 (.O(ti_gsel_N_48), .I0(ti_gsel_c));
    INV ti_gclk_I_0 (.O(ti_gclk_N_53), .I0(ti_gclk_c));
    VCC i2 (.X(out_we_c));
    OR2 ti_gsel_N_48_I_0 (.O(gactive_N_51), .I0(gvalid), .I1(ti_gsel_N_48));
    OR2 i376 (.O(out_adr_c_4), .I0(n407), .I1(n406));
    AND2 i375 (.O(n407), .I0(gvalid), .I1(grmadr[3]));
    AND2 i387 (.O(n419), .I0(gvalid), .I1(grmadr[7]));
    OR2 i367 (.O(out_adr_c_7), .I0(n398), .I1(n397));
    OR2 i385 (.O(out_adr_c_1), .I0(n416), .I1(n415));
    OR2 dataout_I_0 (.O(dataout_N_43), .I0(ti_rom_N_24), .I1(dataout_N_44));
    AND2 i261 (.O(n218), .I0(ti_gsel_N_48), .I1(gactive));
    AND2 i124 (.O(n212), .I0(grmadr_0__N_33), .I1(grmadr[2]));
    AND2 grmadr_0__I_1 (.O(grmadr_0__N_33), .I0(ti_adr_c_14), .I1(ti_we_N_35));
    XOR2 i295 (.O(n112), .I0(gadd), .I1(grmadr[7]));
    OR2 i388 (.O(out_adr_c_0), .I0(n419), .I1(n418));
    XOR2 i345 (.O(n105), .I0(n374), .I1(grmadr[0]));
    AND2 i405 (.O(n437), .I0(ti_adr_c_14), .I1(ti_data_out_2));
    OR2 i264 (.O(out_adr_c_13), .I0(gvalid), .I1(latch[0]));
    OR2 i265 (.O(out_adr_c_14), .I0(gvalid), .I1(latch[1]));
    OR2 gvalid_I_0_111_i1 (.O(out_adr_c_8), .I0(ti_adr_c_7), .I1(gvalid));
    AND2 i368 (.O(n400), .I0(n396), .I1(ti_adr_c_9));
    AND2 i371 (.O(n403), .I0(n396), .I1(ti_adr_c_10));
    AND2 i374 (.O(n406), .I0(n396), .I1(ti_adr_c_11));
    AND2 i377 (.O(n409), .I0(n396), .I1(ti_adr_c_12));
    AND2 i380 (.O(n412), .I0(n396), .I1(ti_adr_c_13));
    AND2 i383 (.O(n415), .I0(n396), .I1(ti_adr_c_14));
    AND2 i386 (.O(n418), .I0(n396), .I1(ti_adr_c_15));
    AND2 i389 (.O(n421), .I0(ti_adr_14__N_50), .I1(n112));
    XOR2 i338 (.O(n106), .I0(n367), .I1(grmadr[1]));
    AND2 i384 (.O(n416), .I0(gvalid), .I1(grmadr[6]));
    XOR2 i331 (.O(n107), .I0(n360), .I1(grmadr[2]));
    XOR2 i317 (.O(n109), .I0(n346), .I1(grmadr[4]));
    XOR2 i310 (.O(n110), .I0(n339), .I1(grmadr[5]));
    XOR2 i303 (.O(n111), .I0(n331), .I1(grmadr[6]));
    AND2 i319 (.O(n353), .I0(n346), .I1(grmadr[4]));
    AND2 i372 (.O(n404), .I0(gvalid), .I1(grmadr[2]));
    OR2 gvalid_I_0_111_i2 (.O(out_adr_c_9), .I0(ti_adr_c_6), .I1(gvalid));
    OR2 gvalid_I_0_111_i3 (.O(out_adr_c_10), .I0(ti_adr_c_5), .I1(gvalid));
    OR2 gvalid_I_0_111_i4 (.O(out_adr_c_11), .I0(ti_adr_c_4), .I1(gvalid));
    OR2 gvalid_I_0_111_i5 (.O(out_adr_c_12), .I0(ti_adr_c_3), .I1(gvalid));
    OR2 i403 (.O(grmadr_0__N_15[4]), .I0(n434), .I1(n433));
    AND2 i333 (.O(n367), .I0(n360), .I1(grmadr[2]));
    AND2 i340 (.O(n374), .I0(n367), .I1(grmadr[1]));
    OR2 i370 (.O(out_adr_c_6), .I0(n401), .I1(n400));
    AND2 i305 (.O(n339), .I0(n331), .I1(grmadr[6]));
    AND2 i312 (.O(n346), .I0(n339), .I1(grmadr[5]));
    AND2 i297 (.O(n331), .I0(gadd), .I1(grmadr[7]));
    OR2 i382 (.O(out_adr_c_2), .I0(n413), .I1(n412));
    XOR2 i324 (.O(n108), .I0(n353), .I1(grmadr[3]));
    AND2 i326 (.O(n360), .I0(n353), .I1(grmadr[3]));
    AND2 i1 (.O(n388), .I0(n387), .I1(grmadr[0]));
    AND2 i366 (.O(n398), .I0(gvalid), .I1(grmadr[0]));
    AND2 i381 (.O(n413), .I0(gvalid), .I1(grmadr[5]));
    OR2 i373 (.O(out_adr_c_5), .I0(n404), .I1(n403));
    OR2 i363 (.O(n282), .I0(n394), .I1(n393));
    OR2 i358 (.O(n391), .I0(grmadr[1]), .I1(n212));
    OR2 i266 (.O(out_adr_c_15), .I0(gvalid), .I1(latch[2]));
    OR2 i267 (.O(out_adr_c_16), .I0(gvalid), .I1(latch[3]));
    OR2 i268 (.O(out_adr_c_17), .I0(gvalid), .I1(latch[4]));
    OR2 i269 (.O(out_adr_c_18), .I0(gvalid), .I1(latch[5]));
    OR2 i270 (.O(out_adr_c_19), .I0(gvalid), .I1(latch[6]));
    OR2 i271 (.O(out_adr_c_20), .I0(gvalid), .I1(latch[7]));
    OR2 i272 (.O(out_adr_c_21), .I0(gvalid), .I1(latch[8]));
    OR2 i273 (.O(out_adr_c_22), .I0(gvalid), .I1(latch[9]));
    OR2 i274 (.O(out_adr_c_23), .I0(gvalid), .I1(latch[10]));
    OR2 i275 (.O(out_adr_c_24), .I0(gvalid), .I1(latch[11]));
    OR2 i276 (.O(out_adr_c_25), .I0(gvalid), .I1(latch[12]));
    OR2 i277 (.O(out_adr_c_26), .I0(gvalid), .I1(latch[13]));
    AND2 i369 (.O(n401), .I0(gvalid), .I1(grmadr[1]));
    AND2 i378 (.O(n410), .I0(gvalid), .I1(grmadr[4]));
    AND2 i392 (.O(n424), .I0(ti_adr_14__N_50), .I1(n111));
    AND2 i402 (.O(n434), .I0(ti_adr_c_14), .I1(ti_data_out_3));
    AND2 i395 (.O(n427), .I0(ti_adr_14__N_50), .I1(n110));
    OR2 i400 (.O(grmadr_0__N_15[3]), .I0(n431), .I1(n430));
    AND2 i398 (.O(n430), .I0(ti_adr_14__N_50), .I1(n109));
    AND2 i399 (.O(n431), .I0(ti_adr_c_14), .I1(ti_data_out_4));
    AND2 i401 (.O(n433), .I0(ti_adr_14__N_50), .I1(n108));
    OR2 i397 (.O(grmadr_0__N_15[2]), .I0(n428), .I1(n427));
    AND2 i404 (.O(n436), .I0(ti_adr_14__N_50), .I1(n107));
    AND2 i396 (.O(n428), .I0(ti_adr_c_14), .I1(ti_data_out_5));
    AND2 i407 (.O(n439), .I0(ti_adr_14__N_50), .I1(n106));
    OR2 i394 (.O(grmadr_0__N_15[1]), .I0(n425), .I1(n424));
    AND2 i410 (.O(n442), .I0(ti_adr_14__N_50), .I1(n105));
    AND2 i393 (.O(n425), .I0(ti_adr_c_14), .I1(ti_data_out_6));
    OR2 i379 (.O(out_adr_c_3), .I0(n410), .I1(n409));
    AND4 i3 (.O(dataout_N_44), .I0(out_reset_c), .I1(ti_gsel_N_48), .I2(ti_adr_14__N_50), 
         .I3(gvalid));
    AND2 i260 (.O(dataout), .I0(dataout_N_43), .I1(ti_we_c));
    OR2 i391 (.O(grmadr_0__N_15[0]), .I0(n422), .I1(n421));
    AND2 i390 (.O(n422), .I0(ti_adr_c_14), .I1(ti_data_out_7));
    OR2 i406 (.O(grmadr_0__N_15[5]), .I0(n437), .I1(n436));
    AND2 i408 (.O(n440), .I0(ti_adr_c_14), .I1(ti_data_out_1));
    OR2 i409 (.O(grmadr_0__N_15[6]), .I0(n440), .I1(n439));
    AND2 i411 (.O(n443), .I0(ti_adr_c_14), .I1(ti_data_out_0));
    OR2 i412 (.O(grmadr_0__N_15[7]), .I0(n443), .I1(n442));
    
endmodule
//
// Verilog Description of module INV
// module not written out since it is a black-box. 
//

//
// Verilog Description of module AND2
// module not written out since it is a black-box. 
//

//
// Verilog Description of module GND
// module not written out since it is a black-box. 
//

//
// Verilog Description of module VCC
// module not written out since it is a black-box. 
//

//
// Verilog Description of module OR2
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

