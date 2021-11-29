`timescale 1ns / 1ps



module cpuops(i_clk, i_reset, i_op, i_a, i_b, o_c,

              mantissa_sum, mantissa_shift, i_a_mantissa, i_b_mantissa, count);

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

output reg [23:0] i_a_mantissa; // 24-bits wide to hold implied 1 (added later)
output reg [23:0] i_b_mantissa;
reg [22:0] o_c_mantissa;

output reg [24:0] mantissa_sum;
output reg [23:0] mantissa_shift;
output reg [23:0] count;

reg [31:0] add_result;

reg isNormal = 1'b0;
integer i;

always @(posedge i_clk) begin

    // unpack
    i_a_sign <= i_a[31];
    i_b_sign <= i_b[31];
    
    i_a_exponent <= (i_a[30:23]);
    i_b_exponent <= (i_b[30:23]);
    
    i_a_mantissa <= {1'b1, i_a[22:0]}; // prepend implied 1 before msb of mantissa
    i_b_mantissa <= {1'b1, i_b[22:0]};
    
    
    // initialize mantissa registers
    mantissa_shift <= 24'b0;
    mantissa_sum <= 25'b0;
    count <= 24'b0;
    isNormal <= 1'b0; // flag
    
    // a exponent > b exponent
    if(i_a_exponent > i_b_exponent) begin
    
        // add aligned mantissas together
        mantissa_shift = (i_b_mantissa >> (i_a_exponent - i_b_exponent));
        mantissa_sum = (mantissa_shift + i_a_mantissa);
        
        // normalize mantissas
        for(i = 24; i > 0; i = i - 1) begin   
            if(isNormal == 1'b0) begin
                if(mantissa_sum[i] == 0) begin
                    count = (count + 1);
                end
            end  
        isNormal = 1'b1;
        end
        
        o_c_sign = 1'b0; // this is a temporary hard-code while we figure out exp and mantissa 
        o_c_exponent = (i_a_exponent >> count);
        o_c_mantissa = (mantissa_sum << count);
    end
    
    // b exponent > a exponent
    else if(i_a_exponent < i_b_exponent) begin
        mantissa_shift = (i_a_mantissa >> (i_b_exponent - i_a_exponent));
        mantissa_sum = (mantissa_shift + i_b_mantissa);
    
        for(i = 24; i > 0; i = i - 1) begin   
            if(isNormal == 1'b0) begin
                if(mantissa_sum[i] == 0) begin
                    count = (count + 1);
                end
            end   
        isNormal = 1'b1;
        end
        
        o_c_sign = 1'b0; // this is a temporary hard-code while we figure out exp and mantissa 
        o_c_exponent = (i_b_exponent >> count);
        o_c_mantissa = (mantissa_sum << count);                     
    end
    
    // same exponents: no mantissa shift needed
    else if(i_a_exponent == i_b_exponent) begin
        mantissa_sum <= (i_a_mantissa + i_b_mantissa);
     
        for(i = 24; i > 0; i = i - 1) begin 
            if(mantissa_sum[i] == 0) begin
                count = (count + 1);
            end
        isNormal = 25 - count;
        end
        
        o_c_sign = 1'b0;
        o_c_exponent = i_a_exponent + isNormal;
        o_c_mantissa = mantissa_sum << isNormal;
    end
    
    else begin
        $display("Error: Unreachable condition");
    end

// pack the final result
add_result = {o_c_sign, o_c_exponent, o_c_mantissa}; 

end

always @(posedge i_clk) begin

    casez(i_op)
    4'b0001: o_c <= add_result[31:0];
    endcase
    
end

endmodule
