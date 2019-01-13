`ifndef __DATAMEMORY_V__
`define __DATAMEMORY_V__

module DataMemory # ( // synchronous memory with 256 32 - bit locations for data memory
	parameter S = 32, // size
	parameter L = 256 // length
	)	(
	input wire clk,
	input wire [$clog2(L)-1:0] a,
	output wire [S-1:0] dout,
	input wire [S-1:0] din,
	input wire mread,
	input wire mwrite
	);

	reg [S-1:0] memory[0:L-1];

	assign dout = memory[a];

	always @ (posedge clk)
	begin
		if (mwrite == 1)
		begin
			memory[a] <= din;
		end
	end

	initial $readmemh("Data.dat", memory);

endmodule

`endif /*__DATAMEMORY_V__*/
