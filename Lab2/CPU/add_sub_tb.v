module add_sub_tb();

	reg clk;
	reg rstn;
	reg cpu_en;
	reg [31:0] init_w_instr;
	reg [11:0] init_w_adrs;
	reg init_w_en;
	wire [31:0] result;
	wire carry;
	
	top_level top_level_instance(
		.clk(clk),
		.rstn(rstn),
		.cpu_en(cpu_en),
		.init_w_instr(init_w_instr),
		.init_w_adrs(init_w_adrs),
		.init_w_en(init_w_en),
		.result(result),
		.carry(carry)
	);

	always #5 clk = ~clk;

	initial begin
		clk = 0;
		rstn = 0;
		cpu_en = 1;
		init_w_instr = 32'h0000_0000;
		init_w_en = 0;

		#10	//Reset
		rstn = 1;
		init_w_en = 1;
		cpu_en = 0;

		#10	//Load immediate 1 to reg_0
		init_w_adrs = 0;
		init_w_instr = 32'b0001_1000_0000_0000_0001_0000_0000_0000;
	
		#10 	//Add immediate 1 to reg_0
		init_w_adrs = 1;
		init_w_instr = 32'b0101_1000_0000_0000_0001_0000_0000_0000;

		#10	//Branch to MEM 15 if Even
		init_w_adrs = 2;
		init_w_instr = 32'b0011_0010_0000_0000_0000_0000_0000_1111;
		
		#10 	//Load immediate 1 to reg_1
		init_w_adrs = 3;
		init_w_instr = 32'b0001_1000_0000_0000_0001_0000_0000_0001;

		#10	//Load immediate 15 to reg_1
		init_w_adrs = 15;
		init_w_instr = 32'b0001_1000_0000_0000_1111_0000_0000_0001;

		#10
		cpu_en = 1;
		init_w_en = 0;
	end
endmodule
