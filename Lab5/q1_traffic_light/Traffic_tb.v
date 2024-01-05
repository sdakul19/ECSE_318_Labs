`timescale 1s/1s

module traffic_tb;
	reg clk, sa, sb;
	wire ga, ya, ra, gb, yb, rb;
	
	traffic_light UUT(.clk(clk), .sa(sa), .sb(sb), .ga(ga), .ya(ya), .ra(ra), .gb(gb), .yb(yb), .rb(rb));
	
	always #5 clk = ~clk;
	initial begin
		$monitor($time, " sa = %b, sb = %b, ga = %b, ya = %b, ra = %b, gb = %b, yb = %b, rb = %b", sa, sb, ga, ya, ra, gb, yb, rb);
		clk = 1;
		sa = 0;
		sb = 0;

		#10
		$display("\t\t Car is approaching on B street");
		$display("\t\t Light should be green for A street for 60 seconds");
		sa = 0;
		sb = 1;

		#10
		sa = 1;
		$display("\t\t Car is approaching on A street at");
		$display("\t\t Light should be green for A street after 60 seconds B street light is green");
	end
endmodule
