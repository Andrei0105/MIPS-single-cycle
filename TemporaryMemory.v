`ifndef __TEMPORARYMEMORY_V__
`define __TEMPORARYMEMORY_V__

module TemporaryMemory (
	input wire [31:0] memory_addr,
	input wire memory_rden,
	input wire memory_wren,
	output reg [31:0] memory_read_val,
	input wire [31:0] memory_write_val,
	output reg memory_response
	);

	reg [31:0] memory[0:1023];
	
	integer i;

	initial
	begin
	    for(i = 0; i < 1024; i = i + 1)
	    begin
            memory[i] <= 32'd0;
	    end
	end

	localparam STATE_READY = 3'b000;
	localparam STATE_READ = 3'b001;
	localparam STATE_READ_DONE = 3'b010;
	localparam STATE_WRITE = 3'b011;
	localparam STATE_WRITE_DONE = 3'b100;

	reg [2:0] state = STATE_READY;

	always @ (*)
	begin
		case (state)
			STATE_READY:
			begin
				if (memory_rden)
				begin
					state <= STATE_READ;
				end
				if (memory_wren)
				begin
					state <= STATE_WRITE;
				end
			end

			STATE_READ:
			begin
				memory_read_val <= memory[memory_addr];
				memory_response <= 1'b1;
				state <= STATE_READ_DONE;
			end

			STATE_READ_DONE:
			begin
				memory_response <= 1'b0;
				state <= STATE_READY;
			end

			STATE_WRITE:
			begin
				memory[memory_addr] <= memory_write_val;
				memory_response <= 1'b1;
				state <= STATE_WRITE_DONE;
			end

			STATE_WRITE_DONE:
			begin
				memory_response <= 1'b0;
				state <= STATE_READY;
			end
			
			default:
			begin
				state <= STATE_READY;
			end
		endcase
	end

endmodule

`endif /*__TEMPORARYMEMORY_V__*/
