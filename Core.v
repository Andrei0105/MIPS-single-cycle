`ifndef __CORE_V__
`define __CORE_V__

`include "ALU.v"
`include "ALUControl.v"
`include "Andm.v"
`include "Control.v"
`include "DataMemory.v"
`include "Datapath.v"
`include "InstructionMemory.v"
`include "Mux.v"
`include "PC.v"
`include "RegisterFile.v"
`include "SignExtend.v"

module Core ( // main cpu module
	input wire clk,
	input wire reset,

	output [31:0] memory_addr,
	output memory_rden,
	output memory_wren,
	input [31:0] memory_read_val,
	output [31:0] memory_write_val,
	input memory_response
	);

	wire [5:0] OpCode;
	wire [1:0] ALUOp;
	wire RegDst;
	wire ALUSrc;
	wire MemtoReg;
	wire RegWrite;
	wire MemRead;
	wire MemWrite;
	wire Branch;

	Datapath _Datapath (
		.clk(clk),
		.reset(reset),
		.RegDst(RegDst),
		.ALUSrc(ALUSrc),
		.MemtoReg(MemtoReg),
		.RegWrite(RegWrite),
		.MemRead(MemRead),
		.MemWrite(MemWrite),
		.Branch(Branch),
		.ALUOp(ALUOp),
		.OpCode(OpCode),

		.memory_addr(memory_addr),
		.memory_rden(memory_rden),
		.memory_read_val(memory_read_val),
		.memory_response(memory_response)
	);

	Control _Control (
		.opcode(OpCode),
		.RegDst(RegDst),
		.ALUSrc(ALUSrc),
		.MemtoReg(MemtoReg),
		.RegWrite(RegWrite),
		.MemRead(MemRead),
		.MemWrite(MemWrite),
		.Branch(Branch),
		.AluOP(ALUOp)
	);

endmodule

`endif /*__CORE_V__*/
