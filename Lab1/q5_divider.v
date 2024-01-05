module q5_divider(remainder,quotient,start,clk,divisor,dividend);
	parameter N = 4;
	input start,clk;
	input [N-1:0]divisor,dividend;
	output[N-1:0] remainder,quotient;

	reg [N-1:0] rega,regm,regq;
	reg q3;
	reg [1:0]state;
	integer count;

	initial state = 2'b00;

	always @(posedge clk) begin
		
		if (state == 2'b00) begin

			if (start == 1'b1) begin
				rega = 4'b0000;
				regm = divisor;
				regq = dividend;
				state = 2'b01;
				
			end 
		
		end else if (state == 2'b01) begin
			for (count = N; count > 0; count = count - 1) begin
				q3 = regq[3];
				rega = rega << 1;
				rega[0] = q3;
				regq = regq << 1;
				rega = rega - regm;
				
				if (rega[3] == 1'b1) begin		
					regq[0] = 1'b0;
					rega = rega + regm;
				end else if (rega[3] == 1'b0) begin
					regq[0] = 1'b1;
					
				end
				
			end

			state = 2'b10;
		end 

	end

	assign quotient = regq;
	assign remainder = rega;


endmodule


