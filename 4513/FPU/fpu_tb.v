`timescale 1ns / 1ps


module fpu_alu_tb(

    );
    
    reg clk;
    reg rst;
    reg start;
    reg [2:0] i_signed;
    reg [31:0]input_a;
    reg [31:0]input_b;
    wire o_busy;
    wire o_valid;
    wire o_err;
    wire [31:0] o_quotient;
    wire [3:0] o_flags;

    fpu instantiation_name(clk,
        rst,
        start,
        i_signed,
        input_a,
        input_b,
        o_busy,
        o_valid,
        o_err,
        o_quotient,
        o_flags
        );
    
     initial
      begin
        clk <= 1'b0;
        while (1) begin
          #5 clk <= ~clk;
        end
      end
      
    initial
      begin
        #500000 $finish;
      end

    parameter numOfValuesPerOperation = 4;
    parameter numOfOperations = 6;
    parameter totalNumOfValues = numOfOperations * numOfValuesPerOperation;
    reg [31:0] arrValsA [totalNumOfValues-1:0];
    reg [31:0] arrValsB [totalNumOfValues-1:0];
    
    reg valWrittenFlag = 0;
    integer i = 0;
    initial
    begin
        rst = 0;
        start = 0;
        i_signed = 3'd0;
        input_a = 32'd0;
        input_b = 32'd0;
        
        //VALUES FOR OP 0 (IF YOUR OPERATION NEEDS TWO INPUTS, ALSO ADD IN arrValsB)
        arrValsA[0] = 32'h3fc00000; //1.5
        arrValsA[1] = 32'h41500000; //13
        arrValsA[2] = 32'hc348999a; //-200.6
        arrValsA[3] = 32'h00000000; // 0
        
        //VALUES FOR OP 1
        arrValsA[4] = 32'h00000002; //2
        arrValsA[5] = 32'hFFFFFFF4; //-12
        arrValsA[6] = 32'h00000000; // 0
        arrValsA[7] = 32'h0007D214; // 512532
        
        //VALUES FOR OP 2
        arrValsA[8] = 32'h00000002; //2
        arrValsA[9] = 32'hFFFFFFF4; //-12
        arrValsA[10] = 32'h00000000; // 0
        arrValsA[11] = 32'h0007D214; // 512532
        
        //VALUES FOR OP 3
        arrValsA[12] = 32'h00000002; //2
        arrValsA[13] = 32'hFFFFFFF4; //-12
        arrValsA[14] = 32'h00000000; // 0
        arrValsA[15] = 32'h0007D214; // 512532
        
        //VALUES FOR OP 4
        arrValsA[16] = 32'h00000002; //2
        arrValsA[17] = 32'hFFFFFFF4; //-12
        arrValsA[18] = 32'h00000000; // 0
        arrValsA[19] = 32'h0007D214; // 512532
        
        //VALUES FOR OP 5
        arrValsA[20] = 32'h00000002; //2
        arrValsA[21] = 32'hFFFFFFF4; //-12
        arrValsA[22] = 32'h00000000; // 0
        arrValsA[23] = 32'h0007D214; // 512532
        
        valWrittenFlag = 1;
    end
    initial
    begin
        while(!valWrittenFlag)
        begin
            #10;
        end
        for(i = 0; i < totalNumOfValues; i = i+1)
        begin
            while(o_busy == 1'b1) begin
                #10;
            end
            rst = 1'b1;
            #10;
            rst = 1'b0;
            while(o_busy != 1'b0) begin
                #5;
            end
            if(i%4 == 0 && i > 3'd3)begin
                i_signed = i_signed + 1;
            end
            input_a = arrValsA[i];
            input_b = arrValsA[i];
            #15;
            start = 1'b1;
            while(o_valid != 1'b1) begin
                #1;
            end
            start = 1'b0;
        end
    end
endmodule
