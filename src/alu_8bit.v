`default_nettype none

module alu_8bit (
    input wire [3:0] A,
    input wire [3:0] B,
    input wire [2:0] sel,
    output reg [3:0] Y,
    output wire zero,
    output wire carry
);

    // Definición de operaciones
    parameter ADD = 3'b000;
    parameter SUB = 3'b001;
    parameter AND = 3'b010;
    parameter OR  = 3'b011;
    parameter XOR = 3'b100;
    parameter NOT = 3'b101;
    parameter SHL = 3'b110;
    parameter SHR = 3'b111;

    wire [4:0] add_result = A + B;
    wire [4:0] sub_result = A - B;

    always @(*) begin
        case(sel)
            ADD: begin
                Y = add_result[3:0];
                carry = add_result[4];
            end
            SUB: begin
                Y = sub_result[3:0];
                carry = sub_result[4];
            end
            AND: Y = A & B;
            OR:  Y = A | B;
            XOR: Y = A ^ B;
            NOT: Y = ~A;
            SHL: Y = {A[2:0], 1'b0};
            SHR: Y = {1'b0, A[3:1]};
            default: Y = 4'b0;
        endcase
    end

    assign zero = (Y == 4'b0);
endmodule
