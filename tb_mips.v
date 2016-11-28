module tb_mips;
//cpu testbench

reg clk;
reg res;

mips mips_DUT(clk, res);

initial
	forever #5 clk = ~clk;

initial begin
	clk = 0;
	res = 1;
	#10 res = 0;

	#3000 $finish;

end

endmodule
