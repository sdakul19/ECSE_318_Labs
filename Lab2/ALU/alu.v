module alu(c, overflow, a, b, op);
    input [15:0]a,b;                //16 bit inputs A and B
    input [4:0]op;                  //5 bit opcode that determines ALU operation
    output [15:0] c;                 //16 bit result based on inputs A and B and opcode
    output overflow;

    reg [15:0] result;
    reg overfloww;

    parameter ARITHMETIC = 2'b00;
    parameter LOGIC = 2'b01;
    parameter SHIFT = 2'b10;
    parameter SET = 2'b11;


    wire [15:0] adderOut;
    wire [2:0] code;
    assign code = op[2:0];
    wire adderOF;
    adder a1(adderOut, adderOF, a, b, code);

    always @(code or a or b or adderOut or adderOF) begin
        case(op[4:3])
            ARITHMETIC: begin                //Arithmetic operations
                result <= adderOut;
                overfloww <= adderOF;
            end
            LOGIC: begin                //Logic operations
                overfloww = 0;
                case(op[2:0])
                    3'b000: begin
                        result <= a & b;
                    end
                    3'b001: begin
                        result <= a | b;
                    end
                    3'b010: begin
                        result <= a ^ b;
                    end
                    3'b100: begin
                        result <= ~a;
                    end
                    default: result <= 0;
                endcase
            end
            SHIFT: begin                //Shift operations
                overfloww = 0;
                case(op[2:0])
                    3'b000: begin
                        result <= a << b;
                    end
                    3'b001: begin
                        result <= a >> b;
                    end
                    3'b010: begin
                        result <= a <<< b;
                    end
                    3'b011: begin
                        result <= a >>> b;
                    end
                    default: result = 0;
                endcase
            end
            SET: begin                //Set condition operations
                overfloww = 0;
                case(op[2:0])
                    3'b000: begin
                        case({a[15],b[15]})
                                2'b00: begin
                                        result <= a <= b ? 1 : 0;
                                end
                                2'b11: begin
                                        result <= a <= b ? 1 : 0;
                                end
                                2'b01: begin
                                        result <= 0;
                                end
                                2'b10: begin
                                        result <= 1;
                                end
                        endcase
                    end
                    3'b001: begin
                        case({a[15],b[15]})
                                2'b00: begin
                                        result <= a < b ? 1 : 0;
                                end
                                2'b11: begin
                                        result <= a < b ? 1 : 0;
                                end
                                2'b01: begin
                                        result <= 0;
                                end
                                2'b10: begin
                                        result <= 1;
                                end
                        endcase
                    end
                    3'b010: begin
                        case({a[15],b[15]})
                                2'b00: begin
                                        result <= a >= b ? 1 : 0;
                                end
                                2'b11: begin
                                        result <= a >= b ? 1 : 0;
                                end
                                2'b01: begin
                                        result <= 1;
                                end
                                2'b10: begin
                                        result <= 0;
                                end
                        endcase
                    end
                    3'b011: begin
                        case({a[15],b[15]})
                                2'b00: begin
                                        result <= a > b ? 1 : 0;
                                end
                                2'b11: begin
                                        result <= a > b ? 1 : 0;
                                end
                                2'b01: begin
                                        result <= 1;
                                end
                                2'b10: begin
                                        result <= 0;
                                end
                        endcase
                    end
                    3'b100: begin
                        result <= a == b ? 1 : 0;
                    end
                    3'b101: begin
                        result <= a != b ? 1 : 0;
                    end
                    default: result <= 0;

                endcase
            end
            default result <= 0;
        endcase
    end
    assign c = result;
    assign overflow = overfloww;
endmodule

module adder(C, overflow, A, B, code);
input [15:0] A, B;
input [2:0] code;
output [15:0] C;
output overflow;
wire cin;
wire [15:0] cA, cB, nB, one, negOne;
reg vin;
reg [15:0] newB;
fa fa7(cB, cout, vout, B ~^ 1'b0, 16'b0000000000000001, 1'b0, 1'b0);
assign cin = 1'b0;

always@(A or B or code or cB)
begin
        case(code)
                3'b000: begin                //signed addition
                        vin = 1'b1;
                        newB = B;
                end
                3'b001: begin                //unsigned addition
                        vin = 1'b0;
                        newB = B;
                end
                3'b010: begin                //signed subtraction
                        vin = 1'b1;
                        newB = cB;
                end
                3'b011: begin                //unsigned subtraction
                        vin = 1'b0;
                        newB = cB;
                end
                3'b100: begin                //signed increment
                        vin = 1'b1;
                        newB = 1;
                end
                3'b101: begin                //signed decrement
                        vin = 1'b1;
                        newB = -1;
                end
        endcase
end
assign nB = newB;
fa fa1(C, cout, overflow, A, nB, cin, vin);

endmodule

module fa(C,cout,vout,A,B,cin,vin);
input [15:0] A, B;
input cin, vin;
output [15:0] C;
output cout, vout;
wire [16:0] carry;

assign carry[0] = cin;
genvar i;
generate
        for(i=0; i<16; i = i + 1)
        begin
                assign C[i] = A[i] ^ B[i] ^ carry[i];
                assign carry[i+1] = ((A[i] ^ B[i]) & carry[i]) | (A[i] & B[i]);
        end
endgenerate
assign cout = carry[16];
assign vout = (A[15]&B[15]&(~C[15])&vin) | ((~A[15])&(~B[15])&C[15]&vin);
endmodule

