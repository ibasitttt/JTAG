`timescale 1ns/1ps

module jtag_tb;
    // Test signals
    reg  tms;
    reg  tck;
    reg  trst;
    reg  tdi;
    wire tdo;
    
    // No state indicators needed - using individual state outputs instead
    
    // All TAP Controller states for waveform visibility
    wire test_logic_reset_state;
    wire run_test_idle_state;
    wire select_dr_scan_state;
    wire capture_dr_state;
    wire shift_dr_state;
    wire exit1_dr_state;
    wire pause_dr_state;
    wire exit2_dr_state;
    wire update_dr_state;
    wire select_ir_scan_state;
    wire capture_ir_state;
    wire shift_ir_state;
    wire exit1_ir_state;
    wire pause_ir_state;
    wire exit2_ir_state;
    wire update_ir_state;
    
    // Current state as a 4-bit value
    wire [3:0] current_state;
    
    // Instantiate the JTAG TAP controller
    jtag_top dut (
        .tms(tms),
        .tck(tck),
        .trst(trst),
        .tdi(tdi),
        .tdo(tdo),
        .test_logic_reset_state(test_logic_reset_state),
        .run_test_idle_state(run_test_idle_state),
        .select_dr_scan_state(select_dr_scan_state),
        .capture_dr_state(capture_dr_state),
        .shift_dr_state(shift_dr_state),
        .exit1_dr_state(exit1_dr_state),
        .pause_dr_state(pause_dr_state),
        .exit2_dr_state(exit2_dr_state),
        .update_dr_state(update_dr_state),
        .select_ir_scan_state(select_ir_scan_state),
        .capture_ir_state(capture_ir_state),
        .shift_ir_state(shift_ir_state),
        .exit1_ir_state(exit1_ir_state),
        .pause_ir_state(pause_ir_state),
        .exit2_ir_state(exit2_ir_state),
        .update_ir_state(update_ir_state),
        .current_state(current_state)
    );
    
    // Clock generation
    always #5 tck = ~tck;
    
    // Test sequence
    initial begin
        // Initialize signals
        tck = 0;
        tms = 1;
        trst = 0;
        tdi = 0;
        
        // Release reset
        #20 trst = 1;
        
        // Test FSM state transitions
        
        // Go to Test-Logic-Reset state
        tms = 1; #10; #10; #10; #10; #10;
        $display("Should be in TEST_LOGIC_RESET state (state=%h)", current_state);
        
        // Go to Run-Test/Idle
        tms = 0; #10;
        $display("Should be in RUN_TEST_IDLE state (state=%h)", current_state);
        
        // Go to Select-DR-Scan
        tms = 1; #10;
        $display("Should be in SELECT_DR_SCAN state (state=%h)", current_state);
        
        // Go to Capture-DR
        tms = 0; #10;
        $display("Should be in CAPTURE_DR state (state=%h, capture_dr=%b)", current_state, capture_dr_state);
        
        // Go to Shift-DR
        tms = 0; #10;
        $display("Should be in SHIFT_DR state (state=%h, shift_dr=%b)", current_state, shift_dr_state);
        
        // Stay in Shift-DR for a few cycles
        tms = 0; #10; #10; #10;
        $display("Should still be in SHIFT_DR state (state=%h, shift_dr=%b)", current_state, shift_dr_state);
        
        // Go to Exit1-DR
        tms = 1; #10;
        $display("Should be in EXIT1_DR state (state=%h)", current_state);
        
        // Go to Update-DR
        tms = 1; #10;
        $display("Should be in UPDATE_DR state (state=%h, update_dr=%b)", current_state, update_dr_state);
        
        // Go to Run-Test/Idle
        tms = 0; #10;
        $display("Should be in RUN_TEST_IDLE state (state=%h)", current_state);
        
        // Go to Select-DR-Scan
        tms = 1; #10;
        $display("Should be in SELECT_DR_SCAN state (state=%h)", current_state);
        
        // Go to Select-IR-Scan
        tms = 1; #10;
        $display("Should be in SELECT_IR_SCAN state (state=%h)", current_state);
        
        // Go to Capture-IR
        tms = 0; #10;
        $display("Should be in CAPTURE_IR state (state=%h, capture_ir=%b)", current_state, capture_ir_state);
        
        // Go to Shift-IR
        tms = 0; #10;
        $display("Should be in SHIFT_IR state (state=%h, shift_ir=%b)", current_state, shift_ir_state);
        
        // Stay in Shift-IR for a few cycles
        tms = 0; #10; #10; #10;
        $display("Should still be in SHIFT_IR state (state=%h, shift_ir=%b)", current_state, shift_ir_state);
        
        // Go to Exit1-IR
        tms = 1; #10;
        $display("Should be in EXIT1_IR state (state=%h)", current_state);
        
        // Go to Update-IR
        tms = 1; #10;
        $display("Should be in UPDATE_IR state (state=%h, update_ir=%b)", current_state, update_ir_state);
        
        // Go to Run-Test/Idle
        tms = 0; #10;
        $display("Should be in RUN_TEST_IDLE state (state=%h)", current_state);
        
        // End simulation
        #20 $finish;
    end
    
    // Monitor state indicators and signals
    initial begin
        $monitor("Time=%0t, TMS=%b, TDI=%b, TDO=%b, State=%h, TLR=%b, RTI=%b, SDR=%b, CDR=%b, ShDR=%b, E1DR=%b, PDR=%b, E2DR=%b, UDR=%b, SIR=%b, CIR=%b, ShIR=%b, E1IR=%b, PIR=%b, E2IR=%b, UIR=%b", 
                 $time, tms, tdi, tdo, current_state, 
                 test_logic_reset_state, run_test_idle_state, 
                 select_dr_scan_state, capture_dr_state, shift_dr_state, 
                 exit1_dr_state, pause_dr_state, exit2_dr_state, update_dr_state,
                 select_ir_scan_state, capture_ir_state, shift_ir_state,
                 exit1_ir_state, pause_ir_state, exit2_ir_state, update_ir_state);
    end
    
    // Generate VCD file for waveform viewing
    initial begin
        $dumpfile("jtag_tb.vcd");
        $dumpvars(0, jtag_tb);
    end
    
endmodule
