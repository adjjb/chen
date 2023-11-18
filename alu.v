`include "add.v"
`include "mul.v"

module alu(
    input [15:0] a,
    input [15:0] b,
    input [1:0] op,
    input clk,
    output reg [15:0] result
);

    wire [15:0] add_res;
    wire [15:0] mul_res;
    
    add add_0(.a(a), .b(b), .result(add_res));
    mul mul_0(.a(a), .b(b), .result(mul_res));
    


    always @(*) begin
        case (op)
            2'b01: result = add_res; // Addition with zero padding
            2'b10: result = mul_res;          // Multiplication
            default: result = 16'b0;             // Default case, can be modified as needed
        endcase
    end


 endmodule