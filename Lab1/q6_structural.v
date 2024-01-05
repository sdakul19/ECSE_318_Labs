module q6_structural(out, E, W, CLK);
	input E,W,CLK;
	output out;
	wire g1,g2,g3,g4,g5,g6,qa,qb;

	and and1(g1,qa,~qb);
	and and2(g2,qa,W);
	or or1(g3,E,g1,g2);
	dff dffa(qa,g3,CLK);

	and and3(g4,qb,~qa);
	and and4(g5,qb,E);
	or or2(g6,W,g4,g5);
	dff dffb(qb,g6,CLK);

	and and5(out,~qa,~qb);

endmodule


module dff(q,d,CLK);
	input d, CLK;
	output q;
	reg q;

	initial q = 0;
	always @(posedge CLK) 
		begin
			q <= d;
		end

endmodule