`timescale 1ns / 1ps

module Mux4to1(output [4:0] out, input [3:0] in, [1:0] sel);
     assign  out = sel[1] ? (sel[0] ? in[3] : in[2]) : (sel[0] ? in[1] : in[0]); 
     // if s1 is high, then evaluate first s0 block
     // if s1 is low, evaluate second s0 block
     // second "nested" ternary operation decides which input is high and passes
     // it along to output.
endmodule

module Mux16to1 (output [3:0] out, input [15:0] in, input [3:0] sel);
wire [4:1] k;

    Mux4to1 mux0(k[1], in[3:0], sel[1:0]);
    Mux4to1 mux1(k[2], in[7:4], sel[1:0]);
    Mux4to1 mux2(k[3], in[11:8], sel[1:0]);
    Mux4to1 mux3(k[4], in[15:12], sel[1:0]);
    Mux4to1 mux4(out, k[4:1], sel[3:2]); // overall 16to1mux output
 
endmodule
