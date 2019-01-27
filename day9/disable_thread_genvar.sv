timeunit 1ns;
timeprecision 1ns;

module test_task (input int instance_id,input int thread_id);
  initial begin
    #1;
      start_test(thread_id,instance_id);
  //    start_test(2,instance_id);
  //    start_test(3,instance_id);
  end

  task start_test (int thread, int inst);
    fork : monitor
      begin
         $display("@%0t: %m inst: %0d, thread: %0d, before disable",$time, inst, thread);
         #10;
         if ((thread==2) && (inst==2)) begin
            disable monitor;// II GOTCHA! affects multiple threads
         end
         #1;
         $display("@%0t: %m inst: %0d, thread: %0d, after disable",$time, inst, thread);
      end
    join_none
  endtask:start_test

endmodule:test_task

module top;
  genvar i,j;

  generate
    for(i=1;i<4;i++) begin:test_task_inst
      for(j=1;j<4;j++) begin:test_task_thread
        test_task ins (.instance_id(i),.thread_id(j));
      end
    end
  endgenerate

  initial begin
    $timeformat(-9,2," ns",10);
  end

endmodule:top



