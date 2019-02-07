meunit 1ns;
timeprecision 1ps;
module bidi_gate;

  wire[1:0] io1_w,io2_w;
  bit [1:0] io1,io2;
  bit [1:0] control;
  genvar i,j;


  typedef enum {
                SPANSION = 'h1,
                MICRON   = 'h2
                } model_t;

  model_t model;

  assign io1_w = io1;

  generate
    for(i=0;i<2;i++) begin:s0_t
      tranif1 s0_type (io1_w[i],io2_w[i],control[0]);
    end:s0_t
  endgenerate

 // tranif1 s0_t1 (io1_w,io2_w,control);


//  SPANSION s0 (

  initial begin
    $monitor("io1_w: %0b,io2_w: %0b,control: %0b",io1_w,io2_w,control);
  end

  always @(model) begin
//    $display($time,"model change %0s",model.name());
    case(model)
      SPANSION: control = 2'b01;
      MICRON  : control = 2'b10;
      default : control = 2'b00;
    endcase
  end


  initial begin

    #1ns;
    model   = SPANSION;

    io1     = 'h1;
//    control = 1'b0;
    #10ns;
    io1     = 'h2;
 //   control = 1'b1;
//    io1     = 'h2;

    #10ns;
    model   = MICRON;
//    control = 1'b0;
    io1     = 'h1;

  end




endmodule:bidi_gate
                      
