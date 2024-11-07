module spi_topblock (
    // Top-level module connecting all SPI components
    // Modify ports as per your design requirements
    input wire clk,
    input wire reset,
    input wire [(`SPI_DATA_WIDTH)-1:0] spi_data_in,
    output reg [(`SPI_DATA_WIDTH)-1:0] spi_data_out
);

// Instantiate SPI components
clk_gen clk_gen_inst (
    .clk_in(clk),  // Replace with actual clock input
    .spi_clk(spi_clk)
);

spi_shift_reg shift_reg_inst (
    .spi_clk(spi_clk),
    .spi_cs(spi_cs),
    .spi_data_in(spi_data_in),
    .spi_data_out(spi_data_out)
);

spi_slave slave_inst (
    .spi_clk(spi_clk),
    .spi_cs(spi_cs),
    .spi_data_in(spi_data_in),
    .spi_data_out(spi_data_out)
);

spi_wishbone_master master_inst (
    // Connect to Wishbone master interface
    .clk(clk),
    .reset(reset),
    .data_out(spi_data_out),
    .data_in(spi_data_in),
    .spi_cs(spi_cs),
    .spi_clk(spi_clk),
    .spi_mosi(spi_mosi),
    .spi_miso(spi_miso),
    .spi_ss(spi_ss)
);

endmodule
