`timescale 1ns / 1ps

module Subtractor_1bit_tb;

reg A, B, Bin;
wire Diff, Bout;

//UUT
Subtractor_1bit S1(A, B, Bin, Diff, Bout);

initial begin

A = 1'b0; B = 1'b0; Bin = 1'b0;
#10 A = 1'b0; B = 1'b0; Bin = 1'b1;
#10 A = 1'b0; B = 1'b1; Bin = 1'b0;
#10 A = 1'b0; B = 1'b1; Bin = 1'b1;
#10 A = 1'b1; B = 1'b0; Bin = 1'b0;
#10 A = 1'b1; B = 1'b0; Bin = 1'b1;
#10 A = 1'b1; B = 1'b1; Bin = 1'b0;
#10 A = 1'b1; B = 1'b1; Bin = 1'b1;

end
endmodule
