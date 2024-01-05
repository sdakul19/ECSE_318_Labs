module q4_tb();

	reg[7:0] a;
	reg[7:0] b;
	reg clk, set, clear;
	wire [7:0] result;
	wire carry;

	serial_adder UUT(.a(a), .b(b), .clk(clk), .set(set), .clear(clear), .result(result), .carry(carry));

	initial clk = 0;
	always #5 clk = ~clk;

	initial begin
		$monitor($time, "clk = %b, a = %b, b = %b, set = %b, clear = %b, result = %b, carry = %b", clk, a, b, set, clear, result, carry);
		a = 0;
		b = 0;
		set = 1;
		clear = 1;
		//$monitor($time, "clk = %b, a = %b, b = %b, set = %b, clear = %b, result = %b, carry = %b", clk, a, b, set, clear, result, carry);

		#10
		a = 4'b00000111;
		b = 4'b00000011;
		set = 0;
		clear = 0;
		//$monitor($time, "clk = %b, a = %b, b = %b, set = %b, clear = %b, result = %b, carry = %b", clk, a, b, set, clear, result, carry);

		#10
		set = 1;
		clear = 1;
		//$monitor($time, "clk = %b, a = %b, b = %b, set = %b, clear = %b, result = %b, carry = %b", clk, a, b, set, clear, result, carry);
		
		#90
		a = 4'b00000110;
		b = 4'b00000100;
		set = 0;
		clear = 0;
		
		#10
		set = 1;
		clear = 1;
		

	end
endmodule
