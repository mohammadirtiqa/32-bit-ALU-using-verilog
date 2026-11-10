`timescale 1ns/1ps
module tb_alu_32bit;
    reg [31:0] a,b;
    reg [3:0] alu_sel;
    wire [31:0] result;
    wire zero,carry,overflow,negative;
    integer checks=0, errors=0;

    alu_32bit dut(.a(a),.b(b),.alu_sel(alu_sel),.result(result),
                  .zero(zero),.carry(carry),.overflow(overflow),.negative(negative));

    task check;
        input [31:0] expected;
        input [8*36-1:0] label;
        begin
            #1; checks=checks+1;
            if(result !== expected) begin
                errors=errors+1;
                $display("FAIL %-36s expected=%h got=%h",label,expected,result);
            end else $display("PASS %-36s result=%h",label,result);
        end
    endtask

    initial begin
        $display("32-BIT ALU VERILOG TESTBENCH");
        a=10;b=5;alu_sel=0;check(15,"ADD 10 + 5");
        a=32'hffffffff;b=1;alu_sel=0;check(0,"ADD carry wraparound");
        if(carry!==1'b1 || zero!==1'b1) errors=errors+1;
        a=20;b=7;alu_sel=1;check(13,"SUB 20 - 7");
        a=3;b=5;alu_sel=1;check(32'hfffffffe,"SUB negative result");
        if(negative!==1'b1) errors=errors+1;
        a=32'ha5a5f0f0;b=32'h0f0fff00;alu_sel=2;check(32'h0505f000,"AND");
        alu_sel=3;check(32'hafaffff0,"OR");
        alu_sel=4;check(32'haaaa0ff0,"XOR");
        alu_sel=5;check(32'h5a5a0f0f,"NOT A");
        a=1;b=4;alu_sel=6;check(32'h10,"SLL by 4");
        a=32'h80000000;b=4;alu_sel=7;check(32'h08000000,"SRL by 4");
        a=32'h80000000;b=4;alu_sel=8;check(32'hf8000000,"SRA by 4");
        a=32'hffffffff;b=1;alu_sel=9;check(1,"SLT signed -1 < 1");
        a=7;b=3;alu_sel=9;check(0,"SLT signed 7 < 3");
        a=32'h7fffffff;b=1;alu_sel=0;check(32'h80000000,"ADD signed overflow");
        if(overflow!==1'b1) errors=errors+1;
        a=32'h12345678;b=32'h87654321;alu_sel=15;check(0,"Invalid opcode");
        $display("TOTAL CHECKS: %0d | ERRORS: %0d",checks,errors);
        if(errors==0) begin
            $display("SIMULATION STATUS: ALL TESTS PASSED");
            $finish;
        end else begin
            $display("SIMULATION STATUS: FAILED");
            $fatal(1);
        end
    end
endmodule
