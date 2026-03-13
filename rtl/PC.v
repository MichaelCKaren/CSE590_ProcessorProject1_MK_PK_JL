`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/13/2026 02:04:28 PM
// Design Name: 
// Module Name: PC
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


module PC(
    input wire clk,
    input wire [6:0] im_addr_i,
    output wire [6:0] im_addr_o,
    output wire [15:0] instr_o
    );
    
    //// Clocked Registers
    reg [6:0] im_addr_reg = 7'b0000000;
    reg [15:0] instr_reg;
    // Instruction Memeory 
    reg [7:0] instruction_mem [0:127];
    
    initial begin
        $readmemh("/home/waveshop/Documents/PersonalMK/School/CSE590_Project1/tests/hex_data.txt", instruction_mem);
    end
    
    //// Fetch and Increment
    always @(posedge clk) begin
        if (im_addr_i < 128)
            im_addr_reg <= im_addr_i+2;
        else 
            im_addr_reg <= 7'b0000000;
    end
    
    
    assign im_addr_o = im_addr_reg;
    assign instr_o[7:0] = instruction_mem[im_addr_i];
    assign instr_o[15:8] = instruction_mem[im_addr_i+1];
   
    
endmodule
