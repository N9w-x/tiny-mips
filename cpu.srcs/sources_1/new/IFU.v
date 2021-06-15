`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/12/15 08:34:48
// Design Name: 
// Module Name: IFU
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


module IFU (
    input clk,rst,
    input alu_zero,ct_jump,ct_jr,
    input[1:0] ct_branch,//��תָ���ж�ct_branch[1]��beqָ�ct_branch[0]��bneָ��
    input[31:0] rf_pc_addr,//jrָ����ָ���Ĵ�����ֵ
    output[31:0] inst,
    output[31:0] PC
);
    reg [31:0]pc = 0;//pc��ַ
    reg[31:0] instRom[65535:0];//ָ������ռ�Ϊ256kb
    wire[31:0] ext_data;//������չ���ֵ
    
    //initial $readmemh("inst.data",instRom);//����ָ���ļ���������,��һ������Ϊ�ļ���ַ���ڶ���Ϊָ�����

    ipcore ip(pc[17:2],inst);

    assign PC = pc;

    assign ext_data = {{16{inst[15]}},inst[15:0]};//�����ݽ��з�����չ

    always @(posedge clk) begin
        if(!rst)
            pc<=0;
        else begin 
            if(ct_jr)begin
                pc<=rf_pc_addr;
            end
            else if(ct_jump)begin
                pc<={pc[31:28],inst[25:0],2'b00};
            end
            else if(ct_branch[1]&&alu_zero)begin
                pc<=pc + 4 + {ext_data[29:0],2'b00};
            end
            else if(ct_branch[0]&&(!alu_zero))begin
                pc<=pc + 4 + {ext_data[29:0],2'b00};
            end
            else
                pc <= pc+4;
        end
    end
endmodule
