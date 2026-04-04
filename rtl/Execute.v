`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/14/2026 01:47:44 AM
// Design Name: 
// Module Name: Execute
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


`include "Defines.v"
module Execute(
    input wire op2_sel,
    input wire alu_sel,
    input wire b_condition,
    input wire [15:0] op1_i,
    input wire [15:0] op2_i,
    input wire [15:0] imm,
    output reg [15:0] alu_result,
    output reg zero
    );
    
    reg [15:0] op1;
    reg [15:0] op2;
    always @(*) begin
        // OP2 Selection mux between RT/RD and IMM
        op1 = op1_i;
        if (op2_sel == 1'b0)
            op2 = op2_i;
        else
            op2 = imm;
            
        // Branch Equivalence Result
        if (b_condition == 0)   
            zero = (op1 == op2) ? 1'b1 : 1'b0;  // BEQ
        else                    
            zero = (op1 != op2) ? 1'b1 : 1'b0;// BNE
        
        // Computation Result
        case (alu_sel)
            `ALU_ADD : begin
                alu_result = $signed(op1) + $signed(op2);
            end
            `ALU_SUB : begin
                alu_result = $signed(op1) - $signed(op2);   
            end
            `ALU_SLL : begin
                alu_result = op2 << op1[3:0];
            end
            `ALU_AND : begin
                alu_result = op1 & op2;
            end
            `ALU_SW : begin
                alu_result = op1 + $signed(op2);
            end
            `ALU_LW : begin
                alu_result = op1 + $signed(op2);
            end
            default : begin
                alu_result = `ZeroWord;
            end
        endcase
    end
    
    
    
    
    
endmodule
