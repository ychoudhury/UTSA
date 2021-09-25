`timescale 1ns / 1ps

module Subtractor_1bit(A, B, Bin, Diff, Bout);

input A, B, Bin;
output Diff, Bout;
assign Diff = (A - B - Bin);
assign Bout = ((~A & Bin) | (~A & B) | (B & Bin)); // k-map reduction of Bout based on provided truth table
endmodule

module Subtractor_4bit(.A(A), .B(B), .Bin(Bin), .Diff(Diff), .Bout(Bout));

input [3:0] A, B;
input Bin;
output wire [3:0] Diff;
output wire Bout;
wire [3:0] b; // intermediary register to hold borrow values

Subtractor_1bit S0(A[0], B[0], Bin, Diff[0], b[0]);
Subtractor_1bit S1(A[1], B[1], b[0], Diff[1], b[1]);
Subtractor_1bit S2(A[2], B[2], b[1], Diff[2], b[2]);
Subtractor_1bit S3(A[3], B[3], b[2], Diff[3], b[3]);

assign Bout = b[3];

endmodule
