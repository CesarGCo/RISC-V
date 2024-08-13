`timescale 1ns/100ps

module tb_data_path();
    reg _clock, _reset;
    data_path dp(
        .clk(_clock),
        .reset(_reset)
    );

    initial begin
        _clock = 0;
        forever #1 _clock = ~_clock; 
    end

    always @(dp.instruction)
    begin
        //Verificação para conferir se todas as instruções foram lidas.
        if (dp.instruction === 32'bx) begin
            _reset = 1;
            $display("==================================================================================================");
            $display("**Banco de registradores apos a execucao das instrucoes**");
            for (integer i = 0; i < 32; i++)
            begin
                //$display("mem[%d]: %d", i, dp.data_memory_inst.memory_file[i]); 
                $display("Register[%d]: %d", i, dp.registers_inst.register_file[i]);
            end
        end
    end

    initial begin
        //Faz a leitura do arquivo de instruções.
        $readmemb("../Src/Txt_files/instructions_binary.txt", dp.instruction_memory_inst.instructions_file);

        //Inicializa com 0s o valor de cada registrador do banco de registradores e cada campo da memória de dados.
        $readmemb("../Src/Txt_files/registers_start.txt", dp.registers_inst.register_file);
        $readmemb("../Src/Txt_files/data_memory_start.txt", dp.data_memory_inst.memory_file);
        #1;
        _reset = 1;
        #1;
        _reset = 0;

        /*for (integer i = 0; i < 32; i = i + 1)
        begin
                #2 $display("inst: %b", dp.pc_out);
        end */

        #30;

        #1 $finish;
    end

endmodule