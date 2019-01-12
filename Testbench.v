`include "Core.v"

module Testbench(); // cpu testbench

	reg clk;
	reg reset;

	Core _Core(
		.clk(clk),
		.reset(reset)
	);

	initial
	begin
		forever #5 clk <= ~clk;
	end

	initial
	begin
		clk = 0;
		reset = 1;
		#10 reset = 0;
		#3000 $finish;
	end

endmodule
