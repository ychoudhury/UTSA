`timescale 1ns / 1ps

module ALU_4bit(A, B, Control, Cin, ALU_output, Cout);
input [3:0] A, B;
input [2:0] Control;
input Cin;
output wire [3:0] ALU_output;
output wire Cout;
wire [3:0] orvalue;
reg [3:0] r;
reg c;

always @(*) begin // * used for combinational logic

case(Control)
    3'b000: // Instruction: Add
        {c, r[3:0]} <= (A[3:0] + B[3:0] + Cin); // last bit out becomes carry, r gets sum of A and B
        
    3'b001: // Instruction: Subtract
        {c, r[3:0]} <= (A[3:0] - B[3:0] - Cin);
        
    3'b010: // Instruction: OR
        r <= orvalue; // result of gate level modelling after always block
                
    3'b011: // Instruction: AND
        r <= (A & B);
        
    3'b100: // Instruction: Shift Left
        r <= (A << 1);
        
    3'b101: // Instruction: Shift Right
        r <= (A >> 1);
        
    3'b110: // Instruction: ROL
        r <= {A[2:0], A[3]};
               
    3'b111: // Instruction: ROR
        r <= {A[0], A[3:1]};

endcase

end

or(orvalue[0], A[0], B[0]); // gate level modelling
or(orvalue[1], A[1], B[1]);
or(orvalue[2], A[2], B[2]);
or(orvalue[3], A[3], B[3]);

assign ALU_output = r;
assign Cout = c;

endmodule
