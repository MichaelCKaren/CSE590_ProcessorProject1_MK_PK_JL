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

`include "Defines.v"

module Decoder(
    input wire clk,
    input wire [15:0] instr_i,
    input wire reg_wen,
    input wire [15:0] reg_wdata,
    output wire [3:0] opcode_o,
    output wire [3:0] funct_o,
    output wire [15:0] op1_o,
    output wire [15:0] op2_o,
    output wire [15:0] imm_o,
    output wire [15:0] j_addr_o
    );
    
    // Instaniate Register File
    reg [15:0] reg_file [0:15];
    
    initial begin
        //$readmemh("/home/waveshop/Documents/PersonalMK/School/CSE590_Project1/tests/ADD_TEST_REG.txt", reg_file);
        $readmemh("/home/waveshop/Documents/PersonalMK/School/CSE590_Project1/SW_TEST_REG.txt", reg_file);
        reg_file[15] = 16'hB0BA;
    end
    
    // Parse Opcode 
    wire [3:0] opcode = instr_i[15:12];
    assign opcode_o = opcode;
    
    // Parse Register Addresses
    wire [3:0] rs_addr = instr_i[7:4];
    wire [3:0] rt_addr = instr_i[11:8];
    wire [3:0] rd_addr = rt_addr;
    
    // Fetch Register Data
    wire [15:0] rs = reg_file[rs_addr];
    wire [15:0] rt = reg_file[rt_addr];
    
    assign op1_o = rs;
    assign op2_o = rt;
    

    // Parse Funct and IMM + Sign Extended
    wire [3:0] funct = instr_i[3:0];
    assign funct_o = funct;
    wire [3:0] imm = funct;
    wire [15:0] imm_signed = {{12{imm[3]}},imm};
    assign imm_o = imm_signed;
    assign j_addr_o = {{4{instr_i[11]}},instr_i[11:0]};
    
    // Write Operation
    always @(posedge clk) begin
        if (reg_wen == 1'b1) begin
            reg_file[rd_addr] = reg_wdata;
        end
    end
    
endmodule
