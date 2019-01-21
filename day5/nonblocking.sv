module nonblocking();

 timeunit 1us;
 timeprecision 1ns;
 bit clk;
 reg rst;

 initial begin
  clk = 1'b0;
 #5ns clk = 1'b1;

 end

 initial begin
  rst <= 1'b1;
  #5ns rst <= 1'b0;
 end

 initial begin
 $dumpfile("file.vcd");
 $dumpvars(0);
 $vcdpluson(0);
 $vcdplusdeltacycleon;
#30;
 $vcdplusdeltacycleoff;
 end

initial begin
 $timeformat(-9,3,"ns",5);
$display("starting tb");
#30;
$display("ending tb %t",$time);
$finish();
end

endmodule:nonblocking
