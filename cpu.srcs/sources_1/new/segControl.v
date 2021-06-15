`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/06/01 15:13:48
// Design Name: 
// Module Name: segControl
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


module segControl(
input rst,
input clk190hz,
input subSign,
input [31:0] oprand1,
input [31:0] oprand2,
input [31:0] ans,
output reg [3:0] pos1,
output [7:0] seg1,
output reg [3:0] pos2,
output [7:0] seg2
);
    reg [1:0] posC1,posC2;
    reg [3:0] dataP1,dataP2;
    always @(posedge clk190hz)begin
        if (!rst)
            posC1 <= 0;
        else begin 
        case(posC1)
            0:begin
                pos1<=4'b0001;
                dataP1<=ans[3:0];
            end
            1:begin
                pos1<=4'b0010;
                dataP1<=ans[7:4];
            end
            2:begin
                pos1<=4'b0100;
                dataP1<=4'b0000;
            end
            3:begin
                pos1<=4'b1000;
                dataP1<=oprand2[3:0];
            end
        endcase
        posC1<=posC1+1;
        end
    end
    always @(posedge clk190hz)begin
        if (!rst)
            posC2 <= 0;
        else begin
        case(posC2)
            0:begin
                pos2<=4'b0001;
                dataP2<=oprand2[7:4];
            end
            1:begin
                pos2<=4'b0010;
                dataP2<=4'b0000;
            end
            2:begin
                pos2<=4'b0100;
                dataP2<=oprand1[3:0];
            end
            3:begin
                pos2<=4'b1000;
                dataP2<=oprand1[7:4];
            end
        endcase
        posC2<=posC2+1;
        end
    end
    reg [7:0]segR1,segR2;
    assign seg1 = (pos1 == 4'b0100) ? 8'b0100_1000:segR1;
    assign seg2 = (pos2 == 4'b0010) ? (subSign ? 8'b0100_0000 : 8'b0000_0000):segR2;
    
    always@(*)
        case(dataP1)
            0:segR1=8'b0011_1111;
            1:segR1=8'b0000_0110;
            2:segR1=8'b0101_1011;
            3:segR1=8'b0100_1111;
            4:segR1=8'b0110_0110;
            5:segR1=8'b0110_1101;
            6:segR1=8'b0111_1101;
            7:segR1=8'b0000_0111;
            8:segR1=8'b0111_1111;
            9:segR1=8'b0110_1111;
            10:segR1=8'b0111_0111;
            11:segR1=8'b0111_1100;
            12:segR1=8'b0011_1001;
            13:segR1=8'b0101_1110;
            14:segR1=8'b0111_1001;
            15:segR1=8'b0111_0001;
            default:segR1=8'b0000_1000;//обаа
        endcase
    always@(*)
        case(dataP2)
            0:segR2=8'b0011_1111;
            1:segR2=8'b0000_0110;
            2:segR2=8'b0101_1011;
            3:segR2=8'b0100_1111;
            4:segR2=8'b0110_0110;
            5:segR2=8'b0110_1101;
            6:segR2=8'b0111_1101;
            7:segR2=8'b0000_0111;
            8:segR2=8'b0111_1111;
            9:segR2=8'b0110_1111;
            10:segR2=8'b0111_0111;
            11:segR2=8'b0111_1100;
            12:segR2=8'b0011_1001;
            13:segR2=8'b0101_1110;
            14:segR2=8'b0111_1001;
            15:segR2=8'b0111_0001;
            default:segR2=8'b0000_1000;//обаа
        endcase
endmodule
