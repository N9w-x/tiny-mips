`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/06/01 15:13:48
// Design Name: 
// Module Name: clkDiv
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

module clkDiv (
  input clk100mhz,
  output clk190hz
);
  reg[25:0] count = 0;
  assign clk190hz = count[18];
  always @(posedge  clk100mhz) 
    count <= count + 1;
endmodule
