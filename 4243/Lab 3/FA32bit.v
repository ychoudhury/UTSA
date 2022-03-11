`timescale 1ns / 1ps

module fa_1(a, b, c_in, s, c_out);
input wire a, b, c_in;
output reg s, c_out;

    always@(*) begin   
        s = (a ^ b ^ c_in);
        c_out = (a & b) | (a ^ b) & c_in;       
    end
    
endmodule

module fa_4(a, b, c_in, s, c_out);
input wire [3:0] a;
input wire [3:0] b;
input wire c_in;

output wire [3:0] s;
output wire c_out;

wire [2:0] c_temp;
    
    fa_1 FA1(a[0], b[0], c_in, s[0], c_temp[0]);
    fa_1 FA2(a[1], b[1], c_temp[0], s[1], c_temp[1]);
    fa_1 FA3(a[2], b[2], c_temp[1], s[2], c_temp[2]);
    fa_1 FA4(a[3], b[3], c_temp[2], s[3], c_out);
    
endmodule

module fa_8(a, b, c_in, s, c_out);
input wire [7:0] a;
input wire [7:0] b;
input wire c_in;

output wire [7:0] s;
output wire c_out;

wire c_temp;
    
    fa_4 FA1(a[3:0], b[3:0], c_in, s[3:0], c_temp);
    fa_4 FA2(a[7:4], b[7:4], c_temp, s[7:4], c_out);
    
endmodule

module fa_32(a, b, c_in, s, c_out);
input wire [31:0] a;
input wire [31:0] b;
input wire c_in;

output wire [31:0] s;
output wire c_out;

wire [2:0] c_temp;
    
    fa_8 FA1(a[7:0], b[7:0], c_in, s[7:0], c_temp[0]);
    fa_8 FA2(a[15:8], b[15:8], c_temp[0], s[15:8], c_temp[1]);
    fa_8 FA3(a[23:16], b[23:16], c_temp[1], s[23:16], c_temp[2]);
    fa_8 FA4(a[31:24], b[31:24], c_temp[2], s[31:24], c_out);
    
endmodule
