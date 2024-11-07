module spi_slave (
    input wire spi_clk,
    input wire spi_cs,
    input wire [(`SPI_DATA_WIDTH)-1:0] spi_data_in,
    output reg [(`SPI_DATA_WIDTH)-1:0] spi_data_out
);

// SPI slave implementation
// Example: Echo back received data
always @(posedge spi_clk) begin
    if (spi_cs == 0) begin  // Chip select active
        spi_data_out <= spi_data_in;
    end
end

endmodule
