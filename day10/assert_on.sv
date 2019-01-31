rogram automatic assert_on;

  class Payload;

    rand int data[8];

  endclass:Payload


  class Bustrans;

    rand int a;

    rand int b;

    constraint c_ab { a < b;
                      b < a; }


  endclass:Bustrans

  Bustrans tr;
  Payload  p;

  initial begin
    tr = new;
    p  = new;
    $assertoff();
    $asserton(1,p_rand);
    tr_rand:assert(tr.randomize()) else $display("tr randomization failed ");
    p_rand:assert(p.randomize()) begin
             $display("p randomization passed ");
           end
           else $display("p randomization failed ");
    $display("tr is %p",tr);
    $display("p is %p",p);


  end




endprogram:assert_on
