`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/14/2026 05:14:48 PM
// Design Name: 
// Module Name: ProgramAddressCalc
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


module ProgramAddressCalc(
    input wire [15:0] im_addr_i,
    input wire [15:0] b_imm,
    input wire [15:0] j_imm,
    input wire zero,
    input wire branch,
    input wire jump,
    output wire [15:0] im_addr_o
    );
    
    reg [15:0] im_addr_reg1;
    reg [15:0] im_addr_reg2;
    
    always @(*) begin
        // Branch Condition
        if (branch == 1 && zero == 1)
            im_addr_reg1 = im_addr_i + ($signed(b_imm) << 1);
        else
            im_addr_reg1 = im_addr_i;
        // Jump Condition
        if (jump == 1)
            im_addr_reg2 = im_addr_i + ($signed(j_imm) << 1);
        else
            im_addr_reg2 = im_addr_reg1;
    end
    
    assign im_addr_o = im_addr_reg2;
    
endmodule
