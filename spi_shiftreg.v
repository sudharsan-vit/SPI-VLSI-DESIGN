module spi_shift_reg (
    input wire spi_clk,
    input wire spi_cs,
    input wire [(`SPI_DATA_WIDTH)-1:0] spi_data_in,
    output reg [(`SPI_DATA_WIDTH)-1:0] spi_data_out
);

reg [(`SPI_DATA_WIDTH)-1:0] shift_reg;

always @(posedge spi_clk) begin
    if (spi_cs == 0) begin  // Chip select active
        shift_reg <= spi_data_in;
    end else begin
        shift_reg <= {shift_reg[(`SPI_DATA_WIDTH)-2:0], 1'b0};  // Shift right
    end
end

assign spi_data_out = shift_reg;

endmodule
