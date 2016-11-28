module signextend (out,  in ) ;
output [31 : 0]  out;
input [15 : 0]  in ;
assign out ={{16 {in [ 15 ]}},in};
endmodule