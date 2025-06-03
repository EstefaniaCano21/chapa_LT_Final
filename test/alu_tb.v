`timescale 1ns/1ps

module alu_tb;
    reg [3:0] A, B;
    reg [2:0] sel;
    wire [3:0] Y;
    wire zero, carry;
    
    // Instancia del módulo bajo prueba
    alu_8bit dut (
        .A(A),
        .B(B),
        .sel(sel),
        .Y(Y),
        .zero(zero),
        .carry(carry)
    );
    
    // Generación de estímulos
    initial begin
        $dumpfile("dump.vcd");
        $dumpvars(0, alu_tb);
        
        // Test ADD: 5 + 3
        A = 4'b0101; B = 4'b0011; sel = 3'b000;
        #10;
        if (Y !== 4'b1000 || carry !== 1'b0 || zero !== 1'b0)
            $display("ERROR: ADD failed");
        
        // Test SUB: 5 - 3
        sel = 3'b001;
        #10;
        if (Y !== 4'b0010 || carry !== 1'b0 || zero !== 1'b0)
            $display("ERROR: SUB failed");
        
        // Test AND: 5 & 3
        sel = 3'b010;
        #10;
        if (Y !== 4'b0001)
            $display("ERROR: AND failed");
        
        $display("Tests completed");
        $finish;
    end
endmodule
