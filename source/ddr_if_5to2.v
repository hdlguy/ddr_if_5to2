//
module ddr_if_5to2 (
    input   logic   clk,
    output  logic   clkout,
    input   logic   dcm_reset,
    output  logic   dcm_lock,
    input   logic   [4:0][13:0]     data_in,
    //
    input   logic   dataclk_in_p,
    input   logic   dataclk_in_n,
    output  logic   dataclk_out_p,
    output  logic   dataclk_out_n,
    output  logic   [1:0][13:0]     data_out_p,
    output  logic   [1:0][13:0]     data_out_n);

    // clock buffer and dcm



    // OSERDES to multiplex data and produce DDR output clock
    OSERDESE2 #(
        .DATA_RATE_OQ("DDR"), 
        .DATA_RATE_TQ("DDR"), 
        .DATA_WIDTH(10), 
        .INIT_OQ(1'b0), 
        .INIT_TQ(1'b0), 
        .SERDES_MODE("MASTER"), // MASTER, SLAVE
        .SRVAL_OQ(1'b0), 
        .SRVAL_TQ(1'b0), 
        .TBYTE_CTL("FALSE"), 
        .TBYTE_SRC("FALSE"), 
        .TRISTATE_WIDTH(4) )
    OSERDESE2_inst (
        .OFB(OFB), // 1-bit output: Feedback path for data
        .OQ(OQ), // 1-bit output: Data path output
        // SHIFTOUT1 / SHIFTOUT2: 1-bit (each) output: Data output expansion (1-bit each)
        .SHIFTOUT1(SHIFTOUT1),
        .SHIFTOUT2(SHIFTOUT2),
        .TBYTEOUT(TBYTEOUT), // 1-bit output: Byte group tristate
        .TFB(TFB), // 1-bit output: 3-state control
        .TQ(TQ), // 1-bit output: 3-state control
        .CLK(CLK), // 1-bit input: High speed clock
        .CLKDIV(CLKDIV), // 1-bit input: Divided clock
        // D1 - D8: 1-bit (each) input: Parallel data inputs (1-bit each)
        .D1(D1), .D2(D2), .D3(D3), .D4(D4), .D5(D5), .D6(D6), .D7(D7), .D8(D8),
        .OCE(OCE),
        // 1-bit input: Output data clock enable
        .RST(RST), // 1-bit input: Reset
        // SHIFTIN1 / SHIFTIN2: 1-bit (each) input: Data input expansion (1-bit each)
        .SHIFTIN1(SHIFTIN1),
        .SHIFTIN2(SHIFTIN2),
        // T1 - T4: 1-bit (each) input: Parallel 3-state inputs
        .T1(0), .T2(0), .T3(0), .T4(0),
        .TBYTEIN(TBYTEIN), // 1-bit input: Byte group tristate
        .TCE(TCE) // 1-bit input: 3-state clock enable
    );

    
    // demultiplex by 4 to feed the 10 to 1 OSERDES


    
endmodule
