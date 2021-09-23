`timescale 1ns / 1ps



module Memory_64byte_tb;

reg [63:0] D_IN;
reg [2:0] ADDR;
reg R_ENABLE, W_ENABLE, RESET, CLK;
wire [63:0] D_OUT;

//UUT
Memory_64byte M1(D_IN, ADDR, R_ENABLE, W_ENABLE, RESET, CLK, D_OUT);

// initially set all control values to 0
initial begin 
D_IN = 16'h0000000000000000;
ADDR = 3'b000;
R_ENABLE = 1'b0;
W_ENABLE = 1'b0;
RESET = 1'b0;
CLK = 1'b0;
end

always #10 CLK = ~CLK;

initial begin

#10
D_IN = 8'b00000001;
ADDR = 3'b000;
R_ENABLE = 1'b0;
W_ENABLE = 1'b1;
RESET = 1'b0;

#20
D_IN = 8'b00000001;
ADDR = 3'b000;
R_ENABLE = 1'b1;
W_ENABLE = 1'b0;
RESET = 1'b0;

#20
D_IN = 8'b00000001;
ADDR = 3'b000;
R_ENABLE = 1'b1;
W_ENABLE = 1'b1;
RESET = 1'b0;

#20
D_IN = 8'b00000001;
ADDR = 3'b000;
R_ENABLE = 1'b1;
W_ENABLE = 1'b0;
RESET = 1'b1;

//

#20
D_IN = 8'b00000010;
ADDR = 3'b000;
R_ENABLE = 1'b0;
W_ENABLE = 1'b1;
RESET = 1'b0;

#20
D_IN = 8'b00000010;
ADDR = 3'b000;
R_ENABLE = 1'b1;
W_ENABLE = 1'b0;
RESET = 1'b0;

#20
D_IN = 8'b00000010;
ADDR = 3'b000;
R_ENABLE = 1'b1;
W_ENABLE = 1'b1;
RESET = 1'b0;

#20
D_IN = 8'b00000010;
ADDR = 3'b000;
R_ENABLE = 1'b1;
W_ENABLE = 1'b0;
RESET = 1'b0;

end

endmodule
