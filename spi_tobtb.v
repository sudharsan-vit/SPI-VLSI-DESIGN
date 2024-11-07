module spi_top_tb;

reg clk;
reg reset;
reg [(`SPI_DATA_WIDTH)-1:0] spi_data_in;
wire [(`SPI_DATA_WIDTH)-1:0] spi_data_out;

// Instantiate the SPI top-level block
spi_topblock dut (
    .clk(clk),
    .reset(reset),
    .spi_data_in(spi_data_in),
    .spi_data_out(spi_data_out)
);

// Clock generation for simulation
always #5 clk = ~clk;

initial begin
    clk = 0;
    reset = 1;
    spi_data_in = 0;
    
    // Release reset after some cycles
    #100;
    reset = 0;
    
    // Example test scenario: Write data and read it back
    spi_data_in = 8'hAA;
    #100;
    spi_data_in = 8'h55;
    #100;
    
    // Add more test scenarios as needed
    
    $finish;
end

endmodule
