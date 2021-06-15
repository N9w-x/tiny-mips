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
    input[1:0] ct_branch,//跳转指令判断ct_branch[1]是beq指令，ct_branch[0]是bne指令
    input[31:0] rf_pc_addr,//jr指令中指定寄存器的值
    output[31:0] inst,
    output[31:0] PC
);
    reg [31:0]pc = 0;//pc地址
    reg[31:0] instRom[65535:0];//指令储存器空间为256kb
    wire[31:0] ext_data;//符号扩展后端值
    
    //initial $readmemh("inst.data",instRom);//加载指令文件到储存器,第一个参数为文件地址，第二个为指令储存器

    ipcore ip(pc[17:2],inst);

    assign PC = pc;

    assign ext_data = {{16{inst[15]}},inst[15:0]};//对数据进行符号扩展

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
