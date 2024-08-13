/*module tb_alu();
    reg [3:0] ALUcontrol;
    reg [31:0] in1;
    reg [31:0] in2;
    wire Zero;
    wire [31:0] result;

    alu inst(
        .ALUcontrol(ALUcontrol),
        .in1(in1),
        .in2(in2),
        .Zero(Zero),
        .result(result)
    );

    initial begin
        in1 = 32'd3;
        in2 = 32'd2;
        $display("Para in1 = 3 e in2 = 2");
        #5
        ALUcontrol = 4'b0000;
        #5
        $display("and: %b", result);
        #5
        ALUcontrol = 4'b0001;
        #5
        $display("or: %b", result);
        #5
        ALUcontrol = 4'b0010;
        #5
        $display("add: %b", result);
        #5
        ALUcontrol = 4'b0010;
        #5
        $display("addi: %b", result);
        #5
        ALUcontrol = 4'b0011;
        #5
        $display("xor: %b", result);
        #5
        ALUcontrol = 4'b0100;
        #5
        $display("sll: %b", result);
        #5
        in1 = 32'd1;
        in2 = 32'd1;
        #5
        $display("Zero: %b", Zero);
        #5
        in1 = 32'd1;
        in2 = 32'd0;
        #5
        $display("Zero: %b", Zero);
        #5
        $finish;
    end

endmodule */

module alu(
    input wire [3:0] ALUcontrol,
    input wire [31:0]in1,
    input wire [31:0]in2,
    output reg Zero,
    output reg [31:0]result
);

    always @* begin

        if(in1 != in2) begin
            Zero <= 1'b1;
        end else begin
            Zero <= 1'b0;
        end
        case(ALUcontrol) 
            4'b0010: result <= in1 + in2;
            4'b0011: result <= in1 ^ in2;
            4'b0100: result <= in1 << in2;
        endcase
            
    end

endmodule