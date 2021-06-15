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
    //写寄存器使能信号
    input rf_wen,
    //通过寄存器内存读取寄存器中的值
    input[4:0] rf_addr_r1,
    input[4:0] rf_addr_r2,
    //寄存器在内存中的地址和写入的值
    input[4:0] rf_addr_w,
    input[31:0] rf_data_w,
    //输出端口
    output[31:0]rf_data_r1,
    output[31:0]rf_data_r2,
    output[31:0]rf_pc_addr
);
    reg [31:0] file[31:0];//寄存器内存 32个32位寄存器

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