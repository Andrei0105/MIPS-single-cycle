`ifndef __DATAMEMORY_V__
`define __DATAMEMORY_V__

module DataMemory # ( // synchronous memory with 256 32 - bit locations for data memory
	parameter S = 32, // size
	parameter L = 256 // length
	)	(
	input wire [$clog2(L)-1:0] a,
	output reg [S-1:0] dout,
	input wire [S-1:0] din,
	input wire mread,
	input wire mwrite,

	output reg [31:0] memory_addr,
	output reg memory_rden,
	output reg memory_wren,
	input wire [31:0] memory_read_val,
	output reg [31:0] memory_write_val,
	input wire memory_response
	);

	always @ (a)
	begin
		if (mread)
		begin
			memory_addr <= a;
			memory_rden <= 1'b1;
		end

		if (mwrite)
		begin
			memory_addr <= a;
			memory_wren <= 1'b1;
			memory_write_val <= din;
		end
	end

	always @ (posedge memory_response)
	begin
		if (memory_rden)
		begin
			dout <= memory_read_val;
			memory_rden <= 1'b0;
		end

		if (memory_wren)
		begin
			memory_wren <= 1'b0;
		end
	end

	endmodule

`endif /*__DATAMEMORY_V__*/
