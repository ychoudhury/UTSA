`timescale 1ns / 1ps



module cpuops(i_clk, i_reset, i_op, i_a, i_b, o_c, 

              mantissa_sum, mantissa_shift, i_a_mantissa, i_b_mantissa);

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

reg [31:0] add_result;

always @(posedge i_clk) begin

    // unpack
    i_a_sign <= i_a[31];
    i_b_sign <= i_b[31];
    
    i_a_exponent <= (i_a[30:23]);
    i_b_exponent <= (i_b[30:23]);
    
    i_a_mantissa <= {1'b1, i_a[22:0]}; // prepend implied 1 before msb of mantissa
    i_b_mantissa <= {1'b1, i_b[22:0]};
    
    // calculate mantissa
    if(i_a_exponent > i_b_exponent) begin
        mantissa_shift = (i_b_mantissa >> (i_a_exponent - i_b_exponent));
        mantissa_sum = (mantissa_shift + i_a_mantissa);
        o_c_sign <= 1'b0; // this is a temporary hard-code while we figure out exp and mantissa
        
        if(mantissa_sum[24] == 1'b1) begin
            o_c_mantissa <= (mantissa_sum << 1); //bug here
            o_c_exponent <= (i_a_exponent + 1'b1);
        end
        
        else if(mantissa_sum[24] != 1'b1) begin
            o_c_mantissa <= mantissa_sum; //bug here
            o_c_exponent <= i_a_exponent;
        end
    end

add_result = {o_c_sign, o_c_exponent, o_c_mantissa}; // packing

end


always @(posedge i_clk) begin

    casez(i_op)
    
    4'b0001: o_c = add_result[31:0];

    endcase
    

end

endmodule
