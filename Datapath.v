`ifndef __DATAPATH_V__
`define __DATAPATH_V__

module Datapath (
	input wire clk,
	input wire reset,
	input wire RegDst,
	input wire ALUSrc,
	input wire MemtoReg,
	input wire RegWrite,
	input wire MemRead,
	input wire MemWrite,
	input wire Branch,
	input wire [1:0] ALUOp,
	output wire [5:0] OpCode,

	output wire [31:0] memory_addr,
	output wire memory_rden,
	output wire memory_wren,
	input wire [31:0] memory_read_val,
	output wire [31:0] memory_write_val,
	input wire memory_response
	);

	wire [31:0] Instruction;
	wire [3:0] ALUCtrl;
	wire [31:0] ALUout;
	wire Zero;
	wire [31:0] PC_addr;
	wire [31:0] ReadRegister1;
	wire [31:0] ReadRegister2;
	wire [4:0] muxinstr_out;
	wire [31:0] muxalu_out;
	wire [31:0] muxdata_out;
	wire [31:0] ReadData;
	wire [31:0] signExtend;
	wire PCsel;

	assign OpCode = Instruction[31:26];

	InstructionMemory # ( // Instruction memory
		.S(32),
		.L(256)
	) _InstructionMemory (
		.a(PC_addr[7:0]),
		.d(Instruction),

		.memory_addr(memory_addr),
		.memory_rden(memory_rden),
		.memory_read_val(memory_read_val),
		.memory_response(memory_response)

	);

	DataMemory # ( // Data memory
		.S(32),
		.L(256)
	) _DataMemory (
		.a(ALUout[7:0]),
		.dout(ReadData),
		.din(ReadRegister2),
		.mread(MemRead),
		.mwrite(MemWrite),

		.memory_addr(memory_addr),
		.memory_rden(memory_rden),
		.memory_wren(memory_wren),
		.memory_read_val(memory_read_val),
		.memory_write_val(memory_write_val),
		.memory_response(memory_response)
	);

	RegisterFile _RegisterFile ( // Registers
		.RegWrite(RegWrite),
		.ra(Instruction[25:21]),
		.rb(Instruction[20:16]),
		.rc(muxinstr_out),
		.da(ReadRegister1),
		.db(ReadRegister2),
		.dc(muxdata_out)
	);

	ALUControl _ALUControl ( // ALUControl
		.AluOp(ALUOp),
		.FnField(Instruction[5:0]),
		.AluCtrl(ALUCtrl)
	);

	ALU _ALU ( // ALU
		.opA(ReadRegister1),
		.opB(muxalu_out),
		.ALUop(ALUCtrl),
		.result(ALUout),
		.zero(Zero)
	);

	PC _PC( // generate PC
		.clk(clk),
		.reset(reset),
		.ain(signExtend),
		.aout(PC_addr),
		.pcsel(PCsel)
	);

	Andm _AndPC ( // AndPC (branch & zero)
		.inA(Branch),
		.inB(Zero),
		.out(PCsel)
	);

	SignExtend _SignExtend ( // Sign extend
		.out(signExtend),
		.in(Instruction[15:0])
	);

	Mux # ( // MUX for Write Register
		.DATA_LENGTH(5)
	) _Mux_Instruction (
		.sel(RegDst),
		.ina(Instruction[20:16]),
		.inb(Instruction[15:11]),
		.out(muxinstr_out)
	);

	Mux # ( // MUX for ALU
		.DATA_LENGTH(32)
	) _MUX_ALU (
		.sel(ALUSrc),
		.ina(ReadRegister2),
		.inb(signExtend),
		.out(muxalu_out)
	);

	Mux # ( // MUX for Data memory
		.DATA_LENGTH(32)
	) _MUX_Data (
		.sel(MemtoReg),
		.ina(ALUout),
		.inb(ReadData),
		.out(muxdata_out)
	);

endmodule

`endif /*__DATAPATH_V__*/
