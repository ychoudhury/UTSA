`timescale 1ns / 1ps

module Subtractor_4bit_tb;

reg [3:0] A, B;
reg Bin;
wire [3:0] Diff;
wire Bout;
integer i;

//UUT
Subtractor_4bit S1(A, B, Bin, Diff, Bout);

initial begin
A = 4'b0000;
B = 4'b0000;
Bin = 1'b0;
end

initial begin
for(i = 0; i < 100; i = i + 1) begin
#10
A = $random;
B = $random;
Bin = $random;
end


end
endmodule
