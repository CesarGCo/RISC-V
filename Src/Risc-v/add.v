/*module tb_add ();
    reg [31:0] in1;
    reg [31:0] in2;
    wire [31:0] result;

    add inst(
        .in1(in1),
        .in2(in2),
        .result(result)
    );

    initial begin
        #5
        in1 = 32'd1;
        in2 = 32'd1;
        #5
        $display("result 1 + 1: %b", result);
        #5
        in1 = 32'd1;
        in2 = 32'd2;
        #5
        $display("result 1 + 2: %b", result);
        #5
        in1 = 32'd5;
        in2 = 32'd2;
        #5
        $display("result 5 + 2: %b", result);
        #20
        $finish;
    end

endmodule */


module add (
    input wire [31:0] in1,
    input wire [31:0] in2,
    output wire [31:0] result
);

assign result = in1 + in2;
    
endmodule