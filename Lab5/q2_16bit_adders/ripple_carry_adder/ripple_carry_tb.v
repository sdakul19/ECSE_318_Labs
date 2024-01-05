module ripple_carry_tb;
	reg [15:0] a, b;
	wire [15:0] sum;
	wire carry;

	ripple_carry UUT(.a(a),.b(b),.sum(sum),.carry(carry));

	initial	begin
		$monitor("a = %b, b = %b, sum = %b, carry = %b", a, b, sum, carry);
		a = 0;
		b = 0;
		
		#10
		a = 16'b0000_0000_0000_1111;
		b = 16'b0000_0000_1111_0000;
			
		#10
		a = 16'b1111_0000_0000_1111;
		b = 16'b0000_0000_1111_0000;

		#10
		a = 16'b0000_0000_0000_1111;
		b = 16'b0111_1111_1111_0001;
		
		#10
		a = 16'b1111_1111_1111_1111;
		b = 16'b0000_0000_0000_0001;
		
		#10
		a = 16'b0000_0000_0000_1111;
		b = 16'b0000_0000_0000_1111;
	end
endmodule
