module FA_Gate (
    input  a,
    input  b,
    input  cin,
    output sum,
    output cout
);

  wire p1;
  wire c1;
  wire c2;

  xor #(2) (p1, a, b);
  xor #(2) (sum, p1, cin);

  and #(2) (c1, a, b);
  and #(2) (c2, p1, cin);

  or  #(2) (cout, c1, c2);

endmodule