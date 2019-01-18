int unsigned uvm_global_random_seed = $urandom;

module test;

string plusarg_name = "TEMP",s;
initial begin
 $display("global seed is %0d ",uvm_global_random_seed);
 $sformat(plusarg_name,"global seed izzzzzzzzs %0d ",uvm_global_random_seed);
 $display(plusarg_name);
end

endmodule
