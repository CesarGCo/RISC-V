module data_path(
    input wire clk,
    input wire reset
);

    wire [31:0] pc_in, pc_out;
    wire [31:0] resultAddPC, resultAddBranch;
    wire [31:0] instruction;
    wire [31:0] writeData;
    wire [31:0] readData1, readData2;

    // Saídas do controller:
    wire branch;
    wire memRead;
    wire memToReg;
    wire [1:0] aluOp;
    wire memWrite;
    wire aluSrc;
    wire regWrite;

    //Valor imediato:
    wire [31:0] immediate;

    // ALU:
    wire [3:0] aluControl;
    wire Zero;
    wire [31:0] resultAlu;

    //Saídas dos mux:
    wire [31:0] resultMuxAlu;
    wire [31:0] readData;

    //Saída da porta and do branch:
    wire outputAnd;

    pc pc_inst (
        .clk(clk),
        .reset(reset),
        .pc_in(pc_in),
        .pc_out(pc_out)
    );

    add add_inst(
        .in1(pc_out),
        .in2(32'b000000000000000000000000000001),
        .result(resultAddPC)
    );

    instruction_memory instruction_memory_inst(
        .address(pc_out),
        .instruction(instruction)
    );

    controller controller_inst(
        .opcode(instruction[6:0]),
        .branch(branch),
        .memRead(memRead),
        .memToReg(memToReg),
        .aluOp(aluOp),
        .memWrite(memWrite),
        .aluSrc(aluSrc),
        .regWrite(regWrite)
    );

    registers registers_inst(
        .clk(clk),
        .regWrite(regWrite),
        .readReg2(instruction[24:20]),
        .readReg1(instruction[19:15]),
        .writeReg(instruction[11:7]),
        .writeData(writeData),
        .readData1(readData1),
        .readData2(readData2)
    );

    alu_control alu_control_inst(
        .aluOp(aluOp),
        .funct3(instruction[14:12]),
        .aluControl(aluControl)
    );

    imm_gen imm_gen_inst(
        .instruction(instruction),
        .immediate(immediate)
    );

    // Multiplexador da porta da ALU:
    mux mux_alu(
        .in1(readData2),
        .in2(immediate),
        .control(aluSrc),
        .result(resultMuxAlu)
    );

    alu alu_inst(
        .ALUcontrol(aluControl),
        .in1(readData1),
        .in2(resultMuxAlu),
        .Zero(Zero),
        .result(resultAlu)
    );

    data_memory data_memory_inst(
        .clk(clk),
        .memRead(memRead),
        .memWrite(memWrite),
        .address(resultAlu[6:0]),
        .writeData(readData2),
        .readData(readData)
    );

    // Write Back:
    mux mux_data(
        .in1(resultAlu),
        .in2(readData),
        .control(memToReg),
        .result(writeData)
    );

    add add_sum(
        .in1(pc_out),
        .in2(immediate),
        .result(resultAddBranch)
    );

    // Porta AND:
    and_branch and_branch_inst(
        .in1(branch),
        .in2(Zero),
        .out(outputAnd)
    );
    
    // Multiplexador que manda o endereço pra PC
    mux mux_pc(
        .in1(resultAddPC),
        .in2(resultAddBranch),
        .control(outputAnd),
        .result(pc_in)
    );

endmodule