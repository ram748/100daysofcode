
class rand_class;

  rand int rand_var;

  function void print();
    $display("RAND_CLASS:rand_var is %0d ",rand_var);
  endfunction:print

endclass:rand_class

program random_stability();

  rand_class r1,r2,r3;
  int temp_var;

  task rand_task();
    int urand_var;
    urand_var = $urandom();
    $display("RAND_TASK:urand_var is %0d ",urand_var);
  endtask

  
 initial begin
  r1 = new();
  r2 = new();

  r1.randomize();
  r1.print();
  r1.randomize();
  r1.randomize();
  fork
    rand_task();
  join_none

     temp_var = $urandom();
     $display("PROGRAM_BLK:temp_var is %0d ",temp_var);

  end

endprogram:random_stability
 
