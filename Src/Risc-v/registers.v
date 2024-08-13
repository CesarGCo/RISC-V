/*module tb_registers();

    reg clk;
    reg regWrite;
    reg [4:0] readReg1;
    reg [4:0] readReg2;
    reg [4:0] writeReg;
    reg [31:0] writeData;

    wire [31:0] readData1;
    wire [31:0] readData2;

    registers inst (
        .clk(clk),
        .regWrite(regWrite),
        .readReg1(readReg1),
        .readReg2(readReg2),
        .writeReg(writeReg),
        .writeData(writeData),
        .readData1(readData1),
        .readData2(readData2)
    );

    initial begin
        clk = 0;
        forever #5 clk = ~clk; 
    end

    initial begin

        regWrite = 0;
        readReg1 = 0;
        readReg2 = 0;
        writeReg = 0;
        writeData = 0;

        $dumpfile("simulation.vcd");
        $dumpvars;

        #10;

        regWrite = 1;
        writeReg = 5'b00001;
        writeData = 32'h12345678;
        #10;

        writeReg = 5'b00010;
        writeData = 32'h87654321;
        #10;

        regWrite = 0;
        readReg1 = 5'b00001;
        readReg2 = 5'b00010;
        #10;

        $display("Read Data 1: %b", readData1);
        $display("Read Data 2: %b", readData2);

        regWrite = 1;
        writeReg = 5'b00000;
        writeData = 32'b1;
        #10

        regWrite = 0;
        readReg1 = 5'b00000;
        readReg2 = 5'b00000;
        #10;

        //Teste do x0
        $display("Read Data 1(X0): %b", readData1);
        $display("Read Data 2(X0): %b", readData2);
        $finish;

    end

endmodule */

module registers(

    input wire clk,
    input wire regWrite,
    input wire [4:0] readReg1,
    input wire [4:0] readReg2,
    input wire [4:0] writeReg,
    input wire [31:0] writeData,
    output reg [31:0] readData1,
    output reg [31:0] readData2
);

reg [31:0] register_file [31:0];

always @(readReg1 or register_file[readReg1]) begin

    if(readReg1 == 5'b00000) begin
        readData1 <= 32'b0;
    end else begin
        readData1 <= register_file[readReg1];
    end
end

always @(readReg2 or register_file[readData2]) begin
    
    if(readReg2 == 5'b00000) begin
        readData2 <= 32'b0;
    end else begin
        readData2 <= register_file[readReg2];
    end

end

always @(posedge clk) begin
    
    if(regWrite) begin
        if(writeReg == 5'b00000) begin
            register_file[writeReg] <= 32'b0;
        end else begin
            register_file[writeReg] <= writeData;
        end
    end
end

endmodule