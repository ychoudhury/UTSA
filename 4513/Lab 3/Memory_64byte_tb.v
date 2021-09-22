`timescale 1ns / 1ps



module Memory_64byte_tb;

reg [7:0] D_IN;
reg [2:0] ADDR;
reg R_ENABLE, W_ENABLE, RESET, CLK;
wire [7:0] D_OUT;

//UUT
Memory_64byte M1(D_IN, ADDR, R_ENABLE, W_ENABLE, RESET, CLK, D_OUT);

initial begin // initially clear all memory locations
D_IN = 8'b00000000;
ADDR = 3'b000;
R_ENABLE = 1'b0;
W_ENABLE = 1'b0;
RESET = 1'b0;
CLK = 1'b0;
#10

D_IN = 8'b11011101;
ADDR = 3'b010;
RESET = 1'b0;
R_ENABLE = 1'b0;
W_ENABLE = 1'b1;
RESET = 1'b0;
#10
R_ENABLE = 1'b1;
W_ENABLE = 1'b0;

#10
D_IN = 8'b00000011;
ADDR = 3'b011;
R_ENABLE = 1'b0;
W_ENABLE = 1'b1;
RESET = 1'b0;
#10
R_ENABLE = 1'b1;
W_ENABLE = 1'b0;      

#10
D_IN = 8'b11111111;
ADDR = 3'b110;
R_ENABLE = 1'b0;
W_ENABLE = 1'b1;
RESET = 1'b1;
#10
R_ENABLE = 1'b1;
W_ENABLE = 1'b0;   

#10;

end
always #10 CLK = ~CLK;
endmodule
