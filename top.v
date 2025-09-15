module jtag_top(
    // JTAG TAP interface
    input wire tms,      // Test Mode Select
    input wire tck,      // Test Clock
    input wire trst,     // Test Reset (active low)
    input wire tdi,      // Test Data Input
    output wire tdo,     // Test Data Output
    
    // All TAP Controller states as individual outputs for waveform visibility
    output wire test_logic_reset_state,
    output wire run_test_idle_state,
    output wire select_dr_scan_state,
    output wire capture_dr_state,
    output wire shift_dr_state,
    output wire exit1_dr_state,
    output wire pause_dr_state,
    output wire exit2_dr_state,
    output wire update_dr_state,
    output wire select_ir_scan_state,
    output wire capture_ir_state,
    output wire shift_ir_state,
    output wire exit1_ir_state,
    output wire pause_ir_state,
    output wire exit2_ir_state,
    output wire update_ir_state,
    
    // Current state as a 4-bit value
    output wire [3:0] current_state
);
    // JTAG TAP Controller States
    localparam TEST_LOGIC_RESET = 4'h0;
    localparam RUN_TEST_IDLE    = 4'h1;
    localparam SELECT_DR_SCAN   = 4'h2;
    localparam CAPTURE_DR       = 4'h3;
    localparam SHIFT_DR         = 4'h4;
    localparam EXIT1_DR         = 4'h5;
    localparam PAUSE_DR         = 4'h6;
    localparam EXIT2_DR         = 4'h7;
    localparam UPDATE_DR        = 4'h8;
    localparam SELECT_IR_SCAN   = 4'h9;
    localparam CAPTURE_IR       = 4'hA;
    localparam SHIFT_IR         = 4'hB;
    localparam EXIT1_IR         = 4'hC;
    localparam PAUSE_IR         = 4'hD;
    localparam EXIT2_IR         = 4'hE;
    localparam UPDATE_IR        = 4'hF;

    // State register
    reg [3:0] state;

    // TAP controller state machine
    always @(posedge tck or negedge trst) begin
        if(~trst) begin
            state <= TEST_LOGIC_RESET;
        end
        else begin
            case(state)
                TEST_LOGIC_RESET: state <= tms ? TEST_LOGIC_RESET : RUN_TEST_IDLE;
                RUN_TEST_IDLE:    state <= tms ? SELECT_DR_SCAN  : RUN_TEST_IDLE;
                SELECT_DR_SCAN:   state <= tms ? SELECT_IR_SCAN  : CAPTURE_DR;
                CAPTURE_DR:       state <= tms ? EXIT1_DR        : SHIFT_DR;
                SHIFT_DR:         state <= tms ? EXIT1_DR        : SHIFT_DR;
                EXIT1_DR:         state <= tms ? UPDATE_DR       : PAUSE_DR;
                PAUSE_DR:         state <= tms ? EXIT2_DR        : PAUSE_DR;
                EXIT2_DR:         state <= tms ? UPDATE_DR       : SHIFT_DR;
                UPDATE_DR:        state <= tms ? SELECT_DR_SCAN  : RUN_TEST_IDLE;

                SELECT_IR_SCAN:   state <= tms ? TEST_LOGIC_RESET : CAPTURE_IR;
                CAPTURE_IR:       state <= tms ? EXIT1_IR         : SHIFT_IR;
                SHIFT_IR:         state <= tms ? EXIT1_IR         : SHIFT_IR;
                EXIT1_IR:         state <= tms ? UPDATE_IR        : PAUSE_IR;
                PAUSE_IR:         state <= tms ? EXIT2_IR         : PAUSE_IR;
                EXIT2_IR:         state <= tms ? UPDATE_IR        : SHIFT_IR;
                UPDATE_IR:        state <= tms ? SELECT_DR_SCAN   : RUN_TEST_IDLE;
                default:          state <= TEST_LOGIC_RESET;
            endcase
        end
    end

    // Output signal assignments - one hot encoding
    // Individual state outputs for waveform visibility
    assign test_logic_reset_state = (state == TEST_LOGIC_RESET);
    assign run_test_idle_state = (state == RUN_TEST_IDLE);
    assign select_dr_scan_state = (state == SELECT_DR_SCAN);
    assign capture_dr_state = (state == CAPTURE_DR);
    assign shift_dr_state = (state == SHIFT_DR);
    assign exit1_dr_state = (state == EXIT1_DR);
    assign pause_dr_state = (state == PAUSE_DR);
    assign exit2_dr_state = (state == EXIT2_DR);
    assign update_dr_state = (state == UPDATE_DR);
    assign select_ir_scan_state = (state == SELECT_IR_SCAN);
    assign capture_ir_state = (state == CAPTURE_IR);
    assign shift_ir_state = (state == SHIFT_IR);
    assign exit1_ir_state = (state == EXIT1_IR);
    assign pause_ir_state = (state == PAUSE_IR);
    assign exit2_ir_state = (state == EXIT2_IR);
    assign update_ir_state = (state == UPDATE_IR);
    
    // Current state output
    assign current_state = state;
    
    // Temporary TDO assignment (will be replaced with actual implementation)
    assign tdo = 1'b0;

endmodule
