imeunit 1ns;
timeprecision 1ns;
program automatic vacuous_assert;

  bit [31:0] req_ack_count;
  bit req,ack;
  bit clk;

  property p_req_ack;
    @(posedge clk) req |-> ##1 ack;
  endproperty:p_req_ack

  A_REQ_ACK:assert property (p_req_ack) begin
              req_ack_count++;
            end
            else begin
              $error;
            end

  initial begin
    forever #5ns clk = ~clk;
  end

  initial begin
   // $assertnonvacuouson();
  //  #25ns req = 1'b1;
  #40ns;
    $display("req_ack_count is %0d",req_ack_count);
    $finish;
  end

  initial begin
    $monitor("req_ack_count is %0d",req_ack_count);
  end


endprogram:vacuous_assert
