`timescale 1ns/100ps

module moduleName_TB;
    reg  [3:0] in1, in2;                    // in = reg
    wire [3:0] out1, out2;                  // out = wire
    wire clk;                               // clk is module input but is also clockGenerator output

    clockGeneratorByPeriod #(4) clock(clk);
    moduleName UUT(out1, out2, in1, in2);   // Unit Under Test

    initial begin

        in1 = 4'b0000; in2 = 4'b0000; #5;  // input value; input value; #delay
        
        $stop;

    end

endmodule
