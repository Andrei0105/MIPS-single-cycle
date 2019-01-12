`ifndef __INSTRUCTIONMEMORY_V__
`define __INSTRUCTIONMEMORY_V__

module InstructionMemory # ( // asynchronous memory with 256 32 - bit locations for instruction memory
	parameter S = 32,
	parameter L = 256
	)	(
	input wire [$clog2(L)-1:0] a,
	output wire [S-1:0] d
	);

	reg [S-1:0] memory [0:L-1];

	assign d = memory[a];

	initial $readmemh("meminstr.dat", memory);

endmodule

`endif /*__INSTRUCTIONMEMORY_V__*/
