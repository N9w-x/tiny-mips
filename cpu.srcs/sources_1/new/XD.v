`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/06/08 17:54:33
// Design Name: 
// Module Name: XD
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


module XD(
input clk,
input key_in,
output key_out
    );
    reg[25:0] count_low;
    reg[25:0] count_high;
    reg key_out_reg;
    parameter SAMPLE_TIME = 500000;
    always@(posedge clk)
        if(key_in == 1'b0)
            count_low <= count_low + 1;
        else
            count_low <= 0;
     always@(posedge clk)
        if(key_in == 1'b1)
            count_high <= count_high + 1;
        else
            count_high <= 0;     
      always@(posedge clk)
        if(count_high == SAMPLE_TIME)
            key_out_reg <= 1;
        else if(count_low == SAMPLE_TIME)
            key_out_reg <= 0;
      assign key_out = key_out_reg;
endmodule
