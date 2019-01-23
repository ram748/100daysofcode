timeunit 1us;
 timeprecision 1ns;

`include "test_module.sv"

module named_block;


  logic clk;

  test t0 (.*);

 initial begin
   clk = 1'b0;
   forever #5ns clk = ~clk;
 end


  initial begin
   $monitor("cnt tmp is %0d ",t0.counter.tmp);
  end

  initial begin

   #100ns;
   $finish();
  end


endmodule:named_block
