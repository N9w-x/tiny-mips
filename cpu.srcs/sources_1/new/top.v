`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/12/16 21:05:44
// Design Name: 
// Module Name: top
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


module top (
    input clk,rst,
    input clk100mhz,
    output[7:0] segOut1,
    output[7:0] segOut2,
    output[7:0] segCt,
    output subSign//subu执行信号
);
    //IFU
    wire[31:0] inst;//指令数据
    wire[31:0] PC;
    //clk100mhz
    wire clk190hz;
    
    //Control模块输出信号
    wire ct_rf_dst,ct_rf_wen,ct_alu_src,ct_data_rf,ct_jump,ct_mem_wen,ct_mem_ren,ct_addr_pc_wen,ct_jr;
    wire[1:0] ct_branch;
    //
    wire[3:0] ct_alu;
    //RegFile
    wire[4:0] rf_addr_w;
    wire[31:0] rf_data_r1,rf_data_r2, rf_data_w,rf_pc_addr;
    //ALU
    wire  alu_zero;
    wire[31:0] alu_src2;
    wire[31:0] alu_res;
    //
    wire[31:0] ext_data;
    //
    wire[31:0] mem_data_o;
    //
    wire clkXd;
    //
    assign rf_addr_w =ct_addr_pc_wen?5'b11111:(ct_rf_dst?inst[15:11]:inst[20:16]);
    //
    assign rf_data_w =ct_addr_pc_wen?(PC+4):(ct_data_rf?mem_data_o:alu_res);        

    //
    assign ext_data = {{16{inst[15]}},inst[15:0]};
    assign alu_src2 = ct_alu_src?ext_data:rf_data_r2;

    //模块连线
    IFU ifu0(clkXd,rst,alu_zero,ct_jump,ct_jr,ct_branch,rf_pc_addr,inst,PC);

    Control ct0(rst,inst[31:26],inst[5:0],ct_rf_dst,ct_rf_wen,ct_alu_src,ct_alu,ct_mem_wen,ct_mem_ren,ct_data_rf,ct_branch,ct_jump,ct_addr_pc_wen,ct_jr,subSign);

    RegFile rf0(clkXd,ct_rf_wen,inst[25:21],inst[20:16],rf_addr_w,rf_data_w,rf_data_r1,rf_data_r2,rf_pc_addr);

    ALU alu0(rst,ct_alu,rf_data_r1,alu_src2,alu_zero,alu_res);

    DataMem datamem0(clkXd,ct_mem_wen,ct_mem_ren,alu_res,rf_data_r2,mem_data_o);
    
    clkDiv clkdiv(clk100mhz,clk190hz);
    
    segControl segct(rst,clk190hz,subSign,rf_data_r1,alu_src2,alu_res,segCt[3:0],segOut1,segCt[7:4],segOut2);
    
    XD xd1(clk100mhz,clk,clkXd);
endmodule
