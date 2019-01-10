module andm ( // 1 bit and for (branch & zero)
	input wire inA,
	input wire inB,
	output wire out
	);

	assign out = inA & inB;

endmodule
