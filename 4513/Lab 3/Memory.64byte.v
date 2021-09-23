`timescale 1ns / 1ps
 // byte accessible 64 byte memory: 8 rows of 8 bytes in each row

module Memory_64byte(D_IN, ADDR, R_ENABLE, W_ENABLE, RESET, CLK, D_OUT);

input [7:0] D_IN = 0; // MDR
input [7:0] ADDR = 0; // MAR
input R_ENABLE, W_ENABLE, RESET, CLK = 0;
output [7:0] D_OUT;

reg [7:0] mem [63:0]; // 8-bit wide and 64 deep memory block (64 Bytes)
reg [7:0] x; // intermediate wire to carry output

integer i, j;

always @(posedge CLK) begin

    if(RESET) begin // clear all memory locations
        for(i = 0; i <= 64; i = i + 1) begin
            mem[i] <= 8'b00000000;
        end
        x = 8'b00000000;
    end
            
    else if(R_ENABLE) begin // give read operation priority
        if(ADDR >= 8'b000 && ADDR <= 8'b111) begin
                x = mem[ADDR];
        end
       
        else x = 8'bZZZZZZZZ; // read disable will not return valid values
        
    end
    
    else if(W_ENABLE) begin
        if(ADDR >= 'd0 && ADDR <= 'd64) begin
                mem[ADDR] <= D_IN; // non-blocking statement to immediately move all input into specified address
                x = 8'bZZZZZZZZ; // not reading anything, so output high impedance is not mistaken for 0 data
        end
        
        else x <= 8'bZZZZZZZZ;
        
    end
    
    $display("Time = %0t, Data In = %4h Address = %3b, Read Enable = %1b, Write Enable = %1b, Reset = %1b, Data Out = %4h", $time, D_IN, ADDR, R_ENABLE, W_ENABLE, RESET, D_OUT);
    for(i = 0; i < 64; i = i + 1) begin
        $display("Contents of Memory Address [%0d] = %8b", i, mem[i]);       
    end
    
end

assign D_OUT = x;
   

endmodule
