// SINGLE PORT ROM
module single_port_rom #(parameter DATA_WIDTH=8, parameter ADDR_WIDTH=8)(
    output [(DATA_WIDTH-1):0] q,
    input  [(ADDR_WIDTH-1):0] addr,
    input  clk
);
    // Declare the ROM variable
    reg [DATA_WIDTH-1:0] ROM [2**ADDR_WIDTH-1:0];

    reg [(DATA_WIDTH-1):0] regQ;
    assign q = regQ;

    initial
    begin
        $readmemb("rom_data.txt", ROM);
    end

    always @(posedge clk)
    begin
        regQ <= ROM[addr];
    end

endmodule

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// DUAL PORT ROM
module dual_port_rom #(parameter DATA_WIDTH=8, parameter ADDR_WIDTH=8)(
    output [(DATA_WIDTH-1):0] qA, qB,
    input  [(ADDR_WIDTH-1):0] addrA, addrB,
    input  clk
);
    // Declare the ROM variable
    reg [DATA_WIDTH-1:0] ROM [2**ADDR_WIDTH-1:0];

    reg [(DATA_WIDTH-1):0] regqA, regqB;
    
    assign qA = regqA;
    assign qB = regqB;

    initial
    begin
        $readmemb("rom_data.txt", ROM);
    end

    always @(posedge clk)
    begin
        regqA <= ROM[addrA];
        regqB <= ROM[addrB];
    end
endmodule

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////