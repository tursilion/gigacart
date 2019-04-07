// Verilog netlist produced by program LSE :  version Diamond Version 0.0.0
// Netlist written on Sat Apr 06 20:43:23 2019
//
// Verilog Description of module gigacart
//

module gigacart (ti_adr, ti_data, ti_we, ti_rom, ti_gsel, ti_gclk, 
            out_adr, out_data, out_oe, out_reset);   // design.vhd(24[8:16])
    input [15:3]ti_adr;   // design.vhd(27[3:9])
    inout [7:0]ti_data;   // design.vhd(28[3:10])
    input ti_we;   // design.vhd(29[3:8])
    input ti_rom;   // design.vhd(30[3:9])
    input ti_gsel;   // design.vhd(31[3:10])
    input ti_gclk;   // design.vhd(32[3:10])
    output [26:0]out_adr;   // design.vhd(35[3:10])
    input [7:0]out_data;   // design.vhd(36[3:11])
    output out_oe;   // design.vhd(42[3:9])
    output out_reset;   // design.vhd(43[3:12])
    
    wire ti_we_c /* synthesis is_clock=1, SET_AS_NETWORK=ti_we_c */ ;   // design.vhd(29[3:8])
    wire ti_gclk_c /* synthesis is_clock=1 */ ;   // design.vhd(32[3:10])
    wire gvalid /* synthesis is_clock=1, SET_AS_NETWORK=gvalid */ ;   // design.vhd(60[9:15])
    wire ti_gclk_N_54 /* synthesis is_inv_clock=1, SET_AS_NETWORK=ti_gclk_N_54, is_clock=1 */ ;   // design.vhd(59[9:16])
    
    wire out_oe_c, ti_adr_c_15, ti_adr_c_14, ti_adr_c_13, ti_adr_c_12, 
        ti_adr_c_11, ti_adr_c_10, ti_adr_c_9, ti_adr_c_8, ti_adr_c_7, 
        ti_adr_c_6, ti_adr_c_5, ti_adr_c_4, ti_adr_c_3, n458, n461, 
        n463, n464, n466, n457, n455, n431, ti_rom_c, ti_gsel_c, 
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
    
    wire grmpage, gactive, gadd, gactive_N_52, n221, ti_gsel_N_42, 
        ti_adr_14__N_44, n414, pwr, dataout_N_38, ti_rom_N_24, dataout_N_37, 
        n427, n428, n387, n380, n440, n439, n373, n437, n366, 
        n430, n401, n394, n454, n470, ti_we_N_35, grmadr_0__N_33, 
        n421, n418, n436, n219, n105, n106, n107, n108, n109, 
        n110, n111, n112, n213, n452, n451, n283, n449, n448, 
        n415, n424;
    wire [7:0]grmadr_0__N_15;
    
    wire n423, ti_data_out_6, n460, ti_data_out_7, n467, ti_data_out_5, 
        n469, ti_data_out_4, n446, ti_data_out_3, n445, ti_data_out_2, 
        n443, ti_data_out_1, ti_data_out_0, n425, n442, n434, n420, 
        n433, n358;
    
    DFFC grmpage_104 (.Q(grmpage), .D(n415), .CLK(gvalid), .CE(grmadr_0__N_33));   // design.vhd(146[3] 183[10])
    DFFC grmadr_i7 (.Q(grmadr[7]), .D(grmadr_0__N_15[0]), .CLK(gvalid), 
         .CE(n283)) /* synthesis lse_init_val=0 */ ;   // design.vhd(146[3] 183[10])
    DFFC gadd_106 (.Q(gadd), .D(n221), .CLK(gvalid), .CE(n283));   // design.vhd(146[3] 183[10])
    DFFC latch_i0_i0 (.Q(latch[0]), .D(ti_adr_c_14), .CLK(ti_we_c), .CE(ti_rom_N_24)) /* synthesis lse_init_val=0 */ ;   // design.vhd(104[3] 130[10])
    DFF gactive_101 (.Q(gactive), .D(gactive_N_52), .CLK(ti_gclk_N_54)) /* synthesis lse_init_val=0 */ ;   // design.vhd(68[3] 79[10])
    DFFC grmadr_i6 (.Q(grmadr[6]), .D(grmadr_0__N_15[1]), .CLK(gvalid), 
         .CE(n283)) /* synthesis lse_init_val=0 */ ;   // design.vhd(146[3] 183[10])
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
    OBUF out_oe_pad (.O(out_oe), .I0(out_oe_c));   // C:/ispLEVER_Classic2_0/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(270[8:12])
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
         .CE(n283)) /* synthesis lse_init_val=0 */ ;   // design.vhd(146[3] 183[10])
    DFFC grmadr_i4 (.Q(grmadr[4]), .D(grmadr_0__N_15[3]), .CLK(gvalid), 
         .CE(n283)) /* synthesis lse_init_val=0 */ ;   // design.vhd(146[3] 183[10])
    DFFC grmadr_i3 (.Q(grmadr[3]), .D(grmadr_0__N_15[4]), .CLK(gvalid), 
         .CE(n283)) /* synthesis lse_init_val=0 */ ;   // design.vhd(146[3] 183[10])
    DFFC grmadr_i2 (.Q(grmadr[2]), .D(grmadr_0__N_15[5]), .CLK(gvalid), 
         .CE(n283)) /* synthesis lse_init_val=0 */ ;   // design.vhd(146[3] 183[10])
    DFFC grmadr_i1 (.Q(grmadr[1]), .D(grmadr_0__N_15[6]), .CLK(gvalid), 
         .CE(n283)) /* synthesis lse_init_val=0 */ ;   // design.vhd(146[3] 183[10])
    DFFC grmadr_i0 (.Q(grmadr[0]), .D(grmadr_0__N_15[7]), .CLK(gvalid), 
         .CE(n283)) /* synthesis lse_init_val=0 */ ;   // design.vhd(146[3] 183[10])
    DFFC latch_i0_i1 (.Q(latch[1]), .D(ti_adr_c_13), .CLK(ti_we_c), .CE(ti_rom_N_24)) /* synthesis lse_init_val=0 */ ;   // design.vhd(104[3] 130[10])
    DFFC latch_i0_i2 (.Q(latch[2]), .D(ti_adr_c_12), .CLK(ti_we_c), .CE(ti_rom_N_24)) /* synthesis lse_init_val=0 */ ;   // design.vhd(104[3] 130[10])
    DFFC latch_i0_i3 (.Q(latch[3]), .D(ti_adr_c_11), .CLK(ti_we_c), .CE(ti_rom_N_24)) /* synthesis lse_init_val=0 */ ;   // design.vhd(104[3] 130[10])
    DFFC latch_i0_i4 (.Q(latch[4]), .D(ti_adr_c_10), .CLK(ti_we_c), .CE(ti_rom_N_24)) /* synthesis lse_init_val=0 */ ;   // design.vhd(104[3] 130[10])
    DFFC latch_i0_i5 (.Q(latch[5]), .D(ti_adr_c_9), .CLK(ti_we_c), .CE(ti_rom_N_24)) /* synthesis lse_init_val=0 */ ;   // design.vhd(104[3] 130[10])
    DFFC latch_i0_i6 (.Q(latch[6]), .D(ti_adr_c_8), .CLK(ti_we_c), .CE(ti_rom_N_24)) /* synthesis lse_init_val=0 */ ;   // design.vhd(104[3] 130[10])
    DFFC latch_i0_i7 (.Q(latch[7]), .D(ti_adr_c_7), .CLK(ti_we_c), .CE(ti_rom_N_24)) /* synthesis lse_init_val=0 */ ;   // design.vhd(104[3] 130[10])
    DFFC latch_i0_i8 (.Q(latch[8]), .D(ti_adr_c_6), .CLK(ti_we_c), .CE(ti_rom_N_24)) /* synthesis lse_init_val=0 */ ;   // design.vhd(104[3] 130[10])
    DFFC latch_i0_i9 (.Q(latch[9]), .D(ti_adr_c_5), .CLK(ti_we_c), .CE(ti_rom_N_24)) /* synthesis lse_init_val=0 */ ;   // design.vhd(104[3] 130[10])
    DFFC latch_i0_i10 (.Q(latch[10]), .D(ti_adr_c_4), .CLK(ti_we_c), .CE(ti_rom_N_24)) /* synthesis lse_init_val=0 */ ;   // design.vhd(104[3] 130[10])
    DFFC latch_i0_i11 (.Q(latch[11]), .D(ti_adr_c_3), .CLK(ti_we_c), .CE(ti_rom_N_24)) /* synthesis lse_init_val=0 */ ;   // design.vhd(104[3] 130[10])
    DFFC latch_i0_i12 (.Q(latch[12]), .D(ti_data_out_7), .CLK(ti_we_c), 
         .CE(ti_rom_N_24)) /* synthesis lse_init_val=0 */ ;   // design.vhd(104[3] 130[10])
    DFFC latch_i0_i13 (.Q(latch[13]), .D(ti_data_out_6), .CLK(ti_we_c), 
         .CE(ti_rom_N_24)) /* synthesis lse_init_val=0 */ ;   // design.vhd(104[3] 130[10])
    INV i394 (.O(n423), .I0(gvalid));
    INV i389 (.O(n414), .I0(n418));
    VCC i390 (.X(pwr));
    AND2 i395 (.O(n424), .I0(n423), .I1(ti_adr_c_8));
    INV dataout_I_0 (.O(out_reset_c), .I0(dataout));
    INV i259 (.O(n221), .I0(grmadr_0__N_33));
    DFF gvalid_102 (.Q(gvalid), .D(n219), .CLK(ti_gclk_N_54));   // design.vhd(68[3] 79[10])
    INV i391 (.O(n420), .I0(ti_we_c));
    INV ti_we_I_0_110 (.O(ti_we_N_35), .I0(ti_we_c));
    INV i392 (.O(n421), .I0(ti_adr_c_14));
    INV ti_rom_I_0 (.O(ti_rom_N_24), .I0(ti_rom_c));
    INV ti_adr_14__I_0 (.O(ti_adr_14__N_44), .I0(ti_adr_c_14));
    INV ti_gsel_I_0 (.O(ti_gsel_N_42), .I0(ti_gsel_c));
    INV ti_gclk_I_0 (.O(ti_gclk_N_54), .I0(ti_gclk_c));
    GND i1 (.X(out_oe_c));
    OR2 ti_gsel_N_42_I_0 (.O(gactive_N_52), .I0(gvalid), .I1(ti_gsel_N_42));
    OR2 i400 (.O(out_adr_c_6), .I0(n428), .I1(n427));
    AND2 i327 (.O(n358), .I0(gadd), .I1(grmadr[7]));
    AND2 i429 (.O(n458), .I0(ti_adr_c_14), .I1(ti_data_out_4));
    AND2 i356 (.O(n387), .I0(n380), .I1(grmadr[3]));
    OR2 i427 (.O(grmadr_0__N_15[2]), .I0(n455), .I1(n454));
    OR2 dataout_I_0_113 (.O(dataout_N_37), .I0(ti_rom_N_24), .I1(dataout_N_38));
    AND2 i264 (.O(n219), .I0(ti_gsel_N_42), .I1(gactive));
    AND2 i126 (.O(n213), .I0(grmadr_0__N_33), .I1(grmadr[2]));
    AND2 grmadr_0__I_1 (.O(grmadr_0__N_33), .I0(ti_adr_c_14), .I1(ti_we_N_35));
    XOR2 i325 (.O(n112), .I0(gadd), .I1(grmadr[7]));
    AND2 i426 (.O(n455), .I0(ti_adr_c_14), .I1(ti_data_out_5));
    AND2 i363 (.O(n394), .I0(n387), .I1(grmadr[2]));
    AND2 i435 (.O(n464), .I0(ti_adr_c_14), .I1(ti_data_out_2));
    OR2 i267 (.O(out_adr_c_13), .I0(gvalid), .I1(latch[0]));
    OR2 i268 (.O(out_adr_c_14), .I0(gvalid), .I1(latch[1]));
    OR2 gvalid_I_0_111_i1 (.O(out_adr_c_8), .I0(ti_adr_c_7), .I1(gvalid));
    AND2 i398 (.O(n427), .I0(n423), .I1(ti_adr_c_9));
    AND2 i401 (.O(n430), .I0(n423), .I1(ti_adr_c_10));
    AND2 i404 (.O(n433), .I0(n423), .I1(ti_adr_c_11));
    AND2 i407 (.O(n436), .I0(n423), .I1(ti_adr_c_12));
    AND2 i410 (.O(n439), .I0(n423), .I1(ti_adr_c_13));
    AND2 i413 (.O(n442), .I0(n423), .I1(ti_adr_c_14));
    AND2 i416 (.O(n445), .I0(n423), .I1(ti_adr_c_15));
    AND2 i419 (.O(n448), .I0(ti_adr_14__N_44), .I1(n112));
    XOR2 i368 (.O(n106), .I0(n394), .I1(grmadr[1]));
    OR2 i424 (.O(grmadr_0__N_15[1]), .I0(n452), .I1(n451));
    OR2 i403 (.O(out_adr_c_5), .I0(n431), .I1(n430));
    XOR2 i361 (.O(n107), .I0(n387), .I1(grmadr[2]));
    AND2 i399 (.O(n428), .I0(gvalid), .I1(grmadr[1]));
    AND2 i349 (.O(n380), .I0(n373), .I1(grmadr[4]));
    XOR2 i354 (.O(n108), .I0(n380), .I1(grmadr[3]));
    AND2 i335 (.O(n366), .I0(n358), .I1(grmadr[6]));
    OR2 gvalid_I_0_111_i2 (.O(out_adr_c_9), .I0(ti_adr_c_6), .I1(gvalid));
    OR2 gvalid_I_0_111_i3 (.O(out_adr_c_10), .I0(ti_adr_c_5), .I1(gvalid));
    OR2 gvalid_I_0_111_i4 (.O(out_adr_c_11), .I0(ti_adr_c_4), .I1(gvalid));
    OR2 gvalid_I_0_111_i5 (.O(out_adr_c_12), .I0(ti_adr_c_3), .I1(gvalid));
    OR2 i433 (.O(grmadr_0__N_15[4]), .I0(n461), .I1(n460));
    AND2 i423 (.O(n452), .I0(ti_adr_c_14), .I1(ti_data_out_6));
    OR2 i421 (.O(grmadr_0__N_15[0]), .I0(n449), .I1(n448));
    AND2 i420 (.O(n449), .I0(ti_adr_c_14), .I1(ti_data_out_7));
    OR2 i418 (.O(out_adr_c_0), .I0(n446), .I1(n445));
    AND2 i370 (.O(n401), .I0(n394), .I1(grmadr[1]));
    AND2 i432 (.O(n461), .I0(ti_adr_c_14), .I1(ti_data_out_3));
    AND2 i417 (.O(n446), .I0(gvalid), .I1(grmadr[7]));
    XOR2 i347 (.O(n109), .I0(n373), .I1(grmadr[4]));
    OR2 i415 (.O(out_adr_c_1), .I0(n443), .I1(n442));
    AND2 i1_adj_1 (.O(n415), .I0(n414), .I1(grmadr[0]));
    AND2 i414 (.O(n443), .I0(gvalid), .I1(grmadr[6]));
    OR2 i412 (.O(out_adr_c_2), .I0(n440), .I1(n439));
    AND2 i411 (.O(n440), .I0(gvalid), .I1(grmadr[5]));
    OR2 i393 (.O(n283), .I0(n421), .I1(n420));
    OR2 i388 (.O(n418), .I0(grmadr[1]), .I1(n213));
    OR2 i269 (.O(out_adr_c_15), .I0(gvalid), .I1(latch[2]));
    OR2 i270 (.O(out_adr_c_16), .I0(gvalid), .I1(latch[3]));
    OR2 i271 (.O(out_adr_c_17), .I0(gvalid), .I1(latch[4]));
    OR2 i272 (.O(out_adr_c_18), .I0(gvalid), .I1(latch[5]));
    OR2 i273 (.O(out_adr_c_19), .I0(gvalid), .I1(latch[6]));
    OR2 i274 (.O(out_adr_c_20), .I0(gvalid), .I1(latch[7]));
    OR2 i275 (.O(out_adr_c_21), .I0(gvalid), .I1(latch[8]));
    OR2 i276 (.O(out_adr_c_22), .I0(gvalid), .I1(latch[9]));
    OR2 i277 (.O(out_adr_c_23), .I0(gvalid), .I1(latch[10]));
    OR2 i278 (.O(out_adr_c_24), .I0(gvalid), .I1(latch[11]));
    OR2 i279 (.O(out_adr_c_25), .I0(gvalid), .I1(latch[12]));
    OR2 i280 (.O(out_adr_c_26), .I0(gvalid), .I1(latch[13]));
    OR2 i409 (.O(out_adr_c_3), .I0(n437), .I1(n436));
    AND2 i402 (.O(n431), .I0(gvalid), .I1(grmadr[2]));
    AND2 i422 (.O(n451), .I0(ti_adr_14__N_44), .I1(n111));
    OR2 i430 (.O(grmadr_0__N_15[3]), .I0(n458), .I1(n457));
    AND2 i425 (.O(n454), .I0(ti_adr_14__N_44), .I1(n110));
    AND2 i408 (.O(n437), .I0(gvalid), .I1(grmadr[4]));
    AND2 i428 (.O(n457), .I0(ti_adr_14__N_44), .I1(n109));
    OR2 i406 (.O(out_adr_c_4), .I0(n434), .I1(n433));
    AND2 i431 (.O(n460), .I0(ti_adr_14__N_44), .I1(n108));
    AND2 i405 (.O(n434), .I0(gvalid), .I1(grmadr[3]));
    AND2 i434 (.O(n463), .I0(ti_adr_14__N_44), .I1(n107));
    XOR2 i340 (.O(n110), .I0(n366), .I1(grmadr[5]));
    AND2 i437 (.O(n466), .I0(ti_adr_14__N_44), .I1(n106));
    AND2 i396 (.O(n425), .I0(gvalid), .I1(grmadr[0]));
    AND2 i440 (.O(n469), .I0(ti_adr_14__N_44), .I1(n105));
    AND2 i342 (.O(n373), .I0(n366), .I1(grmadr[5]));
    OR2 i397 (.O(out_adr_c_7), .I0(n425), .I1(n424));
    AND4 i3 (.O(dataout_N_38), .I0(grmpage), .I1(ti_gsel_N_42), .I2(ti_adr_14__N_44), 
         .I3(gvalid));
    AND2 i263 (.O(dataout), .I0(dataout_N_37), .I1(ti_we_c));
    XOR2 i333 (.O(n111), .I0(n358), .I1(grmadr[6]));
    XOR2 i375 (.O(n105), .I0(n401), .I1(grmadr[0]));
    OR2 i436 (.O(grmadr_0__N_15[5]), .I0(n464), .I1(n463));
    AND2 i438 (.O(n467), .I0(ti_adr_c_14), .I1(ti_data_out_1));
    OR2 i439 (.O(grmadr_0__N_15[6]), .I0(n467), .I1(n466));
    AND2 i441 (.O(n470), .I0(ti_adr_c_14), .I1(ti_data_out_0));
    OR2 i442 (.O(grmadr_0__N_15[7]), .I0(n470), .I1(n469));
    
endmodule
//
// Verilog Description of module INV
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
// Verilog Description of module GND
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

