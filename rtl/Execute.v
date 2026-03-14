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
    input wire [15:0] op1_i,
    input wire [15:0] op2_i,
    input wire [15:0] imm,
    output reg [15:0] alu_result,
    output reg zero
    );
    
    always @(*) begin
        zero = (op1_i == op2_i) ? 1'b1 : 1'b0;
        case (alu_sel)
            `ALU_ADD : begin
                alu_result = op1_i + op2_i;
            end
            `ALU_SUB : begin
            
            end
            `ALU_SLL : begin
            
            end
            `ALU_AND : begin
            
            end
            default : begin
                alu_result = `ZeroWord;
            end
        endcase
    end
    
    
    
    
    
endmodule
