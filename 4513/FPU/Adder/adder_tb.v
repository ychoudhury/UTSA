`timescale 1ns / 1ps

module adder_tb;

reg [31:0] input_a;
reg [31:0] input_b;
wire [31:0] output_z;
reg clk, rst;
reg input_a_stb, input_b_stb, output_z_ack;

//UUT
adder A1(input_a,
        input_b,
        input_a_stb,
        input_b_stb,
        output_z_ack,
        clk,
        rst,
        output_z,
        output_z_stb,
        input_a_ack,
        input_b_ack
);
        
initial begin
input_a <= 32'b0;
input_b <= 32'b0;
clk <= 1'b0;
rst <= 1'b0;
input_a_stb <= 1'b1;
input_b_stb <= 1'b1;
output_z_ack <= 1'b1;
end
         
always #10 clk = ~clk;

initial begin
//#10
//input_a <= 32'b01000001011111000000000000000000; // 15.75
//input_b <= 32'b01000000111010000000000000000000; // 7.25
//rst <= 0;

//#10
//input_a <= 32'b01000001011111000000000000000000; // 15.75
//input_b <= 32'b01000000111010000000000000000000; // 7.25
//rst <= 1;

#10
input_a <= 32'b01000001011111000000000000000000; // 15.75
input_b <= 32'b01000000111010000000000000000000; // 7.25
rst <= 0;
end

endmodule
