`timescale 1ns / 1ps

module ALU_8(a, b, sel, c_in, out, c_out);
input wire [7:0] a, b;
input wire [2:0] sel;
input wire c_in;

output reg [7:0] out;
output c_out;
wire [7:0] SUM;

fa_8 fa_8_0(a, b, c_in, SUM[7:0], c_out);


    always@(*) begin
        case(sel)
            3'b000: out = SUM;              // add with c_in
            3'b001: out = a - b - c_in;     // sub with c_in
            3'b010: out = a | b;            // or
            3'b011: out = a & b;            // and
            3'b100: out = a << 1;           // shl
            3'b101: out = a >> 1;           // shr
            3'b110: out = {a[6:0], a[7]};   // rol
            3'b111: out = {a[0], a[7:1]};   // ror
        endcase
    end

endmodule

// test and development adder modules exist below /////////////////////////////////////////////////
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

wire c_temp; // internal wire
  
    fa_4 FA1(a[3:0], b[3:0], c_in, s[3:0], c_temp);
    fa_4 FA2(a[7:4], b[7:4], c_temp, s[7:4], c_out);
    
endmodule
