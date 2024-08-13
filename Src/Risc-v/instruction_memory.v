/*module tb_instruction_memory();

    reg [200:0] file_name;
    reg [6:0] address;
    wire [31:0] instruction;

    instruction_memory uut (
        .file_name(file_name),
        .address(address),
        .instruction(instruction)
    );

    initial begin
        
        file_name = "instrucoes.txt";
        #10;

        address = 7'b0000000;
        #10;
        $display("Instrucao no enderco %d: %b", address, instruction);

        address = 7'b0000001;
        #10;
        $display("Instrucao no enderco %d: %b", address, instruction);

        address = 7'b0000010;
        #10;
        $display("Instrucao no enderco %d: %b", address, instruction);

        address = 7'b0000011;
        #10;
        $display("Instrucao no enderco %d: %b", address, instruction);

        #10 $finish;
    end

endmodule*/


module instruction_memory(
    input wire [31:0] address,
    output reg [31:0] instruction

);

reg [31:0] instructions_file [127:0];
integer file;
integer status;

// always@(file_name)begin

//     file = $fopen(file_name, "r");
//     if(file)begin
//         for(integer i = 0; i < 128; i = i + 1)begin
//            status = $fscanf(file, "%b", instructions_file[i]);
//         end
//         $fclose(file);

//     end else begin
//         $display("Erro para abrir");
//     end
// end


always@(address)begin
    instruction <= instructions_file[address];
end

endmodule