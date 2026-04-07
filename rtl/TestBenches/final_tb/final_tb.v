`timescale 1ns / 1ps

module tb_final;

    // -------------------------------------------------------------------------
    // Clock / top-level wrapper connections
    // -------------------------------------------------------------------------
    reg clk_crystal;
    reg clk_button;
    reg clk_mux_switch;

    wire [15:0] instr_o;
    wire A, B, C, D, E, F, G, DOT;
    wire digit3, digit2, digit1, digit0;

    integer i;

    // -------------------------------------------------------------------------
    // Expected results for this test program
    // -------------------------------------------------------------------------
    localparam [15:0] EXP_ADD_RESULT   = 16'h0008; // r3  = r1 + r2 = 3 + 5
    localparam [15:0] EXP_SUB_RESULT   = 16'h0007; // r4  = r3 - r5 = 8 - 1
    localparam [15:0] EXP_SLL_RESULT   = 16'h000C; // r6  = r1 << r2 = 3 << 2
    localparam [15:0] EXP_AND_RESULT   = 16'h0008; // r7  = r6 & r8 = 0xC & 0xA
    localparam [15:0] EXP_ADDI_RESULT  = 16'h0007; // r8  = r2 + 2 = 5 + 2

    localparam [15:0] EXP_MEM2 = 16'h0008;
    localparam [15:0] EXP_MEM3 = 16'h0007;
    localparam [15:0] EXP_MEM4 = 16'h000C;
    localparam [15:0] EXP_MEM5 = 16'h0008;
    localparam [15:0] EXP_MEM6 = 16'h0007;

    localparam [15:0] EXP_FINAL_PC = 16'd30; // final instruction is JMP -1

    // -------------------------------------------------------------------------
    // DUT
    // -------------------------------------------------------------------------
    Processor_Wrapper UUT (
        .clk_crystal(clk_crystal),
        .clk_button(clk_button),
        .clk_mux_switch(clk_mux_switch),
        .instr_o(instr_o),
        .A(A), .B(B), .C(C), .D(D), .E(E), .F(F), .G(G), .DOT(DOT),
        .digit3(digit3), .digit2(digit2), .digit1(digit1), .digit0(digit0)
    );

    // -------------------------------------------------------------------------
    // Crystal clock
    // Only needed because the wrapper has display/clock-divider logic.
    // The CPU itself will use clk_button directly because clk_mux_switch = 1.
    // -------------------------------------------------------------------------
    initial begin
        clk_crystal = 1'b0;
        forever #5 clk_crystal = ~clk_crystal;
    end

    // -------------------------------------------------------------------------
    // Helper: one manual CPU step
    // -------------------------------------------------------------------------
    task press_button_once;
    begin
        #5 clk_button = 1'b1;
        #5 clk_button = 1'b0;
        #1;

        $display(
            "t=%0t | PC=%0d | instr=%h | r3=%h r4=%h r6=%h r7=%h r8=%h r9=%h r10=%h r11=%h r12=%h r13=%h",
            $time,
            UUT.u_if.im_addr_reg,
            instr_o,
            UUT.u_id.reg_file[3],
            UUT.u_id.reg_file[4],
            UUT.u_id.reg_file[6],
            UUT.u_id.reg_file[7],
            UUT.u_id.reg_file[8],
            UUT.u_id.reg_file[9],
            UUT.u_id.reg_file[10],
            UUT.u_id.reg_file[11],
            UUT.u_id.reg_file[12],
            UUT.u_id.reg_file[13]
        );
    end
    endtask

    // -------------------------------------------------------------------------
    // Helper: check a register
    // -------------------------------------------------------------------------
    task check_reg;
        input [8*20:1] reg_name;
        input [15:0] actual_value;
        input [15:0] expected_value;
    begin
        if (actual_value !== expected_value)
            $display("FAILED [%0s] expected %h, got %h", reg_name, expected_value, actual_value);
        else
            $display("PASSED [%0s] = %h", reg_name, actual_value);
    end
    endtask

    // -------------------------------------------------------------------------
    // Helper: check a memory word (two bytes packed back into 16 bits)
    // -------------------------------------------------------------------------
    task check_mem_word;
        input [8*20:1] mem_name;
        input [15:0] actual_value;
        input [15:0] expected_value;
    begin
        if (actual_value !== expected_value)
            $display("FAILED [%0s] expected %h, got %h", mem_name, expected_value, actual_value);
        else
            $display("PASSED [%0s] = %h", mem_name, actual_value);
    end
    endtask

    // -------------------------------------------------------------------------
    // Test sequence
    // -------------------------------------------------------------------------
    initial begin
        clk_button     = 1'b0;
        clk_mux_switch = 1'b1;   // choose manual button clock as CPU clock

        #1;

        // Override any hardcoded contents inside RTL
        $readmemh("TEST_INSTR.txt", UUT.u_if.instruction_mem);
        $readmemh("TEST_REG.txt",   UUT.u_id.reg_file);
        $readmemh("TEST_MEM.txt",   UUT.u_mem.mem_data);

        // Start program from PC = 0
        UUT.u_if.im_addr_reg = 16'h0000;

        #2;
        $display("============================================================");
        $display("Starting complete ALU + Data Memory test");
        $display("Manual clock path is selected (clk_mux_switch = 1)");
        $display("============================================================");
        $display("Initial | PC=%0d | instr=%h", UUT.u_if.im_addr_reg, instr_o);

        // 16 instructions total:
        // 0..14  -> functional instructions
        // 15     -> JMP -1 to loop forever at PC=30
        for (i = 0; i < 16; i = i + 1)
            press_button_once();

        $display("\n============================================================");
        $display("Final register checks");
        $display("============================================================");

        check_reg("r3  ADD",   UUT.u_id.reg_file[3],  EXP_ADD_RESULT);
        check_reg("r4  SUB",   UUT.u_id.reg_file[4],  EXP_SUB_RESULT);
        check_reg("r6  SLL",   UUT.u_id.reg_file[6],  EXP_SLL_RESULT);
        check_reg("r7  AND",   UUT.u_id.reg_file[7],  EXP_AND_RESULT);
        check_reg("r8  ADDI",  UUT.u_id.reg_file[8],  EXP_ADDI_RESULT);
        check_reg("r9  LW 2",  UUT.u_id.reg_file[9],  EXP_MEM2);
        check_reg("r10 LW 3",  UUT.u_id.reg_file[10], EXP_MEM3);
        check_reg("r11 LW 4",  UUT.u_id.reg_file[11], EXP_MEM4);
        check_reg("r12 LW 5",  UUT.u_id.reg_file[12], EXP_MEM5);
        check_reg("r13 LW 6",  UUT.u_id.reg_file[13], EXP_MEM6);

        $display("\n============================================================");
        $display("Final memory-word checks");
        $display("============================================================");

        // Each word occupies two bytes in mem_data[]
        check_mem_word("mem[2]", {UUT.u_mem.mem_data[5],  UUT.u_mem.mem_data[4]},  EXP_MEM2);
        check_mem_word("mem[3]", {UUT.u_mem.mem_data[7],  UUT.u_mem.mem_data[6]},  EXP_MEM3);
        check_mem_word("mem[4]", {UUT.u_mem.mem_data[9],  UUT.u_mem.mem_data[8]},  EXP_MEM4);
        check_mem_word("mem[5]", {UUT.u_mem.mem_data[11], UUT.u_mem.mem_data[10]}, EXP_MEM5);
        check_mem_word("mem[6]", {UUT.u_mem.mem_data[13], UUT.u_mem.mem_data[12]}, EXP_MEM6);

        $display("\n============================================================");
        $display("Final PC check");
        $display("============================================================");

        if (UUT.u_if.im_addr_reg !== EXP_FINAL_PC)
            $display("FAILED [Final PC] expected %0d, got %0d", EXP_FINAL_PC, UUT.u_if.im_addr_reg);
        else
            $display("PASSED [Final PC] = %0d (stuck at JMP -1)", UUT.u_if.im_addr_reg);

        $display("\nTest complete.");
        $finish;
    end

endmodule