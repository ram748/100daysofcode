class my_class;

  rand int y;
  string i_name;
  function new(string i_name);
     $display("instance name is %0s",i_name);
     this.i_name = i_name;
  endfunction:new

  task not_random();
    process p = process::self();
    p.srandom(1);//Thread seeding
    $display("constant result %0d,instance:%0s ",$urandom(),i_name);

     this.srandom(2); //object seeding

     this.randomize();

    $display("Another seeded result(Object seeding) %0d,instance:%0s ",y,i_name);


  endtask:not_random

function void random();
    $display("random result %0d,instance:%0s ",$urandom(),i_name);
     this.randomize();
    $display("Another seeded result(Object seeding) %0d,instance:%0s ",y,i_name);

endfunction:random


endclass:my_class

//Next get_randstate



module reseed();
 timeunit 1us;
 timeprecision 1ns;

 my_class cls_1,cls_2,cls_3;
 process p;
 string rand_state;
 longint global_seed;

   task delay_time();
     int d_time;
     //d_time = $urandom_range(3,10) ;
     std::randomize(d_time) with {
     d_time >= 3;
        d_time <= 10;
     };
     #(d_time * 1us);
     $display("d_time is %0d,realtime is %t",d_time,$time);

   endtask

 initial begin

   cls_2 = new("cls2");
//   cls_2.not_random();
   cls_1 = new("cls1");
   p = process::self();
   rand_state = p.get_randstate();
  $display("randstate is %0s",rand_state);
   cls_3 = new("cls3");
 //  cls_1.not_random();
//    $timeformat(-6, 3, " us", 20);
  $timeformat(-9, 2, " ns", 10);
   void'($value$plusargs("ntb_random_seed=%d",global_seed));
    $display("Start of threads realtime is %0t",$time);
    #1ns;
   fork
    delay_time();
    delay_time();
    delay_time();
    delay_time();
  join
   p.set_randstate(rand_state);
   cls_1.random();
   cls_2.random();

 end

endmodule:reseed
