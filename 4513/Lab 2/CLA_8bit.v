`timescale 1ns / 1ps

module CLA_GP(G, P, A, B); // Partial Full Adder that outputs Generate and Propogate signals
output wire G, P;
input A, B;

    assign G = (A & B);
    assign P = (A ^ B);
    
endmodule

module PFA_1bit(S, G, P, A, B, Cin); // Partial Full Adder that generates Sum
output wire S, G, P;                 
input A, B, Cin;
    
    assign S = (A ^ B ^ Cin);
    CLA_GP GP1(.G (G), .P (P), .A (A), .B (B)); // Instantiate generate-propagate module and pass along results
    
endmodule

module CLA_4bit(.S (S), .G (G), .P (P), .Cout (Cout), .A (A), .B (B), .Cin (Cin)); // port connection by name instead of by order
output wire [3:0] S, G, P;
output wire [3:0] Cout;
input [3:0] A, B;
input Cin;

    PFA_1bit PFA0(S[0], G[0], P[0], A[0], B[0], Cin); // PFA 1_bit instantiation
    assign Cout[0] = (G[0] | (P[0] & Cin)); // Couts are now generated based on G, P, and Cin

    PFA_1bit PFA1(S[1], G[1], P[1], A[1], B[1], Cout[0]);
    assign Cout[1] = (G[1] | (P[1] & G[0]) | (P[1] & P[0] & Cin));
    
    PFA_1bit PFA2(S[2], G[2], P[2], A[2], B[2], Cout[1]);
    assign Cout[2] = (G[2] | (P[2] & G[1]) | (P[2] & P[1] & G[0]) | (P[2] & P[1] & P[0] & Cin));
    
    PFA_1bit PFA3(S[3], G[3], P[3], A[3], B[3], Cout[2]);
    assign Cout[3] = (G[3] | (P[3] & G[2]) | (P[3] & P[2] & G[1]) | (P[3] & P[2] & P[1] & G[0]) | (P[3] & P[2] & P[1] & P[0] & Cin));
    
    // Cout will be 4 bit wide wire because this is not the final module. Therefore, expect Cout to be larger than one bit
    
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
