//----------------------------------------------------------------------------
// Example
//----------------------------------------------------------------------------

module mux
(
  input  d0, d1,
  input  sel,
  output y
);

  assign y = sel ? d1 : d0;

endmodule

//----------------------------------------------------------------------------
// Task
//----------------------------------------------------------------------------

module and_gate_using_mux
(
    input  a,
    input  b,
    output o
);

  // Task:
  // Implement and gate using instance(s) of mux,
  // constants 0 and 1, and wire connections
  
  wire Const_ZERO = 'b0;
  wire mux_out;

  mux mux1 (.d0(Const_ZERO), .d1(a), .sel(b), .y(mux_out));
  mux mux2 (.d0(Const_ZERO), .d1(mux_out), .sel(a), .y(o));

endmodule
