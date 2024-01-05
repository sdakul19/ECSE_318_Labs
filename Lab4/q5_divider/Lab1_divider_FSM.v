module divider_FSM #(parameter N = 4) (
    input start,
    input clk,
    input [N - 1:0] divisor,
    input [N - 1:0] dividend,
    output [N - 1:0] quotient,
    output [N - 1:0] remainder
);

    reg [N - 1:0] a_reg;
    reg [N - 1:0] m_reg;
    reg [N - 1:0] q_reg;
    
    reg a_reset; 
    reg a_load;
    reg m_load;
    reg q_load;
    reg a_shift;
    reg q_shift;
    reg addsub;
    reg q_lsb;

    reg [2:0] STATE;
    

    localparam S0 = 3'b000;
    localparam S1 = 3'b001;
    localparam S2 = 3'b010;
    localparam S3 = 3'b011;
    localparam S4 = 3'b100;
    localparam S5 = 3'b101;
    localparam S6 = 3'b110;

    assign a_reg = a_reset ? {N{1'b0}} : a_shift ? {a_reg[N - 2 : 0], q_reg[N - 1]} : a_load ? addsub ? a_reg + m_reg : a_reg - m_reg : a_reg;
    assign q_reg = q_load ? dividend : q_shift ? q_reg << 1 : q_reg;
    assign m_reg = m_load ? divisor : m_reg;
    assign q_reg[0] = q_lsb ? a_reg[N - 1] == 1'b1 ? 1'b0 : 1'b1 : q_reg;
    

    integer count;
    
    initial STATE = S0;
    assign remainder = a_reg;
    assign quotient = q_reg;

    always @(posedge clk) begin
        
        case(STATE)
            S0: begin                   //Initialize
                if (start == 1'b1) begin
                    count = N;
		    a_reset <= 1;
		    m_load <= 1;
	            q_load <= 1;
		    q_lsb <= 0;
		    a_shift <= 0;
		    q_shift <= 0;
		    STATE <= S1;
                end 
                
            end
            
            S1: begin                   //Shift
			if (count != 0) begin
                		a_reset <= 0;
				m_load <= 0;
				q_load <= 0;
				a_load <= 0;
				q_lsb <= 0;
				addsub <= 0;

				a_shift <= 1;
				count <= count - 1;
				STATE <= S2;
			end else begin
				STATE <= S0;
			end
                end

            S2: begin                   //Subtract;
             	a_shift <= 0;
		q_shift <= 1;

		addsub <= 0;
		a_load <= 1;
		STATE <= S3;
            end
          
	    
            S3: begin			//Compare;
		a_load <= 0;
                q_shift <= 0;

		if(a_reg[N - 1] == 1'b1) begin
			STATE <= S4;
		end else begin
			STATE <= S6;
		end
            end

	    S4: begin			//Q0 = 0 and restore A
		q_lsb <= 1;

		STATE <= S5;
	    end

	    S5: begin			//restore A
		q_lsb <= 0;

		addsub <= 1;
		a_load <= 1;
		STATE <= S1;
  	    end
            
	    S6: begin
		q_lsb <= 1;
		
		STATE <= S1;
	    end

	   
        endcase
        
    end
    
    
    
endmodule
