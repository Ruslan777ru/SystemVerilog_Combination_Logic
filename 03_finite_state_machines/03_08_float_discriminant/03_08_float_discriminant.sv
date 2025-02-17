//----------------------------------------------------------------------------
// Task
//----------------------------------------------------------------------------

module float_discriminant (
    input clk,
    input rst,

    input              arg_vld,
    input [FLEN - 1:0] a,
    input [FLEN - 1:0] b,
    input [FLEN - 1:0] c,

    output logic              res_vld,
    output logic [FLEN - 1:0] res,
    output logic              res_negative,
    output logic              err,
    output logic              busy
);

  logic [FLEN - 1:0] b_sq;
  logic [FLEN - 1:0] ac;
  logic [FLEN - 1:0] four_ac;

  logic down_valid_b_sq, down_valid_ac, down_valid_four_ac;
  logic busy_b_sq, busy_ac, busy_sub, busy_four_ac;
  logic err_b_sq, err_ac, err_sub, err_four_ac;

  localparam [FLEN - 1:0] four = 64'h4010_0000_0000_0000;
  
  // b^2
  f_mult i_b_sq (
      .clk(clk),
      .rst(rst),
      .a(b),
      .b(b),
      .up_valid(arg_vld),
      .res(b_sq),
      .down_valid(down_valid_b_sq),
      .busy(busy_b_sq),
      .error(err_b_sq)
  );

  // a * c
  f_mult i_ac (
      .clk(clk),
      .rst(rst),
      .a(a),
      .b(c),
      .up_valid(arg_vld),
      .res(ac),
      .down_valid(down_valid_ac),
      .busy(busy_ac),
      .error(err_ac)
  );

  // 4 * a * c
  f_mult i_four_ac (
      .clk(clk),
      .rst(rst),
      .a(four),
      .b(ac),
      .up_valid(down_valid_ac),
      .res(four_ac),
      .down_valid(down_valid_four_ac),
      .busy(busy_four_ac),
      .error(err_four_ac)
  );

  // b^2 - 4ac
  f_sub i_discr (
      .clk(clk),
      .rst(rst),
      .a(b_sq),
      .b(four_ac),
      .up_valid(down_valid_four_ac),
      .res(res),
      .down_valid(res_vld),
      .busy(busy_sub),
      .error(err_sub)
  );

  always_ff @(posedge clk) begin
    if (rst) begin
      res_negative <= 0;
    end else if (res_vld) begin
      res_negative <= res[FLEN - 1];
    end
  end

  assign busy = busy_ac | busy_b_sq | busy_sub | busy_four_ac;

  //error
  assign err  = err_ac | err_b_sq | err_sub | err_four_ac;

endmodule