//----------------------------------------------------------------------------
// Example
//----------------------------------------------------------------------------

module detect_4_bit_sequence_using_fsm
(
  input  clk,
  input  rst,
  input  a,
  output detected
);

  // Detection of the "1010" sequence

  // States (F — First, S — Second)
  enum logic[2:0]
  {
     IDLE = 3'b000,
     F1   = 3'b001,
     F0   = 3'b010,
     S1   = 3'b011,
     S0   = 3'b100
  }
  state, new_state;

  // State transition logic
  always_comb
  begin
    new_state = state;

    // This lint warning is bogus because we assign the default value above
    // verilator lint_off CASEINCOMPLETE

    case (state)
      IDLE: if (  a) new_state = F1;
      F1:   if (~ a) new_state = F0;
      F0:   if (  a) new_state = S1;
            else     new_state = IDLE;
      S1:   if (~ a) new_state = S0;
            else     new_state = F1;
      S0:   if (  a) new_state = S1;
            else     new_state = IDLE;
    endcase

    // verilator lint_on CASEINCOMPLETE

  end

  // Output logic (depends only on the current state)
  assign detected = (state == S0);

  // State update
  always_ff @ (posedge clk)
    if (rst)
      state <= IDLE;
    else
      state <= new_state;

endmodule

//----------------------------------------------------------------------------
// Task
//----------------------------------------------------------------------------

module detect_6_bit_sequence_using_fsm
(
  input  clk,
  input  rst,
  input  a,
  output detected 
);

  enum logic[5:0]
  {
     IDLE = 6'b000000,
     S1   = 6'b100000,
     S2   = 6'b110000,
     S3   = 6'b011000,
     S4   = 6'b001100,
     S5   = 6'b100110,
     S6   = 6'b110011,
     S7   = 6'b011001 
  }
  state, new_state;  

  always_comb
  begin
    new_state = state;  
    case (state)
      IDLE: if (  a) new_state = S1;
      S1:   if (  a) new_state = S2;
            else     new_state = IDLE; 
      S2:   if (  a) new_state = IDLE;
            else     new_state = S3;
      S3:   if (  a) new_state = IDLE;
            else     new_state = S4; 
      S4:   if (  a) new_state = S5;
            else     new_state = IDLE;
      S5:   if (  a) new_state = S6;
            else     new_state = IDLE; 
      S6:   if (  a) new_state = IDLE;
            else     new_state = S7;
      S7:   if (  a) new_state = IDLE; 
            else     new_state = S4; 
      default: new_state = IDLE; 
    endcase
  end


  assign detected = (state == S6);

 
  always_ff @ (posedge clk)
    if (rst)
      state <= IDLE;
    else
      state <= new_state;

endmodule