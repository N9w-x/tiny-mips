`timescale 1ns/1ps

module Control (
    input rst,
    input[5:0] ct_inst,
    input[5:0] aluct_inst,
    output ct_rf_dst,
    output ct_rf_wen,
    output ct_alu_src,
    output[3:0] ct_alu,
    output ct_mem_wen,
    output ct_mem_ren,
    output ct_data_rf,
    output[1:0] ct_branch,
    output ct_jump,
    output ct_addr_pc_wen,//jal向$31写的控制信号
    output ct_jr,
    output subSign
);
    wire inst_r,inst_lw,inst_sw,inst_beq,inst_j,inst_addiu;
    //扩展指令的控制信号
    wire inst_andi,inst_jal,inst_jr,inst_bne;
    
    wire[2:0] ct_alu_op;
    ALUCt aluct0(rst,aluct_inst,ct_alu_op,ct_alu,subSign);
    assign inst_r = (!ct_inst[5])&&(!ct_inst[4])&&(!ct_inst[3])&&(!ct_inst[2])&&(!ct_inst[1])&&(!ct_inst[0]);
    assign inst_lw = (ct_inst[5])&&(!ct_inst[4])&&(!ct_inst[3])&&(!ct_inst[2])&&(ct_inst[1])&&(ct_inst[0]);
    //判断指令类型
    assign inst_sw = (ct_inst[5])&&(!ct_inst[4])&&(ct_inst[3])&&(!ct_inst[2])&&(ct_inst[1])&&(ct_inst[0]);
    assign inst_beq = (!ct_inst[5])&&(!ct_inst[4])&&(!ct_inst[3])&&(ct_inst[2])&&(!ct_inst[1])&&(!ct_inst[0]);
    assign inst_addiu =(!ct_inst[5])&&(!ct_inst[4])&&(ct_inst[3])&&(!ct_inst[2])&&(!ct_inst[1])&&(ct_inst[0]);
    assign inst_j = (!ct_inst[5])&&(!ct_inst[4])&&(!ct_inst[3])&&(!ct_inst[2])&&(ct_inst[1])&&(!ct_inst[0]);
    
    //扩展指令的判断
    assign inst_andi = (!ct_inst[5])&&(!ct_inst[4])&&(ct_inst[3])&&(ct_inst[2])&&(!ct_inst[1])&&(!ct_inst[0]);
    assign inst_jal = (!ct_inst[5])&&(!ct_inst[4])&&(!ct_inst[3])&&(!ct_inst[2])&&(ct_inst[1])&&(ct_inst[0]);
    assign inst_jr = inst_r?(aluct_inst==6'b001000):0;
    assign inst_bne = (!ct_inst[5])&&(!ct_inst[4])&&(!ct_inst[3])&&(ct_inst[2])&&(!ct_inst[1])&&(ct_inst[0]);
    //输出其他模块的使能端
    
    assign ct_rf_dst = rst?inst_r:0;
    assign ct_rf_wen = rst?inst_r||inst_lw||inst_addiu||inst_andi||inst_jal:0;
    assign ct_alu_src = inst_lw||inst_sw||inst_addiu||inst_andi;
    assign ct_alu_op[2:0] = {inst_r,inst_beq,inst_andi};
    assign ct_mem_wen = inst_sw;
    assign ct_mem_ren = inst_lw;
    assign ct_branch[1:0] ={inst_beq,inst_bne};
    assign ct_jump =   rst?inst_j||inst_jal:0;
    assign ct_data_rf = inst_lw;
    assign ct_addr_pc_wen = inst_jal;
    assign ct_jr = inst_jr;
endmodule