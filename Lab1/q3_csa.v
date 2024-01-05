module q3_csa(sum,n1,n2,n3,n4,n5,n6,n7,n8,n9,n10);
	input[7:0] n1,n2,n3,n4,n5,n6,n7,n8,n9,n10;
	output[14:0] sum;
	wire sf0,sf1,sf2,sf3,sf4,sf5,sf6,sf7,sf8,sf9,sf10,sf11,sf12,sf13,sf14,
		co1,co2,co3,co4,co5,co6,co7,co8,co9,co10,co11,co12,co13,co14;
	wire [7:0]s1,c1;
	wire [8:0]s2,c2;
	wire [9:0]s3,c3;
	wire [10:0]s4,c4;
	wire [11:0]s5,c5;
	wire [12:0]s6,c6;
	wire [13:0]s7,c7;
	wire [14:0]s8,c8;

	csa csa1(s1,c1,n1,n2,n3);
	csa #(9) csa2(s2,c2,{1'b0,s1},{1'b0,n4},{c1,1'b0});
	csa #(10) csa3(s3,c3,{1'b0,s2},{2'b00,n5},{c2,1'b0});

	csa #(11) csa4(s4,c4,{1'b0,s3},{3'b000,n6},{c3,1'b0});
	csa #(12) csa5(s5,c5,{1'b0,s4},{4'b0000,n7},{c4,1'b0});
	csa #(13) csa6(s6,c6,{1'b0,s5},{5'b00000,n8},{c5,1'b0});
	csa #(14) csa7(s7,c7,{1'b0,s6},{6'b000000,n9},{c6,1'b0});
	csa #(15) csa8(s8,c8,{1'b0,s7},{7'b0000000,n10},{c7,1'b0});


	csa #(1) fa0(sf0,co0,s8[0],1'b0,1'b0);
	csa #(1) fa1(sf1,co1,s8[1],c8[0],co0);
	csa #(1) fa2(sf2,co2,s8[2],c8[1],co1);
	csa #(1) fa3(sf3,co3,s8[3],c8[2],co2);
	csa #(1) fa4(sf4,co4,s8[4],c8[3],co3);
	csa #(1) fa5(sf5,co5,s8[5],c8[4],co4);
	csa #(1) fa6(sf6,co6,s8[6],c8[5],co5);
	csa #(1) fa7(sf7,co7,s8[7],c8[6],co6);
	csa #(1) fa8(sf8,co8,s8[8],c8[7],co7);
	csa #(1) fa9(sf9,co9,s8[9],c8[8],co8);
	csa #(1) fa10(sf10,co10,s8[10],c8[9],co9);
	csa #(1) fa11(sf11,co11,s8[11],c8[10],co10);
	csa #(1) fa12(sf12,co12,s8[12],c8[11],co11);
	csa #(1) fa13(sf13,co13,s8[13],c8[12],co12);
	csa #(1) fa14(sf14,co14,s8[14],c8[13],co13);

	assign sum = {co14,sf14,sf13,sf12,sf11,sf10,sf9,sf8,sf7,sf6,sf5,sf4,sf3,sf2,sf1,sf0};

endmodule

module csa(sum,cout,a,b,cin);

	parameter N = 8;
	input [N-1:0]a,b,cin;
	output [N-1:0]cout,sum;

	assign sum = a ^ b ^ cin;
	assign cout = a & b | a & cin | b & cin;

endmodule




