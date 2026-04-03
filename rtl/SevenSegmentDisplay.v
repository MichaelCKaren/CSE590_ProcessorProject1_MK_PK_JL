`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/03/2026 03:24:04 PM
// Design Name: 
// Module Name: SevenSegmentDisplay
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


module SevenSegmentDisplay(
    input wire s_clk,
    input wire s_aresetn,
    input wire m_clk,
    input wire m_aresetn,
    input wire [15:0] data,
    
    output reg A,
    output reg B,
    output reg C,
    output reg D,
    output reg E,
    output reg F,
    output reg G,
    output wire DOT,
    output reg digit3,
    output reg digit2,
    output reg digit1,
    output reg digit0
    );
    
    
    
    reg [3:0] x3; // MSB - Left Most
    reg [3:0] x2;
    reg [3:0] x1;
    reg [3:0] x0; // LSB - Right Most


    // Register Output
    always @(posedge s_clk) begin
        x3 <= data[15:12];
        x2 <= data[11:8];
        x1 <= data[7:4];
        x0 <= data[3:0];
    end
    
    // Output Digit FSM
    reg [1:0] state = 2'b00;
    reg [1:0] next_state =2'b01;
    localparam CERO = 2'b00;
    localparam UNO  = 2'b01;
    localparam DOS  = 2'b10;
    localparam TRES = 2'b11;

    always @(posedge m_clk) begin
        if (~m_aresetn) begin
            state  <= CERO;
            next_state <= UNO;
            digit3 <= 1'b0;
            digit2 <= 1'b0;
            digit1 <= 1'b0;
            digit0 <= 1'b0;
        end
        else if (state == CERO) begin
            digit0 <= 1'b0;
            digit3 <= 1'b1;
            state  <= UNO;
            next_state <= DOS;
        end
        else if (state == UNO) begin
            digit3 <= 1'b0;
            digit2 <= 1'b1;
            state <= DOS;
            next_state <= TRES;
        end
        else if (state == DOS) begin
            digit2 <= 1'b0;
            digit1 <= 1'b1;
            state <= TRES;
            next_state <= CERO;
        end
        else if (state == TRES) begin
            digit1 <= 1'b0;
            digit0 <= 1'b1;
            state <= CERO;
            next_state <= UNO;
        end
        else begin
            state  <= CERO;
            digit3 <= 1'b0;
            digit2 <= 1'b0;
            digit1 <= 1'b0;
            digit0 <= 1'b0;
        end
        
    end
    
    reg [3:0] x_in;
    // Segment Control
    assign DOT = 1'b0;
    always @(posedge m_clk) begin
        if (~m_aresetn) begin
            x_in <= 0;
        end
        else if (next_state == CERO) begin
            x_in <= x0;
        end
        else if (next_state == UNO) begin
            x_in <= x1;
        end
        else if (next_state == DOS) begin
            x_in <= x2;
        end
        else if (next_state == TRES) begin
            x_in <= x3;
        end
        else begin
            x_in <= 0;
        end
    end
    
    DigitControl u_digit(
    .X(x_in),
    .A(A),
    .B(B),
    .C(C),
    .D(D),
    .E(E),
    .F(F),
    .G(G)
    );
    
    
endmodule
