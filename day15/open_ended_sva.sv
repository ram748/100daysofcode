timeunit 1ns;
timeprecision 1ns;
module open_ended_sva;

  bit clk,req,ack,done;

  property p_req_ack2;
    @(posedge clk)
    $rose(req) |-> ##1 ($rose(ack)[->1]);
  endproperty:p_req_ack2

  OPEN_ENDED:assert property(p_req_ack2) begin
              $display("passed");
             end else begin
              $display("failed");
             end

  initial begin
    forever #5ns clk = ~clk;
  end

  initial begin:stimulus
    #50ns;
    req = 1'b1;
    #15ns;
    ack= 1'b0;

   #100ns;
   $finish();


  end:stimulus
  

endmodule:open_ended_sva
