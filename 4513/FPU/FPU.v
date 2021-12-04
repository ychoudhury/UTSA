`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/30/2021 12:41:47 PM
// Design Name: 
// Module Name: fpu
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////
module fpu(i_clk, i_reset, i_start, i_operation, i_a, i_b,
		o_busy, o_valid, o_err, o_output, o_flags);
	input	wire		i_clk, i_reset;
	// Input parameters
	input	wire		i_start;
	input   wire [2:0]        i_operation;
	input	wire [31:0]	i_a, i_b;
	
	// Output parameters
	output	reg		o_busy = 1'b0;
	output reg o_valid = 1'b0;
	output reg o_err = 1'b0;
	output	reg [31:0]	o_output = 32'd0;
	output	reg	[3:0]	o_flags = 4'd0;
	
	reg       [3:0] state = 4'd0;
    
    //assign o_state = state;
    parameter   idle          = 4'd0,
                set_inputs    = 4'd1,
                reset_module        = 4'd2,
                reset_module_2       = 4'd3,
                start_operation         = 4'd4,
                wait_completion         =4'd5,
                stop_operation          =4'd6,
                ack_result              =4'd7,
                set_output_ready_high   =4'd8,
                clear_output_valid      =4'd9,
                resettingReg            =4'd10;
                

	
	reg [31:0] modules_a [7:0];
	reg [31:0] modules_b [7:0];
	reg [7:0] modules_reset;
	reg [7:0] modules_start;
	reg [7:0] modules_ack;

	wire [31:0] w_modules_output[7:0];
	wire [7:0] w_modules_output_ready;
	wire [7:0] w_modules_idle;
	

	
    adder instantiation_name0(modules_a[0], modules_b[0],
        modules_start[0],
        modules_ack[0],
        i_clk,
        modules_reset[0],
        w_modules_output[0],
        w_modules_output_ready[0],
        w_modules_idle[0]);
    subtractor instantiation_name1(modules_a[1], modules_b[1],
        modules_start[1],
        modules_ack[1],
        i_clk,
        modules_reset[1],
        w_modules_output[1],
        w_modules_output_ready[1],
        w_modules_idle[1]);
    FPI2F instantiation_name2(modules_a[2],
        modules_start[2],
        modules_ack[2],
        i_clk,
        modules_reset[2],
        w_modules_output[2],
        w_modules_output_ready[2],
        w_modules_idle[2]);
    FPF2I instantiation_name3(modules_a[3],
        modules_start[3],
        modules_ack[3],
        i_clk,
        modules_reset[3],
        w_modules_output[3],
        w_modules_output_ready[3],
        w_modules_idle[3]);
   FPDIV instantiation_name4(modules_a[4], modules_b[4],
        modules_start[4],
        modules_ack[4],
        i_clk,
        modules_reset[4],
        w_modules_output[4],
        w_modules_output_ready[4],
        w_modules_idle[4]);
    FPMPY instantiation_name5(modules_a[5],modules_b[5],
        modules_start[5],
        modules_ack[5],
        i_clk,
        modules_reset[5],
        w_modules_output[5],
        w_modules_output_ready[5],
        w_modules_idle[5]);
    FPI2F instantiation_name6(modules_a[6],
        modules_start[6],
        modules_ack[6],
        i_clk,
        modules_reset[6],
        w_modules_output[6],
        w_modules_output_ready[6],
        w_modules_idle[6]);
    FPF2I instantiation_name7(modules_a[7],
        modules_start[7],
        modules_ack[7],
        i_clk,
        modules_reset[7],
        w_modules_output[7],
        w_modules_output_ready[7],
        w_modules_idle[7]);
        
	//State machine:
	reg [2:0] tempReg;
	always @(posedge i_clk)
    begin

        case(state)
            
            idle:
              begin
                if(i_start) begin //add s_input_a_ack also
                   
                   
                    o_busy <= 1'b1;
                    state <= set_inputs;
                end
            end
            set_inputs:
              begin
                    modules_a[i_operation] <= i_a;
                    modules_b[i_operation] <= i_b;
                    modules_start[i_operation] <= 1'b0;
                    modules_ack[i_operation] <= 1'b0;
                    state <= reset_module;
            end
            
            reset_module:
            begin
                modules_reset[i_operation] <= 1'b1;
                state <= reset_module_2;
            end
            reset_module_2:
            begin
                state <= start_operation;
            end
            start_operation:
            begin
                modules_reset[i_operation] <= 1'b0; //stop reset flag
                if(w_modules_idle[i_operation] == 1'b1) begin
                    modules_start[i_operation] <= 1'b1;
                    state <= wait_completion;
                end
            end
            wait_completion:
            begin
                if(w_modules_output_ready[i_operation] == 1'b1) begin
                    o_output <= w_modules_output[i_operation];
                    state <= stop_operation;
                end
                
            end
            stop_operation:
            begin
                modules_start[i_operation] <= 1'b0;
                
                state <= ack_result;
            end
            ack_result:
            begin
                modules_ack[i_operation] <= 1'b1;
                state <= set_output_ready_high;
            end
            set_output_ready_high:
            begin
                if(w_modules_output_ready[i_operation] == 1'b0) begin
                    modules_ack[i_operation] <= 1'b0;
                    o_busy <= 1'b0;
                    o_valid <= 1'b1;
                    state <= clear_output_valid;
                end
                
            end
            clear_output_valid:
            begin
                
               
                o_valid <= 1'b0;
                state <= idle;
                
            end
            default: begin
            end
        endcase
        if (i_reset == 1'b1) begin
          state <= idle;
          o_busy <= 1'b0;
          o_valid <= 1'b0;
          tempReg <= 3'd0;
          modules_reset[0] <= 1'b1;
          modules_reset[1] <= 1'b1;
          modules_reset[2] <= 1'b1;
          modules_reset[3] <= 1'b1;
          modules_reset[4] <= 1'b1;
          modules_reset[5] <= 1'b1;
          modules_reset[6] <= 1'b1;
          modules_reset[7] <= 1'b1;
          modules_start <= 8'd0;
          modules_ack <= 8'd0;
        end
    end
endmodule










module FPF2I(input_a, start, ack_output, clk, rst, output_z, output_valid, idle_status);

  input  wire   [31:0] input_a;
  input  wire   start;
  input   wire  ack_output;
  input   wire  clk;
  input   wire  rst;
  output  reg  [31:0] output_z;
  output  reg  output_valid;
  output reg   idle_status;


  

  parameter idle         = 3'd0,
            storeVals = 3'd1,
            zeroCheck        = 3'd2,
            shifting_operation       = 3'd3,
            setOutputValid         = 3'd4;
            
  reg       [2:0] state = 3'b000;
  reg [31:0] mantissa, input_a_reg;
  reg [8:0] exponent;
  reg sign_bit;
 
  always @(posedge clk)
  begin
    case(state)
      idle:
      begin
        idle_status <= 1;
        if (start == 1'd1) begin
          input_a_reg <= input_a;
          idle_status <= 0;
          state <= storeVals;
        end
      end
      storeVals:
      begin
        sign_bit <= input_a_reg[31];
        exponent <= input_a_reg[30 : 23] - 127;
        mantissa <= {1'b1, input_a_reg[22 : 0],8'd0};
        state <= zeroCheck;
      end
      zeroCheck:
      begin
        //If The exponent is zero (after addition of bias), then that means the integer is also equal to zero
        if (exponent == 9'b110000001) begin
          output_z <= 32'd0;
          state <= setOutputValid;
        end
        else begin
          state <= shifting_operation;
        end
      end
      shifting_operation:
      begin
        //Keep shifting mantissa right and incrementing exponent, till exponent >= 32, as that is how many bits the resulting int will have
        if ($signed(exponent) < 31 && (mantissa >= 1)) begin
          exponent <= exponent + 1;
          mantissa <= mantissa >> 1;
        end 
        //Else we are ready to set the output
        else begin
            //Check if output needs to be two's complemented based on the sign bit
            if(sign_bit == 1'b1) begin
                output_z <= ((~mantissa) + 1);
            end
            else begin
                output_z <= mantissa;
            end
            state <= setOutputValid;
        end
      end
      setOutputValid:
      begin
        output_valid <= 1;
        //If our output bit is properly propagated, and the user has ack'd our output, we reset the state machine
        if (output_valid == 1'd1 && ack_output == 1'd1) begin
          output_valid <= 0;
          state <= idle;
        end
      end
      //Default case due to verilator linter
      default: begin
      end
    endcase

    //If we receive a reset high, we reset state machine and reset our status outputs
    if (rst == 1) begin
      state <= idle;
      idle_status <= 0;
      output_valid <= 0;
    end
  end

endmodule






























module adder(input_a, input_b, start, ack_output, clk, rst, output_z, output_valid, idle_status);

input wire clk;
input wire rst;
input wire start;

input wire [31:0] input_a;
reg input_a_ack;

input wire [31:0] input_b;
reg input_b_ack;

output wire [31:0] output_z;
output reg idle_status;
output reg output_valid;
input wire ack_output;

reg [31:0] s_output_z;
reg s_input_a_ack;
reg s_input_b_ack;

reg [3:0] state   = 4'd0;

parameter idle           = 4'd0,
          get_a          = 4'd1,
          get_b          = 4'd2,
          unpack         = 4'd3,
          special_cases  = 4'd4,
          align          = 4'd5,
          add_0          = 4'd6,
          add_1          = 4'd7,
          normalise_1    = 4'd8,
          normalise_2    = 4'd9,
          round          = 4'd10,
          pack           = 4'd11,
          put_z          = 4'd12,
          setOutputValid = 4'd13;

reg [31:0] a, b, z;
reg [26:0] a_m, b_m;
reg [23:0] z_m;
reg [9:0] a_e, b_e, z_e;
reg a_s, b_s, z_s;
reg guard, round_bit, sticky;
reg [27:0] sum;

  always @(posedge clk)
  begin

    case(state)
    
      idle:
      begin
      idle_status <= 1'b1;
      if(start == 1'd1) begin
        idle_status <= 1'b0;
        state <= get_a;
        end
      end

      get_a:
      begin
        s_input_a_ack <= 1;
        if (s_input_a_ack) begin
          a <= input_a;
          s_input_a_ack <= 0;
          state <= get_b;
        end
      end

      get_b:
      begin
        s_input_b_ack <= 1;
        if (s_input_b_ack) begin
          b <= input_b;
          s_input_b_ack <= 0;
          state <= unpack;
        end
      end

      unpack:
      begin
        a_m <= {a[22 : 0], 3'd0};
        b_m <= {b[22 : 0], 3'd0};
        a_e <= a[30 : 23] - 127;
        b_e <= b[30 : 23] - 127;
        a_s <= a[31];
        b_s <= b[31];
        state <= special_cases;
      end

      special_cases:
      begin
        //if a is NaN or b is NaN return NaN 
        if ((a_e == 128 && a_m != 0) || (b_e == 128 && b_m != 0)) begin
          z[31] <= 1;
          z[30:23] <= 255;
          z[22] <= 1;
          z[21:0] <= 0;
          state <= put_z;
        //if a is inf return inf
        end
        else if (a_e == 128) begin
          z[31] <= a_s;
          z[30:23] <= 255;
          z[22:0] <= 0;
          //if a is inf and signs don't match return nan
          if ((b_e == 128) && (a_s != b_s)) begin
              z[31] <= b_s;
              z[30:23] <= 255;
              z[22] <= 1;
              z[21:0] <= 0;
          end
          state <= put_z;
        //if b is inf return inf
        end 
        else if (b_e == 128) begin
          z[31] <= b_s;
          z[30:23] <= 255;
          z[22:0] <= 0;
          state <= put_z;
        //if a is zero return b
        end 
        else if ((($signed(a_e) == -127) && (a_m == 0)) && (($signed(b_e) == -127) && (b_m == 0))) begin
          z[31] <= a_s & b_s;
          z[30:23] <= b_e[7:0] + 127;
          z[22:0] <= b_m[26:3];
          state <= put_z;
        //if a is zero return b
        end 
        else if (($signed(a_e) == -127) && (a_m == 0)) begin
          z[31] <= b_s;
          z[30:23] <= b_e[7:0] + 127;
          z[22:0] <= b_m[26:3];
          state <= put_z;
        //if b is zero return a
        end 
        else if (($signed(b_e) == -127) && (b_m == 0)) begin
          z[31] <= a_s;
          z[30:23] <= a_e[7:0] + 127;
          z[22:0] <= a_m[26:3];
          state <= put_z;
        end 
        else begin
          //Denormalised Number
          if ($signed(a_e) == -127) begin
            a_e <= -126;
          end 
          else begin
            a_m[26] <= 1;
          end
          //Denormalised Number
          if ($signed(b_e) == -127) begin
            b_e <= -126;
          end 
          else begin
            b_m[26] <= 1;
          end
          state <= align;
        end
      end

      align:
      begin
        if ($signed(a_e) > $signed(b_e)) begin
          b_e <= b_e + 1;
          b_m <= b_m >> 1;
          b_m[0] <= b_m[0] | b_m[1];
        end 
        else if ($signed(a_e) < $signed(b_e)) begin
          a_e <= a_e + 1;
          a_m <= a_m >> 1;
          a_m[0] <= a_m[0] | a_m[1];
        end 
        else begin
          state <= add_0;
        end
      end

      add_0:
      begin
        z_e <= a_e;
        if (a_s == b_s) begin
          sum <= a_m + b_m;
          z_s <= a_s;
        end 
        else begin
          if (a_m >= b_m) begin
            sum <= a_m - b_m;
            z_s <= a_s;
          end 
          else begin
            sum <= b_m - a_m;
            z_s <= b_s;
          end
        end
        state <= add_1;
      end

      add_1:
      begin
        if (sum[27]) begin
          z_m <= sum[27:4];
          guard <= sum[3];
          round_bit <= sum[2];
          sticky <= sum[1] | sum[0];
          z_e <= z_e + 1;
        end 
        else begin
          z_m <= sum[26:3];
          guard <= sum[2];
          round_bit <= sum[1];
          sticky <= sum[0];
        end
        state <= normalise_1;
      end

      normalise_1:
      begin
        if (z_m[23] == 0 && $signed(z_e) > -126) begin
          z_e <= z_e - 1;
          z_m <= z_m << 1;
          z_m[0] <= guard;
          guard <= round_bit;
          round_bit <= 0;
        end 
        else begin
          state <= normalise_2;
        end
      end

      normalise_2:
      begin
        if ($signed(z_e) < -126) begin
          z_e <= z_e + 1;
          z_m <= z_m >> 1;
          guard <= z_m[0];
          round_bit <= guard;
          sticky <= sticky | round_bit;
        end 
        else begin
          state <= round;
        end
      end

      round:
      begin
        if (guard && (round_bit | sticky | z_m[0])) begin
          z_m <= z_m + 1;
          if (z_m == 24'hffffff) begin
            z_e <=z_e + 1;
          end
        end
        state <= pack;
      end

      pack:
      begin
        z[22 : 0] <= z_m[22:0];
        z[30 : 23] <= z_e[7:0] + 127;
        z[31] <= z_s;
        if ($signed(z_e) == -126 && z_m[23] == 0) begin
          z[30 : 23] <= 0;
        end
        if ($signed(z_e) == -126 && z_m[23:0] == 24'h0) begin
          z[31] <= 1'b0; // FIX SIGN BUG: -a + a = +0.
        end
        //if overflow occurs, return inf
        if ($signed(z_e) > 127) begin
          z[22 : 0] <= 0;
          z[30 : 23] <= 255;
          z[31] <= z_s;
        end
        state <= put_z;
      end

      put_z:
      begin
        s_output_z <= z;
          state <= setOutputValid;
      end
      
      setOutputValid:
      begin
      output_valid <= 1;
        if (output_valid == 1'd1 && ack_output == 1'd1) begin
          output_valid <= 0;
          state <= idle;
        end

      end

    endcase

    if (rst == 1) begin
      state <= idle;
      idle_status <= 0;
      output_valid <= 0;
      s_output_z <= 0;
    end

  end
//  assign input_a_ack = s_input_a_ack;
//  assign input_b_ack = s_input_b_ack;
  assign output_z = s_output_z;

endmodule



module subtractor(input_a, input_b, start, ack_output, clk, rst, output_z, output_valid, idle_status);

input wire clk;
input wire rst;
input wire start;

input wire [31:0] input_a;
reg input_a_ack;

input wire [31:0] input_b;
reg input_b_ack;

output wire [31:0] output_z;
output reg idle_status;
output reg output_valid;
input wire ack_output;

reg [31:0] s_output_z;
reg s_input_a_ack;
reg s_input_b_ack;

reg [3:0] state   = 4'd0;

parameter idle           = 4'd0,
          get_a          = 4'd1,
          get_b          = 4'd2,
          unpack         = 4'd3,
          special_cases  = 4'd4,
          align          = 4'd5,
          add_0          = 4'd6,
          add_1          = 4'd7,
          normalise_1    = 4'd8,
          normalise_2    = 4'd9,
          round          = 4'd10,
          pack           = 4'd11,
          put_z          = 4'd12,
          setOutputValid = 4'd13;

reg [31:0] a, b, z;
reg [26:0] a_m, b_m;
reg [23:0] z_m;
reg [9:0] a_e, b_e, z_e;
reg a_s, b_s, z_s;
reg guard, round_bit, sticky;
reg [27:0] sum;

  always @(posedge clk)
  begin

    case(state)
    
      idle:
      begin
      idle_status <= 1'b1;
      if(start == 1'd1) begin
        idle_status <= 1'b0;
        state <= get_a;
        end
      end

      get_a:
      begin
        s_input_a_ack <= 1;
        if (s_input_a_ack) begin
          a <= input_a;
          s_input_a_ack <= 0;
          state <= get_b;
        end
      end

      get_b:
      begin
        s_input_b_ack <= 1;
        if (s_input_b_ack) begin
          b <= input_b;
          s_input_b_ack <= 0;
          state <= unpack;
        end
      end

      unpack:
      begin
        a_m <= {a[22 : 0], 3'd0};
        b_m <= {b[22 : 0], 3'd0};
        a_e <= a[30 : 23] - 127;
        b_e <= b[30 : 23] - 127;
        a_s <= a[31];
        b_s <= b[31];
        state <= special_cases;
      end

      special_cases:
      begin
        //if a is NaN or b is NaN return NaN 
        if ((a_e == 128 && a_m != 0) || (b_e == 128 && b_m != 0)) begin
          z[31] <= 1;
          z[30:23] <= 255;
          z[22] <= 1;
          z[21:0] <= 0;
          state <= put_z;
        //if a is inf return inf
        end
        else if (a_e == 128) begin
          z[31] <= a_s;
          z[30:23] <= 255;
          z[22:0] <= 0;
          //if a is inf and signs don't match return nan
          if ((b_e == 128) && (a_s != b_s)) begin
              z[31] <= b_s;
              z[30:23] <= 255;
              z[22] <= 1;
              z[21:0] <= 0;
          end
          state <= put_z;
        //if b is inf return -inf
        end 
        else if (b_e == 128) begin
          z[31] <= 1'b1; // sign = 1 for negative infinity
          z[30:23] <= 255;
          z[22:0] <= 0;
          state <= put_z;
        //if a is zero return -b
        end 
        else if ((($signed(a_e) == -127) && (a_m == 0)) && (($signed(b_e) == -127) && (b_m == 0))) begin
          z[31] <= ~(a_s & b_s);
          z[30:23] <= b_e[7:0] + 127;
          z[22:0] <= b_m[26:3];
          state <= put_z;
        //if a is zero return b
        end 
        else if (($signed(a_e) == -127) && (a_m == 0)) begin
          z[31] <= ~b_s;
          z[30:23] <= b_e[7:0] + 127;
          z[22:0] <= b_m[26:3];
          state <= put_z;
        //if b is zero return a
        end 
        else if (($signed(b_e) == -127) && (b_m == 0)) begin
          z[31] <= a_s;
          z[30:23] <= a_e[7:0] + 127;
          z[22:0] <= a_m[26:3];
          state <= put_z;
        end 
        else begin
          //Denormalised Number
          if ($signed(a_e) == -127) begin
            a_e <= -126;
          end 
          else begin
            a_m[26] <= 1;
          end
          //Denormalised Number
          if ($signed(b_e) == -127) begin
            b_e <= -126;
          end 
          else begin
            b_m[26] <= 1;
          end
          state <= align;
        end
      end

      align:
      begin
        if ($signed(a_e) > $signed(b_e)) begin
          b_e <= b_e + 1;
          b_m <= b_m >> 1;
          b_m[0] <= b_m[0] | b_m[1];
        end 
        else if ($signed(a_e) < $signed(b_e)) begin
          a_e <= a_e + 1;
          a_m <= a_m >> 1;
          a_m[0] <= a_m[0] | a_m[1];
        end 
        else begin
          state <= add_0;
        end
      end

      add_0:
      begin
        z_e <= a_e;
        if (a_s == b_s) begin
          sum <= a_m - b_m;
          z_s <= a_s;
        end 
        else begin
          if (a_m >= b_m) begin
            sum <= a_m - b_m;
            z_s <= a_s;
          end 
          else begin
            sum <= b_m - a_m;
            z_s <= b_s;
          end
        end
        state <= add_1;
      end

      add_1:
      begin
        if (sum[27]) begin
          z_m <= sum[27:4];
          guard <= sum[3];
          round_bit <= sum[2];
          sticky <= sum[1] | sum[0];
          z_e <= z_e + 1;
        end 
        else begin
          z_m <= sum[26:3];
          guard <= sum[2];
          round_bit <= sum[1];
          sticky <= sum[0];
        end
        state <= normalise_1;
      end

      normalise_1:
      begin
        if (z_m[23] == 0 && $signed(z_e) > -126) begin
          z_e <= z_e - 1;
          z_m <= z_m << 1;
          z_m[0] <= guard;
          guard <= round_bit;
          round_bit <= 0;
        end 
        else begin
          state <= normalise_2;
        end
      end

      normalise_2:
      begin
        if ($signed(z_e) < -126) begin
          z_e <= z_e + 1;
          z_m <= z_m >> 1;
          guard <= z_m[0];
          round_bit <= guard;
          sticky <= sticky | round_bit;
        end 
        else begin
          state <= round;
        end
      end

      round:
      begin
        if (guard && (round_bit | sticky | z_m[0])) begin
          z_m <= z_m + 1;
          if (z_m == 24'hffffff) begin
            z_e <=z_e + 1;
          end
        end
        state <= pack;
      end

      pack:
      begin
        z[22 : 0] <= z_m[22:0];
        z[30 : 23] <= z_e[7:0] + 127;
        z[31] <= z_s;
        if ($signed(z_e) == -126 && z_m[23] == 0) begin
          z[30 : 23] <= 0;
        end
        if ($signed(z_e) == -126 && z_m[23:0] == 24'h0) begin
          z[31] <= 1'b0; // FIX SIGN BUG: -a + a = +0.
        end
        //if overflow occurs, return inf
        if ($signed(z_e) > 127) begin
          z[22 : 0] <= 0;
          z[30 : 23] <= 255;
          z[31] <= z_s;
        end
        state <= put_z;
      end

      put_z:
      begin
        s_output_z <= z;
          state <= setOutputValid;
      end
      
      setOutputValid:
      begin
      output_valid <= 1;
        if (output_valid == 1'd1 && ack_output == 1'd1) begin
          output_valid <= 0;
          state <= idle;
        end

      end

    endcase

    if (rst == 1) begin
      state <= idle;
      idle_status <= 0;
      output_valid <= 0;
      s_output_z <= 0;
    end

  end
//  assign input_a_ack = s_input_a_ack;
//  assign input_b_ack = s_input_b_ack;
  assign output_z = s_output_z;

endmodule



module FPI2F(input_a, start, ack_output, clk, rst, output_z, output_valid, idle_status);

  input  wire   [31:0] input_a;
  input  wire   start;
  input   wire  ack_output;
  input   wire  clk;
  input   wire  rst;
  output  reg  [31:0] output_z;
  output  reg  output_valid;
  output reg   idle_status;

 
  parameter idle        = 3'd0,
            zeroCheck   = 3'd1,
            storeVals   = 3'd2,
            normalizeAndStoreRoundBits    = 3'd3,
            round      = 3'd4,
            setOutput      = 3'd5,
            setOutputValid      = 3'd6;
  
  reg       [2:0] state = 3'b000;
  reg [31:0] input_a_reg, absolute_value_a;
  reg [23:0] mantissa;
  reg [7:0] roundingBits;
  reg guard, round_bit, sticky;
  reg [7:0] exponent;
  reg sign;

  always @(posedge clk)
  begin
    case(state)
      idle:
      begin
        idle_status <= 1;
        if (start == 1'd1) begin
          input_a_reg <= input_a;
          idle_status <= 0;
          state <= zeroCheck;
        end
      end
      zeroCheck:
      begin
        //If our input val is 0, we simply just set all bits of output to zero
        if ( input_a_reg == 32'd0 ) begin
          output_z <= 32'd0;
          state <= setOutputValid;
        end 
        else begin
          //Basically just storing absolute value of the input a
          absolute_value_a <= input_a_reg[31] ? -input_a_reg : input_a_reg;
          sign <= input_a_reg[31];
          state <= storeVals;
        end
      end

      storeVals:
      begin
        mantissa <= absolute_value_a[31:8];
        roundingBits <= absolute_value_a[7:0];
        exponent <= 31;
        state <= normalizeAndStoreRoundBits;
      end

      normalizeAndStoreRoundBits:
      begin
        //Normalize the mantissa by shifting it left till a 1 reaches the MSB
        if (mantissa[23] == 1'b0) begin
          mantissa <= mantissa << 1;
          exponent <= exponent - 1;
          mantissa[0] <= roundingBits[7];
          roundingBits <= roundingBits << 1;
        end else begin
          //'round status' bits for rounding in next state
          round_bit <= roundingBits[6];
          guard <= roundingBits[7];
          sticky <= roundingBits[5:0] != 0;
          state <= round;
        end
      end
      round:
      begin
        //If the guard and any of the other 'round status' bits are set, we perform a round operation on the mantissa
        if (guard && (round_bit || sticky || mantissa[0])) begin
          mantissa <= mantissa + 1;
          //If there is a max val reached, we increment the exponent
          if (mantissa == 24'hffffff) begin
            exponent <=exponent + 1;
          end
        end
        state <= setOutput;
      end
      setOutput:
      begin
        //Remove bias from exponent before storing in output
        output_z[30 : 23] <= exponent + 127;
        output_z[22 : 0] <= mantissa[22:0];
        output_z[31] <= sign;
        state <= setOutputValid;
      end
      setOutputValid:
      begin
        output_valid <= 1;
        if (output_valid && ack_output) begin
          output_valid <= 0;
          state <= idle;
        end
      end
    endcase
    //Reset procedure
    if (rst == 1) begin
      state <= idle;
      idle_status <= 0;
      output_valid <= 0;
    end
  end
endmodule












module FPDIV(input [31:0]a,
                       input [31:0]b,
                       input start,
                       input ack_output,                                          
                       input clk,
                       input rst,
                       output reg[31:0]y,
                       output reg output_valid,//1 for busy, 0 for ready
                       output reg idle_status,
                       output [24:0]div,
                       output [47:0]a_o);
//y=a/b
reg [3:0] states;

parameter verify_a =4'd0,
          verify_b =4'd1,
          seperate =4'd2,
          special_cases = 4'd3,
          normalise_a =4'd4,
          normalise_b =4'd5,
          div_0 =4'd6,
          div_1 =4'd7,
          normalise_1 =4'd8,
          normalise_2 =4'd9,
          round =4'd10,
          put_together =4'd11,
          outputz =4'd12,
          setOutputValid=4'd13;
// temporary storage for in always loop
reg [31:0] a_t,b_t,z_t;          
reg [47:0] a_m;
reg [23:0] b_m;
reg [23:0] z_m;
//so we can check for overflow
// highest number for overflow would be 127+255
//underflow would be 0 -127 - 127
reg [7:0] a_e,b_e;
reg [8:0] z_e;
reg a_s,b_s,z_s;
reg [31:0] z;
reg [23:0]div_result;

always @ (posedge clk)
begin

    begin
        //dividing starts
        case(states)
            verify_a:
          begin
          idle_status <= 1;
          if (idle_status == 1'd1 && start == 1'd1) begin
              idle_status <= 0;
              a_t <= a;
              states <= verify_b;
              end
              a_t[31:0] <= a[31:0];
              states<=verify_b;
          end
    
         verify_b:
          begin
              b_t[31:0] <= b[31:0];
              states <= seperate;
          end
         seperate:
          begin
          //pad leading zeroes of divdend 
            a_m <= {1'b1,a_t[22:0]}<<24;
 
          //pad a leading zero and pad the rest for trailing zerosof divdend   
            b_m <= {1'b1,b_t[22 :0]};
            a_e <= a_t[30 : 23];
            b_e <= b_t[30 : 23];
            a_s <= a_t[31];
            b_s <= b_t[31];
            states <= special_cases;
          end
        special_cases:
        begin
             //if a is NaN or b is NaN return NaN 
            if ((a_e == 128 && a_m != 0) || (b_e == 128 && b_m != 0)) begin
              z_t[31] <= 1;
              z_t[30:23] <= 255;
              z_t[22] <= 1;
              z_t[21:0] <= 0;
              states <= outputz;
            //if a is inf return inf
            end 
            else if (a_e == 128) begin
              z_t[31] <= a_s ^ b_s;
              z_t[30:23] <= 255;
              z_t[22:0] <= 0;
              
              //if b is zero return NaN
              if (($signed(b_e) == -127) && (b_m == 0)) begin
                z_t[31] <= 1;
                z_t[30:23] <= 255;
                z_t[22] <= 1;
                z_t[21:0] <= 0;
              end
              states <= outputz;
            //if b is inf  and a is a number return 0
             end
             else if (b_e == 128) begin
              
                z_t[31] <= 0;
                z_t[30:23] <= 0;
                z_t[22] <= 0;
                z_t[21:0] <= 0;
              //if b is zero return NaN
              if (($signed(a_e) == -127) && (a_m == 0)) begin
                 z_t[31] <= a_s ^ b_s;
                 z_t[30:23] <= 255;
                 z_t[22:0] <= 0;
               
              end
              states <= outputz;
            //if a is zero return zero
            end 
            else if (($signed(a_e) == -127) && (a_m == 0)) begin
              z_t[31] <= a_s ^ b_s;
              z_t[30:23] <= 0;
              z_t[22:0] <= 0;
              states <= outputz;
            //if b is zero return 
            end
             else if (($signed(b_e) == -127) && (b_m == 0)) begin
             z_t[31] <= a_s ^ b_s;
              z_t[30:23] <= 0;
              z_t[22:0] <= 0;
              states <= outputz;
            end 
            else begin
              states <= div_0;
            end
          end   
          div_0:
          begin
            z_s <= a_s ^ b_s;
            // (n_a-127)-(n_b-127+127) so that you only get the portion you want to subtract
            // might need to check if it is the case where a_e<b_e
            
            //if value becomes huge which worst case would be
            //1.0000/1.0
            if((a_m>>24)<=b_m)
            begin
                
                //48 bits long with the 0's for padding now divide and add 1
               
               z_e <= a_e - b_e + 126;
            end
            else //if the m1<m2 now we need to decrement the exponent
            begin
             
              z_e <= a_e - b_e + 127;
            end
            
            states <= div_1;
          end
    
          div_1:
          begin
          if((a_m[23:0]>>24)<=b_m)
            begin
            div_result<=(a_m/b_m);
            end
          else
          begin
          div_result<=(a_m&(48'hFFFFFE000000)/b_m)+1'b1;
          end
            states <= normalise_1;
          end
          normalise_1:
          begin
            
              states <= put_together;
            
          end
        
          put_together:
          begin
            z_t[22 : 0] <= div_result[22:0];
            z_t[30 : 23] <= z_e[7:0];
            z_t[31] <= z_s;
           
            //if overflow occurs, return inf
            if (z_e > 254) begin
              z_t[22 : 0] <= 0;
              z_t[30 : 23] <= 2047;
              z_t[31] <= z_s;
            end
            states <= outputz;
          end
         outputz:
          begin
            z <= z_t;
            y <=z_t;
            output_valid <= 1;
            states <= setOutputValid;
          end  

         setOutputValid:
         begin
          output_valid <= 1;
           if (output_valid == 1'd1 && ack_output == 1'd1) begin
                output_valid <= 0;
          states <= verify_a;
        end

         end
         default:
          begin
          states <= verify_a;
          end
        endcase
      if (rst == 1) begin
          states <= verify_a;
          idle_status <= 0;
          output_valid <= 0;
       end
    end
    
end
assign div=div_result;
assign a_o=a_m;
endmodule



module 
FPMPY(         input [31:0]a,
                       input [31:0]b,
                       input start,
                       input ack_output,                                          
                       input clk,
                       input rst,
                       output reg[31:0]y,
                       output reg output_valid,//1 for busy, 0 for ready
                       output reg idle_status);
                  
reg [3:0] states;

parameter verify_a =4'd0,
          verify_b =4'd1,
          separate =4'd2,
          special_cases = 4'd3,
          normalise_a =4'd4,
          normalise_b =4'd5,
          multiply_0 =4'd6,
          multiply_1 =4'd7,
          normalise_1 =4'd8,
          normalise_2 =4'd9,
          round =4'd10,
          put_together =4'd11,
          outputz =4'd12,
          setOutputValid=4'd13;
reg [47:0]product;
//holding all of a b z while in the always block
reg       [31:0] a_t, b_t, z_t;
//mantissa of a b and z
reg       [23:0] a_m, b_m, z_m;
//exponent of a,b, and z
reg       [9:0] a_e, b_e, z_e;
//sign of a,b, and z
reg       a_s, b_s, z_s;
reg [31:0] z;
reg       guard, round_bit, sticky;
initial begin
states=0;
end

always @(posedge clk)
begin
    case(states)
     verify_a:
          begin
              idle_status <= 1;
              if (idle_status == 1'd1 && start == 1'd1) begin
                  idle_status <= 0;
                  a_t <= a;
                  states <= verify_b;
                  end
          end

     verify_b:
      begin
          b_t <= b;
          states <= separate;
      end
     separate:
      begin
        a_m <= a_t[22 : 0];
        b_m <= b_t[22 : 0];
        a_e <= a_t[30 : 23] - 127;
        b_e <= b_t[30 : 23] - 127;
        a_s <= a_t[31];
        b_s <= b_t[31];
        states <= special_cases;
      end
    special_cases:
    begin
         //if a is NaN or b is NaN return NaN 
        if ((a_e == 128 && a_m != 0) || (b_e == 128 && b_m != 0)) begin
          z_t[31] <= 1;
          z_t[30:23] <= 255;
          z_t[22] <= 1;
          z_t[21:0] <= 0;
          states <= outputz;
        //if a is inf return inf
        end else if (a_e == 128) begin
          z_t[31] <= a_s ^ b_s;
          z_t[30:23] <= 255;
          z_t[22:0] <= 0;
          
          //if b is zero return NaN
          if (($signed(b_e) == -127) && (b_m == 0)) begin
            z_t[31] <= 1;
            z_t[30:23] <= 255;
            z_t[22] <= 1;
            z_t[21:0] <= 0;
            
          end
          states <= outputz;
        //if b is inf return inf
         end
         else if (b_e == 128) begin
          z_t[31] <= a_s ^ b_s;
          z_t[30:23] <= 255;
          z_t[22:0] <= 0;
          //if b is zero return NaN
          if (($signed(a_e) == -127) && (a_m == 0)) begin
           z_t[31] <= 1;
            z_t[30:23] <= 255;
            z_t[22] <= 1;
            z_t[21:0] <= 0;
           
          end
          states <= outputz;
        //if a is zero return zero
        end 
        else if (($signed(a_e) == -127) && (a_m == 0)) begin
          z_t[31] <= a_s ^ b_s;
          z_t[30:23] <= 0;
          z_t[22:0] <= 0;
          states <= outputz;
        //if b is zero return zero
        end
         else if (($signed(b_e) == -127) && (b_m == 0)) begin
         z_t[31] <= a_s ^ b_s;
          z_t[30:23] <= 0;
          z_t[22:0] <= 0;
          states <= outputz;
        end 
        else begin
          //Denormalised Number
          if ($signed(a_e) == -127) begin
            a_e <= -126;
          end else begin
            a_m[23] <= 1;
          end
          //Denormalised Number
          if ($signed(b_e) == -127) begin
            b_e <= -126;
          end else begin
            b_m[23] <= 1;
          end
          states <= normalise_a;
        end
      end   
   
    normalise_a:
      begin
        if (a_m[23]) begin
          states <= normalise_b;
        end else begin
          a_m <= a_m << 1;
          a_e <= a_e - 1;
        end
      end

      normalise_b:
      begin
        if (b_m[23]) begin
          states <= multiply_0;
        end else begin
          b_m <= b_m << 1;
          b_e <= b_e - 1;
        end
      end
      multiply_0:
      begin
        z_s <= a_s ^ b_s;
        z_e <= a_e + b_e + 1;
        product <= a_m * b_m;
        states <= multiply_1;
      end

      multiply_1:
      begin
        z_m <= product[47:24];
        guard <= product[23];
        round_bit <= product[22];
        sticky <= (product[21:0] != 0);
        states <= normalise_1;
      end
      normalise_1:
      begin
        if (z_m[23] == 0) begin
          z_e <= z_e - 1;
          z_m <= z_m << 1;
          z_m[0] <= guard;
          guard <= round_bit;
          round_bit <= 0;
        end else begin
          states <= normalise_2;
        end
      end

      normalise_2:
      begin
        if ($signed(z_e) < -126) begin
          z_e <= z_e + 1;
          z_m <= z_m >> 1;
          guard <= z_m[0];
          round_bit <= guard;
          sticky <= sticky | round_bit;
        end else begin
          states <= round;
        end
      end
      round:
      begin
        if (guard && (round_bit | sticky | z_m[0])) begin
          z_m <= z_m + 1;
          if (z_m == 24'hffffff) begin
            z_e <=z_e + 1;
          end
        end
        states <= put_together;
      end
      
      put_together:
     begin
        z_t[22 : 0] <= z_m[22:0];
        z_t[30 : 23] <= z_e[7:0] + 127;
        z_t[31] <= z_s;
        if ($signed(z_e) == -126 && z_m[23] == 0) begin
          z_t[30 : 23] <= 0;
        end
        //if overflow occurs, return inf
        if ($signed(z_e) > 127) begin
          z_t[22 : 0] <= 0;
          z_t[30 : 23] <= 2047;
          z_t[31] <= z_s;
        end
        states <= outputz;
      end
     outputz:
      begin
        z <= z_t;
        y <= z_t;
        states <= setOutputValid;
      end  
      setOutputValid:
         begin
          output_valid <= 1;
           if (output_valid == 1'd1 && ack_output == 1'd1) begin
              output_valid <= 0;
              states <= verify_a;
          end
      end
      default:states<=verify_a;
    endcase
    if (rst == 1) begin
          states <= verify_a;
          idle_status <= 0;
          output_valid <= 0;
       end

end

endmodule
