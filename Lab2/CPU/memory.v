module memory(
    input clk,                                      //Global clock signal
    input rstn,                                   //Global reset signal
    input r_en1,                                    //Read instruction enable
    input r_en2,                                    //Read data enable
    input w_en,                                     //Write enable
    input [11:0] r_adrs1,                           //Memory instruction address
    input [11:0] r_adrs2,                           //Memory address to load data
    input [11:0] w_adrs,                            //Memory address to store data
    input [31:0] data_in,                           //Input data
    output reg[31:0] data_out1,                     //Output instruction
    output reg[31:0] data_out2                      //Output data to load
);

    reg [31:0] mem [4095:0];                        //Memory
    integer i;   

    always @(posedge clk) begin: Read_Write_Memory
        
        if (!rstn) begin
            data_out1 <= 0;
            data_out2 <= 0;
            
            for (i = 0; i < 4095; i = i + 1) begin
                mem[i] <= 0;
            end
            
        end else begin
        
        	if(w_en) begin
            		mem[w_adrs] <= data_in;
        	end
        	if(r_en1) begin
            		data_out1 <= mem[r_adrs1];
        	end 
        	if(r_en2) begin
            		data_out2 <= mem[r_adrs2];
        	end
        end
    end
    
endmodule
