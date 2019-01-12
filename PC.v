`ifndef __PC_V__
`define __PC_V__

module PC (
	input wire clk,
	input wire reset,
	input wire [31:0] ain,
	// pecsel = branch & zero
	output reg [31:0] aout,
	input wire pcsel
	);

	always @ (posedge clk)
	begin
		if (reset == 1)
		begin
			aout <= 32'b0;
		end
		else
		begin
			if (pcsel == 0)
			begin
				aout <= aout + 1;
			end
			if (pcsel == 1)
			begin
				aout <= ain + aout + 1; // branch
			end
		end
	end

endmodule

`endif /*__PC_V__*/
