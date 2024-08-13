COMPILER = iverilog
SIMULATOR = vvp

SOURCES = ../Src/Risc-v/alu.v ../Src/Risc-v/alu_control.v ../Src/Risc-v/controller.v ../Src/Risc-v/data_memory.v ../Src/Risc-v/data_path.v ../Src/Risc-v/imm_gen.v ../Src/Risc-v/instruction_memory.v ../Src/Risc-v/mux.v ../Src/Risc-v/pc.v ../Src/Risc-v/registers.v ../Src/Risc-v/add.v ../Src/Risc-v/and_branch.v ../Src/Risc-v/testbench_data_path.v

OUTPUT = simulation.out

ASSEMBLY_INPUT = ../AssemblyCode/input.asm
ASSEMBLY_OUTPUT = ../Src/Txt_files/instructions_binary.txt

all: compile simulate

assembly:
	python ../Src/Assembler/Assembler.py $(ASSEMBLY_INPUT) -o $(ASSEMBLY_OUTPUT)

compile: assembly
	$(COMPILER) -o $(OUTPUT) $(SOURCES)

simulate: compile
	$(SIMULATOR) $(OUTPUT)

clean:
	rm -f $(OUTPUT)


