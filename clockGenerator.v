module clockGeneratorByFrequency #(parameter real FREQUENCY_HZ = 100_000000)( // DEFAULT: 100MHz
    output clk
);
    reg outClk;

    localparam real HALF_PERIOD = (1.0 / (2.0 * FREQUENCY_HZ)) * 1e9; 

    initial outClk = 1'b0;                                         // clk is initially 0

    always
    begin
        #(HALF_PERIOD) outClk = ~outClk;                           // after a delay of period, the clk receives its inverse
    end

    assign clk = outClk;

endmodule

module clockGeneratorByPeriod #(parameter period = 5)(
    output clk
);
    reg outClk;

    initial outClk = 1'b0;                   // clk is initially 0

    always
    begin
        #(period/2) outClk = ~outClk;        // after a delay of period, the clk receives its inverse
    end

    assign clk = outClk;

endmodule