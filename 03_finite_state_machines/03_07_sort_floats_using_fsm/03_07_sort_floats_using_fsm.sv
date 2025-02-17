//----------------------------------------------------------------------------
// Task
//----------------------------------------------------------------------------

module sort_floats_using_fsm (
    input                          clk,
    input                          rst,

    input                          valid_in,
    input        [0:2][FLEN - 1:0] unsorted,

    output logic                   valid_out,
    output logic [0:2][FLEN - 1:0] sorted,
    output logic                   err,
    output logic                   busy,

    output logic      [FLEN - 1:0] f_le_a,
    output logic      [FLEN - 1:0] f_le_b,
    input                          f_le_res,
    input                          f_le_err
);

    enum logic [1:0] {
        STATE_IDLE = 2'b00,
        STATE_COMP_U0_U1 = 2'b01,
        STATE_COMP_U1_U2 = 2'b10,
        STATE_COMP_U0_U2 = 2'b11
    } state, next_state;

    logic [FLEN-1:0] u0, u1, u2;

    logic u0_less_or_equal_u1, u1_less_or_equal_u2, u0_less_or_equal_u2;

    always_comb
    begin
        if (valid_in) begin
            u0 = unsorted[0];
            u1 = unsorted[1];
            u2 = unsorted[2];
        end
    end

    always_comb
    begin
        next_state = state;

        case (state)
        STATE_IDLE : if (valid_in) next_state = STATE_COMP_U0_U1;
        STATE_COMP_U0_U1: if (!f_le_err) next_state = STATE_COMP_U1_U2;
        STATE_COMP_U1_U2: if (!f_le_err) next_state = STATE_COMP_U0_U2;
        STATE_COMP_U0_U2: if (!f_le_err) next_state = STATE_IDLE;
        endcase
    end

    always_ff @ (posedge clk)
        if (rst | f_le_err)
            state <= STATE_IDLE;
        else
            state <= next_state;

    always_comb
    begin
        case (state)

        STATE_IDLE : begin
            f_le_a = u0;
            f_le_b = u1;
            u0_less_or_equal_u1 = f_le_res;
        end

        STATE_COMP_U0_U1: begin
            f_le_a = u1;
            f_le_b = u2;
            u1_less_or_equal_u2 = f_le_res;
        end

        STATE_COMP_U1_U2: begin
            f_le_a = u0;
            f_le_b = u2;
            u0_less_or_equal_u2 = f_le_res;
        end

        endcase
    end

    always_comb
    begin
        if (u0_less_or_equal_u1 & u1_less_or_equal_u2)
            sorted = unsorted;
        else if (u0_less_or_equal_u1 & !u1_less_or_equal_u2 & u0_less_or_equal_u2)
            sorted = {u0, u2, u1};
        else if (u0_less_or_equal_u1 & !u1_less_or_equal_u2 & !u0_less_or_equal_u2)
            sorted = {u2, u0, u1};
        else if (!u0_less_or_equal_u1 & u1_less_or_equal_u2 & !u0_less_or_equal_u2)
            sorted = {u1, u2, u0};
        else if (!u0_less_or_equal_u1 & u1_less_or_equal_u2 & u0_less_or_equal_u2)
            sorted = {u1, u0, u2};
        else if (!u0_less_or_equal_u1 & !u1_less_or_equal_u2)
            sorted = {u2, u1, u0};
    end

    assign valid_out = (state == STATE_COMP_U0_U2) | (f_le_err);
    assign err = f_le_err;
    assign busy = (state != STATE_IDLE);

endmodule