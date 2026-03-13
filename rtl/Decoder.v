`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/13/2026 02:04:28 PM
// Design Name: 
// Module Name: Decoder
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


module Decoder(
    input wire [15:0] instr_i,
    output wire [3:0] opcode_o,
    output reg [15:0] op1_o,
    output reg [15:0] op2_o,
    output reg [15:0] imm_o,
    output wire [11:0] j_addr_o
    );
    
    reg [15:0] reg_file [0:15];
    
    wire [3:0] opcode = instr_i[15:12];
    assign opcode_o = opcode;
    
    
    wire [3:0] rs_addr = instr_i[7:4];
    wire [3:0] rt_addr = instr_i[11:8];
    wire [3:0] rd_addr = rt_addr;
    
    wire [15:0] rs = reg_file[rs_addr];
    wire [15:0] rt = reg_file[rt_addr];
    wire [15:0] rd = rt;
    
    wire [3:0] imm = instr_i[3:0];
    wire [15:0] imm_signed = {{12{imm[3]}},imm};
    
    
    
    always @(*) begin
        case (opcode)
            4'b0000 : begin
                op1_o = rs;
                op2_o = rt;
            end
            default : begin
                op1_o = 16'h0000;
                op2_o = 16'h0000;
            end
        endcase
    end
    
    
   
    
endmodule
