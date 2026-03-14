`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/13/2026 02:13:45 PM
// Design Name: 
// Module Name: tb_PC
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


module tb_PC(
    );
    
    ///// Generate CLK
    reg clk = 0;
    always #5 clk = ~clk;
    
    //// Sweeps the addresses
    wire[6:0] im_addr_i;
    wire[6:0] im_addr_o;
    wire[15:0] instr_o;
    
    assign im_addr_i = im_addr_o;
    
    
    
    PC UUT (
    .clk(clk),
    .im_addr_i(im_addr_i),
    .im_addr_o(im_addr_o),
    .instr_o(instr_o)
    );
    
    
    
endmodule
