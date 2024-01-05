module q3_tb();
reg [7:0] n1, n2, n3,n4,n5,n6,n7,n8,n9,n10;
wire [15:0] sum;

q3_csa UUT(.sum(sum),.n1(n1),.n2(n2),.n3(n3),.n4(n4),.n5(n5),.n6(n6),.n7(n7),.n8(n8),.n9(n9),.n10(n10));
	initial begin

	n1 = 8'b00001011;
	n2 = 8'b00000010;
	n3 = 8'b00001101;
	n4 = 8'b00000100;
	n5 = 8'b00000101;
	n6 = 8'b00000110;
	n7 = 8'b00000111;
	n8 = 8'b00001000;
	n9 = 8'b00001001;
	n10 = 8'b00001010;

	#200
	$display("n1 = %b, n2 = %b, n3 = %b, n4 = %b, n5 = %b, n6 = %b, n7 = %b, n8 = %b, n9 = %b, n10 = %b, sum = %b",n1,n2,n3,n4,n5,n6,n7,n8,n9,n10,sum);


	
	#200
	n1 = 8'b00000011;
	n2 = 8'b00001110;
	n3 = 8'b00000101;
	n4 = 8'b00000110;
	n5 = 8'b00000111;
	n6 = 8'b00001000;
	n7 = 8'b00010011;
	n8 = 8'b00001010;
	n9 = 8'b00000000;
	n10 = 8'b00000000;

	#200
	$display("n1 = %b, n2 = %b, n3 = %b, n4 = %b, n5 = %b, n6 = %b, n7 = %b, n8 = %b, n9 = %b, n10 = %b, sum = %b",n1,n2,n3,n4,n5,n6,n7,n8,n9,n10,sum);

/*
	#100
	n1 = 8'b00000011;
	n2 = 8'b00001110;
	n3 = 8'b00000101;
	n4 = 8'b00000110;
	n5 = 8'b00000111;
	n6 = 8'b00001000;
	n7 = 8'b00010011;
	n8 = 8'b00001010;
	n9 = 8'b10000000;
	n10 = 8'b01000000;

	#100
	$display("n1 = %b, n2 = %b, n3 = %b, n4 = %b, n5 = %b, n6 = %b, n7 = %b, n8 = %b, n9 = %b, n10 = %b, sum = %b",n1,n2,n3,n4,n5,n6,n7,n8,n9,n10,sum);

*/

	end
endmodule