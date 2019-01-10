module signextend (out,  in) ;
output wire [31 : 0]  out;
input wire [15 : 0]  in ;
assign out  = {{16 {in [ 15 ]}},in};
endmodule