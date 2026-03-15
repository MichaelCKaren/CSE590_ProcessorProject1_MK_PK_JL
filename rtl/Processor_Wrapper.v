`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/14/2026 01:56:52 AM
// Design Name: 
// Module Name: Processor_Wrapper
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


module Processor_Wrapper(
    input wire clk
    );
    
    // ========== Routing Signals ==========
    // Instruction Fetch Signals
    wire [15:0] im_addr_i;
    wire [15:0] im_addr_o;
    wire [15:0] im_addr_final;
    assign im_addr_i = im_addr_final;
    wire [15:0] instr;
    
    // Decoder Output Signals
    reg [15:0] reg_wdata;
    wire [3:0] opcode;
    wire [3:0] funct;
    wire [15:0] op1_d;
    wire [15:0] op2_d;
    wire [15:0] imm;
    wire [15:0] j_addr;
    
    // Controller Output Signals
    wire reg_wen;
    wire op2_sel;
    wire [1:0] alu_sel;
    wire branch;
    wire jump;
    wire mem_wen;
    wire mem_ren;
    wire wb_sel;
    
    // Execute Output Signals
    wire [15:0] alu_result;
    wire zero;
    
    // Memory Signals
    wire [15:0] mem_data;
    
    // ========== Hardware Modules ==========
    PC u_if (
    .clk(clk),
    .im_addr_i(im_addr_i),
    .im_addr_o(im_addr_o),
    .instr_o(instr)
    );
    
    Decoder u_id (
    .instr_i(instr),
    .reg_wen(reg_wen),
    .reg_wdata(),
    .opcode_o(opcode),
    .op1_o(op1_d),
    .op2_o(op2_d),
    .imm_o(imm),
    .j_addr_o(j_addr)
    );
    
    Controller u_control (
    .opcode(opcode),
    .funct(funct),
    .reg_wen(reg_wen),         
    .op2_sel(op2_sel),         
    .alu_sel(alu_sel),    
    .branch(branch),          
    .jump(jump),            
    .mem_wen(mem_wen),         
    .mem_ren(mem_ren),         
    .wb_sel(wb_sel)           
    );
    
    Execute u_ex (
    .op2_sel(op2_sel),
    .alu_sel(alu_sel),
    .op1_i(op1_d),
    .op2_i(op2_d),
    .imm(imm),
    .alu_result(alu_result),
    .zero(zero)
    );
    
    ProgramAddressCalc u_pc_calc(
    .im_addr_i(im_addr_o),
    .b_imm(imm),
    .j_imm(j_addr),
    .zero(zero),
    .branch(branch),
    .jump(jump),
    .im_addr_o(im_addr_final)
    );
    
    DataMemory u_mem(
    .mem_wen(mem_wen),
    .mem_ren(mem_ren),
    .mem_addr_i(alu_result),
    .mem_data_i(op2_d),
    .mem_data_o(mem_data)
    );
    
    // ========== WB MUX ==========
    always @(*) begin
        if (wb_sel == 0)
            reg_wdata = alu_result;
        else
            reg_wdata = mem_data;
    end
    
endmodule
