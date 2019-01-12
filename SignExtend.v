`ifndef __SIGNEXTEND_V__
`define __SIGNEXTEND_V__

module SignExtend (
	output wire [31:0] out,
	input wire [15:0] in
	);

	assign out  = { { 16{in[15]} }, in };

endmodule

`endif /*__SIGNEXTEND_V__*/
