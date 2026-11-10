`timescale 1ns/1ps
module alu_32bit (
    input wire [31:0] a, b,
    input wire [3:0] alu_sel,
    output reg [31:0] result,
    output wire zero,
    output reg carry, overflow,
    output wire negative
);
    localparam ADD=4'h0, SUB=4'h1, AND_OP=4'h2, OR_OP=4'h3,
               XOR_OP=4'h4, NOT_OP=4'h5, SLL=4'h6, SRL=4'h7,
               SRA=4'h8, SLT=4'h9;
    reg [32:0] ext;
    always @* begin
        result=32'b0; carry=1'b0; overflow=1'b0; ext=33'b0;
        case (alu_sel)
            ADD: begin
                ext={1'b0,a}+{1'b0,b}; result=ext[31:0]; carry=ext[32];
                overflow=(~(a[31]^b[31])) & (result[31]^a[31]);
            end
            SUB: begin
                ext={1'b0,a}+{1'b0,~b}+33'd1; result=ext[31:0]; carry=ext[32];
                overflow=(a[31]^b[31]) & (result[31]^a[31]);
            end
            AND_OP: result=a&b;
            OR_OP:  result=a|b;
            XOR_OP: result=a^b;
            NOT_OP: result=~a;
            SLL: result=a<<b[4:0];
            SRL: result=a>>b[4:0];
            SRA: result=$signed(a)>>>b[4:0];
            SLT: result=($signed(a)<$signed(b)) ? 32'd1 : 32'd0;
            default: result=32'b0;
        endcase
    end
    assign zero=(result==32'b0);
    assign negative=result[31];
endmodule
