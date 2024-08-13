/*module tb_data_memory();

    reg clk;
    reg memRead;
    reg memWrite;
    reg [6:0] address;
    reg [31:0] writeData;
    wire [31:0] readData;

    data_memory inst (

        .clk(clk),
        .memRead(memRead),
        .memWrite(memWrite),
        .address(address),
        .writeData(writeData),
        .readData(readData)
    );

    initial begin
        clk = 0;
        forever #5 clk = ~clk; 
    end

    initial begin

        memRead = 0;
        memWrite = 0;
        address = 0;
        writeData = 0; 
        #10;

        address = 7'b0000001;
        writeData = 32'h12345678;
        memWrite = 1;
        #10;

        address = 7'b0000010;
        writeData = 32'h87654321;
        #10;

        address = 7'b0000011;
        writeData = 32'h24585347;
        #10;

        address = 7'b1111110;
        writeData = 32'h46754347;
        #10;
        
        memWrite = 0;
        memRead = 1;
        for (address = 0; address < 127; address = address + 1) begin
            #10;
            $display("Address: %0d, Data: %h", address, readData);
        end

        $finish;

    end

endmodule */


module data_memory(

    input wire clk,
    input wire memRead,
    input wire memWrite,
    input wire [6:0] address,
    input wire [31:0] writeData,
    output reg [31:0] readData

);

reg [31:0] memory_file [126:0];

always @(posedge clk) begin

    if(memWrite) begin
        memory_file[address] <= writeData;
    end
end

always @(negedge clk) begin

    if(memRead) begin
        readData <= memory_file[address];
    end
end

endmodule