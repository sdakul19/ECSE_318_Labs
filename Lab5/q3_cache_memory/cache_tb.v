module cache_tb;

	reg pstrobe, clk, prw;
	reg [15:0] paddress;
	reg [7:0] empty_data;
	reg reset;

	wire pready;
	wire [31:0] pdata;

	wire sysstrobe, sysrw;
	wire [15:0] sysaddress;
	wire [7:0] sysdata;

	cache cache_UUT(.pstrobe(pstrobe), .clk(clk), .prw(prw), .paddress(paddress), .sysdata(sysdata),
		 .pready(pready), .sysstrobe(sysstrobe), .sysrw(sysrw), .pdata(pdata), .sysaddress(sysaddress));

	memory mem_UUT(.strobe(sysstrobe), .rw_en(sysrw), .clk(clk), .mem_adrs(sysaddress), .reset(reset), .data_in(empty_data), .data_out(sysdata));
	
	always #50 clk = ~clk;
	initial begin
		
		$monitor($time, "paddress = %b, pdata = %b", paddress, pdata);
		clk = 1;
		pstrobe = 0;
		prw = 0;
		reset = 1;

		#100
		reset = 0;
		pstrobe = 1;
		paddress = 16'b000000_0001_0000_00;
		

		#100
		$display("\t\tFetching '%b'", paddress);
		pstrobe = 0;
		
		#600
		pstrobe = 1;
		paddress = 16'b00000_0010_0000_00;
		
			
		#100
		$display("\t\tFetching '%b'", paddress);
		pstrobe = 0;

		#600
		pstrobe = 1;
		paddress = 16'b00000_0011_0001_00;
		
		#100
		$display("\t\tFetching '%b'", paddress);
		pstrobe = 0;

		#600
		pstrobe = 1;
		paddress = 16'b00000_1000_0000_00;

		#100
		$display("\t\tFetching '%b'", paddress);
		pstrobe = 0;

		#600
		pstrobe = 1;
		paddress = 16'b00000_0101_0001_00;
		

		#100
		$display("\t\tFetching '%b'", paddress);
		pstrobe = 0;

		#600
		pstrobe = 1;
		paddress = 16'b00000_0101_0111_00;
		

		#100
		$display("\t\tFetching '%b'", paddress);
		pstrobe = 0;

		#600
		pstrobe = 1;
		paddress = 16'b00000_0101_1000_00;
		

		#100
		$display("\t\tFetching '%b'", paddress);
		pstrobe = 0;

		#600
		pstrobe = 1;
		paddress = 16'b00000_0101_1001_00;
		
		#100
		$display("\t\tFetching '%b'", paddress);
		pstrobe = 0;

		#600
		pstrobe = 1;
		paddress = 16'b00000_0101_0111_00;

		#100
		$display("\t\tFetching '%b'", paddress);
		pstrobe = 0;


		#200
		pstrobe = 1;
		paddress = 16'b00000_0101_0001_00;

		#100
		$display("\t\tFetching '%b'", paddress);
		pstrobe = 0;

	end
endmodule
