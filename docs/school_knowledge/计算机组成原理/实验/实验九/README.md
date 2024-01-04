# 实验九

## 1、实验目的 
- 掌握MIPS R型和I型指令的综合数据通路设计
- 掌握数据流的多路选通控制方法
- 掌握取数指令lw和存数指令sw指令的寻址方式及其有效地址产生方法
- 实现MIPS的部分 I型和R型指令的功能

## 2、实验内容与原理

- 实验八的基础上，再行实现MIPS的6条I型指令：

  - 4条立即数寻址的运算和传送指令
  - 2条相对寄存器寻址的存数和取数指令。
  - 与原理课相比，多了4条立即数运算指令。

  

### （1）MIPS的I型立即数寻址指令及数据通路

![image-20240103171042066](./assets/image-20240103171042066.png)

#### I型与R型指令有明显不同

- 没有rd寄存器，使用rt作为目的寄存器；
- 源操作数有一个为立即数，位于指令的低16位。

#### 解决目的寄存器的可选性

- 设置一个二选一数据选择器，控制信号为rd_rt_s：
  - 当rd_rt_s=0，将指令的rd字段送写地址W_Addr；
  - 当rd_rt_s=1，将指令的rt字段送写地址W_Addr。

**Verilog语句如下：**

```verilog
 assign W_Addr = (rd_rt_s) ? rt : rd;
```



#### 扩展16位的立即数imm

- 设置一位imm_s来控制这两种扩展：
  - imm_s=1，符号扩展；
  - imm_s=0，则0扩展。

**Verilog语句如下：**

```verilog
assign imm_data=(imm_s) ?{16{imm[15]},imm} :{16{1’b0},imm};
```

#### ALU的输入数据B端的数据选择

- 设置二选一数据选择器（控制信号为rt_imm_s）
  - 当rt_imm_s=0，将寄存器堆的B端口读出数据R_Data_B送ALU的B端
  - 当rt_imm_s=1，将扩展好的立即数imm_data送ALU的B输入端

**Verilog语句如下:**

```verilog
assign ALU_B = (rt_imm_s) ? imm_data :R_Data_B;
```



#### 改造的数据通路

![image-20240103171436253](./assets/image-20240103171436253.png)

### （2）I型取数/存数指令及其数据通路

#### 改进数据通路，实现两条访存指令

##### 添加一个数据存储器RAM，存放指令访问的数据

必须添加吗？

##### 有效地址EA的计算

ALU来实现，置rt_imm_s=1，imm_s=1。

为何是带符号扩展？

##### 将ALU的输出直接送存储器地址端口

**Verilog描述：**

```verilog
assign Mem_Addr = ALU_F
```



##### 存储器读出的数据

- alu_mem_s=0，则将ALU的输出送寄存器堆的写数据端口
- alu_mem_s=1，则将存储器的读出数据送寄存器堆的写数据端口。

**Verilog描述如下:**

```verilog
assign W_Data=alu_mem_s ?M_R_Data :ALU_F;
```



##### 存储器的写入数据

将寄存器堆的B端口数据直接送至存储器的写数据端口

**Verilog描述如下:**

```verilog
assign M_W_Data = R_Data_B;
```



#### 新的完整的R-I型指令数据通路

![image-20240103172900631](./assets/image-20240103172900631.png)

#### R-I型指令的控制流

![image-20240103172923497](./assets/image-20240103172923497.png)