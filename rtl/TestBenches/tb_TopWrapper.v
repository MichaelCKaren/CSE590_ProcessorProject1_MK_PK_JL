`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/14/2026 03:21:30 AM
// Design Name: 
// Module Name: tb_TopWrapper
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


module tb_TopWrapper(
    );
    
    reg clk_button = 0;
    always #1000 clk_button = ~clk_button;
    reg clk_crystal = 0;
    always #1 clk_crystal = ~clk_crystal;
    
    Processor_Wrapper UUT (
    .clk_crystal(clk_crystal),
    .clk_button(clk_button),
    .clk_mux_switch(1'b1)
    );
endmodule
