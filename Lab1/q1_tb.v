module testbench();
reg [3:0]X;
reg [3:0]Y;
wire [7:0]P;

q1_multiplier UUT(P,X,Y);
	initial begin
		
		#10
		X = 4'b0010;
		Y = 4'b0110;
		#10
		$display("Multiplicand X = %b, Multiplier Y = %b, Product = %b" ,X,Y,P);
		
		#10
		X = 4'b0011;
		Y = 4'b1100;
		#10
		$display("Multiplicand X = %b, Multiplier Y = %b, Product = %b",X,Y,P);

	
	


		end
endmodule
