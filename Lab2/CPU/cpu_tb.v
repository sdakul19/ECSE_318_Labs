module cpu_tb();
	
	reg clk;
	reg rstn;
	reg [31:0] instr_mem;
	
	wire [11:0] str_adrs;
	wire [31:0] data_str;
	wire mem_str_en;
	wire [11:0] instr_adrs;
	wire mem_read_instr;
	wire mem_ld_en;
	wire [11:0] mem_ld_adrs;

	cpu cpu_instance (
		.clk(clk),
		.rstn(rstn),
		.instr_mem(instr_mem),
		.str_adrs(str_adrs),
		.data_str(data_str),
		.mem_str_en(mem_str_en),
		.instr_adrs(instr_adrs),
		.mem_read_instr(mem_read_instr),
		.mem_ld_en(mem_ld_en),
		.mem_ld_adrs(mem_ld_adrs)
	);
	
	always #5 clk = ~clk;
	
	initial begin
		clk = 0;
		rstn = 0;
		instr_mem = 32'h0000_0000;

		#10
		rstn = 1;
		instr_mem = 32'b0000_0000_0000_0000_0000_0000_0000_1111;
	end
endmodule
