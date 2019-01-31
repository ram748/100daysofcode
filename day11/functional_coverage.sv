program automatic fun_coverage;
  event cg_sample;

  class Abc;
    rand bit [7:0] a,b,c;

    covergroup CG_abc @(cg_sample);
      coverpoint a;
      coverpoint c;
    endgroup

    covergroup CG_bbc @(cg_sample);
      option.per_instance = 1;
      coverpoint b;
    endgroup

    function new;
      CG_abc = new;
      CG_bbc = new;
    endfunction:new

  endclass:Abc

  initial begin
    Abc a1 = new;
    Abc a2 = new;

    for (int i=0;i<8;i++) begin
      a1.a = i;
      a1.b = i+1;
      a1.c = i+2;
      ->cg_sample;
    //a1.CG_abc.sample();
    end
    $display("overall coverage %0d ",$get_coverage());

  end


endprogram:fun_coverage
