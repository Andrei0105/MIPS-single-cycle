`ifndef __ALU_V__
`define __ALU_V__

module ALU (
	input wire [31:0] opA,
	input wire [31:0] opB,
	input wire [3:0] ALUop,
	output reg [31:0] result,
	output wire zero // 1 if result is 0
	);

	assign zero = (result == 0);

	always @ (ALUop or opA or opB)
	begin
		case(ALUop)
			4'b0000: result = opA & opB;
			4'b0001: result = opA | opB;
			4'b0010: result = opA + opB;
			4'b0110: result = opA - opB;
			4'b0111: result = opA < opB ? 1 : 0; // slt
			4'b1100: result = ~(opA | opB);
		endcase
	end

endmodule

`endif /*__ALU_V__*/
