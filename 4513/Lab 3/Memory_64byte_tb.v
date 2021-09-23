`timescale 1ns / 1ps



module Memory_64byte_tb;

reg [7:0] D_IN;
reg [63:0] ADDR;
reg R_ENABLE, W_ENABLE, RESET, CLK;
wire [7:0] D_OUT;

//UUT
Memory_64byte M1(D_IN, ADDR, R_ENABLE, W_ENABLE, RESET, CLK, D_OUT);

// initialize all control values to 0
initial begin 
D_IN = 8'b00000000;
ADDR = 'd0;
R_ENABLE = 1'b0;
W_ENABLE = 1'b0;
RESET = 1'b0;
CLK = 1'b0;
end

always #10 CLK = ~CLK;

initial begin
// write 1 to address 0
// should expect high Z output because we are not reading anything
#10
D_IN = 8'b00000001;
ADDR = 'd0;
R_ENABLE = 1'b0;
W_ENABLE = 1'b1; 
RESET = 1'b0;

// read output of address 0
//should expect 1 from previous statements
#20
D_IN = 8'b00000001;
ADDR = 'd0;
R_ENABLE = 1'b1;
W_ENABLE = 1'b0;
RESET = 1'b0;

// enable read and write at the same time
// read should prioritize based on module logic
#20
D_IN = 8'b00000001;
ADDR = 'd0;
R_ENABLE = 1'b1;
W_ENABLE = 1'b1;
RESET = 1'b0;

// enable reset
// output should be 0
#20
D_IN = 8'b00000001;
ADDR = 'd0;
R_ENABLE = 1'b1;
W_ENABLE = 1'b1;
RESET = 1'b1;

// same as previous code with binary 2 input into address dec 50
#20
D_IN = 8'b00000010;
ADDR = 'd50;
R_ENABLE = 1'b0;
W_ENABLE = 1'b1;
RESET = 1'b0;

#20
D_IN = 8'b00000010;
ADDR = 'd50;
R_ENABLE = 1'b1;
W_ENABLE = 1'b0;
RESET = 1'b0;

#20
D_IN = 8'b00000010;
ADDR = 'd50;
R_ENABLE = 1'b1;
W_ENABLE = 1'b1;
RESET = 1'b0;

#20
D_IN = 8'b00000010;
ADDR = 'd0;
R_ENABLE = 1'b1;
W_ENABLE = 1'b1;
RESET = 1'b1;
 
// read and write to memory address outside of 64 byte range
// should expect high-Z impedance
#20
D_IN = 8'b00000010;
ADDR = 'd70;
R_ENABLE = 1'b1;
W_ENABLE = 1'b1;
RESET = 1'b0;

#20
D_IN = 8'b00000010;
ADDR = 'd70;
R_ENABLE = 1'b1;
W_ENABLE = 1'b0;
RESET = 1'b0;


end

endmodule
