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

module not_gate_using_mux
(
    input  i,
    output o
);

  // Task:
  // Implement not gate using instance(s) of mux,
  // constants 0 and 1, and wire connections


  wire Const_ZERO = 1'b0;
  wire Const_ONE  = 1'b1;

  mux mux0 ( .d0(Const_ONE), .d1(Const_ZERO), .sel(i), .y(o));
 // mux mux1 = (d0(Const_ZERO), d1(Const_ONE), sel[i], y(0));

endmodule
