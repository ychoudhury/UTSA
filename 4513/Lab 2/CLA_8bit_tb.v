`timescale 1ns / 1ps


//module CLA_GP_tb;
//reg A = 0;
//reg B = 0;
//wire G, P;

////UUT
//CLA_GP CLA1(G, P, A, B);

//initial begin
//A = 1'b0; B = 1'b0; // G = 0, P = 0
//#30
//A = 1'b0; B = 1'b1; // G = 0 , P = 1
//#30
//A = 1'b1; B = 1'b0; // G = 0, P = 1
//#30
//A = 1'b1; B = 1'b1; // G = 1, P = 0
//end
//endmodule

//module PFA_tb;
//reg A = 0;
//reg B = 0;
//reg Cin;
//wire S;

////UUT
//PFA_1bit PFA(G, P, S, A, B, Cin);

//initial begin
//A = 1'b0; B = 1'b0; Cin = 1'b1; // G = 0, P = 0, S = 1
//#30
//A = 1'b0; B = 1'b1; Cin = 1'b0; // G = 0 , P = 1, S = 1
//#30
//A = 1'b0; B = 1'b1; Cin = 1'b1; // G = 1, P = 0, S = 1;
//#30
//A = 1'b1; B = 1'b1; Cin = 1'b1; // G = 1, P = 0, S = 1;
//end
//endmodule



//module CLA_4bit_tb;
//reg [3:0] A = 0;
//reg [3:0] B = 0;
//reg Cin;
//wire [3:0] S;
//wire [3:0] Cout;

////UUT
//CLA_4bit CLA1(S, G, P, Cout, A, B, Cin);

//initial begin
//    A=4'b1000; B=4'b0001; Cin=1'b1;
    
//    #30 A=4'b0001; B=4'b0001; Cin=1'b0;
   
//    #30 A=4'b1000; B=4'b0001; Cin=1'b1;
    
//    #30 A=4'b1100; B=4'b0001; Cin=1'b0;
    
//    #30 A=4'b1000; B=4'b0001; Cin=1'b0;
    
//    #30 A=4'b0000; B=4'b0000; Cin=1'b1;
   
//    #30 A=4'b1000; B=4'b0010; Cin=1'b1;
    
//    #30 A=4'b1111; B=4'b0000; Cin=1'b1;
//end
//endmodule

module CLA_8bit_tb;
reg [7:0] A = 0;
reg [7:0] B = 0;
reg Cin;
wire [7:0] S;
wire Cout;

//UUT
CLA_8bit CLA1(S, G, P, Cout, A, B, Cin);

initial begin

A=8'b00001000; B=8'b00000001; Cin=1'b1;
#30 A=8'b00000001; B=8'b00000001; Cin=1'b0;
#30 A=8'b10011000; B=8'b10000001; Cin=1'b1;
#30 A=8'b10101010; B=8'b01000001; Cin=1'b0;
#30 A=8'b10001000; B=8'b00100001; Cin=1'b0;
#30 A=8'b00101000; B=8'b00010000; Cin=1'b1;
#30 A=8'b00001000; B=8'b00000010; Cin=1'b1;

end
endmodule
