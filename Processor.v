`ifndef __PROCESSOR_V__
`define __PROCESSOR_V__

`include "Core.v"

module Processor (
	input wire clk,
	input wire reset
	);

	wire [31:0] memory_addr;
	wire memory_wren;
	wire memory_rden;
	wire [31:0] memory_write_val;
	wire [31:0] memory_read_val;
	wire memory_response;

	Core _Core (
		.clk(clk),
		.reset(reset),
		.memory_addr(memory_addr),
		.memory_wren(memory_wren),
		.memory_rden(memory_rden),
		.memory_write_val(memory_write_val),
		.memory_read_val(memory_read_val),
		.memory_response(memory_response)
	);

	TemporaryMemory _TemporaryMemory (
		.memory_addr(memory_addr),
		.memory_wren(memory_wren),
		.memory_rden(memory_rden),
		.memory_write_val(memory_write_val),
		.memory_read_val(memory_read_val),
		.memory_response(memory_response)
	);

endmodule

`endif /*__PROCESSOR_V__*/
