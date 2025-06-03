module tt_um_fsm_lock (
    input  wire [7:0] ui_in,      // Inputs from the user (PIN + control)
    output wire [7:0] uo_out,     // Outputs to the user (LEDs)
    input  wire       clk,        // Main clock
    input  wire       rst_n       // Active-low reset
);

    wire reset = ~rst_n;
    wire enter = ui_in[7];
    wire [3:0] digit = ui_in[3:0];
    
    wire [1:0] state;
    wire correct_digit;

    // FSM Mealy: compara dígito ingresado
    fsm_mealy mealy_inst (
        .digit(digit),
        .state(state),
        .enter(enter),
        .correct_digit(correct_digit)
    );

    // FSM Moore: administra los estados
    fsm_moore moore_inst (
        .clk(clk),
        .reset(reset),
        .enter(enter),
        .correct_digit(correct_digit),
        .state(state),
        .locked_led(uo_out[0]),
        .unlocked_led(uo_out[1]),
        .error_led(uo_out[2]),
        .state_leds(uo_out[5:3])  // Salidas para ver el estado actual
    );

    // uo_out[7:6] quedan libres (o puedes usarlas para debug futuro)

endmodule
