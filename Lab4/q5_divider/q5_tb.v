module q5_tb();
	reg start,clk;
	reg [3:0] divisor,dividend;
	wire [3:0] remainder, quotient;
	integer count;
	q5_divider UUT(
		.start(start),
		.clk(clk),
		.divisor(divisor),
		.dividend(dividend),
		.remainder(remainder),
		.quotient(quotient)
	);
	initial clk = 1'b0;
	always #5 clk = ~clk;

	initial begin
		
		start = 1'b1;
		dividend = 4'b0111;
		divisor = 4'b0010;
		#50
		$display($time,,"divisor = %b, dividend = %b, quotient = %b, remainder = %b",divisor,dividend,quotient,remainder);
		/*
		start = 1'b1;
		dividend = 4'b0110;
		divisor = 4'b0010;
		
		#50
		$display($time,,"divisor = %b, dividend = %b, quotient = %b, remainder = %b",divisor,dividend,quotient,remainder);
		*/$finish;
		
	end
endmodule


