`timescale 10ns/1ns

module q2_tb();
reg [3:0] a,b;
reg Cin;
wire [3:0] sum;
wire Cout;

cla UUT(.a(a), .b(b), .Cin(Cin), .sum(sum), .Cout(Cout));

	initial begin
		
		a = 4'b0000;
		b = 4'b0000;
		Cin = 0;
		
		#10
		a = 4'b0110;
		b = 4'b0010;
		Cin = 0;
		
		#10
		$display( "a = %b, b = %b, Carry in = %b, sum = %b, Carry out = %b",a,b,Cin,sum,Cout);
		
		#10
		a = 4'b0111;
		b = 4'b0001;
		Cin = 0;
		
		#10
		$display("a = %b, b = %b, Carry in = %b, sum = %b, Carry out = %b",a,b,Cin,sum,Cout);
	
		#10
		a = 4'b1111;
		b = 4'b1111;
		Cin = 0;

		#10
		$display("a = %b, b = %b, Carry in = %b, sum = %b, Carry out = %b",a,b,Cin,sum,Cout);


	end

endmodule
 