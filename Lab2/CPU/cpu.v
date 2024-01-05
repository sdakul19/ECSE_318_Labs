module cpu (
	input clk,				//Global clock signal
	input rstn,				//Global reset signal
	input [31:0] instr_mem,			//Instruction from memory
	input [31:0] data_ld,			//Data in from memory to be loaded
	output reg[11:0] str_adrs,		//Address location for store
	output reg[31:0] data_str,		//Data to store
	output reg mem_str_en,			//Store enable for memory
	output reg [11:0] instr_adrs,		//Address for instruction
	output reg mem_read_instr,		//Read instructon enable for memory
	output reg mem_ld_en,			//Load enable for memory
	output reg [11:0] ld_adrs		//Address location for load
);
	reg [31:0] instruction;			//Instruction register
	reg[2:0] state;				//State register
	reg halt;				//Halt register
	reg [3:0] opcode;			//Opcode register
	reg [31:0] op1;				//Operand 1
	reg [31:0] op2;				//Operand 2
	reg [31:0] reg_a [31:0];		//File register A

	reg [31:0] result;			//Result from operations
	reg branch_valid;			//Branch valid control
	reg [11:0] branch_adrs;			//Branch address
	
	wire [11:0] cnt;			//Count from program counter

	localparam FETCH = 3'b000;		//Fetch stage
	localparam DECODE = 3'b001;		//Decode stage
	localparam EXECUTE = 3'b010;		//Execute stage
	localparam DELAY = 3'b011;		//Delay stage 
	localparam WB = 3'b100;			//Write back stage
	localparam IDLE = 3'b111;		//Idle stage

	localparam NOP = 4'b0000;		//No operation
	localparam LD = 4'b0001;		//Load
	localparam STR = 4'b0010;		//Store
	localparam BRA = 4'b0011;		//Branch
	localparam XOR = 4'b0100;		//XOR 
	localparam ADD = 4'b0101;		//Add
	localparam ROT = 4'b0110;		//Rotate
	localparam SHF = 4'b0111;		//Shift
	localparam HLT = 4'b1000;		//Halt
	localparam CMP = 4'b1001;		//Complement
	
	integer i;
	pc pc_instance(
		.clk(clk),
		.rstn(rstn),
		.branch_valid(branch_valid),
		.branch_adrs(branch_adrs),
		.inc_en(state == FETCH),
		.cnt(cnt)
	);

	
	always @ (posedge clk) begin

		if (!rstn) begin
			state <= IDLE;
			str_adrs <= 0;
			data_str <= 0;
			branch_adrs <= 0;
			branch_valid <= 0;
			mem_read_instr <= 0;
			mem_str_en <= 0;
			instr_adrs <= 0;
			mem_ld_en <= 0;
			op1 <= 0;
			op2 <= 0;
			
			for (i = 0; i < 32; i = i + 1) begin
				reg_a[i] <= 0;
			end
			halt <= 0;
		
		end
		else if (!branch_valid) begin
			case(state)
				
				IDLE: begin
					state <= halt ? IDLE : FETCH;
					mem_read_instr <= 1;
					instr_adrs <= cnt;
				end

				FETCH: begin
					state <= DECODE;
					instruction <= instr_mem;
					mem_read_instr <= 0;
					
				end

				DECODE: begin
					state <= EXECUTE;
					opcode <= instruction[31:28];
					op1 <= instruction[27] ? {{20{1'b0}}, instruction[23:12]} : reg_a[instruction[23:12]];
					op2 <= instruction[26] ? {32{1'b0}} : reg_a[instruction[11:0]]; 
				end

				EXECUTE: begin
					state <= DELAY;
						case(opcode)
						
							NOP: begin
					
							end
							LD: begin
								if(instruction[27]) begin
									reg_a[instruction[11:0]] <= {{20{1'b0}}, instruction[23:12]};
								end 
								else begin
									mem_ld_en <= 1;
									ld_adrs <= instruction[23:12];
								end	
							end
							STR: begin
								mem_str_en <= 1;
								str_adrs <= instruction[11:0];
								if(instruction[27]) begin
									data_str <= op1;
								end 
								else begin
									data_str <= reg_a[instruction[23:12]];
								end
							
							end
						//BRA:
						//XOR:
						//ADD:
						//ROT:
						//SHF:
						  HLT: halt <= 1;
						//CMP:
					   	  default: state <= DELAY;
					   endcase
				    end

				DELAY: state <= WB;
					
				WB: begin		//Write back for load instructions
					state <= IDLE;
					case(opcode)
						LD: begin
							if(!instruction[27]) begin
								reg_a[instruction[11:0]] <= data_ld;
							end
						end
					endcase
				end
			endcase
		end
	end
endmodule
