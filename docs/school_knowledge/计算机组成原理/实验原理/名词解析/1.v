//R_I_CPU.v
`timescale 1ns / 1ps // 定义模拟的时间单位和时间精度

module CPU(clk, rst, clk_M,
     OF, ZF, F, ALU_OP, M_R_Data, 
    rd_rt_s, imm_s, rt_imm_s, Mem_Write, alu_mem_s, 
    Write_Reg, R_Data_B, Inst_code
);

// Inputs
input clk, rst, clk_M;// 定义输入端口

output [31:0] PC, PC_new, Inst_code; // 定义输出端口
output [5:0] OP, func; // 定义输出端口
output [4:0] rs, rt, rd; // 定义输出端口
Instruct Instruct_Instance(.clk(clk),.rst(rst), // 实例化Instruct模块
    .PC(PC),.PC_new(PC_new),.Inst_code(Inst_code),
    .OP(OP),.rs(rs),.rt(rt),.rd(rd),.func(func),
    .shamt(),.imm(),.addr());
output reg CF; // 定义输出寄存器
output Write_Reg; // 定义输出端口    
output [2:0] ALU_OP; // 定义输出端口
// Wires
wire [31:0] Inst_code;
wire [5:0] op_code, funct;
wire [4:0] rs_addr, rt_addr, rd_addr, shamt;
wire [31:0] Mem_Addr;
wire [4:0] W_Addr;
wire [31:0] imm_data;
wire [31:0] R_Data_A;
wire [15:0] imm;
wire [31:0] ALU_B;
wire [31:0] W_Data;

// Outputs
output [31:0] F;
output OF, ZF;
output [31:0] M_R_Data;

output rd_rt_s, imm_s, rt_imm_s, Mem_Write, alu_mem_s;
output [31:0] R_Data_B;

// Program Counter
//PC pc1(clk, rst, Inst_code);

// Instruction Decoding
//assign op_code = Inst_code[31:26];
//assign rs_addr = Inst_code[25:21];
//assign rt_addr = Inst_code[20:16];
//assign rd_addr = Inst_code[15:11];
//assign shamt = Inst_code[10:6];
//assign funct = Inst_code[5:0];
//assign imm = Inst_code[15:0];

// Operation Function
//OP_Func op(
//    op_code, funct, Write_Reg, ALU_OP, 
//    rd_rt_s, imm_s, rt_imm_s, Mem_Write, alu_mem_s
//);

// Write Address and Immediate Data Handling
assign W_Addr = (rd_rt_s) ? rt_addr : rd_addr;
assign imm_data = (imm_s) ? {{16{imm[15]}}, imm} : {{16{1'b0}}, imm};
assign W_Data = alu_mem_s ? M_R_Data : F;

// Fourth Experiment Module
Fourth_experiment_first F1(
    rs_addr, rt_addr, Write_Reg, R_Data_A, R_Data_B, 
    rst, clk, W_Addr, W_Data
);

// ALU Input Selection
assign ALU_B = (rt_imm_s) ? imm_data : R_Data_B;

// Third Experiment Module
Third_experiment_first T1(
    OF, ZF, ALU_OP, R_Data_A, ALU_B, F
);

// RAM Module
RAM RAM_B (
    .clka(clk_M),     // Input clock
    .wea(Mem_Write),  // Write enable
    .addra(F[5:0]),   // Address
    .dina(R_Data_B),  // Data input
    .douta(M_R_Data)  // Data output
);

endmodule

//instract.v
`timescale 1ns / 1ps
// 取指令和指令分段模块
module Instruct(clk, rst,
    PC, PC_new, Inst_code,
    OP, rs, rt, rd, shamt, func, imm, addr);
    input clk, rst; // 时钟及重置信号
    output reg [31:0] PC; // Program Counter, 程序计数器
    output [31:0] PC_new; // PC自增值
    output [31:0] Inst_code; // 指令机器码

    always @(negedge clk)
        if (rst) PC <= 32'h0000_0000; // 同步清零
        else PC <= PC_new; // 更新PC
    assign PC_new = PC + 4; // 组合逻辑, 暂存PC自增值

    // 实例化指令存储器IP核
    Rom_Instraction ROM_Instruction_Instance(
        .clka(clk),         // input wire clka
        .addra(PC[7:2]),    // input wire [5 : 0] addra
        .douta(Inst_code)); // output wire [31 : 0] douta

    // 指令分段
    output [5:0] OP, func;
    output [4:0] rs, rt, rd, shamt;
    output [15:0] imm; // offset/immediate of I-Type
    output [25:0] addr; // address of J-Type
    assign OP    = Inst_code[31:26];
    assign rs    = Inst_code[25:21];
    assign rt    = Inst_code[20:16];
    assign rd    = Inst_code[15:11];
    assign shamt = Inst_code[10: 6];
    assign func  = Inst_code[ 5: 0];
    assign imm   = Inst_code[15: 0];
    assign addr  = Inst_code[25: 0];
endmodule

//ROM_Instruction.v
/*******************************************************************************
*     This file is owned and controlled by Xilinx and must be used solely      *
*     for design, simulation, implementation and creation of design files      *
*     limited to Xilinx devices or technologies. Use with non-Xilinx           *
*     devices or technologies is expressly prohibited and immediately          *
*     terminates your license.                                                 *
*                                                                              *
*     XILINX IS PROVIDING THIS DESIGN, CODE, OR INFORMATION "AS IS" SOLELY     *
*     FOR USE IN DEVELOPING PROGRAMS AND SOLUTIONS FOR XILINX DEVICES.  BY     *
*     PROVIDING THIS DESIGN, CODE, OR INFORMATION AS ONE POSSIBLE              *
*     IMPLEMENTATION OF THIS FEATURE, APPLICATION OR STANDARD, XILINX IS       *
*     MAKING NO REPRESENTATION THAT THIS IMPLEMENTATION IS FREE FROM ANY       *
*     CLAIMS OF INFRINGEMENT, AND YOU ARE RESPONSIBLE FOR OBTAINING ANY        *
*     RIGHTS YOU MAY REQUIRE FOR YOUR IMPLEMENTATION.  XILINX EXPRESSLY        *
*     DISCLAIMS ANY WARRANTY WHATSOEVER WITH RESPECT TO THE ADEQUACY OF THE    *
*     IMPLEMENTATION, INCLUDING BUT NOT LIMITED TO ANY WARRANTIES OR           *
*     REPRESENTATIONS THAT THIS IMPLEMENTATION IS FREE FROM CLAIMS OF          *
*     INFRINGEMENT, IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A    *
*     PARTICULAR PURPOSE.                                                      *
*                                                                              *
*     Xilinx products are not intended for use in life support appliances,     *
*     devices, or systems.  Use in such applications are expressly             *
*     prohibited.                                                              *
*                                                                              *
*     (c) Copyright 1995-2018 Xilinx, Inc.                                     *
*     All rights reserved.                                                     *
*******************************************************************************/
// You must compile the wrapper file Rom_Instraction.v when simulating
// the core, Rom_Instraction. When compiling the wrapper file, be sure to
// reference the XilinxCoreLib Verilog simulation library. For detailed
// instructions, please refer to the "CORE Generator Help".

// The synthesis directives "translate_off/translate_on" specified below are
// supported by Xilinx, Mentor Graphics and Synplicity synthesis
// tools. Ensure they are correct for your synthesis tool(s).

`timescale 1ns/1ps

module Rom_Instraction(
  clka,
  addra,
  douta
);

input clka;
input [5 : 0] addra;
output [31 : 0] douta;

// synthesis translate_off

  BLK_MEM_GEN_V7_3 #(
    .C_ADDRA_WIDTH(6),
    .C_ADDRB_WIDTH(6),
    .C_ALGORITHM(1),
    .C_AXI_ID_WIDTH(4),
    .C_AXI_SLAVE_TYPE(0),
    .C_AXI_TYPE(1),
    .C_BYTE_SIZE(9),
    .C_COMMON_CLK(0),
    .C_DEFAULT_DATA("0"),
    .C_DISABLE_WARN_BHV_COLL(0),
    .C_DISABLE_WARN_BHV_RANGE(0),
    .C_ENABLE_32BIT_ADDRESS(0),
    .C_FAMILY("artix7"),
    .C_HAS_AXI_ID(0),
    .C_HAS_ENA(0),
    .C_HAS_ENB(0),
    .C_HAS_INJECTERR(0),
    .C_HAS_MEM_OUTPUT_REGS_A(0),
    .C_HAS_MEM_OUTPUT_REGS_B(0),
    .C_HAS_MUX_OUTPUT_REGS_A(0),
    .C_HAS_MUX_OUTPUT_REGS_B(0),
    .C_HAS_REGCEA(0),
    .C_HAS_REGCEB(0),
    .C_HAS_RSTA(0),
    .C_HAS_RSTB(0),
    .C_HAS_SOFTECC_INPUT_REGS_A(0),
    .C_HAS_SOFTECC_OUTPUT_REGS_B(0),
    .C_INIT_FILE("BlankString"),
    .C_INIT_FILE_NAME("Rom_Instraction.mif"),
    .C_INITA_VAL("0"),
    .C_INITB_VAL("0"),
    .C_INTERFACE_TYPE(0),
    .C_LOAD_INIT_FILE(1),
    .C_MEM_TYPE(3),
    .C_MUX_PIPELINE_STAGES(0),
    .C_PRIM_TYPE(1),
    .C_READ_DEPTH_A(64),
    .C_READ_DEPTH_B(64),
    .C_READ_WIDTH_A(32),
    .C_READ_WIDTH_B(32),
    .C_RST_PRIORITY_A("CE"),
    .C_RST_PRIORITY_B("CE"),
    .C_RST_TYPE("SYNC"),
    .C_RSTRAM_A(0),
    .C_RSTRAM_B(0),
    .C_SIM_COLLISION_CHECK("ALL"),
    .C_USE_BRAM_BLOCK(0),
    .C_USE_BYTE_WEA(0),
    .C_USE_BYTE_WEB(0),
    .C_USE_DEFAULT_DATA(0),
    .C_USE_ECC(0),
    .C_USE_SOFTECC(0),
    .C_WEA_WIDTH(1),
    .C_WEB_WIDTH(1),
    .C_WRITE_DEPTH_A(64),
    .C_WRITE_DEPTH_B(64),
    .C_WRITE_MODE_A("WRITE_FIRST"),
    .C_WRITE_MODE_B("WRITE_FIRST"),
    .C_WRITE_WIDTH_A(32),
    .C_WRITE_WIDTH_B(32),
    .C_XDEVICEFAMILY("artix7")
  )
  inst (
    .CLKA(clka),
    .ADDRA(addra),
    .DOUTA(douta),
    .RSTA(),
    .ENA(),
    .REGCEA(),
    .WEA(),
    .DINA(),
    .CLKB(),
    .RSTB(),
    .ENB(),
    .REGCEB(),
    .WEB(),
    .ADDRB(),
    .DINB(),
    .DOUTB(),
    .INJECTSBITERR(),
    .INJECTDBITERR(),
    .SBITERR(),
    .DBITERR(),
    .RDADDRECC(),
    .S_ACLK(),
    .S_ARESETN(),
    .S_AXI_AWID(),
    .S_AXI_AWADDR(),
    .S_AXI_AWLEN(),
    .S_AXI_AWSIZE(),
    .S_AXI_AWBURST(),
    .S_AXI_AWVALID(),
    .S_AXI_AWREADY(),
    .S_AXI_WDATA(),
    .S_AXI_WSTRB(),
    .S_AXI_WLAST(),
    .S_AXI_WVALID(),
    .S_AXI_WREADY(),
    .S_AXI_BID(),
    .S_AXI_BRESP(),
    .S_AXI_BVALID(),
    .S_AXI_BREADY(),
    .S_AXI_ARID(),
    .S_AXI_ARADDR(),
    .S_AXI_ARLEN(),
    .S_AXI_ARSIZE(),
    .S_AXI_ARBURST(),
    .S_AXI_ARVALID(),
    .S_AXI_ARREADY(),
    .S_AXI_RID(),
    .S_AXI_RDATA(),
    .S_AXI_RRESP(),
    .S_AXI_RLAST(),
    .S_AXI_RVALID(),
    .S_AXI_RREADY(),
    .S_AXI_INJECTSBITERR(),
    .S_AXI_INJECTDBITERR(),
    .S_AXI_SBITERR(),
    .S_AXI_DBITERR(),
    .S_AXI_RDADDRECC()
  );

// synthesis translate_on

endmodule