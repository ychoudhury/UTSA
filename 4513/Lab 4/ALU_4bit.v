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
    3'b000: // Instruction: Add
        {c, r[3:0]} <= (A[3:0] + B[3:0] + Cin);
    3'b001: // Instruction: Subtract
        r = 1'b1;
        
    3'b010: // Instruction: OR
        r = (A | B);
        
    3'b011: // Instruction: AND
        r = (A & B);
        
    3'b100: // Instruction: Shift Left
        r = 1'b1;
    3'b101: // Instruction: Shift Right
        r = 1'b1;
    3'b110: // Instruction: ROL
        r = 1'b1;
    3'b111: // Instruction: ROR
        r = 1'b1;

endcase
end

assign ALU_output = r;
assign Cout = c;

endmodule
