`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/06/10 18:44:37
// Design Name: 
// Module Name: tb
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


module tb;
    reg clk = 0;
    reg rst =1;
    reg clk100mhz = 0;
    wire [7:0] segout1,segout2,segct;
    initial begin
        forever
            #50 clk = ~clk;
            #1  clk100mhz = ~clk100mhz;
    end
    top top1(clk,rst,clk100mhz,segout1,segout2,segct,subSign);
endmodule
