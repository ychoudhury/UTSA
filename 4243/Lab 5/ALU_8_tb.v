`timescale 1ns / 1ps

module ALU_8_tb();
reg [7:0] a, b;
reg c_in;
integer sel;

wire [7:0] out;
wire c_out;

ALU_8 ALU_8_0(a, b, sel[2:0], c_in, out, c_out);
    
initial begin
    $monitor("a = %2x, b = %2x, sel = %1d, out = %2h", a, b, sel, out);
    // a = 0xCC and b = 0x01.
    a = 8'hCC;
    b = 8'h01;
    c_in = 1'b0;
    for(sel = 0; sel < 8; sel = sel + 1) begin
        #100;
    end
end

endmodule
