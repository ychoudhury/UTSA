`timescale 1ns / 1ps



module Memory_64byte_tb;

reg [7:0] D_IN;
reg [2:0] ADDR;
reg R_ENABLE, W_ENABLE, RESET, CLK;
wire [7:0] D_OUT;

//UUT
Memory_64byte M1(D_IN, ADDR, R_ENABLE, W_ENABLE, RESET, CLK, D_OUT);

initial begin
D_IN = 8'b00000000;
ADDR = 3'b000;
R_ENABLE = 1'b0;
W_ENABLE = 1'b0;
RESET = 1'b0;
CLK = 1'b0;
#10

ADDR = 3'b010;
W_ENABLE = 1'b1;
D_IN = 8'b11011101;
#10
W_ENABLE = 1'b0;
R_ENABLE = 1'b1;

#10;

end
always #10 CLK = ~CLK;
endmodule
