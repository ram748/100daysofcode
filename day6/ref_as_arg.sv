
class Consumer;
 rand int c_1;

 function static print();
   $display("c_1 is %0d",c_1);
   print = 4'b1x0z;
 endfunction:print
endclass:Consumer

class Producer;
 rand int p_1;

 function void print();
   $display("p_1 is %0d",p_1);
 endfunction:print
endclass:Producer

module test;
 Consumer c;
 Producer p;
 integer tmp;

 function void build_env(Consumer c, ref Producer p);
   c = new(); // construct object and store handle in c
   p = new(); // construct object and store handle in p
endfunction

 initial begin
  build_env(c,p);
  c.randomize();
  p.randomize();
  tmp = c.print();
  p.print();
  $display("tmp is %0b",tmp);
 end

endmodule:test
                                                                                                                            
