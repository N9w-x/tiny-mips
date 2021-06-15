`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/12/16 21:05:03
// Design Name: 
// Module Name: ALUCt
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


module ALUCt (
    input rst,
    input[5:0] funct,
    input[2:0] alu_ct_op,
    output reg[3:0] alu_ct,
    output subSign
);
    assign subSign = alu_ct_op == 3'b100 && funct == 6'b100011;
    always @(*) begin
        if(!rst)
            alu_ct<=0;
        else begin
            case (alu_ct_op)
                3'b000:alu_ct= 4'b0010;
                3'b010:alu_ct=4'b0110; 
                3'b001:alu_ct=4'b1001;
                3'b100:case (funct)
                    6'b100001:alu_ct=4'b0010;//addu
                    6'b100011:begin
                        alu_ct=4'b0110;//subu
                    end
                endcase
            endcase
        end
    end
endmodule