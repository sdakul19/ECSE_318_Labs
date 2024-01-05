module mem_tb;
        reg  strobe, rw_en, clk, reset;
        reg[15:0] mem_adrs;
        reg[7:0] data_in;
        wire[7:0] data_out;


        memory UUT(.strobe(strobe), .rw_en(rw_en), .clk(clk), .mem_adrs(mem_adrs), .reset, .data_in(data_in), .data_out(data_out));
        
        always #5 clk = ~clk;

        initial begin

                $monitor($time, "Address  = %b,  data_in = %b, strobe = %b, clk = %b, rw_en = %b, data_out = %b", mem_adrs, data_in, strobe, clk, rw_en, data_out);

		clk = 1;
		data_in = 0;
		strobe = 0;
		rw_en = 0;
		data_in = 2'hFF;
		mem_adrs = 2'h00;
		reset = 1;

		#10
		reset = 0;
                strobe = 1;
		rw_en = 1;
		mem_adrs = 2'h00;
		
		#10
		mem_adrs = 2'h01;

		#10
		mem_adrs = 2'h02;

		#10
		mem_adrs = 2'h03;
		
		#10
		mem_adrs = 2'h04;
		
        end
endmodule
