module cpu (
        input clk,                                      //Global clock signal
        input rstn,                                     //Global reset signal
        input [31:0] instr_mem,                 //Instruction from memory
        input [31:0] data_ld,                   //Data in from memory to be loaded
        output reg[11:0] str_adrs,              //Address location for store
        output reg[31:0] data_str,              //Data to store
        output reg mem_str_en,                  //Store enable for memory
        output reg [11:0] instr_adrs,   //Address for instruction
        output reg mem_read_instr,              //Read instructon enable for memory
        output reg mem_ld_en,                   //Load enable for memory
        output reg [11:0] ld_adrs,              //Address location for load
        output reg [31:0] result,
        output reg carry
);
        reg [31:0] instruction;                 //Instruction register
        reg[2:0] state;                                 //State register
        reg halt;                                       //Halt register
        reg [3:0] opcode;                           //Opcode register
        reg [31:0] op1;                             //Operand 1
        reg [31:0] op2;                             //Operand 2
        reg [31:0] reg_a [31:0];                //File register A


        reg branch_valid;                           //Branch valid control
        reg [11:0] branch_adrs;                 //Branch address

        wire [11:0] cnt;                            //Count from program counter
        wire [4:0]status;                    //Program status from status register

        localparam FETCH = 3'b000;              //Fetch stage
        localparam DECODE = 3'b001;             //Decode stage
        localparam EXECUTE = 3'b010;    //Execute stage
        localparam DELAY = 3'b011;              //Delay stage
        localparam WB = 3'b100;                 //Write back stage
        localparam IDLE = 3'b111;               //Idle stage


        localparam NOP = 4'b0000;               //No operation
        localparam LD = 4'b0001;                //Load
        localparam STR = 4'b0010;               //Store
        localparam BRA = 4'b0011;               //Branch
        localparam XOR = 4'b0100;               //XOR 
        localparam ADD = 4'b0101;               //Add
        localparam ROT = 4'b0110;               //Rotate
        localparam SHF = 4'b0111;               //Shift
        localparam HLT = 4'b1000;               //Halt
        localparam CMP = 4'b1001;               //Complement

        integer i;

        pc pc_instance(
                .clk(clk),
                .rstn(rstn),
                .branch_valid(branch_valid),
                .branch_adrs(branch_adrs),
                .inc_en(state == FETCH),
                .cnt(cnt)
        );

        psr psr_instance(
            .clk(clk),
            .result(result),
            .c_in(carry),
            .psr(status)
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
                else begin
                        case(state)

                                IDLE: begin
                                        state <= halt ? IDLE : FETCH;
                                        
                                        
					
                                end

                                FETCH: begin
                                        state <= DECODE;
					mem_read_instr <= 1;
					instr_adrs <= cnt;
                                        instruction <= instr_mem;
                                        branch_valid <= 0;

                                end

                                DECODE: begin
                                        state <= EXECUTE;
                                        opcode <= instruction[31:28];
                                        op1 <= instruction[27] ? {{20{1'b0}}, instruction[23:12]} : reg_a[instruction[23:12]];
                                        op2 <= instruction[26] ? {32{1'b0}} : reg_a[instruction[11:0]];
                                end

                                EXECUTE: begin
                                        state <= DELAY;
					if (!branch_valid) begin
                                                case(opcode)

                                                        NOP: state <= DELAY;

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
                                                        BRA: begin
                                                          
                                                            case(instruction[26:24])

                                                                3'b000: begin             //Always
                                                                                branch_adrs <= instruction[11:0];
                                                                                branch_valid <= 1'b1;
                                                                end
                                                                3'b001: begin             //Parity
                                                                                if(status[1] == 1)begin
                                                                                        branch_adrs <= instruction[11:0];
                                                                                        branch_valid <= 1'b1;
                                                                                end
                                                                end
                                                                3'b010: begin             //Even
                                                                                if(status[2] == 1)begin
                                                                                        branch_adrs <= instruction[11:0];
                                                                                        branch_valid <= 1'b1;
                                                                                end
                                                                end
                                                                3'b011: begin             //Carry
                                                                                if(status[0] == 1)begin
                                                                                        branch_adrs <= instruction[11:0];
                                                                                        branch_valid <= 1'b1;
                                                                                end
                                                                end
                                                                3'b100: begin             //Negative
                                                                                if(status[3] == 1)begin
                                                                                        branch_adrs <= instruction[11:0];
                                                                                        branch_valid <= 1'b1;
                                                                                end
                                                                end
                                                                3'b101: begin             //Zero
                                                                                if(status[4] == 1)begin
                                                                                        branch_adrs <= instruction[11:0];
                                                                                        branch_valid <= 1'b1;
                                                                                end
                                                                end
                                                                3'b110: begin             //No carry
                                                                                if(status[0] == 0)begin
                                                                                        branch_adrs <= instruction[11:0];
                                                                                        branch_valid <= 1'b1;
                                                                                end
                                                                end
                                                                3'b111: begin             //Positive
                                                                                if(status[3] == 0)begin
                                                                                        branch_adrs <= instruction[11:0];
                                                                                        branch_valid <= 1'b1;
                                                                                end
                                                                end

                                                                default: begin
                                                                    branch_valid <= 0;
                                                                    branch_adrs <= 0;
                                                                end

                                                        endcase
                                                    end
                                                    XOR: begin
                                                        result <= op1 ^ op2;
                                                        branch_valid <= 0;
                                                        branch_adrs <= 0;
                                                        carry <= 0;
                                                    end
                                                    ADD: begin
                                                        {carry,result} <= op1 + op2;
                                                    end
                                                        ROT: begin
                                                                case(instruction[23])  //check if cnt is negative or postive
                                                                        1'b0:begin //positive   
                                                                            result <= (op2 >> op1) | (op2 << (32-op1)); //OR function merges the shift functions to create circular shift
                                                                            branch_adrs <= 0;
                                                                            branch_valid <= 0;
                                                                        end
                                                                        1'b1:begin //negative
                                                                            result <= (op2 << op1[4:0]) | (op2 >> (32 - op1[4:0]));  
                                                                                branch_adrs <= 0;
                                                                                branch_valid <= 0;
                                                                         end
                                                                         default: begin
                                                                                result <= op2;
                                                                                branch_adrs <= 0;
                                                                                branch_valid <= 0;
                                                                        end
                                                                endcase
                                                        end
                                                        SHF: begin
                                                                case(instruction[23])  //check if cnt is negative or postive
                                                                        1'b0:begin //positive
                                                                            result <= op2 >> op1;
                                                                            branch_adrs <= 0;
                                                                            branch_valid <= 0;
                                                                        end
                                                                        1'b1:begin //negative
                                                                            result <= op2 << op1[4:0]; 
                                                                            branch_adrs <= 0;
                                                                            branch_valid <= 0;
                                                                        end
                                                                        default: begin
                                                                                result <= op2;
                                                                                branch_adrs <= 0;
                                                                                branch_valid <= 0;
                                                                        end
                                                                endcase
                                                        end
                                                        HLT: halt <= 1;
                                                        CMP: result <= ~op1;
                                                    default: begin
                                                        state <= DELAY;
                                                        result <= 0;
                                                        carry <= 0;
                                                    end
						
                                           endcase
					end
                                    end

                                DELAY: state <= WB;         //Delay stage so loaded data from memory can be latched

                                WB: begin               //Write back for all instructions except branch, store, no-op, and halt
                                        state <= IDLE;
                                        if (opcode == LD) begin
                                                if(!instruction[27]) begin
                                                        reg_a[instruction[11:0]] <= data_ld;
                                                end
                                        end
                                        else if ((opcode != BRA) && (opcode != STR) && (opcode != HLT) && (opcode != NOP)) begin
                                                reg_a[instruction[11:0]] <= result;
                                        end
                                        else begin
                                                
                                        end
                                end
                        endcase
                end
		
        end
endmodule

