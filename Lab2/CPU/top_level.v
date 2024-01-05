module top_level(
	input clk,
	input rstn,
	input cpu_en,
	input init_w_en,
	input [31:0] init_w_instr,
	input [11:0] init_w_adrs,
	output [31:0] result
);

	wire [31:0] instr_mem;
	wire [31:0] data_ld;
	wire [31:0] data_str;
	wire [11:0] str_adrs;
	wire [11:0] instr_adrs;
	wire [11:0] ld_adrs;
	wire mem_str_en;
	wire mem_read_instr;
	wire mem_ld_en;
	
	wire w_mem_en;
	wire [31:0] w_data_mem;
	wire [11:0] w_mem_adrs;
	wire gated_cpu_clk;

	assign gated_cpu_clk = cpu_en ? clk : 1'b0;
	assign w_data_mem = cpu_en ? data_str : init_w_instr;
	assign w_mem_en = cpu_en ? mem_str_en : init_w_en;
	assign w_mem_adrs = cpu_en? str_adrs : init_w_adrs;

	assign result = data_str;

	cpu cpu_instance(
		.clk(gated_cpu_clk),
		.rstn(rstn),
		.instr_mem(instr_mem),
		.data_ld(data_ld),
		.str_adrs(str_adrs),
		.data_str(data_str),
		.mem_str_en(mem_str_en),
		.instr_adrs(instr_adrs),
		.mem_read_instr(mem_read_instr),
		.mem_ld_en(mem_ld_en),
		.ld_adrs(ld_adrs)
	);
	

	memory memory_instance(
		.clk(clk),
		.rstn(rstn),
		.r_en1(mem_read_instr),
		.r_en2(mem_ld_en),
		.w_en(w_mem_en),
		.r_adrs1(instr_adrs),
		.r_adrs2(ld_adrs),
		.w_adrs(w_mem_adrs),
		.data_in(w_data_mem),
		.data_out1(instr_mem),
		.data_out2(data_ld)
	);

	
endmodule

