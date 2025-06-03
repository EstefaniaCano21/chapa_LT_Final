module mealy (
    input [3:0] digit,
    input [1:0] state,
    input enter,
    output reg correct_digit
);

    wire [3:0] pin0 = 4'd9;
    wire [3:0] pin1 = 4'd9;
    wire [3:0] pin2 = 4'd7;
    wire [3:0] pin3 = 4'd9;

    wire [3:0] pin_selected;

    assign pin_selected = (state == 2'd0) ? pin0 :
                          (state == 2'd1) ? pin1 :
                          (state == 2'd2) ? pin2 :
                                            pin3;

    always @(*) begin
        correct_digit = (enter && (digit == pin_selected));
    end

endmodule

