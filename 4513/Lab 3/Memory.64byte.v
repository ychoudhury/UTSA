`timescale 1ns / 1ps
 // byte accessible 64 byte memory: 8 rows of 8 bytes in each row

module Memory_64byte(D_IN, ADDR, R_ENABLE, W_ENABLE, RESET, CLK, D_OUT);

input [7:0] D_IN; // MDR
input [2:0] ADDR; // MAR
input R_ENABLE, W_ENABLE, RESET, CLK;
output [7:0] D_OUT;

reg [7:0] mem [2:0]; // 8-bit wide and 8 deep memory block (64 Bytes)
reg [7:0] x;

integer i; // used to clear row of memory

always @(posedge CLK) begin

    if(RESET) begin // clear memory
        x <= 8'b0000000;
        
        end
            
    else if(R_ENABLE) begin
        if(ADDR >= 3'b000 && ADDR <= 3'b111) begin //check if valid address is given
                x = mem[ADDR];
        end
        else begin
            x = 8'bZZZZZZZZ; // read disable will not return valid values
        end
    end
    
    else if(W_ENABLE) begin
        if(ADDR >= 3'b000 && ADDR <= 3'b111) begin
                x <= D_IN; // non-blocking statement to immediately move all input into specified address
        end
        else begin
        // NOP
        end
    end
    $display("Time = %0t, Data In = %8b, Address = %3b, Read Enable = %1b, Write Enable = %1b, Reset = %1b, Data Out = %8b", $time, D_IN, ADDR, R_ENABLE, W_ENABLE, RESET, D_OUT);
    end

   assign D_OUT = x;
   

endmodule
