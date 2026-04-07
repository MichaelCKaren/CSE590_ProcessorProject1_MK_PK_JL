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

`include "Defines.v"
module DataMemory(
    input wire clk,
    input wire mem_wen,
    input wire mem_ren,
    input wire [6:0] mem_addr_i,
    input wire [15:0] mem_data_i,
    output reg [15:0] mem_data_o
    );
   
    // Initialize Data Memory
    reg [7:0] mem_data [0:127];
    initial begin
        $readmemh("/home/waveshop/Documents/PersonalMK/School/CSE590_Project1/ZEROS_MEM.txt", mem_data);
    end
   
    // Memory Write, Memory Read, and Memory Default
    reg [6:0] mem_addr;
    always @(*) begin
        // Shift Left By 1
        mem_addr = mem_addr_i << 1;
        
        if (mem_ren == 1'b1) begin
            mem_data_o = {mem_data[mem_addr+1], mem_data[mem_addr]};
        end
        else begin
            mem_data_o = `ZeroWord;
        end
    end
    
    always @(posedge clk) begin
        if (mem_wen == 1'b1) begin
            mem_data[mem_addr] <= mem_data_i[7:0];
            mem_data[mem_addr+1] <= mem_data_i[15:8];
        end
    end
    
endmodule
