module testbench();
reg [3:0] a,b;
reg Cin;
wire [3:0] sum;
wire Cout;

q2_cla UUT(Cout,sum,Cin,a,b);

	initial begin
	
		a = 4'b0110;
		b = 4'b0010;
		Cin = 0;
		
		#200
		$display( "a = %b, b = %b, Carry in = %b, sum = %b, Carry out = %b",a,b,Cin,sum,Cout);
		
		#200
		a = 4'b0111;
		b = 4'b0001;
		Cin = 0;
		
		#200
		$display("a = %b, b = %b, Carry in = %b, sum = %b, Carry out = %b",a,b,Cin,sum,Cout);
	
		#200
		a = 4'b1111;
		b = 4'b1111;
		Cin = 0;

		#200
		$display("a = %b, b = %b, Carry in = %b, sum = %b, Carry out = %b",a,b,Cin,sum,Cout);


	end

endmodule
 