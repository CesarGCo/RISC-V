/*module tb_alu_control();

    reg [1:0] aluOp;
    reg [2:0] funct3;
    wire [3:0] aluControl;

    alu_control inst (

        .aluOp(aluOp),
        .funct3(funct3),
        .aluControl(aluControl)
    );

    initial begin
        
        $dumpfile("simulation.vcd");
        $dumpvars;

        aluOp = 2'b10;
        funct3 = 3'b000;
        #1;
        $display("Alu control com aluOp = %b: %b", aluOp, aluControl);

        aluOp = 2'b00;
        funct3 = 3'b000;
        #1;
        $display("Alu control com aluOp = %b: %b", aluOp, aluControl);

        aluOp = 2'b01;
        funct3 = 3'b000;
        #1;
        $display("Alu control com aluOp = %b: %b", aluOp, aluControl);

        #10 $finish;
    end

endmodule*/



module alu_control(

    input wire [1:0] aluOp,
    input wire [2:0] funct3,
    output reg [3:0] aluControl
);

always @(aluOp or funct3) begin

    case(aluOp)

        2'b00:begin //lw, sw e addi
            aluControl <= 4'b0010;
        end

        2'b10:begin
            case(funct3)

                3'b000:begin //add
                    aluControl <= 4'b0010;
                end

                3'b100:begin //xor
                    aluControl <= 4'b0011;
                end

                3'b001:begin //sll
                    aluControl <= 4'b0100;
                end

            endcase
        end

        2'b01:begin //Bne 
            aluControl <= 4'b0110;
        end

    endcase

end

endmodule