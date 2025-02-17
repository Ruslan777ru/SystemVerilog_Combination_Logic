//----------------------------------------------------------------------------
// Task
//----------------------------------------------------------------------------

module serial_adder_with_vld
(
  input  clk,
  input  rst,
  input  vld,
  input  a,
  input  b,
  input  last,
  output sum
);

  // Task:
  // Implement a module that performs serial addition of two numbers
  // (one pair of bits is summed per clock cycle).
  //
  // It should have input signals a and b, and output signal sum.
  // Additionally, the module have two control signals, vld and last.
  //
  // The vld signal indicates when the input values are valid.
  // The last signal indicates when the last digits of the input numbers has been received.
  //
  // When vld is high, the module should add the values of a and b and produce the sum.
  // When last is high, the module should output the sum and reset its internal state, but
  // only if vld is also high, otherwise last should be ignored.
  //
  // When rst is high, the module should reset its internal state.


//  logic Transfer_bit, Transfer_bit_out;
  
//   always_ff @ (posedge clk or posedge rst) begin

//     if (rst) begin
//        Transfer_bit <= 0;
//        sum <= 0;
//     end

//     else if (vld) begin
//         sum <= a ^ b ^ Transfer_bit;
//         Transfer_bit <= (a * b) + (a * Transfer_bit) + (b * Transfer_bit);
//       end

//     if (last && vld) begin
//         //sum <= sum;
//         Transfer_bit <= 0;
//     end


  logic Transfer_bit, Transfer_bit_next;

  assign sum = a ^ b ^ Transfer_bit;
  assign Transfer_bit_next = (a * b) + (a * Transfer_bit) + (b * Transfer_bit);

  always_ff @ (posedge clk) begin
    if (rst | (last & vld))
        Transfer_bit <= '0;
    else if (~ vld)
        Transfer_bit <= Transfer_bit;
    else
      Transfer_bit <= Transfer_bit_next;

  end

endmodule
