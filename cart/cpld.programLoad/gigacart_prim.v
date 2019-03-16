// Verilog netlist produced by program LSE :  version Diamond Version 0.0.0
// Netlist written on Mon Mar 11 20:06:08 2019
//
// Verilog Description of module gigacart
//

module gigacart (ti_adr, ti_data, ti_we, ti_rom, ti_gsel, ti_gclk, 
            out_adr, out_data, out_reset, out_we, out_oe, out_ce);   // design.vhd(26[8:16])
    input [15:3]ti_adr;   // design.vhd(29[3:9])
    inout [7:0]ti_data;   // design.vhd(30[3:10])
    input ti_we;   // design.vhd(31[3:8])
    input ti_rom;   // design.vhd(32[3:9])
    input ti_gsel;   // design.vhd(33[3:10])
    input ti_gclk;   // design.vhd(34[3:10])
    output [26:0]out_adr;   // design.vhd(37[3:10])
    inout [7:0]out_data;   // design.vhd(38[3:11])
    output out_reset;   // design.vhd(39[3:12])
    output out_we;   // design.vhd(40[10:16])
    output out_oe;   // design.vhd(41[3:9])
    output out_ce;   // design.vhd(42[3:9])
    
    wire ti_we_c /* synthesis is_clock=1, SET_AS_NETWORK=ti_we_c */ ;   // design.vhd(31[3:8])
    
    wire pwr, n479_c, n478_c, n477_c, out_adr_c_12_c, out_adr_c_11_c, 
        out_adr_c_10_c, out_adr_c_9_c, out_adr_c_8_c, out_adr_c_7_c, 
        out_adr_c_6_c, out_adr_c_5_c, out_adr_c_4_c, out_adr_c_3_c, 
        ti_rom_c, ti_gsel_c, ti_gclk_c, out_adr_c_26, out_adr_c_25, 
        out_adr_c_24, out_adr_c_23, out_adr_c_22, out_adr_c_21, out_adr_c_20, 
        out_adr_c_19, out_adr_c_18, out_adr_c_17, out_adr_c_16, out_adr_c_15, 
        out_adr_c_14, out_adr_c_13, gnd, out_reset_c, out_we_c, out_oe_c, 
        out_ce_c;
    wire [1:0]wordmask;   // design.vhd(48[9:17])
    
    wire dataout, n519, n510, out_adr_26__N_28, out_data_out_7, ti_data_out_0, 
        ti_data_out_1, ti_data_out_2, ti_data_out_5, n508, n516, n518, 
        n504, n4, out_data_7__N_15, ti_data_out_3, ti_data_out_6, 
        ti_data_out_4, ti_data_out_7, n513, n520, n515, n512, out_data_out_6, 
        out_data_out_5, out_data_out_4, out_data_out_3, out_data_out_2, 
        out_data_out_1, out_data_out_0;
    
    AND2 i448 (.O(out_ce_c), .I0(n516), .I1(n515));
    INV i443 (.O(n512), .I0(ti_rom_c));
    OR2 i437 (.O(n508), .I0(ti_gsel_c), .I1(ti_we_c));
    AND2 i450 (.O(n519), .I0(n479_c), .I1(wordmask[0]));
    OR2 i451 (.O(n520), .I0(n519), .I1(n518));
    INV i444 (.O(n513), .I0(n479_c));
    OBUF out_adr_pad_3 (.O(out_adr[3]), .I0(out_adr_c_12_c));   // C:/ispLEVER_Classic2_0/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(270[8:12])
    OBUF out_adr_pad_4 (.O(out_adr[4]), .I0(out_adr_c_11_c));   // C:/ispLEVER_Classic2_0/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(270[8:12])
    DFFC latch__i14 (.Q(out_adr_c_26), .D(ti_data_out_6), .CLK(ti_we_c), 
         .CE(out_adr_26__N_28)) /* synthesis lse_init_val=0 */ ;   // design.vhd(76[3] 105[10])
    OBUF out_adr_pad_5 (.O(out_adr[5]), .I0(out_adr_c_10_c));   // C:/ispLEVER_Classic2_0/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(270[8:12])
    OBUF out_adr_pad_6 (.O(out_adr[6]), .I0(out_adr_c_9_c));   // C:/ispLEVER_Classic2_0/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(270[8:12])
    GND i441 (.X(gnd));
    INV out_data_7__N_15_I_0 (.O(out_we_c), .I0(out_data_7__N_15));
    INV i440 (.O(n504), .I0(n510));
    INV i438 (.O(n4), .I0(n508));
    INV i446 (.O(n515), .I0(dataout));
    DFFC latch__i1 (.Q(out_adr_c_13), .D(n478_c), .CLK(ti_we_c), .CE(out_adr_26__N_28)) /* synthesis lse_init_val=0 */ ;   // design.vhd(76[3] 105[10])
    OBUF out_adr_pad_7 (.O(out_adr[7]), .I0(out_adr_c_8_c));   // C:/ispLEVER_Classic2_0/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(270[8:12])
    OBUF out_adr_pad_8 (.O(out_adr[8]), .I0(out_adr_c_7_c));   // C:/ispLEVER_Classic2_0/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(270[8:12])
    OBUF out_adr_pad_9 (.O(out_adr[9]), .I0(out_adr_c_6_c));   // C:/ispLEVER_Classic2_0/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(270[8:12])
    OBUF out_adr_pad_10 (.O(out_adr[10]), .I0(out_adr_c_5_c));   // C:/ispLEVER_Classic2_0/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(270[8:12])
    OBUF out_adr_pad_11 (.O(out_adr[11]), .I0(out_adr_c_4_c));   // C:/ispLEVER_Classic2_0/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(270[8:12])
    OBUF out_adr_pad_12 (.O(out_adr[12]), .I0(out_adr_c_3_c));   // C:/ispLEVER_Classic2_0/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(270[8:12])
    OBUF out_adr_pad_13 (.O(out_adr[13]), .I0(out_adr_c_13));   // C:/ispLEVER_Classic2_0/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(270[8:12])
    OR3 i439 (.O(n510), .I0(wordmask[0]), .I1(ti_rom_c), .I2(wordmask[1]));
    AND2 i449 (.O(n518), .I0(n513), .I1(wordmask[1]));
    OBUF out_adr_pad_14 (.O(out_adr[14]), .I0(out_adr_c_14));   // C:/ispLEVER_Classic2_0/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(270[8:12])
    AND2 i445 (.O(out_adr_26__N_28), .I0(n513), .I1(n512));
    AND2 i1 (.O(dataout), .I0(n504), .I1(ti_we_c));
    OBUF out_adr_pad_15 (.O(out_adr[15]), .I0(out_adr_c_15));   // C:/ispLEVER_Classic2_0/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(270[8:12])
    AND2 i2 (.O(out_data_7__N_15), .I0(n4), .I1(n520));
    OBUF out_adr_pad_16 (.O(out_adr[16]), .I0(out_adr_c_16));   // C:/ispLEVER_Classic2_0/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(270[8:12])
    OBUF out_adr_pad_2 (.O(out_adr[2]), .I0(n477_c));   // C:/ispLEVER_Classic2_0/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(270[8:12])
    OBUF out_adr_pad_17 (.O(out_adr[17]), .I0(out_adr_c_17));   // C:/ispLEVER_Classic2_0/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(270[8:12])
    OBUF out_adr_pad_18 (.O(out_adr[18]), .I0(out_adr_c_18));   // C:/ispLEVER_Classic2_0/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(270[8:12])
    OBUF out_adr_pad_19 (.O(out_adr[19]), .I0(out_adr_c_19));   // C:/ispLEVER_Classic2_0/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(270[8:12])
    BI_DIR ti_data_pad_3 (.O(ti_data_out_3), .I0(out_data_out_4), .IO(ti_data[3]), 
           .OE(dataout));   // C:/ispLEVER_Classic2_0/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(67[8:14])
    OBUF out_adr_pad_20 (.O(out_adr[20]), .I0(out_adr_c_20));   // C:/ispLEVER_Classic2_0/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(270[8:12])
    OBUF out_adr_pad_1 (.O(out_adr[1]), .I0(n478_c));   // C:/ispLEVER_Classic2_0/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(270[8:12])
    OBUF out_adr_pad_21 (.O(out_adr[21]), .I0(out_adr_c_21));   // C:/ispLEVER_Classic2_0/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(270[8:12])
    OBUF out_adr_pad_22 (.O(out_adr[22]), .I0(out_adr_c_22));   // C:/ispLEVER_Classic2_0/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(270[8:12])
    OBUF out_adr_pad_23 (.O(out_adr[23]), .I0(out_adr_c_23));   // C:/ispLEVER_Classic2_0/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(270[8:12])
    OBUF out_adr_pad_24 (.O(out_adr[24]), .I0(out_adr_c_24));   // C:/ispLEVER_Classic2_0/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(270[8:12])
    OBUF out_adr_pad_25 (.O(out_adr[25]), .I0(out_adr_c_25));   // C:/ispLEVER_Classic2_0/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(270[8:12])
    OBUF out_adr_pad_26 (.O(out_adr[26]), .I0(out_adr_c_26));   // C:/ispLEVER_Classic2_0/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(270[8:12])
    BI_DIR out_data_pad_0 (.O(out_data_out_0), .I0(ti_data_out_7), .IO(out_data[0]), 
           .OE(out_data_7__N_15));   // C:/ispLEVER_Classic2_0/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(67[8:14])
    INV dataout_I_0 (.O(out_oe_c), .I0(dataout));
    BI_DIR out_data_pad_1 (.O(out_data_out_1), .I0(ti_data_out_6), .IO(out_data[1]), 
           .OE(out_data_7__N_15));   // C:/ispLEVER_Classic2_0/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(67[8:14])
    DFFC latch__i13 (.Q(out_adr_c_25), .D(ti_data_out_7), .CLK(ti_we_c), 
         .CE(out_adr_26__N_28)) /* synthesis lse_init_val=0 */ ;   // design.vhd(76[3] 105[10])
    BI_DIR out_data_pad_2 (.O(out_data_out_2), .I0(ti_data_out_5), .IO(out_data[2]), 
           .OE(out_data_7__N_15));   // C:/ispLEVER_Classic2_0/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(67[8:14])
    DFFC latch__i12 (.Q(out_adr_c_24), .D(out_adr_c_3_c), .CLK(ti_we_c), 
         .CE(out_adr_26__N_28)) /* synthesis lse_init_val=0 */ ;   // design.vhd(76[3] 105[10])
    BI_DIR out_data_pad_3 (.O(out_data_out_3), .I0(ti_data_out_4), .IO(out_data[3]), 
           .OE(out_data_7__N_15));   // C:/ispLEVER_Classic2_0/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(67[8:14])
    DFFC latch__i11 (.Q(out_adr_c_23), .D(out_adr_c_4_c), .CLK(ti_we_c), 
         .CE(out_adr_26__N_28)) /* synthesis lse_init_val=0 */ ;   // design.vhd(76[3] 105[10])
    BI_DIR out_data_pad_4 (.O(out_data_out_4), .I0(ti_data_out_3), .IO(out_data[4]), 
           .OE(out_data_7__N_15));   // C:/ispLEVER_Classic2_0/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(67[8:14])
    DFFC latch__i10 (.Q(out_adr_c_22), .D(out_adr_c_5_c), .CLK(ti_we_c), 
         .CE(out_adr_26__N_28)) /* synthesis lse_init_val=0 */ ;   // design.vhd(76[3] 105[10])
    BI_DIR out_data_pad_5 (.O(out_data_out_5), .I0(ti_data_out_2), .IO(out_data[5]), 
           .OE(out_data_7__N_15));   // C:/ispLEVER_Classic2_0/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(67[8:14])
    DFFC latch__i9 (.Q(out_adr_c_21), .D(out_adr_c_6_c), .CLK(ti_we_c), 
         .CE(out_adr_26__N_28)) /* synthesis lse_init_val=0 */ ;   // design.vhd(76[3] 105[10])
    BI_DIR out_data_pad_6 (.O(out_data_out_6), .I0(ti_data_out_1), .IO(out_data[6]), 
           .OE(out_data_7__N_15));   // C:/ispLEVER_Classic2_0/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(67[8:14])
    DFFC latch__i8 (.Q(out_adr_c_20), .D(out_adr_c_7_c), .CLK(ti_we_c), 
         .CE(out_adr_26__N_28)) /* synthesis lse_init_val=0 */ ;   // design.vhd(76[3] 105[10])
    BI_DIR out_data_pad_7 (.O(out_data_out_7), .I0(ti_data_out_0), .IO(out_data[7]), 
           .OE(out_data_7__N_15));   // C:/ispLEVER_Classic2_0/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(67[8:14])
    DFFC latch__i7 (.Q(out_adr_c_19), .D(out_adr_c_8_c), .CLK(ti_we_c), 
         .CE(out_adr_26__N_28)) /* synthesis lse_init_val=0 */ ;   // design.vhd(76[3] 105[10])
    DFFC latch__i6 (.Q(out_adr_c_18), .D(out_adr_c_9_c), .CLK(ti_we_c), 
         .CE(out_adr_26__N_28)) /* synthesis lse_init_val=0 */ ;   // design.vhd(76[3] 105[10])
    BI_DIR ti_data_pad_4 (.O(ti_data_out_4), .I0(out_data_out_3), .IO(ti_data[4]), 
           .OE(dataout));   // C:/ispLEVER_Classic2_0/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(67[8:14])
    BI_DIR ti_data_pad_0 (.O(ti_data_out_0), .I0(out_data_out_7), .IO(ti_data[0]), 
           .OE(dataout));   // C:/ispLEVER_Classic2_0/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(67[8:14])
    DFFC latch__i5 (.Q(out_adr_c_17), .D(out_adr_c_10_c), .CLK(ti_we_c), 
         .CE(out_adr_26__N_28)) /* synthesis lse_init_val=0 */ ;   // design.vhd(76[3] 105[10])
    DFFC latch__i4 (.Q(out_adr_c_16), .D(out_adr_c_11_c), .CLK(ti_we_c), 
         .CE(out_adr_26__N_28)) /* synthesis lse_init_val=0 */ ;   // design.vhd(76[3] 105[10])
    BI_DIR ti_data_pad_5 (.O(ti_data_out_5), .I0(out_data_out_2), .IO(ti_data[5]), 
           .OE(dataout));   // C:/ispLEVER_Classic2_0/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(67[8:14])
    BI_DIR ti_data_pad_1 (.O(ti_data_out_1), .I0(out_data_out_6), .IO(ti_data[1]), 
           .OE(dataout));   // C:/ispLEVER_Classic2_0/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(67[8:14])
    DFFC latch__i3 (.Q(out_adr_c_15), .D(out_adr_c_12_c), .CLK(ti_we_c), 
         .CE(out_adr_26__N_28)) /* synthesis lse_init_val=0 */ ;   // design.vhd(76[3] 105[10])
    DFFC latch__i2 (.Q(out_adr_c_14), .D(n477_c), .CLK(ti_we_c), .CE(out_adr_26__N_28)) /* synthesis lse_init_val=0 */ ;   // design.vhd(76[3] 105[10])
    BI_DIR ti_data_pad_6 (.O(ti_data_out_6), .I0(out_data_out_1), .IO(ti_data[6]), 
           .OE(dataout));   // C:/ispLEVER_Classic2_0/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(67[8:14])
    BI_DIR ti_data_pad_2 (.O(ti_data_out_2), .I0(out_data_out_5), .IO(ti_data[2]), 
           .OE(dataout));   // C:/ispLEVER_Classic2_0/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(67[8:14])
    DFFC wordmask_i0_i1 (.Q(wordmask[1]), .D(ti_data_out_4), .CLK(ti_we_c), 
         .CE(out_adr_26__N_28)) /* synthesis lse_init_val=0 */ ;   // design.vhd(76[3] 105[10])
    DFFC wordmask_i0_i0 (.Q(wordmask[0]), .D(ti_data_out_5), .CLK(ti_we_c), 
         .CE(out_adr_26__N_28)) /* synthesis lse_init_val=0 */ ;   // design.vhd(76[3] 105[10])
    BI_DIR ti_data_pad_7 (.O(ti_data_out_7), .I0(out_data_out_0), .IO(ti_data[7]), 
           .OE(dataout));   // C:/ispLEVER_Classic2_0/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(67[8:14])
    OBUF out_adr_pad_0 (.O(out_adr[0]), .I0(n479_c));   // C:/ispLEVER_Classic2_0/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(270[8:12])
    DFFC resetout_123 (.Q(out_reset_c), .D(ti_data_out_3), .CLK(ti_we_c), 
         .CE(out_adr_26__N_28));   // design.vhd(76[3] 105[10])
    INV i447 (.O(n516), .I0(out_data_7__N_15));
    VCC i442 (.X(pwr));
    OBUF out_reset_pad (.O(out_reset), .I0(out_reset_c));   // C:/ispLEVER_Classic2_0/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(270[8:12])
    OBUF out_we_pad (.O(out_we), .I0(out_we_c));   // C:/ispLEVER_Classic2_0/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(270[8:12])
    OBUF out_oe_pad (.O(out_oe), .I0(out_oe_c));   // C:/ispLEVER_Classic2_0/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(270[8:12])
    OBUF out_ce_pad (.O(out_ce), .I0(out_ce_c));   // C:/ispLEVER_Classic2_0/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(270[8:12])
    IBUF n479_pad (.O(n479_c), .I0(ti_adr[15]));   // C:/ispLEVER_Classic2_0/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(186[8:12])
    IBUF n478_pad (.O(n478_c), .I0(ti_adr[14]));   // C:/ispLEVER_Classic2_0/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(186[8:12])
    IBUF n477_pad (.O(n477_c), .I0(ti_adr[13]));   // C:/ispLEVER_Classic2_0/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(186[8:12])
    IBUF out_adr_c_12_pad (.O(out_adr_c_12_c), .I0(ti_adr[12]));   // C:/ispLEVER_Classic2_0/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(186[8:12])
    IBUF out_adr_c_11_pad (.O(out_adr_c_11_c), .I0(ti_adr[11]));   // C:/ispLEVER_Classic2_0/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(186[8:12])
    IBUF out_adr_c_10_pad (.O(out_adr_c_10_c), .I0(ti_adr[10]));   // C:/ispLEVER_Classic2_0/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(186[8:12])
    IBUF out_adr_c_9_pad (.O(out_adr_c_9_c), .I0(ti_adr[9]));   // C:/ispLEVER_Classic2_0/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(186[8:12])
    IBUF out_adr_c_8_pad (.O(out_adr_c_8_c), .I0(ti_adr[8]));   // C:/ispLEVER_Classic2_0/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(186[8:12])
    IBUF out_adr_c_7_pad (.O(out_adr_c_7_c), .I0(ti_adr[7]));   // C:/ispLEVER_Classic2_0/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(186[8:12])
    IBUF out_adr_c_6_pad (.O(out_adr_c_6_c), .I0(ti_adr[6]));   // C:/ispLEVER_Classic2_0/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(186[8:12])
    IBUF out_adr_c_5_pad (.O(out_adr_c_5_c), .I0(ti_adr[5]));   // C:/ispLEVER_Classic2_0/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(186[8:12])
    IBUF out_adr_c_4_pad (.O(out_adr_c_4_c), .I0(ti_adr[4]));   // C:/ispLEVER_Classic2_0/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(186[8:12])
    IBUF out_adr_c_3_pad (.O(out_adr_c_3_c), .I0(ti_adr[3]));   // C:/ispLEVER_Classic2_0/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(186[8:12])
    IBUF ti_we_pad (.O(ti_we_c), .I0(ti_we));   // C:/ispLEVER_Classic2_0/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(186[8:12])
    IBUF ti_rom_pad (.O(ti_rom_c), .I0(ti_rom));   // C:/ispLEVER_Classic2_0/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(186[8:12])
    IBUF ti_gsel_pad (.O(ti_gsel_c), .I0(ti_gsel));   // C:/ispLEVER_Classic2_0/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(186[8:12])
    IBUF ti_gclk_pad (.O(ti_gclk_c), .I0(ti_gclk));   // C:/ispLEVER_Classic2_0/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(186[8:12])
    
endmodule
//
// Verilog Description of module AND2
// module not written out since it is a black-box. 
//

//
// Verilog Description of module INV
// module not written out since it is a black-box. 
//

//
// Verilog Description of module OR2
// module not written out since it is a black-box. 
//

//
// Verilog Description of module GND
// module not written out since it is a black-box. 
//

//
// Verilog Description of module OR3
// module not written out since it is a black-box. 
//

//
// Verilog Description of module VCC
// module not written out since it is a black-box. 
//

