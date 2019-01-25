timeunit 1us;
timeprecision 1ns;

  interface wd(input bit clock);

  endinterface
package automatic watchdog;



  class watchdog;
    virtual wd wd_local;

     function new(virtual wd wd1);
        this.wd_local = wd1;
     endfunction:new


    task watchdog (input int irq_num,input int max_cycles) ;
      $display("At %0d: Watchdog started for IRQ[%0d] for %0d cycles",$time, irq_num, max_cycles);
      repeat (max_cycles) begin
        @(posedge wd_local.clock); // II delay until max cycles reached
        $display("Time %0d: Repeating inside IRQ[%0d] thread, Maxcycles are %0d",$time, irq_num, max_cycles);
      end
      $display("Error at %0d: IRQ[%Od] no after %0d cycles",$time, irq_num, max_cycles);
    endtask: watchdog
endpackage

module tb_top();

bit clock;

initial begin
 clock = 1'b0;
 forever #5ns clock = ~clock;
end

wd wd_i(clock);
test t0(wd_i);

endmodule:tb_top

//Demo of the fact Static functions are tasks are not re-entrant
program test (wd wd_i);

 import watchdog::*;


logic [1:0] ack;
logic [1:0] irq;


watchdog w0;
initial begin: irs_test
  w0 = new(wd_i);
  $display("Forking off two interrupt requests ... \n");
  fork
    w0.watchdog (0,2); //II must receive aok[O] within 20 cycles
    w0.watchdog (1,5);// II must receive ack[l] within 50 cycles
     begin
       irq[0] = 1'b1;
       irq[1] = 1'b1;
       wait (ack)
       $display("Received ack at %0d, disabling watChdog", $time);
       disable w0.watchdog; //II got ack; kill both watchdog tasks
     end
//    #100ns;
  join_any
  $display("\At %0d, test completed or timed out", $time);
  $finish;// II abort simulation
end: irs_test


endprogram:test
