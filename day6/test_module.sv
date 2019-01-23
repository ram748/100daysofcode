module test(input logic clk);

  always @(posedge clk) begin:counter
    int tmp;
        tmp += 1'b1;
  end:counter

endmodule:test
