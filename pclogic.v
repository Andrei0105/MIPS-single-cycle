module pclogic(clk, reset, ain, aout, pcsel);

input reset;
input clk;
input [31:0] ain;
//pecsel = branch & zero
input pcsel;

output reg [31:0] aout;

always @(posedge clk ) begin
	if (reset==1)
		aout<=32'b0;
	else
		if (pcsel==0) begin
			aout<=aout+1;
		end
		if (pcsel==1) begin
			aout<=ain+aout+1; //branch
	end
end


endmodule
