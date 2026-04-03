`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/03/2026 04:17:45 PM
// Design Name: 
// Module Name: DigitControl
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


module DigitControl(
    input wire X,
    
    output reg A,
    output reg B,
    output reg C,
    output reg D,
    output reg E,
    output reg F,
    output reg G
    );

    always @(*) begin
        case(X) 
            4'h0 : begin
                A <= 0;
                B <= 0;
                C <= 0;
                D <= 0;
                E <= 0;
                F <= 0;
                G <= 1;
            end
            4'h1 : begin
                A <= 1;
                B <= 0;
                C <= 0;
                D <= 1;
                E <= 1;
                F <= 1;
                G <= 1;
            end
            4'h2 : begin
                A <= 0;
                B <= 0;
                C <= 1;
                D <= 0;
                E <= 0;
                F <= 1;
                G <= 0;
            end
            4'h3 : begin
                A <= 0;
                B <= 0;
                C <= 0;
                D <= 0;
                E <= 1;
                F <= 1;
                G <= 0;
            end
            4'h4 : begin
                A <= 1;
                B <= 0;
                C <= 0;
                D <= 1;
                E <= 1;
                F <= 0;
                G <= 0;
            end
            4'h5 : begin
                A <= 0;
                B <= 1;
                C <= 0;
                D <= 0;
                E <= 1;
                F <= 0;
                G <= 0;
            end
            4'h6 : begin
                A <= 0;
                B <= 1;
                C <= 0;
                D <= 0;
                E <= 0;
                F <= 0;
                G <= 0;
            end
            4'h7 : begin
                A <= 0;
                B <= 0;
                C <= 0;
                D <= 1;
                E <= 1;
                F <= 1;
                G <= 1;
            end
            4'h8 : begin
                A <= 0;
                B <= 0;
                C <= 0;
                D <= 0;
                E <= 0;
                F <= 0;
                G <= 0;
            end
            4'h9 : begin
                A <= 0;
                B <= 0;
                C <= 0;
                D <= 0;
                E <= 1;
                F <= 0;
                G <= 0;
            end
            4'hA : begin
                A <= 0;
                B <= 0;
                C <= 0;
                D <= 1;
                E <= 0;
                F <= 0;
                G <= 0;
            end
            4'hB : begin
                A <= 1;
                B <= 1;
                C <= 0;
                D <= 0;
                E <= 0;
                F <= 0;
                G <= 0;
            end
            4'hC : begin
                A <= 0;
                B <= 1;
                C <= 1;
                D <= 0;
                E <= 0;
                F <= 0;
                G <= 1;
            end
            4'hD : begin
                A <= 1;
                B <= 0;
                C <= 0;
                D <= 0;
                E <= 0;
                F <= 1;
                G <= 0;
            end
            4'hE : begin
                A <= 0;
                B <= 1;
                C <= 1;
                D <= 0;
                E <= 0;
                F <= 0;
                G <= 0;
            end
            4'hF : begin
                A <= 0;
                B <= 1;
                C <= 1;
                D <= 1;
                E <= 0;
                F <= 0;
                G <= 0;
            end
            default : begin
                A <= 1;
                B <= 1;
                C <= 1;
                D <= 1;
                E <= 1;
                F <= 1;
                G <= 0;
            end
        endcase
    end
    
endmodule
