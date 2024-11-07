module spi_clgen (
    input wire wb_clk_in,
    input wire wb_rst,
    input wire tip,
    input wire go,
    input wire last_clk,
    input wire [3:0] divider,  // Assuming 4 bits for the divider
    output reg sclk_out,
    output reg cpol_0,
    output reg cpol_1
);

    reg [3:0] cnt;  // Assuming 4 bits for the counter

    // Counter counts half period
    always @(posedge wb_clk_in or posedge wb_rst) begin
        if (wb_rst) begin
            cnt <= 4'b0001;  // Initial value
        end else if (tip) begin
            if (cnt == (divider + 1)) begin
                cnt <= 4'b0001;  // Reset counter
            end else begin
                cnt <= cnt + 1;
            end
        end else if (cnt == 0) begin
            cnt <= 4'b0001;  // Reset counter
        end
    end

    // Generation of the serial clock
    always @(posedge wb_clk_in or posedge wb_rst) begin
        if (wb_rst) begin
            sclk_out <= 1'b0;
        end else if (tip) begin
            if (cnt == (divider + 1)) begin
                if (!last_clk || sclk_out) begin
                    sclk_out <= ~sclk_out;
                end
            end
        end
    end

    // Posedge and negedge detection of sclk
    always @(posedge wb_clk_in or posedge wb_rst) begin
        if (wb_rst) begin
            cpol_0 <= 1'b0;
            cpol_1 <= 1'b0;
        end else if (tip) begin
            cpol_0 <= 1'b0;
            cpol_1 <= 1'b0;
            if (~sclk_out && cnt == divider) begin
                cpol_0 <= 1'b1;
            end
            if (sclk_out && cnt == divider) begin
                cpol_1 <= 1'b1;
            end
        end
    end

endmodule
