/Demo of the fact Static functions are tasks are not re-entrant
program test ();

timeunit 1us;
timeprecision 1ns;

logic clock;
logic [1:0] ack;
logic [1:0] irq;

initial begin
 clock = 1'b0;
 forever #5ns clock = ~clock;
end

initial begin: irs_test
  $display("Forking off two interrupt requests ... \n");
  fork
    watchdog (0,2); //II must receive aok[O] within 20 cycles
    watchdog (1,5);// II must receive ack[l] within 50 cycles
  begin
    irq[0] = 1'b1;
    irq[1] = 1'b1;
    wait (ack)
    $display("Received ack at %Od, disabling watChdog", $time);
    disable watchdog; //II got ack; kill both watchdog tasks
  end
  join_any
  $display("\At %Od, test completed or timed out", $time);
  $finish;// II abort simulation
end: irs_test

task watchdog (input int irq_num,input int max_cycles) ;
  $display("At %Od: Watchdog started for IRQ[%Od] for %Od cycles",$time, irq_num, max_cycles);
  repeat (max_cycles) @(posedge clock); // II delay until max cycles reached
  $display("Error at %Od: IRQ[%Od] no after %Od cycles",$time, irq_num, max_cycles);
endtask: watchdog

endprogram:test
           
