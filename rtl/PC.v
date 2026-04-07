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
    input wire [15:0] im_addr_i,
    output wire [15:0] im_addr_o,
    output wire [15:0] instr_o
    );
    
    //// Clocked Registers
    reg [15:0] im_addr_reg = 16'h0000;
    // Instruction Memeory 
    reg [7:0] instruction_mem [0:127];
    
    //initial begin
    //    // ADD TEST
    //    instruction_mem[0] = 8'b00110000;
    //    instruction_mem[1] = 8'b00000110;
    //    // STORE WORD TEST
    //    instruction_mem[2] = 8'b11100000;
    //    instruction_mem[3] = 8'b00101111;
    //    //BNE TEST
    //    //instruction_mem[4] = 8'b00101101;
    //    //instruction_mem[5] = 8'b01010100;
    //    instruction_mem[4] = 8'b11111101;
    //    instruction_mem[5] = 8'b01101111;
    //end
    initial begin
    //    $readmemh("/home/waveshop/Documents/PersonalMK/School/CSE590_Project1/tests/hex_data.txt", instruction_mem);
        $readmemh("/home/waveshop/CSE590_ProcessorProject1_MK_PK_JL/rtl/HexFiles/DEMO/IM_DEADBEEF.txt", instruction_mem);
    end
    
    //// Fetch and Increment
    always @(posedge clk) begin
        //if (im_addr_i < 128)
            im_addr_reg <= im_addr_i;
        //else 
            //im_addr_reg <= 16'h0000;
    end
    
    
    assign im_addr_o = im_addr_reg+2;
    assign instr_o[7:0] = instruction_mem[im_addr_reg];
    assign instr_o[15:8] = instruction_mem[im_addr_reg+1];
   
    
endmodule
