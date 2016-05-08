//
module ddr_if_5to2 (
    input   logic   clk,        // this is the clock that the data comes in with.
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
    logic   dataclk_in;
    logic   divclk;
    logic   [1:0][9:0][13:0]    demux_data;



    // OSERDES to multiplex data and produce DDR output clock
    ddr_io_wiz0 serdes_1 (
        .data_out_from_device(demux_data[1]), 
        .data_out_to_pins_p(data_out_p[1]), 
        .data_out_to_pins_n(data_out_n[1]), 
        .clk_to_pins_p(dataclk_out_p), 
        .clk_to_pins_n(dataclk_out_p), 
        .clk_in(dataclk_in), 
        .clk_div_in(divclk), 
        .clk_reset(0), 
        .io_reset(0) 
    ); 

    ddr_io_wiz0 serdes_0 (
        .data_out_from_device(demux_data[0]), 
        .data_out_to_pins_p(data_out_p[0]), 
        .data_out_to_pins_n(data_out_n[0]), 
        .clk_to_pins_p(), 
        .clk_to_pins_n(), 
        .clk_in(dataclk_in), 
        .clk_div_in(divclk), 
        .clk_reset(0), 
        .io_reset(0) 
    ); 


    // demultiplex by 4 to feed the 10 to 1 OSERDES


    
endmodule
