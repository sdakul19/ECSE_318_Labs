module uniform_csa_tb;
	reg [15:0] a, b;
	reg cin;
	wire [15:0] sum;
	wire carry;

	uniform_csa UUT(.a(a),.b(b), .cin(cin), .sum(sum),.carry(carry));

	initial	begin
		$monitor("a = %b, b = %b, cin = %b, sum = %b, carry = %b", a, b, cin, sum, carry);
		a = 0;
		b = 0;
		cin = 0;
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
