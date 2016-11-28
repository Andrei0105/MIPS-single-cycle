module mem_async(a,d);
//asynchronous memory with 256 32-bit locations
//for instruction memory
parameter S=32;
parameter L=256;

input [$clog2(L) - 1:0] a;
output [(S-1):0] d;

reg [S-1:0] memory [L-1:0];
assign d=memory[a];

initial $readmemh("meminstr.dat", memory);

endmodule
