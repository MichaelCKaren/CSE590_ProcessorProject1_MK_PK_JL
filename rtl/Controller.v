`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/13/2026 06:19:22 PM
// Design Name: 
// Module Name: Controller
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

module Controller(
    input wire [3:0] opcode,
    input wire [3:0] funct,
    output reg reg_wen,         // Register Write Enable, Active High
    output reg op2_sel,         // Operand 2 Select For ALU, 0 = op2, 1 = imm_signed
    output reg [2:0] alu_sel,   // ALU Operation Select, 0 = ADD, 1 = SUB, 2 = SLL, 3 = AND
    output reg b_con,           // Branch Condition, 0 = BEQ, 1 = BNE
    output reg branch,          // Branch Enable, Active High
    output reg jump,            // Jump Enable, Active High
    output reg mem_wen,         // Memory Write Enable, Active High
    output reg mem_ren,         // Memory Read Enable, Active High
    output reg wb_sel,          // Write Back Select, 0 = ALU Result, 1 = Memory Result
    output reg digit_w         // Write op1 to digital display
    );
    
    // Begin Function Decoding
    always @(*) begin
        case (opcode)
            `OP_R : begin
                case (funct)
                    `FUNCT_ADD : begin
                        reg_wen = 1'b1;
                        op2_sel = 1'b0;
                        alu_sel = `ALU_ADD;
                        b_con   = 1'b0;
                        branch  = 1'b0;
                        jump    = 1'b0;
                        mem_wen = 1'b0;
                        mem_ren = 1'b0;
                        wb_sel  = 1'b0;
                        digit_w = 1'b0;
                    end
                    `FUNCT_SUB : begin
                        reg_wen = 1'b1;
                        op2_sel = 1'b0;
                        alu_sel = `ALU_SUB;
                        b_con = 1'b0;
                        branch = 1'b0;
                        jump = 1'b0;
                        mem_wen = 1'b0;
                        mem_ren = 1'b0;
                        wb_sel = 1'b0;
                        digit_w = 1'b0;
                    end
                    `FUNCT_SLL : begin
                        reg_wen = 1'b1;
                        op2_sel = 1'b0;
                        alu_sel = `ALU_SLL;
                        b_con = 1'b0;
                        branch = 1'b0;
                        jump = 1'b0;
                        mem_wen = 1'b0;
                        mem_ren = 1'b0;
                        wb_sel = 1'b0;
                        digit_w = 1'b0;
                    end
                    `FUNCT_AND : begin
                        reg_wen = 1'b1;
                        op2_sel = 1'b0;
                        alu_sel = `ALU_AND;
                        b_con = 1'b0;
                        branch = 1'b0;
                        jump = 1'b0;
                        mem_wen = 1'b0;
                        mem_ren = 1'b0;
                        wb_sel = 1'b0;
                        digit_w = 1'b0;
                    end
                    default : begin
                        reg_wen = 1'b0;
                        op2_sel = 1'b0;
                        alu_sel = 3'd0;
                        b_con   = 1'b0;
                        branch  = 1'b0;
                        jump    = 1'b0;
                        mem_wen = 1'b0;
                        mem_ren = 1'b0;
                        wb_sel  = 1'b0;
                        digit_w = 1'b0;
                    end
                endcase
            end
            `OP_LW : begin
                reg_wen = 1'b1;
                op2_sel = 1'b1;
                alu_sel = `ALU_LW;
                b_con   = 1'b0;
                branch  = 1'b0;
                jump    = 1'b0;
                mem_wen = 1'b0;
                mem_ren = 1'b1;
                wb_sel  = 1'b1;
                digit_w = 1'b0;
            end
            `OP_SW : begin
                reg_wen = 1'b0;
                op2_sel = 1'b1;
                alu_sel = `ALU_SW;
                b_con   = 1'b0;
                branch  = 1'b0;
                jump    = 1'b0;
                mem_wen = 1'b1;
                mem_ren = 1'b0;
                wb_sel  = 1'b0;
                digit_w = 1'b0;    
            end
            `OP_ADDI : begin
                reg_wen = 1'b1;
                op2_sel = 1'b1;
                alu_sel = `ALU_ADD;
                b_con   = 1'b0;
                branch  = 1'b0;
                jump    = 1'b0;
                mem_wen = 1'b0;
                mem_ren = 1'b0;
                wb_sel  = 1'b0;
                digit_w = 1'b0;
                
            end
            `OP_BEQ : begin
                reg_wen = 1'b0;
                op2_sel = 1'b0;
                alu_sel = 3'd0;
                b_con   = 1'b0;
                branch  = 1'b1;
                jump    = 1'b0;
                mem_wen = 1'b0;
                mem_ren = 1'b0;
                wb_sel  = 1'b0;
                digit_w = 1'b0;
                
            end
            `OP_BNE : begin
                reg_wen = 1'b0;
                op2_sel = 1'b0;
                alu_sel = 3'd0;
                b_con   = 1'b1;
                branch  = 1'b1;
                jump    = 1'b0;
                mem_wen = 1'b0;
                mem_ren = 1'b0;
                wb_sel  = 1'b0;
                digit_w = 1'b0;
            end
            `OP_JMP : begin
                reg_wen = 1'b0;
                op2_sel = 1'b0;
                alu_sel = 3'd0;
                b_con   = 1'b0;
                branch  = 1'b0;
                jump    = 1'b1;
                mem_wen = 1'b0;
                mem_ren = 1'b0;
                wb_sel  = 1'b0;
                digit_w = 1'b0;
            end
            `OP_DIG : begin
                reg_wen = 1'b0;
                op2_sel = 1'b0;
                alu_sel = 3'd0;
                b_con   = 1'b0;
                branch  = 1'b0;
                jump    = 1'b0;
                mem_wen = 1'b0;
                mem_ren = 1'b0;
                wb_sel  = 1'b0;
                digit_w = 1'b1;
            end
            default : begin
                reg_wen = 1'b0;
                op2_sel = 1'b0;
                alu_sel = 2'd0;
                b_con   = 1'b0;
                branch  = 1'b0;
                jump    = 1'b0;
                mem_wen = 1'b0;
                mem_ren = 1'b0;
                wb_sel  = 1'b0;
            end
        endcase
    end
    
endmodule
