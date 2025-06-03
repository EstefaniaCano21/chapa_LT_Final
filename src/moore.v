module moore (
    input clk,
    input reset,
    input enter,
    input correct_digit,
    output [1:0] state,
    output locked_led,
    output unlocked_led,
    output error_led,
    output [2:0] state_leds
);

    parameter S0 = 2'd0;
    parameter S1 = 2'd1;
    parameter S2 = 2'd2;
    parameter S3 = 2'd3;

    reg [1:0] current, next;

    always @(posedge clk or posedge reset) begin
        if (reset)
            current <= S0;
        else if (enter)
            current <= next;
    end

    always @(*) begin
        next = current;
        case (current)
            S0: if (enter && correct_digit) next = S1;
            S1: if (enter && correct_digit) next = S2;
                else if (enter && !correct_digit) next = S0;
            S2: if (enter && correct_digit) next = S3;
                else if (enter && !correct_digit) next = S0;
            S3: if (enter) next = S0;
        endcase
    end

    assign state = current;
    assign locked_led   = (current != S3);
    assign unlocked_led = (current == S3);
    assign error_led    = (enter && !correct_digit && current != S3);
    assign state_leds   = {1'b0, current};

endmodule

