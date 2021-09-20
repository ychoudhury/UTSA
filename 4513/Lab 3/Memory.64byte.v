`timescale 1ns / 1ps
 // byte accessible 64 byte memory: 8 rows of 8 bytes in each row

module Memory_64byte(D_IN, ADDR, R_ENABLE, W_ENABLE, RESET, CLK, D_OUT);

input [7:0] D_IN; // MDR
input [2:0] ADDR; // MAR
input R_ENABLE, W_ENABLE, RESET, CLK;
output [7:0] D_OUT;

reg [7:0] mem [2:0]; // 8-bit wide and 8 deep memory block (64 Bytes)

integer i; // used to clear row of memory

always @(posedge CLK) begin

    if(RESET) begin // clear memory
        for(i = 0; i < 7; i = i + 1)
            mem[i] = 0;
        end
            
    else if(W_ENABLE) begin
        mem[ADDR] <= D_IN; // non-blocking statement to immediately move all input into specified address
    end
    
    end
    
    assign D_OUT = (R_ENABLE && ~W_ENABLE) ? mem[ADDR] : 8'bZZZZZZZZ; // output either contents of memory address or no connection
        
endmodule
