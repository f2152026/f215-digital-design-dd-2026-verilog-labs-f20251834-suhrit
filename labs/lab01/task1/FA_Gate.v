// FA_Gate.v
// Gate-level structural full adder (Task 1b)
// Same logic as Task 1a, but the five gate instantiations are written
// in a different order: the final 'or' is now listed first, and the
// first 'xor' is now listed last.

module FA_Gate (
    input  a,
    input  b,
    input  cin,
    output sum,
    output cout
);

  wire p1;   // p1 = a ^ b   (intermediate propagate signal)
  wire c1;   // c1 = a & b
  wire c2;   // c2 = p1 & cin

  or  (cout, c1, c2);
  and (c2, p1, cin);
  and (c1, a, b);
  xor (sum, p1, cin);
  xor (p1, a, b);

endmodule