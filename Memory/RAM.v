// SINGLE PORT RAM WITH SINGLE READ/WRITE ADDRESS
module single_port_ram #(parameter DATA_WIDTH = 8, parameter ADDR_WIDTH = 6)(
    output [(DATA_WIDTH-1):0] q,    
    input  [(DATA_WIDTH-1):0] data,
    input  [(ADDR_WIDTH-1):0] addr,
    input  writeEnabled,
    input  clk    
);
    // Declare the RAM variable
    reg [DATA_WIDTH-1:0] RAM [2**ADDR_WIDTH-1:0];

    reg [ADDR_WIDTH-1:0] regAddr;

    always @(posedge clk)
    begin
        if(writeEnabled)
        begin
            ram[addr] <= data;
        end

        regAddr <= addr;
    end

    assign q = ram[regAddr];

endmodule

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// SINGLE PORT RAM WITH SINGLE READ/WRITE ADDRESS - SYNCHRONIZED OUTPUT
module single_port_ram #(parameter DATA_WIDTH = 8, parameter ADDR_WIDTH = 6)(
    output [(DATA_WIDTH-1):0] q,    
    input  [(DATA_WIDTH-1):0] data,
    input  [(ADDR_WIDTH-1):0] addr,
    input  writeEnabled,
    input  clk    
);
    // Declare the RAM variable
    reg [DATA_WIDTH-1:0] RAM [2**ADDR_WIDTH-1:0];

    reg [ADDR_WIDTH-1:0] regAddr;
    reg [(DATA_WIDTH-1):0] regData;

    always @(posedge clk)
    begin
        if(writeEnabled)
        begin
            ram[addr] <= data;
        end

        regAddr <= addr;
        regData <= RAM[regAddr]; 
    end

    assign q = regData;

endmodule

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// SIMPLE DUAL PORT RAM WITH SEPARATE READ/WRITE ADDRESSES AND SINGLE READ/WRITE CLOCK
module simple_dual_port_ram_single_clock #(parameter DATA_WIDTH=8, parameter ADDR_WIDTH=6)(
    output [(DATA_WIDTH-1):0] q,
    input  [(DATA_WIDTH-1):0] data,
    input  [(ADDR_WIDTH-1):0] read_addr, write_addr,
    input  writeEnabled,
    input  clk
);
    // Declare the RAM variable
    reg [DATA_WIDTH-1:0] RAM [2**ADDR_WIDTH-1:0];

    reg [(DATA_WIDTH-1):0] regQ;

    always @(posedge clk)
    begin
        if(writeEnabled)
        begin
            RAM[write_addr] <= data;
        end

        regQ <= RAM[read_addr];
    end

    assign q = regQ;
endmodule

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// TRUE DUAL PORT RAM WITH SINGLE CLOCK
module true_dual_port_ram_single_clock #(parameter DATA_WIDTH=8, parameter ADDR_WIDTH=6)(
    output [(DATA_WIDTH-1):0] qA, qB,
    input [(DATA_WIDTH-1):0] dataA, dataB,
    input [(ADDR_WIDTH-1):0] addrA, addrB,
    input writeEnabledA, writeEnabledB, 
    input clk
);
    // Declare the RAM variable
    reg [DATA_WIDTH-1:0] RAM [2**ADDR_WIDTH-1:0];
    reg [(DATA_WIDTH-1):0] regqA, regqB;
    
    assign qA = regqA;
    assign qB = regqB;

    always @(posedge clk)
    begin
        if(writeEnabledA) 
        begin
            RAM[addrA] <= dataA;
            regqA <= dataA;
        end
        else 
        begin
            regqA <= RAM[addrA];
        end 
    end

    always @(posedge clk)
    begin
        if(writeEnabledB) 
        begin
            RAM[addrB] <= dataB;
            regqB <= dataB;
        end
        else 
        begin
            regqB <= RAM[addrB];
        end 
    end

endmodule

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// TRUE DUAL PORT RAM WITH DUAL CLOCKS
module true_dual_port_ram_dual_clock #(parameter DATA_WIDTH=8, parameter ADDR_WIDTH=6)(
    output [(DATA_WIDTH-1):0] qA, qB,
    input [(DATA_WIDTH-1):0] dataA, dataB,
    input [(ADDR_WIDTH-1):0] addrA, addrB,
    input writeEnabledA, writeEnabledB,
    input clkA, clkB
);
    // Declare the RAM variable
    reg [DATA_WIDTH-1:0] RAM [2**ADDR_WIDTH-1:0];

    reg [(DATA_WIDTH-1):0] regqA, regqB;
    
    assign qA = regqA;
    assign qB = regqB;

    always @(posedge clkA)
    begin
        if(writeEnabledA) 
        begin
            RAM[addrA] <= dataA;
            regqA <= dataA;
        end
        else 
        begin
            regqA <= RAM[addrA];
        end 
    end

    always @(posedge clkB)
    begin
        if(writeEnabledB) 
        begin
            RAM[addrB] <= dataB;
            regqB <= dataB;
        end
        else 
        begin
            regqB <= RAM[addrB];
        end 
    end

endmodule
