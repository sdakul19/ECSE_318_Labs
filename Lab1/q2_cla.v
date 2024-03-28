module q2_cla(Cout, sum,Cin,a,b);
input [3:0] a, b;
input Cin;
output Cout;
output [3:0] sum;
wire [3:0] g,p,c;


and #10 and0(g[0],a[0],b[0]);
xor #10 xor0(p[0],a[0],b[0]);
xor #10 sum0(sum[0],Cin,p[0]);

and #10 and1(g[1],a[1],b[1]);
xor #10 xor1(p[1],a[1],b[1]);
assign c[1] = g[0] | (p[0] & Cin);
xor #10 sum1(sum[1],c[1],p[1]);

and #10 and2(g[2],a[2],b[2]);
xor #10 xor2(p[2],a[2],b[2]);
assign c[2] = g[1] | (p[1] & c[1]);
xor #10 sum2(sum[2],c[2],p[2]);

and #10 and3(g[3],a[3],b[3]);
xor #10 xor3(p[3],a[3],b[3]);
assign c[3] = g[2] | (p[2] & c[2]);
xor #10 sum3(sum[3],c[3],p[3]);

assign Cout = g[3] | (p[3] & c[3]);

endmodule
