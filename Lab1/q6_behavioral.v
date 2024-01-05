module q6_behavioral(out,E,W,CLK);

	input CLK,E,W;
	output out;
	reg qa, qb;

	initial qa = 0;
	initial qb = 0;

always @(posedge CLK)
	
	
	begin
	qa <= E | (qa & ~qb) | (qa & W);
	qb <= W | (qb & ~qa) | (qb & E);
	
	end
assign out = (~qa) & (~qb);
endmodule

