`ifndef __INSTRUCTIONMEMORY_V__
`define __INSTRUCTIONMEMORY_V__

module InstructionMemory # ( // asynchronous memory with 256 32 - bit locations for instruction memory
	parameter S = 32,
	parameter L = 256
	)	(
	input wire [$clog2(L)-1:0] a,
	output reg [S-1:0] d,

	output reg [31:0] memory_addr,
	output reg memory_rden,
	input wire [31:0] memory_read_val,
	input wire memory_response
	);

	always @ (a)
	begin
		memory_addr <= a;
		memory_rden <= 1'b1;
	end

	always @ (posedge memory_response)
	begin
		if (memory_rden)
		begin
			d <= memory_read_val;
			memory_rden <= 1'b0;
		end
	end

endmodule

`endif /*__INSTRUCTIONMEMORY_V__*/
