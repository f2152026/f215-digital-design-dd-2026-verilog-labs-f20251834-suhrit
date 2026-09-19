// tb.v

module tb;

  reg [1:0] t_A;
  reg [1:0] t_B;
  wire t_GT;
  wire t_LT;
  wire t_EQ;

  integer A;
  integer B;
  integer errors;

  comp2 U1 (
    .A(t_A),
    .B(t_B),
    .GT(t_GT),
    .LT(t_LT),
    .EQ(t_EQ)
  );

  initial begin
    errors = 0;

    for (A = 0; A < 4; A = A + 1) begin
      for (B = 0; B < 4; B = B + 1) begin

        t_A = A;
        t_B = B;
        #1;

        if ((t_GT + t_LT + t_EQ) !== 1) begin
          $display("FAIL: A=%0d B=%0d | GT=%b LT=%b EQ=%b",
                   A, B, t_GT, t_LT, t_EQ);
          errors = errors + 1;
        end
        else if ((A > B && t_GT !== 1) ||
                 (A < B && t_LT !== 1) ||
                 (A == B && t_EQ !== 1)) begin
          $display("FAIL: A=%0d B=%0d | GT=%b LT=%b EQ=%b",
                   A, B, t_GT, t_LT, t_EQ);
          errors = errors + 1;
        end
        else begin
          $display("PASS: A=%0d B=%0d | GT=%b LT=%b EQ=%b",
                   A, B, t_GT, t_LT, t_EQ);
        end

      end
    end

    if (errors == 0)
      $display("ALL COMPARATOR TESTS PASSED");
    else
      $display("%0d TESTS FAILED", errors);

    $finish;
  end

endmodule