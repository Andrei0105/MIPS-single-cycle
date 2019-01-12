`ifndef __ANDM_V__
`define __ANDM_V__

module Andm ( // 1 bit and for (branch & zero)
	input wire inA,
	input wire inB,
	output wire out
	);

	assign out = inA & inB;

endmodule

`endif /*__ANDM_V__*/
