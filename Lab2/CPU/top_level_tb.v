module top_level_tb();
	
	reg clk;
	reg rstn;
	reg cpu_en;
	reg [31:0] init_w_instr;
	reg [11:0] init_w_adrs;
	reg init_w_en;
	wire [31:0] result;
	
	top_level top_level_instance(
		.clk(clk),
		.rstn(rstn),
		.cpu_en(cpu_en),
		.init_w_instr(init_w_instr),
		.init_w_adrs(init_w_adrs),
		.init_w_en(init_w_en),
		.result(result)
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
		
		
		#10	//Load immediate 3 to reg_a 0
		init_w_adrs = 0;
		init_w_instr = 32'b0001_1000_0000_0000_0011_0000_0000_0000;

		
		#10	//Store reg_a 0 to mem15
		init_w_adrs = 1;
		init_w_instr = 32'b0010_0000_0000_0000_0000_0000_0000_1111;
		
		
		#10 	//Load mem15 to reg_a 1
		init_w_adrs = 2;
		init_w_instr = 32'b0001_0000_0000_0000_1111_0000_0000_0001;
		
		#10	//Store reg_a 1 to mem10
		init_w_adrs = 3;
		init_w_instr = 32'b0010_0000_0000_0000_0001_0000_0000_1010;
		
		#10	//Store immediate 15 to mem 8
		init_w_adrs = 4;
		init_w_instr = 32'b0010_1000_0000_0000_1111_0000_0000_1000;
		
		#10	//Load mem 8 to reg_a 2
		init_w_adrs = 5;
		init_w_instr = 32'b0001_0000_0000_0000_1000_0000_0000_0010;

		/*
		#10 	//Halt
		init_w_adrs = 4;
		init_w_instr = 32'b1000_0000_0000_0000_0000_0000_0000_0000;
		
		
		#10	//Number 3 in mem15
		init_w_adrs = 15;
		init_w_instr = 32'b0000_0000_0000_0000_0000_0000_0000_0011;
		*/
		#10
		cpu_en = 1;
		init_w_en = 0;
	end
endmodule
