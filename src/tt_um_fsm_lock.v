module tt_um_fsm_lock (
    input  wire [7:0] ui_in,    // Entradas del usuario
    output wire [7:0] uo_out,   // Salidas al usuario
    input  wire       clk,      // Reloj principal
    input  wire       rst_n     // Reset activo bajo
);

    // Señales internas
    wire reset = ~rst_n;
    wire enter = ui_in[7];
    wire [3:0] digit = ui_in[3:0];
    wire [1:0] state;
    wire correct_digit;

    // Instancia de la FSM Mealy
    mealy u_mealy (
        .digit(digit),
        .state(state),
        .enter(enter),
        .correct_digit(correct_digit)
    );

    // Instancia de la FSM Moore
    moore u_moore (
        .clk(clk),
        .reset(reset),
        .enter(enter),
        .correct_digit(correct_digit),
        .state(state),
        .locked_led(uo_out[0]),
        .unlocked_led(uo_out[1]),
        .error_led(uo_out[2]),
        .state_leds(uo_out[5:3])  // 3 bits de estado visualizados
    );

    // Las salidas uo_out[6] y uo_out[7] no se utilizan

endmodule
