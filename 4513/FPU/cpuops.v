`timescale 1ns / 1ps


module cpuops(i_clk, i_reset, i_op, i_a, i_b, o_c);

input wire i_clk, i_reset;
input wire [3:0] i_op;
input wire [31:0] i_a, i_b;
output reg [31:0] o_c;

// decompose inputs
reg [0:0] i_a_sign;
reg [0:0] i_b_sign;
reg [0:0] o_c_sign;

reg [7:0] i_a_exponent;
reg [7:0] i_b_exponent;
reg [7:0] o_c_exponent;

reg [23:0] i_a_mantissa;
reg [23:0] i_b_mantissa;
reg [22:0] o_c_mantissa;

reg [31:0] add_result;

// FPU adder pre-logic
always @(posedge i_clk) begin
    
    i_a_sign <= i_a[31];
    i_b_sign <= i_b[31];
    
    i_a_exponent <= (i_a[30:23] - 127); // subtracting bias from exponent
    i_b_exponent <= (i_b[30:23] - 127);
    
    i_a_mantissa <= {1'b1, i_a[22:0]}; // prepend implied 1 before msb of mantissa
    i_b_mantissa <= {1'b1, i_b[22:0]};
    
    
/////////// start basic hardcoded stuff////////////////       

     // reset
    if(i_reset) begin
        assign o_c_sign = 0;
        assign o_c_exponent = 0;
        assign o_c_mantissa = 0;
    end   
    
     // both 0s
    else if(i_a == 0 && i_b == 0) begin
        assign o_c_sign = 0;
        assign o_c_exponent = 0;
        assign o_c_mantissa = 0;
    end

     // a = 0
    else if(i_a == 0 && i_b != 0) begin
        assign o_c_sign = i_b_sign;
        assign o_c_exponent = i_b_exponent + 127;
        assign o_c_mantissa = i_b_mantissa;
    end
    
    // b = 0
    else if(i_b == 0 && i_a != 0) begin
        assign o_c_sign = i_a_sign;
        assign o_c_exponent = i_a_exponent + 127;
        assign o_c_mantissa = i_a_mantissa;
    end
    
/////////// end basic hardcoded stuff////////////////    
   
     
    // align exponents
    else if(i_a_exponent > i_b_exponent) begin
        i_b_exponent <= i_b_exponent + 1;
        i_b_mantissa <= i_b_mantissa >> 1;
        i_b_mantissa[0] <= (i_b_mantissa[0] | i_b_mantissa[1]);       
    end 
    
    else if (i_a_exponent < i_b_exponent) begin
        i_a_exponent <= i_a_exponent + 1;
        i_a_mantissa <= i_a_mantissa >> 1;
        i_a_mantissa[0] <= (i_a_mantissa[0] | i_a_mantissa[1]);
    end
    
    else begin
        o_c_exponent <= i_a_exponent; // not sure on this one - taken from dawsonjon line 176
        if(i_a_sign == i_b_sign) begin
            o_c_mantissa <= i_a_mantissa + i_b_mantissa;
            o_c_sign <= i_a_sign;
        end
    
        else begin
            if(i_a_mantissa >= i_b_mantissa) begin
                o_c_mantissa <= i_a_mantissa - i_b_mantissa;
                o_c_sign <= i_b_sign;
            end
            
            else begin
                o_c_mantissa <= i_b_mantissa - i_a_mantissa;
                o_c_sign <= i_b_sign;            
            end
        end
    end
    

    add_result[31:0] = {o_c_sign, o_c_exponent, o_c_mantissa}; // packing
    
   end

always @(posedge i_clk) begin

    casez(i_op)
    
//    4'b0001: o_c <= i_a | i_b;

// this is how to use the pre-logic result in the ALU
    4'b0001: o_c <= add_result[31:0];
    
    endcase
    

end

endmodule
