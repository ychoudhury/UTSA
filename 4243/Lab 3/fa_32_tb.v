`timescale 1ns / 1ps

module fa_32_tb();

integer a;
integer b;
reg c_in;

wire [31:0] s;
wire c_out;

// DUT
fa_32 FA1(a, b, c_in, s, c_out);

    initial begin
        $monitor("a=%d, b=%d, c_in=%1b, s=%d, c_out=%1b", a, b, c_in, s, c_out);
        c_in = 1'b0;
        // 256 + 256 = 512.
        a = 256;
        b = 256;
        #200;
        // 4 + 35 = 39.
        a = 4;
        b = 35;
        #200;
        // Test overflow -> s = 1 and c_out = 1'b1;
        a = ~(0);
        b = 2;
        #200;
    end
 
endmodule
