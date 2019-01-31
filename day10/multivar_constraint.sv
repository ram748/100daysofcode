program automatic multivar;

  class mvar;
    rand bit [3:0] lo,med,hi;
 //   rand bit lo_med_true;

    constraint c_lmh { lo  < med;
                       med < hi; }
//    constraint lm_t { (low_med

  endclass:mvar

  mvar m;

  initial begin
    m = new;
    m.lo = 'h4;
    repeat(10) begin
      m.randomize(med,hi);
      $display("mvar is %p",m);
    end

  end
endprogram:multivar
