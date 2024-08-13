/*module tb_imm_gen();

    reg [31:0] instruction;
    wire [31:0] immediate;

    imm_gen inst (
        .instruction(instruction),
        .immediate(immediate)
    );

    initial begin

        instruction = 32'b00000110000000000000011110100011;   //Base:0000011 00000 00000 000 01111 0100011
        #5;

        $display("IMM com 0 (Tipo S): %b", immediate);

        instruction = 32'b10000110000000000000011110100011;
        #5;

        $display("IMM com 1 (Tipo S): %b", immediate);

        instruction = 32'b00000110001100000000011110000011;
        #5;

        $display("IMM com 0 (Tipo I): %b", immediate);

        instruction = 32'b10000110001100000000011110000011;
        #5;           

        $display("IMM com 1 (Tipo I): %b", immediate);

        instruction = 32'b
        #5;

        $display("IMM com 1 (Tipo SB): %b", immediate);

    end

endmodule*/

module imm_gen(

    input wire [31:0] instruction,
    output reg [31:0] immediate
);

always @(instruction) begin

    case(instruction[6:0])

        7'b0100011:begin //sw
            immediate <= {{20{instruction[31]}}, {instruction[31:25], instruction[11:7]}};
        end

        7'b0000011:begin //lw
            immediate <= {{20{instruction[31]}}, instruction[31:20]};
        end

        7'b0010011:begin //addi
            immediate <= {{20{instruction[31]}}, instruction[31:20]};
        end

        7'b1100111:begin //bne
            immediate <=  {{20{instruction[31]}}, instruction[31], instruction[7], instruction[30:25], instruction[11:8]};
        end

    endcase

end


endmodule