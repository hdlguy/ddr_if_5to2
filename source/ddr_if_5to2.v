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

    
    // demultiplex by 4 to feed the 10 to 1 OSERDES

    
endmodule
