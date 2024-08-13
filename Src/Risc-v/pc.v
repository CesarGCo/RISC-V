/*module tb_pc();

    reg clk;
    reg reset;
    reg [6:0] pc_in;
    wire [6:0] pc_out;

    pc inst (
        .clk(clk),
        .reset(reset),
        .pc_in(pc_in),
        .pc_out(pc_out)
    );

    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    initial begin
    
        reset = 1;
        pc_in = 7'b0;
        #10; 

        pc_in = 7'b1;
        #10; 

        $display("Apos reset = 1, Pc_in: %b; Pc_out: %b", pc_in, pc_out);

        reset = 0;
        #10; 

        $display("Apos reset = 0, Pc_in: %b; Pc_out: %b", pc_in, pc_out);

        pc_in = 7'b1010101;
        #10; 

        $display("Apos mudanca de pc_in, Pc_in: %b; Pc_out: %b", pc_in, pc_out);

        $finish; 
    end

endmodule */

module pc(
    input wire clk,
    input wire reset,
    input wire [31:0] pc_in,
    output reg [31:0] pc_out
);

always @(posedge clk) begin
    pc_out <= (reset) ? 32'b0 : pc_in;
end

endmodule
