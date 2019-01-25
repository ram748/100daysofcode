

class agreement extends uvm_barrier;

  typedef enum{AGREE, DISAGREE, WAIT} agree_t;

  local static bit debug = 0;
  local static agree_t participants[uvm_object];

  function new(string name = "agreement");
    super.new(name);
    set_threshold(1);
  endfunction

  static function void set_debug();
    debug = 1;
  endfunction

  static function void clr_debug();
    debug = 0;
  endfunction

  local function void update(uvm_object ptcpnt,agree_t a);

    // If there is no change in vote,
    // then there is nothing to update
    if(participants.exists(ptcpnt) &&
        participants[ptcpnt] == a)
      return;

    participants[ptcpnt] = a;

    case(a)
      AGREE:    set_threshold(get_threshold() - 1);
      DISAGREE: set_threshold(get_threshold() + 1);
      WAIT:; // do nothing
    endcase

  endfunction

  function void agree(uvm_object obj,
                      int lineno = 0);
    update(obj, AGREE);
    if(debug)
      `uvm_info("AGREE",status_msg(obj, lineno),UVM_NONE);
 endfunction

  function void disagree(uvm_object obj,
                         int lineno = 0);
    update(obj, DISAGREE);
    if(debug)
      `uvm_info("DISAGREE",
                status_msg(obj, lineno),
                UVM_NONE);
  endfunction

  task wait_for_agreement(uvm_object obj,
                          int lineno = 0);
    wait_for();
    if(debug)
      `uvm_info("ALL IN AGREEMENT",
                status_msg(obj, lineno),
                UVM_NONE);
  endtask


  function clear(uvm_object obj,
                 int lineno = 0);
    set_threshold(1);
    if(debug)
      `uvm_info("CLEAR",
                status_msg(obj, lineno),
                UVM_NONE);
  endfunction

  local function string status_msg(uvm_object obj = null,
                                   int lineno = 0);

    string msg;

    case(1)
      (obj == null) && (lineno == 0) :
          $sformat(msg, "[%s] threshold = %0d",
                        get_name(), get_threshold());
      (obj == null) && (lineno != 0) :
          $sformat(msg, "[%s] threshold = %0d @ %0d",
                         get_name(), get_threshold(), lineno);
      (obj != null) && (lineno == 0) :
          $sformat(msg, "[%s] %s: threshold = %0d",
                        get_name(), obj.get_full_name,
                        get_threshold());
      (obj != null) && (lineno != 0) :
          $sformat(msg, "[%s] %s: threshold = %0d @ %0d",
                        get_name(), obj.get_full_name,
                        get_threshold(), lineno);
    endcase

    return msg;
  endfunction

endclass

