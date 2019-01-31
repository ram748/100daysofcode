program automatic test;

  class Payload;

    rand int data[8];

  endclass:Payload

  class Header;

    rand int addr;
    rand Payload p;

    function new;

      this.p = new;

    endfunction:new

  endclass:Header


  Header h;
  initial begin
    h = new;
    assert(h.randomize());
    $display("h.addr is %0d",h.addr);
    foreach(h.p.data[i]) begin
      $display(h.p.data[i]);
    end
  end

endprogram:test
