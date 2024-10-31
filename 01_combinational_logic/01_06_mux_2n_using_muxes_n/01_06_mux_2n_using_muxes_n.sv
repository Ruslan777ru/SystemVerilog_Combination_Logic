//----------------------------------------------------------------------------
// Example
//----------------------------------------------------------------------------

module mux_2_1
(
  input  [3:0] d0, d1,
  input        sel,
  output [3:0] y
);

  assign y = sel ? d1 : d0;

endmodule

//----------------------------------------------------------------------------
// Task
//----------------------------------------------------------------------------


module mux_2_1_1(

    input [3:0] d0,
    input [3:0] d1,
    input sel,
    output [3:0] y
);
    assign y = sel ? d1 : d0;

endmodule

module mux_2_1_2(

    input [3:0] d2,
    input [3:0] d3,
    input sel,
    output [3:0] y
);
    assign y = sel ? d3 : d2;

endmodule

module mux_2_1_3(

    input [3:0] a,
    input [3:0] b,
    input sel,
    output [3:0] y
);
    assign y = sel ? b : a;
    
endmodule

module mux_4_1
(
  input  [3:0] d0, d1, d2, d3,
  input  [1:0] sel,
  output [3:0] y
);

  // Task:
  // Implement mux_4_1 using three instances of mux_2_1

  logic [3:0] mux_0_out;
  logic [3:0] mux_1_out;
 // wire [3:0] mux_2_1_3;
 
  mux_2_1_1 mux0 (d0, d1, sel[0], mux_0_out);  
  mux_2_1_2 mux1 (d2, d3, sel[0], mux_1_out);
  mux_2_1_3 mux2 (mux_0_out, mux_1_out, sel[1], y);



endmodule
