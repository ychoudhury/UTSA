`timescale 1ns / 1ps

module ALU_4bit_tb;

reg [3:0] A, B;
reg [2:0] Control;
reg Cin;
wire [3:0] ALU_output;
wire Cout;
reg [3:0] r;
reg c;
integer i;

//UUT
ALU_4bit ALU1(A, B, Control, Cin, ALU_output, Cout); 

initial begin

A = 4'b0000; 
B = 4'b0000; 
Control = 3'b000;
Cin = 1'b0;
r = 4'b0000;
c = 1'b0;
end

initial begin

Control = 3'b000;
for(i = 0; i < 1; i = i + 1) begin
#5
A = $random;
B = $random;
Cin = $random;
end

#10
Control = 3'b001;
for(i = 0; i < 1; i = i + 1) begin
#5
A = $random;
B = $random;
Cin = $random;
end

#10
Control = 3'b010;
for(i = 0; i < 1; i = i + 1) begin
#5
A = $random;
B = $random;
Cin = 1'b0;
end

#10
Control = 3'b011;
for(i = 0; i < 1; i = i + 1) begin
#5
A = $random;
B = $random;
Cin = 1'b0;
end

#10
Control = 3'b100;
for(i = 0; i < 1; i = i + 1) begin
#5
A = $random;
B = 4'b000;
Cin = 1'b0;
end

#10
Control = 3'b101;
for(i = 0; i < 1; i = i + 1) begin
#5
A = $random;
B = 4'b000;
Cin = 1'b0;
end

#10
Control = 3'b110;
for(i = 0; i < 1; i = i + 1) begin
#5
A = $random;
B = 4'b0000;
Cin = 1'b0;
end

#10
Control = 3'b111;
for(i = 0; i < 1; i = i + 1) begin
#5
A = $random;
B = 4'b0000;
Cin = 1'b0;
end

end
endmodule
