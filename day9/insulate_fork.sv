eunit 1ns;
timeprecision 1ns;

program automatic insulate_fork;


 task start_a_thread (int delay);
   fork
     begin
       $display("@%0t start_a_thread(%0d) -started",$time,delay);
       #(delay * 1us);
       $display("@%0t start_a_thread(%0d) -complete",$time,delay);
     end
   join_none
 endtask:start_a_thread

 task do_action;
   start_a_thread(20);
 endtask:do_action

 initial begin
   $timeformat(-6, 2, " us", 10);
 end

 initial begin:seperate_thread
   do_action();
 end:seperate_thread

 initial begin:test_sequence
       start_a_thread(10);
 start_a_thread(30);
       #15us disable fork;
       disable seperate_thread;
   #100us;  //Wait for all threads to complete
 end:test_sequence

//#####Working insulate fork##########
 //initial begin:test_sequence
 //  do_action();
 //  fork
 //    begin:insulated_block
 //      start_a_thread(10);
 //      start_a_thread(30);
 //      #15us disable fork;
 //    end:insulated_block
 //  join
 //  #100us;  //Wait for all threads to complete
 //end:test_sequence

endprogram:insulate_fork
                            
