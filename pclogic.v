module pclogic (clk, reset, ain, aout, pcsel);

input wire reset;
input wire clk;
input wire [31:0] ain;
// pecsel = branch & zero
input wire pcsel;

output reg [31:0] aout;

always @ (posedge clk)
begin
	if (reset ==  1)
		aout <  = 32'b0;
	else
		if (pcsel ==  0)
begin
			aout <  = aout + 1;
		end
		if (pcsel ==  1)
begin
			aout <  = ain + aout + 1; // branch
	end
end


endmodule
