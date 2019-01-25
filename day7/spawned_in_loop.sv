module spawned_in_loop();

 integer thread_id[3] = '{10,11,12};


  initial begin
   for(int id=0;id<3;id++) begin
      fork
       // automatic int id = id_tmp;
        $display("id:%0d,thread_id is %0d",id,thread_id[id]);
      join_none
   end
  end


endmodule:spawned_in_loop
