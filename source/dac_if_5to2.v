// This module performs a 5 to 2 multiplex operation using Virtex-7 I/O logic to feed
// a dac with a 2 to 1 input multiplexor and DDR clock.
module dac_if_5to2 (
    output  logic   clkout,
    input   logic   dcm_reset,
    output  logic   dcm_locked,
    input   logic   [4:0][13:0]     data_in,
    //
    input   logic   dataclk_in_p,
    input   logic   dataclk_in_n,
    output  logic   dataclk_out_p,
    output  logic   dataclk_out_n,
    output  logic   [1:0][13:0]     data_out_p,
    output  logic   [1:0][13:0]     data_out_n);

    // clock buffer and dcm
    logic   clk400, clk80, clk320;
    ddr_if_clk_wiz clk_wiz (.clk_in400_p(dataclk_in_p),  .clk_in400_n(dataclk_in_n), .clk_out320(clk320), .clk_out80(clk80), .clk_out400(clk400), .reset(dcm_reset), .locked(dcm_locked));      
    assign clkout = clk320;

    // demultiplex input data by 4 and cross clock domain
    logic   [3:0][4:0][13:0]    shift_data, d1;
    always_ff @(posedge clk320) begin
        for(int i=0; i<5; i++) begin
            shift_data[3][i] <= data_in[i];
            shift_data[2][i] <= shift_data[3][i];
            shift_data[1][i] <= shift_data[2][i];
            shift_data[0][i] <= shift_data[1][i];
        end 
    end
    always_ff @(posedge clk80) d1 <= shift_data;

    // rename demuxed data.
    logic [19:0][13:0] d2;
    assign d2 = d1;
    
    // OSERDES to multiplex data and produce DDR output clock
    ddr_io_wiz0 serdes_1 (
        .data_out_from_device({d2[19], d2[17], d2[15], d2[13], d2[11], d2[9], d2[7], d2[5], d2[3], d2[1]}),
        .data_out_to_pins_p(data_out_p[1]), 
        .data_out_to_pins_n(data_out_n[1]), 
        .clk_to_pins_p(dataclk_out_p), 
        .clk_to_pins_n(dataclk_out_n), 
        .clk_in(clk400), 
        .clk_div_in(clk80), 
        .clk_reset(~dcm_locked), 
        .io_reset (~dcm_locked) 
    ); 

    ddr_io_wiz0 serdes_0 (
        .data_out_from_device({d2[18], d2[16], d2[14], d2[12], d2[10], d2[8], d2[6], d2[4], d2[2], d2[0]}),
        .data_out_to_pins_p(data_out_p[0]), 
        .data_out_to_pins_n(data_out_n[0]), 
        .clk_to_pins_p(), 
        .clk_to_pins_n(), 
        .clk_in(clk400), 
        .clk_div_in(clk80), 
        .clk_reset(~dcm_locked), 
        .io_reset (~dcm_locked) 
    ); 
    
endmodule
