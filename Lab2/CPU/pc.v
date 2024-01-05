module pc (
	input clk,			//Global clock signal
	input rstn,			//Global reset signal
	input inc_en,			//Increment count control
	input branch_valid,		//Branch control
	input [11:0] branch_adrs,	//Branch address 
	output reg[11:0] cnt		//Count
);	

	always @(posedge clk) begin : PROGRAM_COUNTER

		if(!rstn) begin			//When reset, count is 0
			cnt <= 0;
		end 
		else if (inc_en) begin		//Increment when last instruction is finished
			cnt <= branch_valid ? branch_adrs : cnt + 1;
		end
	end


endmodule
