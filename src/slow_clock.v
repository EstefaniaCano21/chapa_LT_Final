module slow_clock (
    input clk,
    input reset,
    output reg clk_out
);

    // Parámetro de división para generar ~2Hz desde 100MHz
    parameter DIV = 25000000;

    reg [24:0] counter;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            counter <= 0;
            clk_out <= 0;
        end else begin
            if (counter == DIV - 1) begin
                counter <= 0;
                clk_out <= ~clk_out;
            end else begin
                counter <= counter + 1;
            end
        end
    end

endmodule
