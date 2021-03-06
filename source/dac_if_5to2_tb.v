module dac_if_5to2_tb;

    logic   clkout;
    logic   dcm_reset;
    logic   dcm_locked;
    logic   sysclk_in;
    logic   [4:0][13:0]     data_in;
    logic   dataclk_in_p;
    logic   dataclk_in_n;
    logic   dataclk_out_p;
    logic   dataclk_out_n;
    logic   [1:0][13:0]     data_out_p;
    logic   [1:0][13:0]     data_out_n;

    localparam clk_period = 2.5;
    
    dac_if_5to2 uut (.*);

    logic   clkin = 0;
    always #(clk_period/2) clkin = ~clkin;
    assign dataclk_in_p =  clkin;
    assign dataclk_in_n = ~clkin;

    assign sysclk_in = clkout;
    
    initial begin
        dcm_reset = 1;
        #(clk_period*10);
        dcm_reset = 0;
    end

    // generate some input data
    always_ff @(posedge clkout) begin
        if(dcm_locked == 0) 
            data_in[4:0] <= {14'h4, 14'h3, 14'h2, 14'h1, 14'h0};
        else begin
            for(int i=0; i<5; i++) data_in[i] <= data_in[i] + 5;
        end
    end

endmodule
