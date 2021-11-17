`timescale 1ns / 1ps

// This multiplier uses the IEEE 754 single precision floating point standard.
// This program takes two 32-bit representations of floating bit numbers and multiplies them together.

module multiplier(A, B, reset, out);

input [31:0] A, B;
input reset = 1'b0;
output [31:0] out;

// define components of Single Precision Floating Point
reg A_sign;
reg [7:0] A_exponent;
reg [23:0] A_mantissa;

reg B_sign;
reg [7:0] B_exponent;
reg [23:0] B_mantissa;

reg out_sign;
reg [7:0] out_exponent;
reg [23:0] out_mantissa;


reg isNormal = 1'b0;
reg [47:0] mantissaMultiplicand;
reg [22:0] mantissaNormalised = 23'b0;

reg [31:0] outputReg = 32'b0;
integer i;


always @(*) begin

    if(reset == 1) begin // reset flag
        outputReg <= 32'b00000000000000000000000000000000;
    end
    
    else if(A == 0 || B == 0) begin // early out
        outputReg <= 32'b00000000000000000000000000000000;
    end

    else begin
        A_mantissa = {1'b1, A[22:0]};
        B_mantissa = {1'b1, B[22:0]}; 
    
        mantissaNormalised = 23'b0;
        
        A_exponent = A[30:23];
        B_exponent = B[30:23];
        
        A_sign = A[31];
        B_sign = B[31];
        
        isNormal = 1'b0;
        
        mantissaMultiplicand = (A_mantissa * B_mantissa);
                
        if(mantissaMultiplicand & (1 << 47)) begin      
            out_exponent = (A_exponent + B_exponent - 126);        
        end
        
        else begin
            out_exponent = (A_exponent + B_exponent - 127);
        end
                        // up until here we're good

        for(i = 47; i > 0; i = i - 1) begin
            if(isNormal == 1'b0) begin
                if(mantissaMultiplicand[i]) begin
                    mantissaNormalised = mantissaNormalised | {mantissaMultiplicand >> (i-23)};
                    isNormal = 1'b1;
                end
            end    
        end
        
        out_sign = A_sign ^ B_sign;
        
        outputReg = {out_sign, out_exponent, mantissaNormalised};
        
    end
    
end
                
assign out = outputReg;
    
        
endmodule
