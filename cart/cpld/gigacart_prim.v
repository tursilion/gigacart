// Verilog netlist produced by program LSE :  version Diamond Version 0.0.0
// Netlist written on Wed Oct 10 00:29:42 2018
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
    
    wire ti_gclk_c /* synthesis is_clock=1 */ ;   // design.vhd(29[3:10])
    wire out_adr_c /* synthesis SET_AS_NETWORK=out_adr_c, is_clock=1 */ ;   // design.vhd(32[3:10])
    wire ti_gclk_N_48 /* synthesis is_inv_clock=1, SET_AS_NETWORK=ti_gclk_N_48, is_clock=1 */ ;   // design.vhd(52[9:15])
    
    wire out_reset_c, ti_adr_c_15, ti_adr_c_14, ti_adr_c_13, ti_adr_c_12, 
        ti_adr_c_11, ti_adr_c_10, ti_adr_c_9, ti_adr_c_8, ti_adr_c_7, 
        ti_adr_c_6, ti_adr_c_5, ti_adr_c_4, ti_adr_c_3, n448, n492, 
        ti_we_c, ti_rom_c, ti_gsel_c, n38, n39, n40, n41, n42, 
        n43, n44, n45, n481, n484, n487, n490, n493, out_adr_c_12, 
        out_adr_c_11, out_adr_c_10, out_adr_c_9, out_adr_c_8, out_adr_c_7, 
        out_adr_c_6, out_adr_c_5, out_adr_c_4, out_adr_c_3, out_adr_c_2, 
        out_adr_c_1, out_adr_c_0, out_data_c_7, out_data_c_6, out_data_c_5, 
        out_data_c_4, out_data_c_3, out_data_c_2, out_data_c_1, out_data_c_0, 
        dataout;
    wire [0:7]grmadr;   // design.vhd(49[9:15])
    
    wire grmpage, gactive, n496, n215, n453, n462, gactive_N_38, 
        gvalid_N_43, ti_gsel_N_26, ti_adr_14__N_28, n456, n451, dataout_N_22, 
        ti_rom_N_30, dataout_N_21, ti_we_N_19, grmadr_0__N_17, n454, 
        n435, gnd, n443, n416, ti_data_out_5, n409, n471, ti_data_out_7, 
        ti_data_out_1, ti_data_out_3, n491, ti_data_out_4, ti_data_out_0, 
        ti_data_out_6, n457, n447, n168, n499, n201, ti_data_out_2, 
        n469, n449, n489, n468, n402, n488, n466, n486, n395, 
        n441, n485, n463, n483, n460, n482, n459, n480, n379, 
        n479, n442, n478, n388, n477, n465, n501, n500, n498, 
        n475, n474, n423, n472, n497, n495, n494;
    
    XOR2 i408 (.O(n41), .I0(n402), .I1(grmadr[3]));
    AND2 i486 (.O(n482), .I0(grmadr_0__N_17), .I1(ti_data_out_1));
    DFFC grmpage_105 (.Q(grmpage), .D(n442), .CLK(out_adr_c), .CE(grmadr_0__N_17));   // design.vhd(145[3] 173[10])
    OBUF out_adr_pad_10 (.O(out_adr[10]), .I0(out_adr_c_10));   // C:/ispLEVER_Classic2_0/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(270[8:12])
    DFFC gvalid_103 (.Q(out_adr_c), .D(gvalid_N_43), .CLK(ti_gclk_N_48), 
         .CE(n215)) /* synthesis lse_init_val=0 */ ;   // design.vhd(59[3] 79[10])
    OBUF out_adr_pad_11 (.O(out_adr[11]), .I0(out_adr_c_11));   // C:/ispLEVER_Classic2_0/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(270[8:12])
    OBUF out_adr_pad_9 (.O(out_adr[9]), .I0(out_adr_c_9));   // C:/ispLEVER_Classic2_0/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(270[8:12])
    OBUF out_adr_pad_12 (.O(out_adr[12]), .I0(out_adr_c_12));   // C:/ispLEVER_Classic2_0/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(270[8:12])
    OBUF out_adr_pad_13 (.O(out_adr[13]), .I0(out_adr_c));   // C:/ispLEVER_Classic2_0/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(270[8:12])
    OBUF out_adr_pad_14 (.O(out_adr[14]), .I0(out_adr_c));   // C:/ispLEVER_Classic2_0/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(270[8:12])
    DFF grmadr_122__i0 (.Q(grmadr[0]), .D(n480), .CLK(out_adr_c)) /* synthesis syn_use_carry_chain=1 */ ;   // C:/ispLEVER_Classic2_0/lse/vhdl_packages/vh2008/ieee/numeric_std_2008.vhd(2193[12:13])
    OBUF out_adr_pad_15 (.O(out_adr[15]), .I0(out_adr_c));   // C:/ispLEVER_Classic2_0/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(270[8:12])
    OBUF out_adr_pad_8 (.O(out_adr[8]), .I0(out_adr_c_8));   // C:/ispLEVER_Classic2_0/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(270[8:12])
    OBUF out_adr_pad_16 (.O(out_adr[16]), .I0(out_adr_c));   // C:/ispLEVER_Classic2_0/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(270[8:12])
    OBUF out_adr_pad_17 (.O(out_adr[17]), .I0(out_adr_c));   // C:/ispLEVER_Classic2_0/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(270[8:12])
    OBUF out_adr_pad_18 (.O(out_adr[18]), .I0(out_adr_c));   // C:/ispLEVER_Classic2_0/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(270[8:12])
    OBUF out_adr_pad_19 (.O(out_adr[19]), .I0(out_adr_c));   // C:/ispLEVER_Classic2_0/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(270[8:12])
    OBUF out_adr_pad_20 (.O(out_adr[20]), .I0(out_adr_c));   // C:/ispLEVER_Classic2_0/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(270[8:12])
    OBUF out_adr_pad_21 (.O(out_adr[21]), .I0(out_adr_c));   // C:/ispLEVER_Classic2_0/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(270[8:12])
    OBUF out_adr_pad_22 (.O(out_adr[22]), .I0(out_adr_c));   // C:/ispLEVER_Classic2_0/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(270[8:12])
    OBUF out_adr_pad_23 (.O(out_adr[23]), .I0(out_adr_c));   // C:/ispLEVER_Classic2_0/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(270[8:12])
    OBUF out_adr_pad_24 (.O(out_adr[24]), .I0(out_adr_c));   // C:/ispLEVER_Classic2_0/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(270[8:12])
    OBUF out_adr_pad_25 (.O(out_adr[25]), .I0(out_adr_c));   // C:/ispLEVER_Classic2_0/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(270[8:12])
    OBUF out_adr_pad_26 (.O(out_adr[26]), .I0(out_adr_c));   // C:/ispLEVER_Classic2_0/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(270[8:12])
    BI_DIR ti_data_pad_0 (.O(ti_data_out_0), .I0(out_data_c_7), .IO(ti_data[0]), 
           .OE(dataout));   // C:/ispLEVER_Classic2_0/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(67[8:14])
    DFF grmadr_122__i1 (.Q(grmadr[1]), .D(n483), .CLK(out_adr_c)) /* synthesis syn_use_carry_chain=1 */ ;   // C:/ispLEVER_Classic2_0/lse/vhdl_packages/vh2008/ieee/numeric_std_2008.vhd(2193[12:13])
    BI_DIR ti_data_pad_1 (.O(ti_data_out_1), .I0(out_data_c_6), .IO(ti_data[1]), 
           .OE(dataout));   // C:/ispLEVER_Classic2_0/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(67[8:14])
    DFF grmadr_122__i2 (.Q(grmadr[2]), .D(n486), .CLK(out_adr_c)) /* synthesis syn_use_carry_chain=1 */ ;   // C:/ispLEVER_Classic2_0/lse/vhdl_packages/vh2008/ieee/numeric_std_2008.vhd(2193[12:13])
    BI_DIR ti_data_pad_2 (.O(ti_data_out_2), .I0(out_data_c_5), .IO(ti_data[2]), 
           .OE(dataout));   // C:/ispLEVER_Classic2_0/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(67[8:14])
    DFF grmadr_122__i3 (.Q(grmadr[3]), .D(n489), .CLK(out_adr_c)) /* synthesis syn_use_carry_chain=1 */ ;   // C:/ispLEVER_Classic2_0/lse/vhdl_packages/vh2008/ieee/numeric_std_2008.vhd(2193[12:13])
    BI_DIR ti_data_pad_3 (.O(ti_data_out_3), .I0(out_data_c_4), .IO(ti_data[3]), 
           .OE(dataout));   // C:/ispLEVER_Classic2_0/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(67[8:14])
    DFF grmadr_122__i4 (.Q(grmadr[4]), .D(n492), .CLK(out_adr_c)) /* synthesis syn_use_carry_chain=1 */ ;   // C:/ispLEVER_Classic2_0/lse/vhdl_packages/vh2008/ieee/numeric_std_2008.vhd(2193[12:13])
    BI_DIR ti_data_pad_4 (.O(ti_data_out_4), .I0(out_data_c_3), .IO(ti_data[4]), 
           .OE(dataout));   // C:/ispLEVER_Classic2_0/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(67[8:14])
    DFF grmadr_122__i5 (.Q(grmadr[5]), .D(n495), .CLK(out_adr_c)) /* synthesis syn_use_carry_chain=1 */ ;   // C:/ispLEVER_Classic2_0/lse/vhdl_packages/vh2008/ieee/numeric_std_2008.vhd(2193[12:13])
    BI_DIR ti_data_pad_5 (.O(ti_data_out_5), .I0(out_data_c_2), .IO(ti_data[5]), 
           .OE(dataout));   // C:/ispLEVER_Classic2_0/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(67[8:14])
    DFF grmadr_122__i6 (.Q(grmadr[6]), .D(n501), .CLK(out_adr_c)) /* synthesis syn_use_carry_chain=1 */ ;   // C:/ispLEVER_Classic2_0/lse/vhdl_packages/vh2008/ieee/numeric_std_2008.vhd(2193[12:13])
    BI_DIR ti_data_pad_6 (.O(ti_data_out_6), .I0(out_data_c_1), .IO(ti_data[6]), 
           .OE(dataout));   // C:/ispLEVER_Classic2_0/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(67[8:14])
    DFF grmadr_122__i7 (.Q(grmadr[7]), .D(n498), .CLK(out_adr_c)) /* synthesis syn_use_carry_chain=1 */ ;   // C:/ispLEVER_Classic2_0/lse/vhdl_packages/vh2008/ieee/numeric_std_2008.vhd(2193[12:13])
    BI_DIR ti_data_pad_7 (.O(ti_data_out_7), .I0(out_data_c_0), .IO(ti_data[7]), 
           .OE(dataout));   // C:/ispLEVER_Classic2_0/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(67[8:14])
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
    OR2 i1 (.O(n215), .I0(n447), .I1(n201));
    DFFC gactive_104 (.Q(gactive), .D(gactive_N_38), .CLK(ti_gclk_N_48), 
         .CE(gvalid_N_43)) /* synthesis lse_init_val=0 */ ;   // design.vhd(59[3] 79[10])
    XOR2 i415 (.O(n40), .I0(n409), .I1(grmadr[2]));
    AND2 i458 (.O(n454), .I0(out_adr_c), .I1(grmadr[0]));
    OR2 gvalid_I_0_113_i5 (.O(out_adr_c_12), .I0(ti_adr_c_3), .I1(out_adr_c));
    OR2 gvalid_I_0_113_i4 (.O(out_adr_c_11), .I0(ti_adr_c_4), .I1(out_adr_c));
    OR2 gvalid_I_0_113_i3 (.O(out_adr_c_10), .I0(ti_adr_c_5), .I1(out_adr_c));
    OR2 gvalid_I_0_113_i2 (.O(out_adr_c_9), .I0(ti_adr_c_6), .I1(out_adr_c));
    AND2 i200 (.O(n201), .I0(ti_gsel_N_26), .I1(gactive));
    AND2 i503 (.O(n499), .I0(n477), .I1(n44));
    AND2 i500 (.O(n496), .I0(n477), .I1(n45));
    AND2 i497 (.O(n493), .I0(n477), .I1(n43));
    AND2 i494 (.O(n490), .I0(n477), .I1(n42));
    AND2 i491 (.O(n487), .I0(n477), .I1(n41));
    AND2 i488 (.O(n484), .I0(n477), .I1(n40));
    AND2 i485 (.O(n481), .I0(n477), .I1(n39));
    OR2 i459 (.O(out_adr_c_7), .I0(n454), .I1(n453));
    AND2 i478 (.O(n474), .I0(n449), .I1(ti_adr_c_15));
    AND2 i475 (.O(n471), .I0(n449), .I1(ti_adr_c_14));
    AND2 i472 (.O(n468), .I0(n449), .I1(ti_adr_c_13));
    AND2 i469 (.O(n465), .I0(n449), .I1(ti_adr_c_12));
    AND2 i466 (.O(n462), .I0(n449), .I1(ti_adr_c_11));
    AND2 i463 (.O(n459), .I0(n449), .I1(ti_adr_c_10));
    AND2 i460 (.O(n456), .I0(n449), .I1(ti_adr_c_9));
    OR2 gvalid_I_0_113_i1 (.O(out_adr_c_8), .I0(ti_adr_c_7), .I1(out_adr_c));
    XOR2 i401 (.O(n42), .I0(n395), .I1(grmadr[4]));
    AND4 i3 (.O(dataout_N_22), .I0(grmpage), .I1(ti_gsel_N_26), .I2(ti_adr_14__N_28), 
         .I3(out_adr_c));
    AND2 i127 (.O(n168), .I0(grmadr_0__N_17), .I1(grmadr[2]));
    AND2 grmadr_0__I_1 (.O(grmadr_0__N_17), .I0(ti_adr_c_14), .I1(ti_we_N_19));
    OR2 i454 (.O(gvalid_N_43), .I0(n449), .I1(n448));
    OR2 dataout_I_0 (.O(dataout_N_21), .I0(ti_rom_N_30), .I1(dataout_N_22));
    OR2 i456 (.O(gactive_N_38), .I0(n451), .I1(out_adr_c));
    AND2 i461 (.O(n457), .I0(out_adr_c), .I1(grmadr[1]));
    XOR2 i1_adj_1 (.O(n435), .I0(grmadr[7]), .I1(ti_adr_c_14));
    XOR2 i422 (.O(n39), .I0(n416), .I1(grmadr[1]));
    AND2 i467 (.O(n463), .I0(out_adr_c), .I1(grmadr[3]));
    AND2 i457 (.O(n453), .I0(n449), .I1(ti_adr_c_8));
    OR2 i462 (.O(out_adr_c_6), .I0(n457), .I1(n456));
    INV i439 (.O(n45), .I0(n435));
    INV i451 (.O(n447), .I0(gvalid_N_43));
    INV i481 (.O(n477), .I0(grmadr_0__N_17));
    INV i452 (.O(n448), .I0(ti_gsel_c));
    GND i450 (.X(gnd));
    INV i447 (.O(n441), .I0(n443));
    INV i453 (.O(n449), .I0(out_adr_c));
    INV ti_we_I_0_112 (.O(ti_we_N_19), .I0(ti_we_c));
    INV ti_rom_I_0 (.O(ti_rom_N_30), .I0(ti_rom_c));
    INV ti_adr_14__I_0 (.O(ti_adr_14__N_28), .I0(ti_adr_c_14));
    INV ti_gsel_I_0 (.O(ti_gsel_N_26), .I0(ti_gsel_c));
    INV i455 (.O(n451), .I0(ti_gsel_c));
    INV ti_gclk_I_0 (.O(ti_gclk_N_48), .I0(ti_gclk_c));
    VCC i2 (.X(out_reset_c));
    OR2 i484 (.O(n480), .I0(n479), .I1(n478));
    AND2 i483 (.O(n479), .I0(grmadr_0__N_17), .I1(ti_data_out_0));
    XOR2 i394 (.O(n43), .I0(n388), .I1(grmadr[5]));
    AND2 i482 (.O(n478), .I0(n477), .I1(n38));
    XOR2 i387 (.O(n44), .I0(n379), .I1(grmadr[6]));
    OR2 i480 (.O(out_adr_c_0), .I0(n475), .I1(n474));
    AND2 i397 (.O(n395), .I0(n388), .I1(grmadr[5]));
    AND2 i479 (.O(n475), .I0(out_adr_c), .I1(grmadr[7]));
    AND2 i464 (.O(n460), .I0(out_adr_c), .I1(grmadr[2]));
    OR2 i477 (.O(out_adr_c_1), .I0(n472), .I1(n471));
    AND2 i390 (.O(n388), .I0(n379), .I1(grmadr[6]));
    AND2 i476 (.O(n472), .I0(out_adr_c), .I1(grmadr[6]));
    OR2 i474 (.O(out_adr_c_2), .I0(n469), .I1(n468));
    OR2 i465 (.O(out_adr_c_5), .I0(n460), .I1(n459));
    AND2 i381 (.O(n379), .I0(grmadr[7]), .I1(ti_adr_14__N_28));
    AND2 i473 (.O(n469), .I0(out_adr_c), .I1(grmadr[5]));
    AND2 i425 (.O(n423), .I0(n416), .I1(grmadr[1]));
    AND2 i284 (.O(dataout), .I0(dataout_N_21), .I1(ti_we_c));
    OR2 i471 (.O(out_adr_c_3), .I0(n466), .I1(n465));
    AND2 i418 (.O(n416), .I0(n409), .I1(grmadr[2]));
    AND2 i404 (.O(n402), .I0(n395), .I1(grmadr[4]));
    AND2 i1_adj_2 (.O(n442), .I0(n441), .I1(grmadr[0]));
    AND2 i470 (.O(n466), .I0(out_adr_c), .I1(grmadr[4]));
    AND2 i411 (.O(n409), .I0(n402), .I1(grmadr[3]));
    OR2 i505 (.O(n501), .I0(n500), .I1(n499));
    AND2 i504 (.O(n500), .I0(grmadr_0__N_17), .I1(ti_data_out_6));
    OR2 i502 (.O(n498), .I0(n497), .I1(n496));
    AND2 i501 (.O(n497), .I0(grmadr_0__N_17), .I1(ti_data_out_7));
    OR2 i499 (.O(n495), .I0(n494), .I1(n493));
    AND2 i498 (.O(n494), .I0(grmadr_0__N_17), .I1(ti_data_out_5));
    OR2 i496 (.O(n492), .I0(n491), .I1(n490));
    AND2 i495 (.O(n491), .I0(grmadr_0__N_17), .I1(ti_data_out_4));
    OR2 i493 (.O(n489), .I0(n488), .I1(n487));
    AND2 i492 (.O(n488), .I0(grmadr_0__N_17), .I1(ti_data_out_3));
    OR2 i468 (.O(out_adr_c_4), .I0(n463), .I1(n462));
    OR2 i446 (.O(n443), .I0(grmadr[1]), .I1(n168));
    XOR2 i429 (.O(n38), .I0(n423), .I1(grmadr[0]));
    OR2 i490 (.O(n486), .I0(n485), .I1(n484));
    AND2 i489 (.O(n485), .I0(grmadr_0__N_17), .I1(ti_data_out_2));
    OR2 i487 (.O(n483), .I0(n482), .I1(n481));
    
endmodule
//
// Verilog Description of module XOR2
// module not written out since it is a black-box. 
//

//
// Verilog Description of module AND2
// module not written out since it is a black-box. 
//

//
// Verilog Description of module OR2
// module not written out since it is a black-box. 
//

//
// Verilog Description of module AND4
// module not written out since it is a black-box. 
//

//
// Verilog Description of module INV
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

