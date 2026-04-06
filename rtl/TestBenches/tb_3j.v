`timescale 1ns / 1ps

module tb_AllJumps;

    reg clk_crystal;
    reg clk_button;
    reg clk_mux_switch;

    wire [15:0] instr_o;
    wire A, B, C, D, E, F, G, DOT;
    wire digit3, digit2, digit1, digit0;

    integer i;

    Processor_Wrapper UUT (
        .clk_crystal(clk_crystal),
        .clk_button(clk_button),
        .clk_mux_switch(clk_mux_switch),
        .instr_o(instr_o),
        .A(A), .B(B), .C(C), .D(D), .E(E), .F(F), .G(G), .DOT(DOT),
        .digit3(digit3), .digit2(digit2), .digit1(digit1), .digit0(digit0)
    );

    // Only for the display-related divider logic inside Processor_Wrapper.
    // Since clk_mux_switch = 1, the CPU itself uses clk_button directly.
    initial begin
        clk_crystal = 1'b0;
        forever #5 clk_crystal = ~clk_crystal;
    end

    task press_button;
    begin
        #5  clk_button = 1'b1;
        #5  clk_button = 1'b0;
        #1;

        $display("t=%0t | PC=%0d | instr=%h | r4=%h r5=%h r6=%h r7=%h r8=%h",
                 $time,
                 UUT.u_if.im_addr_reg,
                 instr_o,
                 UUT.u_id.reg_file[4],
                 UUT.u_id.reg_file[5],
                 UUT.u_id.reg_file[6],
                 UUT.u_id.reg_file[7],
                 UUT.u_id.reg_file[8]);
    end
    endtask

    initial begin
        clk_button     = 1'b0;
        clk_mux_switch = 1'b1;   // choose manual clk_button path

        // Let all initial blocks in PC.v / Decoder.v settle.
        #2;

        $display("Starting 3-jump test...");
        $display("Initial | PC=%0d | instr=%h | r4=%h r5=%h r6=%h r7=%h r8=%h",
                 UUT.u_if.im_addr_reg,
                 instr_o,
                 UUT.u_id.reg_file[4],
                 UUT.u_id.reg_file[5],
                 UUT.u_id.reg_file[6],
                 UUT.u_id.reg_file[7],
                 UUT.u_id.reg_file[8]);

        // One button press advances the PC once.
        // 12 presses are enough to execute the whole test and reach JMP -1.
        for (i = 0; i < 12; i = i + 1)
            press_button();

        $display("\nFinal Flag States:");
        $display("r4 (BEQ Taken)     = %h", UUT.u_id.reg_file[4]);
        $display("r5 (BEQ Not Taken) = %h", UUT.u_id.reg_file[5]);
        $display("r6 (BNE Taken)     = %h", UUT.u_id.reg_file[6]);
        $display("r7 (BNE Not Taken) = %h", UUT.u_id.reg_file[7]);
        $display("r8 (JMP Execution) = %h", UUT.u_id.reg_file[8]);
        $display("Final PC           = %0d", UUT.u_if.im_addr_reg);

        if (UUT.u_id.reg_file[4] !== 16'h0001)
            $display("FAILED [BEQ Taken]: Expected r4=0001, got %h", UUT.u_id.reg_file[4]);
        else
            $display("PASSED [BEQ Taken]");

        if (UUT.u_id.reg_file[5] !== 16'h0001)
            $display("FAILED [BEQ Not Taken]: Expected r5=0001, got %h", UUT.u_id.reg_file[5]);
        else
            $display("PASSED [BEQ Not Taken]");

        if (UUT.u_id.reg_file[6] !== 16'h0001)
            $display("FAILED [BNE Taken]: Expected r6=0001, got %h", UUT.u_id.reg_file[6]);
        else
            $display("PASSED [BNE Taken]");

        if (UUT.u_id.reg_file[7] !== 16'h0001)
            $display("FAILED [BNE Not Taken]: Expected r7=0001, got %h", UUT.u_id.reg_file[7]);
        else
            $display("PASSED [BNE Not Taken]");

        if (UUT.u_id.reg_file[8] !== 16'h0001)
            $display("FAILED [JMP]: Expected r8=0001, got %h", UUT.u_id.reg_file[8]);
        else
            $display("PASSED [JMP]");

        if (UUT.u_if.im_addr_reg !== 16'd30)
            $display("FAILED [Final Loop]: Expected PC=30 at JMP -1 loop, got %0d", UUT.u_if.im_addr_reg);
        else
            $display("PASSED [Final Loop at PC=30]");

        $finish;
    end

endmodule