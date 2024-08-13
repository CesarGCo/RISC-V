/*module tb_mux ();
    reg [31:0] in1;
    reg [31:0] in2;
    reg control;
    wire [31:0] result;

    mux inst (
        .in1(in1),
        .in2(in2),
        .control(control),
        .result(result)
    );

    initial begin
        in1 = 32'd3;
        in2 = 32'd15;
        #5
        control = 1'b0;
        #5
        $display("control 0: %b", result);
        #5
        control = 1'b1;
        #5
        $display("control 1: %b", result);
        #5 
        $finish;
        
    end
endmodule */

module mux (
    input wire [31:0] in1,
    input wire [31:0] in2,
    input wire control,
    output wire [31:0] result
);
    assign result = (control == 1) ? in2 : in1;

endmodule