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
    
    reg clk = 0;
    always #5 clk = ~clk;
    
    Processor_Wrapper UUT (
    .clk(clk)
    );
endmodule
