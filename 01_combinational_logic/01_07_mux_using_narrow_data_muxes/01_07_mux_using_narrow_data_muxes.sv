//----------------------------------------------------------------------------
// Example
//----------------------------------------------------------------------------


module mux_4_1_width_2
(
  input  [1:0] d0, d1, d2, d3,
  input  [1:0] sel,
  output [1:0] y
);

  assign y = sel [1] ? (sel [0] ? d3 : d2)
                     : (sel [0] ? d1 : d0);

endmodule

//----------------------------------------------------------------------------
// Task
//----------------------------------------------------------------------------


  // Task:
  // Implement mux_4_1 with 4-bit data
  // using two instances of mux_4_1_width_2 with 2-bit data

// module mux_2_1_1
// (
//   input  [1:0] d0, d1,
//   input   sel,
//   output [1:0] y
// );

//   assign y = sel ? d1 : d0;

// endmodule

// module mux_2_1_2
// (
//   input  [1:0] d3, d2,
//   input   sel,
//   output [1:0] y
// );

//   assign y = sel ? d3 : d2;

// endmodule


// module mux_4_1
// (
//   input  [3:0] d0, d1, d2, d3,
//   input  [1:0] sel,
//   output [3:0] y
// );


//   logic [1:0] mux_0_out;
//   logic [1:0] mux_1_out;
 
//   mux_2_1_1 mux0 (d0 [1:0], d1 [1:0], sel[0], mux_0_out);  
//   mux_2_1_2 mux1 (d2 [1:0], d3 [1:0], sel[0], mux_1_out);

//   assign y = {mux_1_out, mux_0_out};



// endmodule


module mux_4_1 (
  input  [3:0] d0, d1, d2, d3,
  input  [1:0] sel,
  output [3:0] y
);

  logic [1:0] mux_0_out;
  logic [1:0] mux_1_out;

  mux_4_1_width_2 mux0 (d0[1:0], d1[1:0], d2[1:0], d3[1:0], sel, mux_0_out);
  mux_4_1_width_2 mux1 (d0[3:2], d1[3:2], d2[3:2], d3[3:2], sel, mux_1_out);

  assign y = {mux_1_out, mux_0_out};

endmodule