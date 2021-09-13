`timescale 1ns / 1ps

module PFA_1bit(S, G, P, A, B, Cin); // Partial Full Adder that generates Generate and Propogate signals
output wire S, G, P;

input A, B, Cin;

    assign G = (A & B);
    assign P = (A ^ B);
    assign S = (A ^ B ^ Cin);
    
endmodule

module CLA_4bit(.S (S), .G (G), .P (P), .Cout (Cout), .A (A), .B (B), .Cin (Cin));
output wire [3:0] S, G, P;
output wire [3:0] Cout;
input [3:0] A, B;
input Cin;

    PFA_1bit PFA0(S[0], G[0], P[0], A[0], B[0], Cin);
    assign Cout[0] = (G[0] | (P[0] & Cin));

    PFA_1bit PFA1(S[1], G[1], P[1], A[1], B[1], Cout[0]);
    assign Cout[1] = (G[1] | (P[1] & G[0]) | (P[1] & P[0] & Cin));
    
    PFA_1bit PFA2(S[2], G[2], P[2], A[2], B[2], Cout[1]);
    assign Cout[2] = (G[2] | (P[2] & G[1]) | (P[2] & P[1] & G[0]) | (P[2] & P[1] & P[0] & Cin));
    
    PFA_1bit PFA3(S[3], G[3], P[3], A[3], B[3], Cout[2]);
    assign Cout[3] = (G[3] | (P[3] & G[2]) | (P[3] & P[2] & G[1]) | (P[3] & P[2] & P[1] & G[0]) | (P[3] & P[2] & P[1] & P[0] & Cin));
    
endmodule

module CLA_8bit(.S (S), .G (G), .P (P), .Cout (Cout), .A (A), .B (B), .Cin (Cin)); // port connection by name instead of by order
output wire [7:0] S;
output wire G, P, Cout;
input [7:0] A, B;
input Cin;
wire [7:0] g, p, c;

    CLA_4bit CLA1(S[3:0], g[3:0], p[3:0], c[3:0], A[3:0], B[3:0], Cin);
    CLA_4bit CLA2(S[7:4], g[7:4], p[7:4], c[7:4], A[7:4], B[7:4], c[3]);

// take MSB (bit 7) as actual output from adder circuit -> All other p,g, and cout are intermediary and do not matter
assign P = p[7];
assign G = g[7];
assign Cout = c[7];

endmodule
