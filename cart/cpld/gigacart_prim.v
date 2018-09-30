// Verilog netlist produced by program LSE :  version Diamond Version 0.0.0
// Netlist written on Sat Sep 29 22:47:29 2018
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
    wire ti_gclk_c /* synthesis is_clock=1, SET_AS_NETWORK=ti_gclk_c */ ;   // design.vhd(29[3:10])
    wire gactive /* synthesis is_clock=1 */ ;   // design.vhd(51[9:16])
    wire ti_we_N_45 /* synthesis is_inv_clock=1, SET_AS_NETWORK=ti_we_N_45, is_clock=1 */ ;   // design.vhd(35[3:12])
    wire gactive_N_24 /* synthesis SET_AS_NETWORK=gactive_N_24, is_inv_clock=1, is_clock=1 */ ;   // design.vhd(49[9:15])
    
    wire n406, out_reset_c, ti_adr_c_15, ti_adr_c_14, ti_adr_c_13, 
        ti_adr_c_12, ti_adr_c_11, ti_adr_c_10, ti_adr_c_9, ti_adr_c_8, 
        ti_adr_c_7, ti_adr_c_6, ti_adr_c_5, ti_adr_c_4, ti_adr_c_3, 
        n431, n430, n428, ti_rom_c, ti_gsel_c, out_adr_c_26, out_adr_c_25, 
        out_adr_c_24, out_adr_c_23, out_adr_c_22, out_adr_c_21, out_adr_c_20, 
        out_adr_c_19, out_adr_c_18, out_adr_c_17, out_adr_c_16, out_adr_c_15, 
        out_adr_c_14, out_adr_c_13, out_adr_c_12, out_adr_c_11, out_adr_c_10, 
        out_adr_c_9, out_adr_c_8, out_adr_c_7, out_adr_c_6, out_adr_c_5, 
        out_adr_c_4, out_adr_c_3, out_adr_c_2, out_adr_c_1, out_adr_c_0, 
        out_data_c_7, out_data_c_6, out_data_c_5, out_data_c_4, out_data_c_3, 
        out_data_c_2, out_data_c_1, out_data_c_0, n375, dataout;
    wire [13:0]latch;   // design.vhd(46[9:14])
    wire [0:7]grmadr;   // design.vhd(49[9:15])
    
    wire grmpage, gvalid, n412, n248, gactive_N_27, n253, n410, 
        n409, n340, n368, gactive_N_25, gvalid_N_36, ti_rom_N_41, 
        dataout_N_46, n413, n422, n354, n347, n407, n361, n398, 
        n427, ti_gsel_N_30, out_reset_N_43, n403, n386, n394, n425, 
        ti_data_out_7, n424, n400, ti_data_out_6, n393, n419, n405, 
        n38, n39, n40, n41, n42, n43, n44, n45, n402, n239, 
        n416, gnd, n415, n418, n421;
    
    DFFC grmpage_109 (.Q(grmpage), .D(n394), .CLK(ti_we_N_45), .CE(out_reset_N_43));   // design.vhd(145[3] 171[10])
    DFF grmadr_130__i7 (.Q(grmadr[7]), .D(n45), .CLK(gactive_N_24)) /* synthesis syn_use_carry_chain=1 */ ;   // C:/ispLEVER_Classic2_0/lse/vhdl_packages/vh2008/ieee/numeric_std_2008.vhd(2193[12:13])
    OBUF out_adr_pad_3 (.O(out_adr[3]), .I0(out_adr_c_3));   // C:/ispLEVER_Classic2_0/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(270[8:12])
    OBUF out_adr_pad_0 (.O(out_adr[0]), .I0(out_adr_c_0));   // C:/ispLEVER_Classic2_0/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(270[8:12])
    OBUF out_adr_pad_1 (.O(out_adr[1]), .I0(out_adr_c_1));   // C:/ispLEVER_Classic2_0/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(270[8:12])
    OBUF out_adr_pad_4 (.O(out_adr[4]), .I0(out_adr_c_4));   // C:/ispLEVER_Classic2_0/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(270[8:12])
    DFFC gvalid_106 (.Q(gvalid), .D(gvalid_N_36), .CLK(ti_gclk_c), .CE(n253)) /* synthesis lse_init_val=0 */ ;   // design.vhd(59[3] 79[10])
    OR2 i377 (.O(gactive_N_25), .I0(n403), .I1(gvalid));
    DFFC latch_i0_i13 (.Q(latch[13]), .D(ti_data_out_6), .CLK(ti_we_c), 
         .CE(ti_rom_N_41)) /* synthesis lse_init_val=0 */ ;   // design.vhd(101[3] 127[10])
    DFFC latch_i0_i12 (.Q(latch[12]), .D(ti_data_out_7), .CLK(ti_we_c), 
         .CE(ti_rom_N_41)) /* synthesis lse_init_val=0 */ ;   // design.vhd(101[3] 127[10])
    DFFC latch_i0_i11 (.Q(latch[11]), .D(ti_adr_c_3), .CLK(ti_we_c), .CE(ti_rom_N_41)) /* synthesis lse_init_val=0 */ ;   // design.vhd(101[3] 127[10])
    DFFC latch_i0_i10 (.Q(latch[10]), .D(ti_adr_c_4), .CLK(ti_we_c), .CE(ti_rom_N_41)) /* synthesis lse_init_val=0 */ ;   // design.vhd(101[3] 127[10])
    DFFC latch_i0_i9 (.Q(latch[9]), .D(ti_adr_c_5), .CLK(ti_we_c), .CE(ti_rom_N_41)) /* synthesis lse_init_val=0 */ ;   // design.vhd(101[3] 127[10])
    DFFC latch_i0_i7 (.Q(latch[7]), .D(ti_adr_c_7), .CLK(ti_we_c), .CE(ti_rom_N_41)) /* synthesis lse_init_val=0 */ ;   // design.vhd(101[3] 127[10])
    OBUF out_adr_pad_2 (.O(out_adr[2]), .I0(out_adr_c_2));   // C:/ispLEVER_Classic2_0/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(270[8:12])
    OBUF out_adr_pad_5 (.O(out_adr[5]), .I0(out_adr_c_5));   // C:/ispLEVER_Classic2_0/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(270[8:12])
    OBUF out_adr_pad_6 (.O(out_adr[6]), .I0(out_adr_c_6));   // C:/ispLEVER_Classic2_0/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(270[8:12])
    OBUF out_adr_pad_7 (.O(out_adr[7]), .I0(out_adr_c_7));   // C:/ispLEVER_Classic2_0/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(270[8:12])
    OBUF out_adr_pad_8 (.O(out_adr[8]), .I0(out_adr_c_8));   // C:/ispLEVER_Classic2_0/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(270[8:12])
    OBUF out_adr_pad_9 (.O(out_adr[9]), .I0(out_adr_c_9));   // C:/ispLEVER_Classic2_0/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(270[8:12])
    OBUF out_adr_pad_10 (.O(out_adr[10]), .I0(out_adr_c_10));   // C:/ispLEVER_Classic2_0/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(270[8:12])
    OBUF out_adr_pad_11 (.O(out_adr[11]), .I0(out_adr_c_11));   // C:/ispLEVER_Classic2_0/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(270[8:12])
    OBUF out_adr_pad_12 (.O(out_adr[12]), .I0(out_adr_c_12));   // C:/ispLEVER_Classic2_0/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(270[8:12])
    OBUF out_adr_pad_13 (.O(out_adr[13]), .I0(out_adr_c_13));   // C:/ispLEVER_Classic2_0/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(270[8:12])
    OBUF out_adr_pad_14 (.O(out_adr[14]), .I0(out_adr_c_14));   // C:/ispLEVER_Classic2_0/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(270[8:12])
    OBUF out_adr_pad_15 (.O(out_adr[15]), .I0(out_adr_c_15));   // C:/ispLEVER_Classic2_0/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(270[8:12])
    OBUF out_adr_pad_16 (.O(out_adr[16]), .I0(out_adr_c_16));   // C:/ispLEVER_Classic2_0/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(270[8:12])
    OBUF out_adr_pad_17 (.O(out_adr[17]), .I0(out_adr_c_17));   // C:/ispLEVER_Classic2_0/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(270[8:12])
    OBUF out_adr_pad_18 (.O(out_adr[18]), .I0(out_adr_c_18));   // C:/ispLEVER_Classic2_0/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(270[8:12])
    OBUF out_adr_pad_19 (.O(out_adr[19]), .I0(out_adr_c_19));   // C:/ispLEVER_Classic2_0/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(270[8:12])
    OBUF out_adr_pad_20 (.O(out_adr[20]), .I0(out_adr_c_20));   // C:/ispLEVER_Classic2_0/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(270[8:12])
    OBUF out_adr_pad_21 (.O(out_adr[21]), .I0(out_adr_c_21));   // C:/ispLEVER_Classic2_0/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(270[8:12])
    OBUF out_adr_pad_22 (.O(out_adr[22]), .I0(out_adr_c_22));   // C:/ispLEVER_Classic2_0/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(270[8:12])
    OBUF out_adr_pad_23 (.O(out_adr[23]), .I0(out_adr_c_23));   // C:/ispLEVER_Classic2_0/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(270[8:12])
    OBUF out_adr_pad_24 (.O(out_adr[24]), .I0(out_adr_c_24));   // C:/ispLEVER_Classic2_0/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(270[8:12])
    OBUF out_adr_pad_25 (.O(out_adr[25]), .I0(out_adr_c_25));   // C:/ispLEVER_Classic2_0/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(270[8:12])
    OBUF out_adr_pad_26 (.O(out_adr[26]), .I0(out_adr_c_26));   // C:/ispLEVER_Classic2_0/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(270[8:12])
    BUFTH ti_data_pad_0 (.O(ti_data[0]), .I0(out_data_c_7), .OE(dataout));   // C:/ispLEVER_Classic2_0/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(76[8:13])
    DFFC latch_i0_i6 (.Q(latch[6]), .D(ti_adr_c_8), .CLK(ti_we_c), .CE(ti_rom_N_41)) /* synthesis lse_init_val=0 */ ;   // design.vhd(101[3] 127[10])
    BUFTH ti_data_pad_1 (.O(ti_data[1]), .I0(out_data_c_6), .OE(dataout));   // C:/ispLEVER_Classic2_0/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(76[8:13])
    DFFC latch_i0_i5 (.Q(latch[5]), .D(ti_adr_c_9), .CLK(ti_we_c), .CE(ti_rom_N_41)) /* synthesis lse_init_val=0 */ ;   // design.vhd(101[3] 127[10])
    BUFTH ti_data_pad_2 (.O(ti_data[2]), .I0(out_data_c_5), .OE(dataout));   // C:/ispLEVER_Classic2_0/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(76[8:13])
    DFFC latch_i0_i4 (.Q(latch[4]), .D(ti_adr_c_10), .CLK(ti_we_c), .CE(ti_rom_N_41)) /* synthesis lse_init_val=0 */ ;   // design.vhd(101[3] 127[10])
    BUFTH ti_data_pad_3 (.O(ti_data[3]), .I0(out_data_c_4), .OE(dataout));   // C:/ispLEVER_Classic2_0/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(76[8:13])
    DFFC latch_i0_i3 (.Q(latch[3]), .D(ti_adr_c_11), .CLK(ti_we_c), .CE(ti_rom_N_41)) /* synthesis lse_init_val=0 */ ;   // design.vhd(101[3] 127[10])
    BUFTH ti_data_pad_4 (.O(ti_data[4]), .I0(out_data_c_3), .OE(dataout));   // C:/ispLEVER_Classic2_0/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(76[8:13])
    DFFC latch_i0_i2 (.Q(latch[2]), .D(ti_adr_c_12), .CLK(ti_we_c), .CE(ti_rom_N_41)) /* synthesis lse_init_val=0 */ ;   // design.vhd(101[3] 127[10])
    BUFTH ti_data_pad_5 (.O(ti_data[5]), .I0(out_data_c_2), .OE(dataout));   // C:/ispLEVER_Classic2_0/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(76[8:13])
    DFFC latch_i0_i1 (.Q(latch[1]), .D(ti_adr_c_13), .CLK(ti_we_c), .CE(ti_rom_N_41)) /* synthesis lse_init_val=0 */ ;   // design.vhd(101[3] 127[10])
    BI_DIR ti_data_pad_6 (.O(ti_data_out_6), .I0(out_data_c_1), .IO(ti_data[6]), 
           .OE(dataout));   // C:/ispLEVER_Classic2_0/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(67[8:14])
    DFFC latch_i0_i0 (.Q(latch[0]), .D(ti_adr_c_14), .CLK(ti_we_c), .CE(ti_rom_N_41)) /* synthesis lse_init_val=0 */ ;   // design.vhd(101[3] 127[10])
    BI_DIR ti_data_pad_7 (.O(ti_data_out_7), .I0(out_data_c_0), .IO(ti_data[7]), 
           .OE(dataout));   // C:/ispLEVER_Classic2_0/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(67[8:14])
    DFFC latch_i0_i8 (.Q(latch[8]), .D(ti_adr_c_6), .CLK(ti_we_c), .CE(ti_rom_N_41)) /* synthesis lse_init_val=0 */ ;   // design.vhd(101[3] 127[10])
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
    DFF grmadr_130__i6 (.Q(grmadr[6]), .D(n44), .CLK(gactive_N_24)) /* synthesis syn_use_carry_chain=1 */ ;   // C:/ispLEVER_Classic2_0/lse/vhdl_packages/vh2008/ieee/numeric_std_2008.vhd(2193[12:13])
    OR2 i1 (.O(n248), .I0(n402), .I1(gactive_N_27));
    XOR2 i308 (.O(n44), .I0(grmadr[7]), .I1(grmadr[6]));
    AND2 i382 (.O(n409), .I0(n406), .I1(ti_adr_c_8));
    OR2 i405 (.O(out_adr_c_0), .I0(n431), .I1(n430));
    DFF grmadr_130__i5 (.Q(grmadr[5]), .D(n43), .CLK(gactive_N_24)) /* synthesis syn_use_carry_chain=1 */ ;   // C:/ispLEVER_Classic2_0/lse/vhdl_packages/vh2008/ieee/numeric_std_2008.vhd(2193[12:13])
    DFF grmadr_130__i4 (.Q(grmadr[4]), .D(n42), .CLK(gactive_N_24)) /* synthesis syn_use_carry_chain=1 */ ;   // C:/ispLEVER_Classic2_0/lse/vhdl_packages/vh2008/ieee/numeric_std_2008.vhd(2193[12:13])
    DFF grmadr_130__i3 (.Q(grmadr[3]), .D(n41), .CLK(gactive_N_24)) /* synthesis syn_use_carry_chain=1 */ ;   // C:/ispLEVER_Classic2_0/lse/vhdl_packages/vh2008/ieee/numeric_std_2008.vhd(2193[12:13])
    DFF grmadr_130__i2 (.Q(grmadr[2]), .D(n40), .CLK(gactive_N_24)) /* synthesis syn_use_carry_chain=1 */ ;   // C:/ispLEVER_Classic2_0/lse/vhdl_packages/vh2008/ieee/numeric_std_2008.vhd(2193[12:13])
    DFF grmadr_130__i1 (.Q(grmadr[1]), .D(n39), .CLK(gactive_N_24)) /* synthesis syn_use_carry_chain=1 */ ;   // C:/ispLEVER_Classic2_0/lse/vhdl_packages/vh2008/ieee/numeric_std_2008.vhd(2193[12:13])
    DFF grmadr_130__i0 (.Q(grmadr[0]), .D(n38), .CLK(gactive_N_24)) /* synthesis syn_use_carry_chain=1 */ ;   // C:/ispLEVER_Classic2_0/lse/vhdl_packages/vh2008/ieee/numeric_std_2008.vhd(2193[12:13])
    GND i374 (.X(gnd));
    DFFC gactive_107 (.Q(gactive), .D(gactive_N_25), .CLK(ti_gclk_c), 
         .CE(n248)) /* synthesis lse_init_val=0 */ ;   // design.vhd(59[3] 79[10])
    INV i375 (.O(n402), .I0(gactive_N_25));
    INV i373 (.O(n393), .I0(n400));
    INV gactive_I_0 (.O(gactive_N_24), .I0(gactive));
    INV i358 (.O(n386), .I0(ti_adr_c_14));
    INV i376 (.O(n403), .I0(ti_gsel_c));
    INV ti_gsel_I_0 (.O(ti_gsel_N_30), .I0(ti_gsel_c));
    INV ti_we_I_0_123 (.O(ti_we_N_45), .I0(ti_we_c));
    INV ti_rom_I_0 (.O(ti_rom_N_41), .I0(ti_rom_c));
    INV i379 (.O(n406), .I0(gvalid));
    INV i380 (.O(n407), .I0(ti_gsel_c));
    INV i306 (.O(n45), .I0(grmadr[7]));
    VCC i2 (.X(out_reset_c));
    INV i378 (.O(n405), .I0(gvalid_N_36));
    OR2 i1_adj_1 (.O(n253), .I0(n405), .I1(n239));
    AND2 i404 (.O(n431), .I0(gvalid), .I1(grmadr[7]));
    AND2 i1_adj_2 (.O(n394), .I0(n393), .I1(grmadr[0]));
    OR2 gvalid_I_0 (.O(dataout_N_46), .I0(ti_rom_N_41), .I1(gvalid));
    AND3 i2_adj_3 (.O(gactive_N_27), .I0(ti_gsel_N_30), .I1(grmpage), 
         .I2(n386));
    OR2 i402 (.O(out_adr_c_1), .I0(n428), .I1(n427));
    AND2 ti_gsel_N_30_I_0 (.O(out_reset_N_43), .I0(ti_adr_c_14), .I1(ti_gsel_N_30));
    AND2 i389 (.O(n416), .I0(gvalid), .I1(grmadr[2]));
    OR2 i266 (.O(out_adr_c_13), .I0(gvalid), .I1(latch[0]));
    OR2 i267 (.O(out_adr_c_14), .I0(gvalid), .I1(latch[1]));
    OR2 gvalid_I_0_118_i1 (.O(out_adr_c_8), .I0(ti_adr_c_7), .I1(gvalid));
    AND2 i385 (.O(n412), .I0(n406), .I1(ti_adr_c_9));
    AND2 i388 (.O(n415), .I0(n406), .I1(ti_adr_c_10));
    AND2 i391 (.O(n418), .I0(n406), .I1(ti_adr_c_11));
    AND2 i394 (.O(n421), .I0(n406), .I1(ti_adr_c_12));
    AND2 i397 (.O(n424), .I0(n406), .I1(ti_adr_c_13));
    AND2 i400 (.O(n427), .I0(n406), .I1(ti_adr_c_14));
    AND2 i403 (.O(n430), .I0(n406), .I1(ti_adr_c_15));
    XOR2 i322 (.O(n42), .I0(n347), .I1(grmadr[4]));
    AND2 i401 (.O(n428), .I0(gvalid), .I1(grmadr[6]));
    OR2 i399 (.O(out_adr_c_2), .I0(n425), .I1(n424));
    OR2 gvalid_I_0_118_i2 (.O(out_adr_c_9), .I0(ti_adr_c_6), .I1(gvalid));
    OR2 gvalid_I_0_118_i3 (.O(out_adr_c_10), .I0(ti_adr_c_5), .I1(gvalid));
    OR2 gvalid_I_0_118_i4 (.O(out_adr_c_11), .I0(ti_adr_c_4), .I1(gvalid));
    OR2 gvalid_I_0_118_i5 (.O(out_adr_c_12), .I0(ti_adr_c_3), .I1(gvalid));
    AND2 i208 (.O(n239), .I0(gactive_N_27), .I1(gactive));
    AND2 i398 (.O(n425), .I0(gvalid), .I1(grmadr[5]));
    OR2 i396 (.O(out_adr_c_3), .I0(n422), .I1(n421));
    AND2 i395 (.O(n422), .I0(gvalid), .I1(grmadr[4]));
    AND2 i263 (.O(dataout), .I0(dataout_N_46), .I1(ti_we_c));
    OR2 i393 (.O(out_adr_c_4), .I0(n419), .I1(n418));
    AND2 i392 (.O(n419), .I0(gvalid), .I1(grmadr[3]));
    OR2 i268 (.O(out_adr_c_15), .I0(gvalid), .I1(latch[2]));
    OR2 i269 (.O(out_adr_c_16), .I0(gvalid), .I1(latch[3]));
    OR2 i270 (.O(out_adr_c_17), .I0(gvalid), .I1(latch[4]));
    OR2 i271 (.O(out_adr_c_18), .I0(gvalid), .I1(latch[5]));
    OR2 i272 (.O(out_adr_c_19), .I0(gvalid), .I1(latch[6]));
    OR2 i273 (.O(out_adr_c_20), .I0(gvalid), .I1(latch[7]));
    OR2 i274 (.O(out_adr_c_21), .I0(gvalid), .I1(latch[8]));
    OR2 i275 (.O(out_adr_c_22), .I0(gvalid), .I1(latch[9]));
    OR2 i276 (.O(out_adr_c_23), .I0(gvalid), .I1(latch[10]));
    OR2 i277 (.O(out_adr_c_24), .I0(gvalid), .I1(latch[11]));
    OR2 i278 (.O(out_adr_c_25), .I0(gvalid), .I1(latch[12]));
    OR2 i279 (.O(out_adr_c_26), .I0(gvalid), .I1(latch[13]));
    OR2 i387 (.O(out_adr_c_6), .I0(n413), .I1(n412));
    XOR2 i336 (.O(n40), .I0(n361), .I1(grmadr[2]));
    AND2 i386 (.O(n413), .I0(gvalid), .I1(grmadr[1]));
    OR2 i384 (.O(out_adr_c_7), .I0(n410), .I1(n409));
    AND2 i318 (.O(n347), .I0(n340), .I1(grmadr[5]));
    AND2 i383 (.O(n410), .I0(gvalid), .I1(grmadr[0]));
    XOR2 i350 (.O(n38), .I0(n375), .I1(grmadr[0]));
    AND2 i311 (.O(n340), .I0(grmadr[7]), .I1(grmadr[6]));
    AND2 i325 (.O(n354), .I0(n347), .I1(grmadr[4]));
    XOR2 i315 (.O(n43), .I0(n340), .I1(grmadr[5]));
    OR2 i372 (.O(n400), .I0(grmadr[1]), .I1(n398));
    XOR2 i343 (.O(n39), .I0(n368), .I1(grmadr[1]));
    XOR2 i329 (.O(n41), .I0(n354), .I1(grmadr[3]));
    OR2 i381 (.O(gvalid_N_36), .I0(n407), .I1(n406));
    OR2 i390 (.O(out_adr_c_5), .I0(n416), .I1(n415));
    AND2 i370 (.O(n398), .I0(out_reset_N_43), .I1(grmadr[2]));
    AND2 i346 (.O(n375), .I0(n368), .I1(grmadr[1]));
    AND2 i332 (.O(n361), .I0(n354), .I1(grmadr[3]));
    AND2 i339 (.O(n368), .I0(n361), .I1(grmadr[2]));
    
endmodule
//
// Verilog Description of module OR2
// module not written out since it is a black-box. 
//

//
// Verilog Description of module XOR2
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
// Verilog Description of module INV
// module not written out since it is a black-box. 
//

//
// Verilog Description of module VCC
// module not written out since it is a black-box. 
//

//
// Verilog Description of module AND3
// module not written out since it is a black-box. 
//

