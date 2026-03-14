`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/14/2026 02:03:37 AM
// Design Name: 
// Module Name: DataMemory
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


module DataMemory(
    input wire mem_wen,
    input wire mem_ren,
    input wire [6:0] mem_addr_i,
    input wire [15:0] mem_data_i,
    output reg [15:0] mem_data_o
    );
   
    // Initialize Data Memory
    reg [7:0] mem_data [0:127];
   
    // Memory Write, Memory Read, and Memory Default
    always @(*) begin
        if (mem_wen == 1'b1) begin
            mem_data[mem_addr_i] = mem_data_i;
        end
        else if (mem_ren == 1'b1) begin
            mem_data_o = mem_data[mem_addr_i];
        end
        else begin
            mem_data_o = `ZeroWord;
        end
    end
    
endmodule
