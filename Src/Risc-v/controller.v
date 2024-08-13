/*module tb_controller();

    reg [6:0] opcode;
    wire branch;
    wire memRead;
    wire memToReg;
    wire [1:0] aluOp;
    wire memWrite;
    wire aluSrc;
    wire regWrite;

    controller uut (
        .opcode(opcode),
        .branch(branch),
        .memRead(memRead),
        .memToReg(memToReg),
        .aluOp(aluOp),
        .memWrite(memWrite),
        .aluSrc(aluSrc),
        .regWrite(regWrite)
    );

    initial begin
        $dumpfile("simulation.vcd");
        $dumpvars;

        // Test lw (opcode: 0000011)
        opcode = 7'b0000011;
        #5; 
        $display("Opcode: 0000011 - lw");
        $display("branch: %b, memRead: %b, memToReg: %b, aluOp: %b, memWrite: %b, aluSrc: %b, regWrite: %b", 
                 branch, memRead, memToReg, aluOp, memWrite, aluSrc, regWrite);

         // Test sw (opcode: 0100011)
        opcode = 7'b0100011;
        #5; 
        $display("Opcode: 0100011 - sw");
        $display("branch: %b, memRead: %b, memToReg: %b, aluOp: %b, memWrite: %b, aluSrc: %b, regWrite: %b", 
                 branch, memRead, memToReg, aluOp, memWrite, aluSrc, regWrite);

        // Test add (opcode: 0110011)
        opcode = 7'b0110011;
        #5; 
        $display("Opcode: 0110011 - add");
        $display("branch: %b, memRead: %b, memToReg: %b, aluOp: %b, memWrite: %b, aluSrc: %b, regWrite: %b", 
                 branch, memRead, memToReg, aluOp, memWrite, aluSrc, regWrite);

        // Test addi (opcode: 0010011)
        opcode = 7'b0010011;
        #5; 
        $display("Opcode: 0010011 - addi");
        $display("branch: %b, memRead: %b, memToReg: %b, aluOp: %b, memWrite: %b, aluSrc: %b, regWrite: %b", 
                 branch, memRead, memToReg, aluOp, memWrite, aluSrc, regWrite);

        // Test bne (opcode: 1100111)
        opcode = 7'b1100111;
        #5; 
        $display("Opcode: 1100111 - bne");
        $display("branch: %b, memRead: %b, memToReg: %b, aluOp: %b, memWrite: %b, aluSrc: %b, regWrite: %b", 
                 branch, memRead, memToReg, aluOp, memWrite, aluSrc, regWrite); 

        #10
        $finish;
    end

endmodule */


module controller(
    input wire [6:0] opcode,
    output reg branch,
    output reg memRead,
    output reg memToReg,
    output reg [1:0] aluOp,
    output reg memWrite,
    output reg aluSrc,
    output reg regWrite
);

always @(opcode) begin
    case(opcode)

        7'b0110011:begin //Tipo R
            branch <= 1'b0;
            memRead <= 1'b0;
            memWrite <= 1'b0;
            memToReg <= 1'b0;
            aluOp <= 2'b10;
            aluSrc <= 1'b0;
            regWrite <= 1'b1;
        end

        7'b0010011:begin //addi
            branch <= 1'b0;
            memRead <= 1'b0;
            memWrite <= 1'b0;
            memToReg <= 1'b0;
            aluOp <= 2'b00;
            aluSrc <= 1'b1;
            regWrite <= 1'b1;
        end

        7'b0000011:begin //lw
            branch <= 1'b0;
            memRead <= 1'b1;
            memWrite <= 1'b0;
            memToReg <= 1'b1;
            aluOp <= 2'b00;
            aluSrc <= 1'b1;
            regWrite <= 1'b1;
        end

        7'b0100011:begin //sw
            branch <= 1'b0;
            memRead <= 1'b0;
            memWrite <= 1'b1;
            memToReg <= 1'b0;
            aluOp <= 2'b00;
            aluSrc <= 1'b1;
            regWrite <= 1'b0;
        end

        7'b1100111:begin //bne
            branch <= 1'b1;
            memRead <= 1'b0;
            memWrite <= 1'b0;
            memToReg <= 1'b0;
            aluOp <= 2'b01;
            aluSrc <= 1'b0;
            regWrite <= 1'b0;
        end

        default: begin
            branch <= 1'b0;
            memRead <= 1'b0;
            memWrite <= 1'b0;
            memToReg <= 1'b0;
            aluOp <= 2'b00;
            aluSrc <= 1'b0;
            regWrite <= 1'b0;
        end

    endcase
end

endmodule
