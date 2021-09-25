`timescale 1ns / 1ps

module ALU_4bit(A, B, Control, Cin, ALU_output, Cout);
input [3:0] A, B;
input [2:0] Control;
input Cin;
output wire [3:0] ALU_output;
output wire Cout;
reg [3:0] r;
reg c;



always @(*) begin // * used for combinational logic

case(Control)
    3'b000: 
        {r, c} = A + B + Cin;
        
    3'b001: r = 1'b1;
    3'b010: r = 1'b1;
    3'b011: r = 1'b1;
    3'b100: r = 1'b1;
    3'b101: r = 1'b1;
    3'b110: r = 1'b1;
    3'b111: r = 1'b1;

endcase
end

assign ALU_output = r;
assign Cout = c;

endmodule
