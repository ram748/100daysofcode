meunit 1ns;
timeprecision 1ns;

  typedef enum { INIT = 'h0,
                 FETCH = 'h1
                 } state_enum;

module test_vacuous();


  state_enum state_e;
  bit clk;
  bit req,ack;
  bit ack_delayed;
  string result = "None";

  always @(posedge clk) begin
    ack_delayed <=  @(posedge clk) ack;
  end

  initial begin
    forever #5 clk = ~clk;
  end


  always_ff @(posedge clk) begin
    if (state_e == FETCH) begin
  assert property (P_ACK_REQ) begin
         $display("passed");
         result = "Passed";
       end else begin
         $display("failed");
         result = "Failed";
       end
    end
  end

  property P_ACK_REQ;
    @(posedge clk)
        req |-> ##1 ack;
  endproperty

  initial begin
    state_e = INIT;
    req = 1'b0;
    #25ns;
    state_e = FETCH;
    #10ns;
    req = 1'b1;
    #20ns;
    ack = 1'b1;

    #30ns;
 $finish();

  end


  initial begin
    $display("1st Cycle     2nd Cycle    Output message and notes");
    $display("_ _ _ _ _     _ _ _ _ _    _ _ _ _ _ _ _ _ _ _ _ _  ");

    $display("state_e req   ack          ");
    $display("_ _ _ _ _ _   _ _ _ _ _    ");
  end

  always @(posedge clk) begin
    $display("%0s     %0b   %0b          %0s",state_e.name(),req,ack_delayed,result);
  end


endmodule:test_vacuous
