`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/12/16 00:03:47
// Design Name: 
// Module Name: RegFile
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


module RegFile( 
    input clk,  
    //д�Ĵ���ʹ���ź�
    input rf_wen,
    //ͨ���Ĵ����ڴ��ȡ�Ĵ����е�ֵ
    input[4:0] rf_addr_r1,
    input[4:0] rf_addr_r2,
    //�Ĵ������ڴ��еĵ�ַ��д���ֵ
    input[4:0] rf_addr_w,
    input[31:0] rf_data_w,
    //����˿�
    output[31:0]rf_data_r1,
    output[31:0]rf_data_r2,
    output[31:0]rf_pc_addr
);
    reg [31:0] file[31:0];//�Ĵ����ڴ� 32��32λ�Ĵ���

    integer i;
    initial begin
        for(i =0;i<32;i=i+1)
            file[i] = 32'b0;
    end

    assign rf_data_r1 = file[rf_addr_r1];
    assign rf_data_r2 = file[rf_addr_r2];
    assign rf_pc_addr = file[31];
    
    always @(negedge clk) begin
        if(rf_wen)begin
            file[rf_addr_w] <= rf_data_w;
        end
    end
endmodule