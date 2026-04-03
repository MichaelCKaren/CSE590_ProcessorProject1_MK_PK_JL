`timescale 1ns / 1ps

module tb_ADDI_LW_BEQ();
    
    reg clk;

    // Instantiate your processor
    Processor_Wrapper UUT (
        .clk(clk)
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk; // 10ns clock period
    end

    // Monitor and verify outputs
    initial begin
        $display("Starting ADDI, LW, BEQ Test...");
        
        // Wait a few clock cycles for the program to execute
        #10; $display("Cycle 1: ADDI executing...");
        #10; $display("Cycle 2: LW executing...");
        #10; $display("Cycle 3: BEQ executing...");
        #10; $display("Cycle 4: Branch skipped ADDI 1, executing ADDI 2...");
        #20; // Let final writebacks finish

        $display("-------------------------------------------");
        $display("Registers State after execution:");
        $display("$r3 (ADDI result) = %h (Expected: 000f)", UUT.u_id.reg_file[3]);
        $display("$r4 (LW result)   = %h (Expected: bbaa)", UUT.u_id.reg_file[4]);
        $display("$r5 (Skipped)     = %h (Expected: 0000)", UUT.u_id.reg_file[5]);
        $display("$r6 (Branch dest) = %h (Expected: 000b)", UUT.u_id.reg_file[6]);
        $display("-------------------------------------------");

        // 1. Check ADDI
        if (UUT.u_id.reg_file[3] !== 16'h000F) begin
            $display("FAILED [ADDI]: Expected $r3 = 000f, but got %h", UUT.u_id.reg_file[3]);
        end else begin
            $display("PASSED [ADDI]");
        end

        // 2. Check LW
        if (UUT.u_id.reg_file[4] !== 16'hbbaa) begin
            $display("FAILED [LW]: Expected $r4 = bbaa, but got %h", UUT.u_id.reg_file[4]);
        end else begin
            $display("PASSED [LW]");
        end

        // 3. Check BEQ
        if (UUT.u_id.reg_file[5] !== 16'h0000 || UUT.u_id.reg_file[6] !== 16'h000B) begin
            $display("FAILED [BEQ]: Branching behavior was incorrect.");
            if (UUT.u_id.reg_file[5] !== 16'h0000) 
                $display("Branch did NOT skip instruction. $r5 should be 0000, got %h", UUT.u_id.reg_file[5]);
            if (UUT.u_id.reg_file[6] !== 16'h000B) 
                $display("Wrong target or didn't execute. $r6 should be 000b, got %h", UUT.u_id.reg_file[6]);
        end else begin
            $display("PASSED [BEQ]");
        end

        $finish;
    end
endmodule