module q1test();
reg [15:0]X;
reg [15:0]Y;
reg [4:0]opcode;
reg [2:0]code;
reg cin;
wire [15:0]P;
wire cout, overflow;


alu UUT(P, overflow, X, Y, opcode);
        initial begin
                #2
                X = 16'b0100000000000110;
                Y = 16'b0100000000000100;
                opcode = 5'b00000;
                #2
                $display("Overflow signed addition: A = %b, B = %b,code = %b, C = %b, overflow = %b" ,X,Y,opcode,P,overflow);
                #2
                X = 16'b0000000000000110;
                Y = 16'b0000000000000100;
                opcode = 5'b00000;
                #2
                $display("Signed addition: A = %b, B = %b,code = %b, C = %b, overflow = %b" ,X,Y,opcode,P,overflow);
                #2
                X = 16'b0111111111111111;
                Y = 16'b0100100010111100;
                opcode = 5'b00001;
                #2
                $display("Unsigned addition: A = %b, B = %b,code = %b, C = %b, overflow = %b" ,X,Y,opcode,P,overflow);
                #2
                X = 16'b0100000000000110;
                Y = 16'b1000000010001001;
                opcode = 5'b00010;
                #2
                $display("Overflow signed subtraction: A = %b, B = %b,code = %b, C = %b, overflow = %b" ,X,Y,opcode,P,overflow);
                #2
                X = 16'b0100000000001110;
                Y = 16'b0000000000000101;
                opcode = 5'b00010;
                #2
                $display("Signed subtraction: A = %b, B = %b,code = %b, C = %b, overflow = %b" ,X,Y,opcode,P,overflow);
                #2
                X = 16'b0101111111111111;
                Y = 16'b0100000000000000;
                opcode = 5'b00011;
                #2
                $display("Unsigned subtraction: A = %b, B = %b,code = %b, C = %b, overflow = %b" ,X,Y,opcode,P,overflow);
                #2
                X = 16'b0111111111111111;
                Y = 16'b1000000010001001;
                opcode = 5'b00100;
                #2
                $display("Overflow signed increment: A = %b, B = %b,code = %b, C = %b, overflow = %b" ,X,Y,opcode,P,overflow);
                #2
                X = 16'b0100000000001110;
                Y = 16'b0000000000000101;
                opcode = 5'b00100;
                #2
                $display("Signed increment: A = %b, B = %b,code = %b, C = %b, overflow = %b" ,X,Y,opcode,P,overflow);
                #2
                X = 16'b1000000000000000;
                Y = 16'b1000000010001001;
                opcode = 5'b00101;
                #2
                $display("Overflow signed decrement: A = %b, B = %b,code = %b, C = %b, overflow = %b" ,X,Y,opcode,P,overflow);
                #2
                X = 16'b0100000000001110;
                Y = 16'b0000000000000101;
                opcode = 5'b00101;
                #2
                $display("Signed decrement: A = %b, B = %b,code = %b, C = %b, overflow = %b" ,X,Y,opcode,P,overflow);
                #2
                X = 16'b0111111111111111;
                Y = 16'b1000000010001001;
                opcode = 5'b01000;
                #2
                $display("A and B: A = %b, B = %b,code = %b, C = %b, overflow = %b" ,X,Y,opcode,P,overflow);
                #2
                X = 16'b0100011000001110;
                Y = 16'b0000000000000101;
                opcode = 5'b01001;
                #2
                $display("A or B: A = %b, B = %b,code = %b, C = %b, overflow = %b" ,X,Y,opcode,P,overflow);
                #2
                X = 16'b1000000000000000;
                Y = 16'b1000000010001001;
                opcode = 5'b01010;
                #2
                $display("A xor B: A = %b, B = %b,code = %b, C = %b, overflow = %b" ,X,Y,opcode,P,overflow);
                #2
                X = 16'b0100000000001110;
                Y = 16'b0000000000000101;
                opcode = 5'b01100;
                #2
                $display("not A: A = %b, B = %b,code = %b, C = %b, overflow = %b" ,X,Y,opcode,P,overflow);
                #2
                X = 16'b1100110010001110;
                Y = 16'b0000000000000101;
                opcode = 5'b10000;
                #2
                $display("logic left A by B: A = %b, B = %b,code = %b, C = %b, overflow = %b" ,X,Y,opcode,P,overflow);
                #2
                X = 16'b0100110010001110;
                Y = 16'b0000000000000101;
                opcode = 5'b10001;
                #2
                $display("logic right A by B: A = %b, B = %b,code = %b, C = %b, overflow = %b" ,X,Y,opcode,P,overflow);
                #2
                X = 16'b1100110010001110;
                Y = 16'b0000000000000101;
                opcode = 5'b10010;
                #2
                $display("arithmetic left A by B: A = %b, B = %b,code = %b, C = %b, overflow = %b" ,X,Y,opcode,P,overflow);
                #2
                X = 16'b1100110010001110;
                Y = 16'b0000000000000101;
                opcode = 5'b10011;
                #2
                $display("arithmetic right A by B: A = %b, B = %b,code = %b, C = %b, overflow = %b" ,X,Y,opcode,P,overflow);
                #2
                X = 16'b0111111111111111;
                Y = 16'b1000000010001001;
                opcode = 5'b11000;
                #2
                $display("A <= B: A = %b, B = %b,code = %b, C = %b, overflow = %b" ,X,Y,opcode,P,overflow);
                #2
                X = 16'b0100011000001110;
                Y = 16'b0000000000000101;
                opcode = 5'b11001;
                #2
                $display("A < B: A = %b, B = %b,code = %b, C = %b, overflow = %b" ,X,Y,opcode,P,overflow);
                #2
                X = 16'b1001000000000000;
                Y = 16'b1000000010001001;
                opcode = 5'b11010;
                #2
                $display("A >= B: A = %b, B = %b,code = %b, C = %b, overflow = %b" ,X,Y,opcode,P,overflow);
                #2
                X = 16'b0100000000001110;
                Y = 16'b0000000000000101;
                opcode = 5'b11011;
                #2
                $display("A > B: A = %b, B = %b,code = %b, C = %b, overflow = %b" ,X,Y,opcode,P,overflow);
                #2
                X = 16'b1000000010001001;
                Y = 16'b1000000010001001;
                opcode = 5'b11100;
                #2
                $display("A = B: A = %b, B = %b,code = %b, C = %b, overflow = %b" ,X,Y,opcode,P,overflow);
                #2
                X = 16'b0100000000001110;
                Y = 16'b0000000000000101;
                opcode = 5'b11101;
                #2
                $display("A != B: A = %b, B = %b,code = %b, C = %b, overflow = %b" ,X,Y,opcode,P,overflow);
        end
endmodule

