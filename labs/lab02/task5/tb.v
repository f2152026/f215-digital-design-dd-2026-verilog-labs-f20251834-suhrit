// tb.v

module tb;

  reg [3:0] t_a;
  reg [3:0] t_b;
  reg       t_op;
  wire [3:0] t_result;

  integer errors;

  alu U1 (
    .a(t_a),
    .b(t_b),
    .op(t_op),
    .result(t_result)
  );

  // Test the ALU
  initial begin
    errors = 0;

    // ADD tests
    t_a = 4'd3;
    t_b = 4'd2;
    t_op = 1'b0;
    #1;

    if (t_result !== 4'd5) begin
      $display("FAIL: ADD a=%0d b=%0d result=%0d expected=5",
               t_a, t_b, t_result);
      errors = errors + 1;
    end
    else
      $display("PASS: ADD a=%0d b=%0d result=%0d",
               t_a, t_b, t_result);

    // Switch op while keeping operands the same
    t_op = 1'b1;
    #1;

    if (t_result !== 4'd1) begin
      $display("FAIL: SUB a=%0d b=%0d result=%0d expected=1",
               t_a, t_b, t_result);
      errors = errors + 1;
    end
    else
      $display("PASS: SUB a=%0d b=%0d result=%0d",
               t_a, t_b, t_result);

    // More subtraction tests with changing operands
    t_a = 4'd7;
    t_b = 4'd3;
    #1;

    if (t_result !== 4'd4) begin
      $display("FAIL: SUB a=%0d b=%0d result=%0d expected=4",
               t_a, t_b, t_result);
      errors = errors + 1;
    end
    else
      $display("PASS: SUB a=%0d b=%0d result=%0d",
               t_a, t_b, t_result);

    // Switch back to ADD with new operands
    t_op = 1'b0;
    #1;

    if (t_result !== 4'd10) begin
      $display("FAIL: ADD a=%0d b=%0d result=%0d expected=10",
               t_a, t_b, t_result);
      errors = errors + 1;
    end
    else
      $display("PASS: ADD a=%0d b=%0d result=%0d",
               t_a, t_b, t_result);

    // Another subtraction
    t_a = 4'd10;
    t_b = 4'd4;
    t_op = 1'b1;
    #1;

    if (t_result !== 4'd6) begin
      $display("FAIL: SUB a=%0d b=%0d result=%0d expected=6",
               t_a, t_b, t_result);
      errors = errors + 1;
    end
    else
      $display("PASS: SUB a=%0d b=%0d result=%0d",
               t_a, t_b, t_result);

    if (errors == 0)
      $display("ALL ALU TESTS PASSED");
    else
      $display("%0d TESTS FAILED", errors);

    $finish;
  end

  initial begin
    $monitor($time, " a=%0d b=%0d op=%b | result=%0d",
             t_a, t_b, t_op, t_result);
  end

endmodule