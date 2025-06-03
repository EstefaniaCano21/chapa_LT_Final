module tt_um_fsm_lock (
    input  wire [7:0] ui_in,     // Entradas del usuario
    output wire [7:0] uo_out,    // Salidas al usuario
    input  wire [7:0] uio_in,    // IOs de entrada (no usados)
    output wire [7:0] uio_out,   // IOs de salida (no usados)
    output wire [7:0] uio_oe,    // IOs enable (no usados)
    input  wire       clk,       // Reloj principal
    input  wire       rst_n,     // Reset activo bajo
    input  wire       ena        // Enable de Tiny Tapeout
);

    // Manejo de señales internas
    wire reset = ~rst_n;
    wire enter = ui_in[7];
    wire [3:0] digit = ui_in[3:0];
    wire [1:0] state;
    wire correct_digit;

    // Señales no utilizadas, para evitar advertencias
    wire unused0 = ui_in[4];
    wire unused1 = ui_in[5];
    wire unused2 = ui_in[6];

    // Instancias
    mealy u_mealy (
        .digit(digit),
        .state(state),
        .enter(enter),
        .correct_digit(correct_digit)
    );

    moore u_moore (
        .clk(clk),
        .reset(reset),
        .enter(enter),
        .correct_digit(correct_digit),
        .state(state),
        .locked_led(uo_out[0]),
        .unlocked_led(uo_out[1]),
        .error_led(uo_out[2]),
        .state_leds(uo_out[5:3])
    );

    // Salidas no utilizadas forzadas a 0
    assign uo_out[6] = 1'b0;
    assign uo_out[7] = 1'b0;
    assign uio_out   = 8'b0;
    assign uio_oe    = 8'b0;

endmodule
