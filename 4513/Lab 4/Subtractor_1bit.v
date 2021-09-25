`timescale 1ns / 1ps

module Subtractor_1bit(A, B, Bin, Diff, Bout);

input A, B, Bin;
output Diff, Bout;
assign Diff = (A - B - Bin);
assign Bout = ((~A & Bin) | (~A & B) | (B & Bin)); // k-map reduction of Bout based on provided truth table
endmodule
