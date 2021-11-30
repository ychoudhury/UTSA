`timescale 1ns / 1ps

module subtractor_tb;

reg [31:0] input_a;
reg [31:0] input_b;
wire [31:0] output_z;
reg clk;
reg rst;
reg start;
reg ack_output;
wire idle_status;
wire output_valid;

//UUT
subtractor S1(input_a, input_b, start, ack_output, clk, rst, output_z, output_valid, idle_status);
        
initial begin
input_a <= 32'b0;
input_b <= 32'b0;
clk <= 1'b0;
rst <= 1'b0;
ack_output <= 1'b1;
start <= 1'd1;
end
         
always #10 clk = ~clk;

initial begin

#50
input_a <= 32'b01000011001111101001010111000011; // 190.585
input_b <= 32'b01000000111010000000000000000000; // 7.25
rst <= 0;
end

endmodule
