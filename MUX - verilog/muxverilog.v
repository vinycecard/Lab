module muxverilog(in1, in2, sel, out);
input in1, in2, sel;
output out;

assign out = sel == 1?in2:in1;

endmodule
