//----------------------------------------------------------------------------
// Example
//----------------------------------------------------------------------------

module serial_adder
(
  input  clk,
  input  rst,
  input  a,
  input  b,
  output sum
);

  // Note:
  // carry_d represents the combinational data input to the carry register.

  logic carry;
  wire carry_d;

  assign { carry_d, sum } = a + b + carry;

  always_ff @ (posedge clk)
    if (rst)
      carry <= '0;
    else
      carry <= carry_d;

endmodule

//----------------------------------------------------------------------------
// Task
//----------------------------------------------------------------------------

module serial_adder_using_logic_operations_only
(
  input  clk,
  input  rst,
  input  a,
  input  b,
  output sum
);

  // Task:
  // Implement a serial adder using only ^ (XOR), | (OR), & (AND), ~ (NOT) bitwise operations.
  //
  // Notes:
  // See Harris & Harris book
  // or https://en.wikipedia.org/wiki/Adder_(electronics)#Full_adder webpage
  // for information about the 1-bit full adder implementation.
  //
  // See the testbench for the output format ($display task).

  //First of all, we should create transfer bit and other transfer bit
  
  logic [1:0] Transfer_bit;
  logic [1:0] Transfer_bit_next;

  assign sum = a ^ b ^ Transfer_bit;
  assign Transfer_bit_next = (a * b) + (a * Transfer_bit) + (b * Transfer_bit);


  always_ff @ (posedge clk) begin

    if (rst) begin
       Transfer_bit <= 0;
    end

    else begin
      Transfer_bit<= Transfer_bit_next;
    end

  end

endmodule
