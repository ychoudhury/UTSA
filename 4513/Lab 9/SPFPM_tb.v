`timescale 1ns / 1ps

module multiplier_tb;

reg [31:0] A, B;
reg reset;
wire [31:0] out;

//UUT
multiplier M1(A,B, reset, out);

initial begin
reset = 1'b0;
A = 32'b00000000000000000000000000000000;
B = 32'b00000000000000000000000000000000;
end

initial begin
#20
reset = 1'b0;
A = 32'b00000000000000000000000000000000; // 0
B = 32'b00000000000000000000000000000000; // 0
// expecting 0

#20
reset = 1'b0;
A = 32'b11000001111100000000000000000000; // -30
B = 32'b01000000010000000000000000000000; // 3
// expecting -90

#20
reset = 1'b1;
A = 32'b01000010010010000000000000000000; //50
B = 32'b01000000010000000000000000000000; // 3
// expecting 0 (reset)

#20
reset = 1'b0;
A = 32'b01000010010010000000000000000000; //50
B = 32'b01000000010000000000000000000000; // 3
// expecting 150

#20
reset = 1'b0;
A = 32'b00111111000000000000000000000000; //+0.5
B = 32'b10111110100011100001010001111011; //-0.2775
// expecting -0.13875

#20
reset = 1'b0;
A = 32'b01000000111100000000000000000000; // 7.5
B = 32'b01000001011110000000000000000000; // 15.5
// expecting 116.25

#20
reset = 1'b0;
A = 32'b11000001011010000000000000000000; // -14.5
B = 32'b10111110110000000000000000000000; // -0.375
// expecting 5.4375
end

endmodule