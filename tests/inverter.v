module inverter (A, Y);
  input  A;
  output Y;

  assign Y = ~A;

endmodule
