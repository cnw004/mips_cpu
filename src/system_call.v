/*
module to perform system call instructions

inputs:
  - syscall_control: comes out of control, decides if a it is a syscall
  - instruction: use to determine funccode and also statistical stuff
  - v0: decides what kind of syscall to perform
  - a0: value to be printed by the print syscall

outputs:
  - string_index: the index to print at
  - print_string: should we print?
*/

module system_call(
  input wire syscall_control,
  input wire [31:0] instruction,
  input wire [31:0] v0,
  input wire [31:0] a0);

//for statistics
integer clk_counter = 0;
integer num_instructions = 0;
realtime time_var = 0.0;
initial begin
	$timeformat(-3, 2, "ms", 10);
	time_var <= $realtime;
end


  always @ (posedge syscall_control) begin
	clk_counter = clk_counter + 1;
    //check func_code and syscall_control to decide if the instruction is a syscall
    if((instruction[5:0] == 6'hc) && (syscall_control == 1'b1)) begin
      $display("SYSCALL CALLED");
      case(v0)
        // if v0 is 1 then it is a print syscall
        32'd1: $display("a0 is: %d", a0);
        //if v0 is 10 then the syscall is an exit
        32'd10: $finish;

        32'd4: $display("CHOO CHOO MOTHERFUCKER!!!");

        default: $display("DEFAULT CASE IN SYSTEM_CALL");
      endcase

    end
  end

always @(instruction) begin
	num_instructions = num_instructions + 1;
end
endmodule
