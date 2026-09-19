// tb.v

module tb;

  // Inputs and output
  reg [2:0] t_sel;
  wire [7:0] t_dout;

  integer i;
  integer errors;

  // Instantiate LUT with parameter override
  lut #(
    .WIDTH(8),
    .DEPTH(8)
  ) U1 (
    .sel(t_sel),
    .dout(t_dout)
  );

  // Waveform dump configuration
  string vcd_file;

  initial begin
    if ($value$plusargs("vcd=%s", vcd_file)) begin
      $dumpfile(vcd_file);
      $dumpvars(0, U1);
    end
  end

  // Test every valid address
  initial begin
    errors = 0;

    for (i = 0; i < 8; i = i + 1) begin
      t_sel = i;
      #1;

      if (t_dout !== i * i) begin
        $display("FAIL: sel=%0d dout=%0d expected=%0d",
                 i, t_dout, i * i);
        errors = errors + 1;
      end
      else begin
        $display("PASS: sel=%0d dout=%0d",
                 i, t_dout);
      end
    end

    if (errors == 0)
      $display("ALL LUT TESTS PASSED");
    else
      $display("%0d TESTS FAILED", errors);

    $finish;
  end

endmodule