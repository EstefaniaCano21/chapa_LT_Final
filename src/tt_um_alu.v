`default_nettype none

module tt_um_alu (
    input wire [7:0] ui_in,     // Entradas: A[3:0] = ui_in[3:0], B[3:0] = ui_in[7:4]
    output reg [7:0] uo_out,     // Resultado
    input wire [7:0] uio_in,     // Selector: sel[2:0] = uio_in[2:0]
    output wire [7:0] uio_out,    // Banderas (bit 0: zero, bit 1: carry)
    output wire [7:0] uio_oe,     // Configuración I/O
    input wire ena,               // Habilitación
    input wire clk,               // Reloj
    input wire rst_n              // Reset
);

    // Instancia del módulo ALU
    alu_8bit alu_core (
        .A(ui_in[3:0]),
        .B(ui_in[7:4]),
        .sel(uio_in[2:0]),
        .Y(uo_out[3:0]),
        .zero(uio_out[0]),
        .carry(uio_out[1])
    );

    // Bits no utilizados
    assign uo_out[7:4] = 4'b0;
    assign uio_out[7:2] = 6'b0;
    assign uio_oe = 8'b00000011;  // Solo bits 0-1 como salidas
endmodule
