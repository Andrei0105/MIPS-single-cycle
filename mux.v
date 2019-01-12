`ifndef __MUX_V__
`define __MUX_V__

module Mux # ( // mux 2 to 1
	parameter DATA_LENGTH = 8
	)	(
	input wire sel,
	input wire [DATA_LENGTH-1:0] ina,
	input wire [DATA_LENGTH-1:0] inb,
	output wire [DATA_LENGTH-1:0] out
	);

	assign out = (sel == 0) ? ina : inb;

endmodule

`endif /*__MUX_V__*/
