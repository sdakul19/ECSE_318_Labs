module q6_structural_testbench;
	reg E, W, CLK;
	wire out;

	q6_structural UUT(out, E, W, CLK);
	initial CLK = 1'b0;

	always #5 CLK = ~CLK;
	
	initial begin

		E = 0; W = 0;
		#0
		$monitor($time,, "Input E = %b, Input W = %b, CLK = %b, Output = %b",E,W,CLK,out);

		#10
		E = 0; W = 1;
		#10
		$monitor($time,, "Input E = %b, Input W = %b, CLK = %b, Output = %b",E,W,CLK,out);

		#10
		E = 1; W = 0;
		#10
		$monitor($time,, "Input E = %b, Input W = %b, CLK = %b, Output = %b",E,W,CLK,out);


		#10
		E = 1; W = 1;
		#10
		$monitor($time,, "Input E = %b, Input W = %b, CLK = %b, Output = %b",E,W,CLK,out);

		#10
		E = 0; W = 0;
		#10
		$monitor($time,, "Input E = %b, Input W = %b, CLK = %b, Output = %b",E,W,CLK,out);

		$finish;
	end
endmodule

