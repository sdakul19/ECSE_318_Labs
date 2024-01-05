module psr(
    input clk,                      //Global clock signal
    input [31:0] result,            //Result input from CPU
    input c_in,                     //Carry input from CPU
    output [4:0] psr                //Program Status
);
    reg[4:0] status;                //Internal status register
    
    always @(posedge clk) begin: Status
        status[0] <= c_in ? 1 : 0;                               //Carry in
        status[1] <= ^result == 1 ? 1 : 0;                       //Parity
        status[2] <= (result % 2) == 0 ? 1 : 0;                  //Even
        status[3] <= result < 0 ? 1 : 0;                         //Negative
        status[4] <= result == 0 ? 1 : 0;                        //Zero
    end
    


endmodule
