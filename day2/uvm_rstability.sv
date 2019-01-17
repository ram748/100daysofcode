
import uvm_pkg::*;


class rand_config extends uvm_object;
  `uvm_object_utils(rand_config)
  rand bit config_field1;
  rand int unsigned config_field2;

  function void print();
    $display("config_field1 is %0d , config_field2 is %0d",config_field1,config_field2);
  endfunction:print
endclass:rand_config

class some_env extends uvm_env;

 `uvm_component_utils(some_env)

  rand rand_config rand_config_i;

 function new(string name = "env", uvm_component parent = null);
    super.new(name, parent);
endfunction:new

  function void build_phase(uvm_phase phase);
    $display("Start of print from env : %0s",get_name());
    rand_config_i = rand_config::type_id::create("rand_config_i");
    assert(randomize(rand_config_i)); //1
    rand_config_i.print();
    assert(rand_config_i.randomize()); //2
    rand_config_i.print();
    $display("End of print from env : %0s",get_name());

endclass:some_env

class rand_chk;
  rand int tmp;
endclass:rand_chk

module tb;

  int tmp;
  rand_chk chk;


  class some_test extends uvm_test;

  `uvm_component_utils(some_test)

    some_env env1,env2;

    function new(string name = "some_test", uvm_component parent = null);
        super.new(name, parent);
    endfunction:new

    function void build_phase(uvm_phase phase);
       //env2 = some_env::type_id::create("env2",this);
       env1 = some_env::type_id::create("env1",this);
    endfunction:build_phase

  endclass:some_test


  initial begin
   tmp = $urandom();
   chk = new();
   run_test();
  end

endmodule:tb                                                       
