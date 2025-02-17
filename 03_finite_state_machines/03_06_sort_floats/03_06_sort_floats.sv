//----------------------------------------------------------------------------
// Example
//----------------------------------------------------------------------------

module sort_two_floats_ab (
    input        [FLEN - 1:0] a,
    input        [FLEN - 1:0] b,

    output logic [FLEN - 1:0] res0,
    output logic [FLEN - 1:0] res1,
    output                    err
);

    logic a_less_or_equal_b;

    f_less_or_equal i_floe (
        .a   ( a                 ),
        .b   ( b                 ),
        .res ( a_less_or_equal_b ),
        .err ( err               )
    );

    always_comb begin : a_b_compare
        if ( a_less_or_equal_b ) begin
            res0 = a;
            res1 = b;
        end
        else
        begin
            res0 = b;
            res1 = a;
        end
    end

endmodule

//----------------------------------------------------------------------------
// Example - different style
//----------------------------------------------------------------------------

module sort_two_floats_array
(
    input        [0:1][FLEN - 1:0] unsorted,
    output logic [0:1][FLEN - 1:0] sorted,
    output                         err
);

    logic u0_less_or_equal_u1;

    f_less_or_equal i_floe
    (
        .a   ( unsorted [0]        ),
        .b   ( unsorted [1]        ),
        .res ( u0_less_or_equal_u1 ),
        .err ( err                 )
    );

    always_comb
        if (u0_less_or_equal_u1)
            sorted = unsorted;
        else
              {   sorted [0],   sorted [1] }
            = { unsorted [1], unsorted [0] };

endmodule

//----------------------------------------------------------------------------
// Task
//----------------------------------------------------------------------------

module sort_three_floats (
    input        [0:2][FLEN - 1:0] unsorted,
    output logic [0:2][FLEN - 1:0] sorted,
    output logic                   err
);

    logic [2:0] err_flags;
    logic less_01, less_02, less_12;

    f_less_or_equal compare_01 (
        .a   ( unsorted[0] ),
        .b   ( unsorted[1] ),
        .res ( less_01     ),
        .err ( err_flags[0])
    );

    f_less_or_equal compare_02 (
        .a   ( unsorted[0] ),
        .b   ( unsorted[2] ),
        .res ( less_02     ),
        .err ( err_flags[1])
    );

    f_less_or_equal compare_12 (
        .a   ( unsorted[1] ),
        .b   ( unsorted[2] ),
        .res ( less_12     ),
        .err ( err_flags[2])
    );

    always_comb begin
        err = |err_flags;

        if (less_01) begin
            if (less_12) begin
                sorted[0] = unsorted[0];
                sorted[1] = unsorted[1];
                sorted[2] = unsorted[2];
                
            end else if (less_02) begin 
                sorted[0] = unsorted[0];
                sorted[1] = unsorted[2];
                sorted[2] = unsorted[1];

            end else begin
                sorted[0] = unsorted[2];
                sorted[1] = unsorted[0];
                sorted[2] = unsorted[1];
            end

        end else begin
            if (less_02) begin
                sorted[0] = unsorted[1];
                sorted[1] = unsorted[0];
                sorted[2] = unsorted[2];

            end else if (less_12) begin
                sorted[0] = unsorted[1];
                sorted[1] = unsorted[2];
                sorted[2] = unsorted[0];

            end else begin
                sorted[0] = unsorted[2];
                sorted[1] = unsorted[1];
                sorted[2] = unsorted[0];
            end
        end
    end

endmodule
