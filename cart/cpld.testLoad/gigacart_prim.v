// Verilog netlist produced by program LSE :  version Diamond Version 0.0.0
// Netlist written on Tue Feb 12 02:07:48 2019
//
// Verilog Description of module gigacart
//

module gigacart (ti_adr, ti_data, ti_we, ti_rom, ti_gsel, ti_gclk, 
            out_adr, out_data, out_rom1, out_rom2, out_rom3, out_rom4, 
            out_reset);   // design.vhd(27[8:16])
    input [15:3]ti_adr;   // design.vhd(30[3:9])
    inout [7:0]ti_data;   // design.vhd(31[3:10])
    input ti_we;   // design.vhd(32[3:8])
    input ti_rom;   // design.vhd(33[3:9])
    input ti_gsel;   // design.vhd(34[3:10])
    input ti_gclk;   // design.vhd(35[3:10])
    output [26:0]out_adr;   // design.vhd(38[3:10])
    input [7:0]out_data;   // design.vhd(39[3:11])
    output out_rom1;   // design.vhd(40[3:11])
    output out_rom2;   // design.vhd(41[3:11])
    output out_rom3;   // design.vhd(42[3:11])
    output out_rom4;   // design.vhd(43[3:11])
    output out_reset;   // design.vhd(44[3:12])
    
    wire out_rom3_c_c /* synthesis is_clock=1 */ ;   // design.vhd(35[3:10])
    wire out_adr_c /* synthesis is_clock=1, SET_AS_NETWORK=out_adr_c */ ;   // design.vhd(38[3:10])
    wire ti_gclk_N_52 /* synthesis is_inv_clock=1, SET_AS_NETWORK=ti_gclk_N_52, is_clock=1 */ ;   // design.vhd(60[9:16])
    
    wire n637, pwr, ti_adr_c_15, ti_adr_c_14, ti_adr_c_13, ti_adr_c_12, 
        ti_adr_c_11, ti_adr_c_10, ti_adr_c_9, ti_adr_c_8, ti_adr_c_7, 
        ti_adr_c_6, ti_adr_c_5, ti_adr_c_4, ti_adr_c_3, n657, n656, 
        n671, n693, n669, out_rom4_c_c, ti_rom_c, out_rom1_c_c, 
        ti_data_out_7, n692, ti_data_out_6, ti_data_out_5, ti_data_out_4, 
        ti_data_out_3, out_adr_c_12, out_adr_c_11, out_adr_c_10, out_adr_c_9, 
        out_adr_c_8, out_adr_c_7, out_adr_c_6, out_adr_c_5, out_adr_c_4, 
        out_adr_c_3, out_adr_c_2, out_adr_c_1, out_adr_c_0, out_data_c_7, 
        out_data_c_6, out_data_c_5, out_data_c_4, out_data_c_3, out_data_c_2, 
        out_data_c_1, out_data_c_0, out_reset_c, dataout;
    wire [0:7]grmadr;   // design.vhd(58[9:15])
    
    wire gactive, gadd, gactive_N_50, n632, ti_gsel_N_45, ti_adr_14__N_47, 
        n625, dataout_N_41, ti_rom_N_49, dataout_N_40, ti_data_7__N_11, 
        ti_data_7__N_10, ti_data_7__N_9, ti_data_7__N_8, ti_data_7__N_7, 
        ti_data_7__N_6, ti_data_7__N_5, ti_adr_15__N_4, ti_data_7__N_2, 
        n646, ti_data_7__N_1, ti_we_N_32, grmadr_0__N_30, n635, n638, 
        n211, n119, n120, n121, n122, n123, n124, n125, n126, 
        n668, n681, n624, n690, n654, n680, n628;
    wire [7:0]grmadr_0__N_14;
    
    wire n678, n213, ti_data_out_2, ti_data_out_1, ti_data_out_0, 
        n634, n301, n689, n643, n666, n665, n653, n652, n650, 
        n412, n640, n677, n647, n583, n576, n687, n663, n662, 
        n568, n641, n660, n604, n686, gnd, n590, n699, n698, 
        n696, n684, n683, n675, n659, n644, n695, n674, n672, 
        n611, n597, n649;
    
    BI_DIR ti_data_pad_0 (.O(ti_data_out_0), .I0(ti_data_7__N_11), .IO(ti_data[0]), 
           .OE(dataout));   // C:/ispLEVER_Classic2_0/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(67[8:14])
    AND2 i677 (.O(n660), .I0(out_adr_c), .I1(grmadr[2]));
    DFFC grmadr_i7 (.Q(grmadr[7]), .D(grmadr_0__N_14[0]), .CLK(out_adr_c), 
         .CE(n301)) /* synthesis lse_init_val=0 */ ;   // design.vhd(111[3] 148[10])
    DFFC gadd_146 (.Q(gadd), .D(n211), .CLK(out_adr_c), .CE(n301));   // design.vhd(111[3] 148[10])
    DFF gactive_142 (.Q(gactive), .D(gactive_N_50), .CLK(ti_gclk_N_52)) /* synthesis lse_init_val=0 */ ;   // design.vhd(69[3] 80[10])
    AND2 i658 (.O(n641), .I0(ti_data_7__N_2), .I1(ti_adr_c_4));
    BI_DIR ti_data_pad_1 (.O(ti_data_out_1), .I0(ti_data_7__N_10), .IO(ti_data[1]), 
           .OE(dataout));   // C:/ispLEVER_Classic2_0/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(67[8:14])
    DFFC grmadr_i6 (.Q(grmadr[6]), .D(grmadr_0__N_14[1]), .CLK(out_adr_c), 
         .CE(n301)) /* synthesis lse_init_val=0 */ ;   // design.vhd(111[3] 148[10])
    DFFC grmpage_144 (.Q(out_reset_c), .D(n625), .CLK(out_adr_c), .CE(grmadr_0__N_30));   // design.vhd(111[3] 148[10])
    AND2 i421 (.O(dataout), .I0(dataout_N_40), .I1(out_rom4_c_c));
    OR2 i699 (.O(grmadr_0__N_14[7]), .I0(n681), .I1(n680));
    BI_DIR ti_data_pad_6 (.O(ti_data_out_6), .I0(ti_data_7__N_5), .IO(ti_data[6]), 
           .OE(dataout));   // C:/ispLEVER_Classic2_0/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(67[8:14])
    BI_DIR ti_data_pad_2 (.O(ti_data_out_2), .I0(ti_data_7__N_9), .IO(ti_data[2]), 
           .OE(dataout));   // C:/ispLEVER_Classic2_0/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(67[8:14])
    BI_DIR ti_data_pad_3 (.O(ti_data_out_3), .I0(ti_data_7__N_8), .IO(ti_data[3]), 
           .OE(dataout));   // C:/ispLEVER_Classic2_0/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(67[8:14])
    BI_DIR ti_data_pad_4 (.O(ti_data_out_4), .I0(ti_data_7__N_7), .IO(ti_data[4]), 
           .OE(dataout));   // C:/ispLEVER_Classic2_0/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(67[8:14])
    OR2 ti_gsel_N_45_I_0 (.O(gactive_N_50), .I0(out_adr_c), .I1(ti_gsel_N_45));
    BI_DIR ti_data_pad_5 (.O(ti_data_out_5), .I0(ti_data_7__N_6), .IO(ti_data[5]), 
           .OE(dataout));   // C:/ispLEVER_Classic2_0/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(67[8:14])
    BI_DIR ti_data_pad_7 (.O(ti_data_out_7), .I0(ti_data_7__N_1), .IO(ti_data[7]), 
           .OE(dataout));   // C:/ispLEVER_Classic2_0/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(67[8:14])
    OBUF out_adr_pad_26 (.O(out_adr[26]), .I0(out_adr_c));   // C:/ispLEVER_Classic2_0/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(270[8:12])
    DFFC grmadr_i5 (.Q(grmadr[5]), .D(grmadr_0__N_14[2]), .CLK(out_adr_c), 
         .CE(n301)) /* synthesis lse_init_val=0 */ ;   // design.vhd(111[3] 148[10])
    DFF gvalid_143 (.Q(out_adr_c), .D(n213), .CLK(ti_gclk_N_52));   // design.vhd(69[3] 80[10])
    OBUF out_adr_pad_25 (.O(out_adr[25]), .I0(out_adr_c));   // C:/ispLEVER_Classic2_0/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(270[8:12])
    OBUF out_adr_pad_24 (.O(out_adr[24]), .I0(out_adr_c));   // C:/ispLEVER_Classic2_0/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(270[8:12])
    OBUF out_adr_pad_23 (.O(out_adr[23]), .I0(out_adr_c));   // C:/ispLEVER_Classic2_0/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(270[8:12])
    OBUF out_adr_pad_22 (.O(out_adr[22]), .I0(out_adr_c));   // C:/ispLEVER_Classic2_0/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(270[8:12])
    OBUF out_adr_pad_21 (.O(out_adr[21]), .I0(out_adr_c));   // C:/ispLEVER_Classic2_0/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(270[8:12])
    OBUF out_adr_pad_20 (.O(out_adr[20]), .I0(out_adr_c));   // C:/ispLEVER_Classic2_0/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(270[8:12])
    OBUF out_adr_pad_19 (.O(out_adr[19]), .I0(out_adr_c));   // C:/ispLEVER_Classic2_0/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(270[8:12])
    OBUF out_adr_pad_18 (.O(out_adr[18]), .I0(out_adr_c));   // C:/ispLEVER_Classic2_0/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(270[8:12])
    OBUF out_adr_pad_17 (.O(out_adr[17]), .I0(out_adr_c));   // C:/ispLEVER_Classic2_0/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(270[8:12])
    OBUF out_adr_pad_16 (.O(out_adr[16]), .I0(out_adr_c));   // C:/ispLEVER_Classic2_0/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(270[8:12])
    OBUF out_adr_pad_15 (.O(out_adr[15]), .I0(out_adr_c));   // C:/ispLEVER_Classic2_0/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(270[8:12])
    OBUF out_adr_pad_14 (.O(out_adr[14]), .I0(out_adr_c));   // C:/ispLEVER_Classic2_0/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(270[8:12])
    OBUF out_adr_pad_13 (.O(out_adr[13]), .I0(out_adr_c));   // C:/ispLEVER_Classic2_0/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(270[8:12])
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
    OBUF out_rom1_pad (.O(out_rom1), .I0(out_rom1_c_c));   // C:/ispLEVER_Classic2_0/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(270[8:12])
    OBUF out_rom2_pad (.O(out_rom2), .I0(out_reset_c));   // C:/ispLEVER_Classic2_0/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(270[8:12])
    OBUF out_rom3_pad (.O(out_rom3), .I0(out_rom3_c_c));   // C:/ispLEVER_Classic2_0/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(270[8:12])
    OBUF out_rom4_pad (.O(out_rom4), .I0(out_rom4_c_c));   // C:/ispLEVER_Classic2_0/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(270[8:12])
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
    IBUF out_rom4_c_pad (.O(out_rom4_c_c), .I0(ti_we));   // C:/ispLEVER_Classic2_0/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(186[8:12])
    IBUF ti_rom_pad (.O(ti_rom_c), .I0(ti_rom));   // C:/ispLEVER_Classic2_0/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(186[8:12])
    IBUF out_rom1_c_pad (.O(out_rom1_c_c), .I0(ti_gsel));   // C:/ispLEVER_Classic2_0/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(186[8:12])
    IBUF out_rom3_c_pad (.O(out_rom3_c_c), .I0(ti_gclk));   // C:/ispLEVER_Classic2_0/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(186[8:12])
    IBUF out_data_pad_7 (.O(out_data_c_7), .I0(out_data[7]));   // C:/ispLEVER_Classic2_0/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(186[8:12])
    IBUF out_data_pad_6 (.O(out_data_c_6), .I0(out_data[6]));   // C:/ispLEVER_Classic2_0/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(186[8:12])
    IBUF out_data_pad_5 (.O(out_data_c_5), .I0(out_data[5]));   // C:/ispLEVER_Classic2_0/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(186[8:12])
    IBUF out_data_pad_4 (.O(out_data_c_4), .I0(out_data[4]));   // C:/ispLEVER_Classic2_0/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(186[8:12])
    IBUF out_data_pad_3 (.O(out_data_c_3), .I0(out_data[3]));   // C:/ispLEVER_Classic2_0/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(186[8:12])
    IBUF out_data_pad_2 (.O(out_data_c_2), .I0(out_data[2]));   // C:/ispLEVER_Classic2_0/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(186[8:12])
    IBUF out_data_pad_1 (.O(out_data_c_1), .I0(out_data[1]));   // C:/ispLEVER_Classic2_0/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(186[8:12])
    IBUF out_data_pad_0 (.O(out_data_c_0), .I0(out_data[0]));   // C:/ispLEVER_Classic2_0/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(186[8:12])
    DFFC grmadr_i4 (.Q(grmadr[4]), .D(grmadr_0__N_14[3]), .CLK(out_adr_c), 
         .CE(n301)) /* synthesis lse_init_val=0 */ ;   // design.vhd(111[3] 148[10])
    DFFC grmadr_i3 (.Q(grmadr[3]), .D(grmadr_0__N_14[4]), .CLK(out_adr_c), 
         .CE(n301)) /* synthesis lse_init_val=0 */ ;   // design.vhd(111[3] 148[10])
    DFFC grmadr_i2 (.Q(grmadr[2]), .D(grmadr_0__N_14[5]), .CLK(out_adr_c), 
         .CE(n301)) /* synthesis lse_init_val=0 */ ;   // design.vhd(111[3] 148[10])
    DFFC grmadr_i1 (.Q(grmadr[1]), .D(grmadr_0__N_14[6]), .CLK(out_adr_c), 
         .CE(n301)) /* synthesis lse_init_val=0 */ ;   // design.vhd(111[3] 148[10])
    DFFC grmadr_i0 (.Q(grmadr[0]), .D(grmadr_0__N_14[7]), .CLK(out_adr_c), 
         .CE(n301)) /* synthesis lse_init_val=0 */ ;   // design.vhd(111[3] 148[10])
    OR2 gvalid_I_0_162_i1 (.O(out_adr_c_8), .I0(ti_adr_c_7), .I1(out_adr_c));
    OR2 i693 (.O(out_adr_c_0), .I0(n675), .I1(n674));
    XOR2 i608 (.O(n122), .I0(n590), .I1(grmadr[3]));
    OR2 i653 (.O(n301), .I0(n635), .I1(n634));
    AND2 i686 (.O(n669), .I0(out_adr_c), .I1(grmadr[5]));
    XOR2 i615 (.O(n121), .I0(n597), .I1(grmadr[2]));
    AND2 i710 (.O(n693), .I0(ti_adr_c_14), .I1(ti_data_out_4));
    XOR2 i622 (.O(n120), .I0(n604), .I1(grmadr[1]));
    AND2 i715 (.O(n698), .I0(ti_adr_14__N_47), .I1(n125));
    AND2 i712 (.O(n695), .I0(ti_adr_14__N_47), .I1(n124));
    OR2 i711 (.O(grmadr_0__N_14[3]), .I0(n693), .I1(n692));
    AND2 i709 (.O(n692), .I0(ti_adr_14__N_47), .I1(n123));
    AND2 i713 (.O(n696), .I0(ti_adr_c_14), .I1(ti_data_out_5));
    AND2 i706 (.O(n689), .I0(ti_adr_14__N_47), .I1(n122));
    OR2 i681 (.O(out_adr_c_4), .I0(n663), .I1(n662));
    OR2 i659 (.O(ti_data_7__N_7), .I0(n641), .I1(n640));
    OR2 i714 (.O(grmadr_0__N_14[2]), .I0(n696), .I1(n695));
    AND2 i703 (.O(n686), .I0(ti_adr_14__N_47), .I1(n121));
    AND2 i716 (.O(n699), .I0(ti_adr_c_14), .I1(ti_data_out_6));
    AND2 i700 (.O(n683), .I0(ti_adr_14__N_47), .I1(n120));
    OR2 i717 (.O(grmadr_0__N_14[1]), .I0(n699), .I1(n698));
    AND2 i697 (.O(n680), .I0(ti_adr_14__N_47), .I1(n119));
    OR2 i690 (.O(out_adr_c_1), .I0(n672), .I1(n671));
    XOR2 i629 (.O(n119), .I0(n611), .I1(grmadr[0]));
    OR2 i708 (.O(grmadr_0__N_14[4]), .I0(n690), .I1(n689));
    OR2 i684 (.O(out_adr_c_3), .I0(n666), .I1(n665));
    AND2 i689 (.O(n672), .I0(out_adr_c), .I1(grmadr[6]));
    AND2 i707 (.O(n690), .I0(ti_adr_c_14), .I1(ti_data_out_3));
    AND2 i670 (.O(n653), .I0(n652), .I1(ti_adr_c_8));
    AND2 i654 (.O(n637), .I0(n412), .I1(ti_adr_c_11));
    AND4 i3 (.O(dataout_N_41), .I0(out_reset_c), .I1(ti_gsel_N_45), .I2(ti_adr_14__N_47), 
         .I3(out_adr_c));
    OR2 i647 (.O(n632), .I0(grmadr[1]), .I1(n628));
    AND2 i423 (.O(ti_data_7__N_11), .I0(n412), .I1(ti_adr_c_8));
    AND2 i680 (.O(n663), .I0(out_adr_c), .I1(grmadr[3]));
    AND2 i643 (.O(n628), .I0(grmadr_0__N_30), .I1(grmadr[2]));
    OR2 i687 (.O(out_adr_c_2), .I0(n669), .I1(n668));
    OR2 gvalid_I_0_162_i5 (.O(out_adr_c_12), .I0(ti_adr_c_3), .I1(out_adr_c));
    OR2 i705 (.O(grmadr_0__N_14[5]), .I0(n687), .I1(n686));
    OR2 gvalid_I_0_162_i4 (.O(out_adr_c_11), .I0(ti_adr_c_4), .I1(out_adr_c));
    OR2 gvalid_I_0_162_i3 (.O(out_adr_c_10), .I0(ti_adr_c_5), .I1(out_adr_c));
    AND2 i704 (.O(n687), .I0(ti_adr_c_14), .I1(ti_data_out_2));
    OR2 gvalid_I_0_162_i2 (.O(out_adr_c_9), .I0(ti_adr_c_6), .I1(out_adr_c));
    AND2 i695 (.O(n678), .I0(ti_adr_c_14), .I1(ti_data_out_7));
    AND2 i420 (.O(n213), .I0(ti_gsel_N_45), .I1(gactive));
    AND2 i661 (.O(n644), .I0(ti_data_7__N_2), .I1(ti_adr_c_5));
    AND2 i671 (.O(n654), .I0(out_adr_c), .I1(grmadr[0]));
    AND2 i683 (.O(n666), .I0(out_adr_c), .I1(grmadr[4]));
    AND2 i694 (.O(n677), .I0(ti_adr_14__N_47), .I1(n126));
    AND2 i691 (.O(n674), .I0(n652), .I1(ti_adr_c_15));
    AND2 i688 (.O(n671), .I0(n652), .I1(ti_adr_c_14));
    AND2 i685 (.O(n668), .I0(n652), .I1(ti_adr_c_13));
    AND2 i682 (.O(n665), .I0(n652), .I1(ti_adr_c_12));
    AND2 i679 (.O(n662), .I0(n652), .I1(ti_adr_c_11));
    AND2 i676 (.O(n659), .I0(n652), .I1(ti_adr_c_10));
    AND2 i673 (.O(n656), .I0(n652), .I1(ti_adr_c_9));
    AND2 i692 (.O(n675), .I0(out_adr_c), .I1(grmadr[7]));
    AND2 i1 (.O(n625), .I0(n624), .I1(grmadr[0]));
    OR2 i696 (.O(grmadr_0__N_14[0]), .I0(n678), .I1(n677));
    GND i649 (.X(gnd));
    INV i313 (.O(n211), .I0(grmadr_0__N_30));
    INV i651 (.O(n634), .I0(out_rom4_c_c));
    INV i648 (.O(n624), .I0(n632));
    INV i652 (.O(n635), .I0(ti_adr_c_14));
    INV ti_we_I_0_161 (.O(ti_we_N_32), .I0(out_rom4_c_c));
    INV i669 (.O(n652), .I0(out_adr_c));
    INV ti_adr_15__I_0_159 (.O(ti_adr_15__N_4), .I0(ti_adr_c_15));
    INV i422 (.O(n412), .I0(ti_data_7__N_2));
    INV ti_rom_I_0 (.O(ti_rom_N_49), .I0(ti_rom_c));
    INV ti_adr_14__I_0 (.O(ti_adr_14__N_47), .I0(ti_adr_c_14));
    INV ti_gsel_I_0 (.O(ti_gsel_N_45), .I0(out_rom1_c_c));
    INV ti_gclk_I_0 (.O(ti_gclk_N_52), .I0(out_rom3_c_c));
    VCC i650 (.X(pwr));
    AND2 i624 (.O(n611), .I0(n604), .I1(grmadr[1]));
    OR2 i672 (.O(out_adr_c_7), .I0(n654), .I1(n653));
    AND2 i674 (.O(n657), .I0(out_adr_c), .I1(grmadr[1]));
    XOR2 i579 (.O(n126), .I0(gadd), .I1(grmadr[7]));
    OR2 i675 (.O(out_adr_c_6), .I0(n657), .I1(n656));
    AND2 i655 (.O(n638), .I0(ti_data_7__N_2), .I1(ti_adr_c_3));
    AND2 grmadr_0__I_1 (.O(grmadr_0__N_30), .I0(ti_adr_c_14), .I1(ti_we_N_32));
    AND2 i664 (.O(n647), .I0(ti_data_7__N_2), .I1(ti_adr_c_6));
    AND2 i698 (.O(n681), .I0(ti_adr_c_14), .I1(ti_data_out_0));
    AND2 dataout_I_0_150 (.O(ti_data_7__N_2), .I0(ti_adr_15__N_4), .I1(dataout));
    AND2 i666 (.O(n649), .I0(n412), .I1(ti_adr_c_15));
    AND2 i663 (.O(n646), .I0(n412), .I1(ti_adr_c_14));
    AND2 i660 (.O(n643), .I0(n412), .I1(ti_adr_c_13));
    AND2 i657 (.O(n640), .I0(n412), .I1(ti_adr_c_12));
    AND2 i425 (.O(ti_data_7__N_9), .I0(n412), .I1(ti_adr_c_10));
    AND2 i424 (.O(ti_data_7__N_10), .I0(n412), .I1(ti_adr_c_9));
    OR2 dataout_I_3 (.O(dataout_N_40), .I0(ti_rom_N_49), .I1(dataout_N_41));
    OR2 i668 (.O(ti_data_7__N_1), .I0(n650), .I1(n649));
    OR2 i702 (.O(grmadr_0__N_14[6]), .I0(n684), .I1(n683));
    XOR2 i601 (.O(n123), .I0(n583), .I1(grmadr[4]));
    OR2 i662 (.O(ti_data_7__N_6), .I0(n644), .I1(n643));
    AND2 i701 (.O(n684), .I0(ti_adr_c_14), .I1(ti_data_out_1));
    OR2 i678 (.O(out_adr_c_5), .I0(n660), .I1(n659));
    AND2 i667 (.O(n650), .I0(ti_data_7__N_2), .I1(ti_adr_c_7));
    XOR2 i594 (.O(n124), .I0(n576), .I1(grmadr[5]));
    XOR2 i587 (.O(n125), .I0(n568), .I1(grmadr[6]));
    OR2 i665 (.O(ti_data_7__N_5), .I0(n647), .I1(n646));
    AND2 i603 (.O(n590), .I0(n583), .I1(grmadr[4]));
    AND2 i589 (.O(n576), .I0(n568), .I1(grmadr[6]));
    AND2 i596 (.O(n583), .I0(n576), .I1(grmadr[5]));
    AND2 i581 (.O(n568), .I0(gadd), .I1(grmadr[7]));
    AND2 i610 (.O(n597), .I0(n590), .I1(grmadr[3]));
    AND2 i617 (.O(n604), .I0(n597), .I1(grmadr[2]));
    OR2 i656 (.O(ti_data_7__N_8), .I0(n638), .I1(n637));
    
endmodule
//
// Verilog Description of module AND2
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

//
// Verilog Description of module GND
// module not written out since it is a black-box. 
//

//
// Verilog Description of module INV
// module not written out since it is a black-box. 
//

//
// Verilog Description of module VCC
// module not written out since it is a black-box. 
//

