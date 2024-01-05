module q1_multiplier (P,X,Y);
    parameter N = 4;
    input [N-1:0] X,Y;
    output[7:0]P;

    wire c1,c2,c3,c4,c5,c6,c7,c8,c9,c10,c11,s1,s2,s3,s4,s5,s6;
    assign P[0] = X[0] * Y[0];  	    //Product bit 0
    ha ha1(P[1],c1,X[1]&Y[0],X[0]&Y[1]);    //Product bit 1
    
    ha ha2(s1,c2,X[2]&Y[0],X[1]&Y[1]);      //Calculates partial sum and carry in column 3
    fa fa1(P[2],c3,s1,X[0]&Y[2],c1);        //Product bit 2
    
    ha ha3(s2,c4,X[3]&Y[0],X[2]&Y[1]);      //Calculates partial sum and carry in column 4
    fa fa2(s3,c5,s2,X[1]&Y[2],c2);          //Calculates partial sum and carry in column 4
    fa fa3(P[3],c6,s3,c3,X[0]&Y[3]);        //Product bit 3
    
    fa fa4(s4,c7,X[3]&Y[1],X[2]&Y[2],c4);   //Calculates partial sum and carry in column 5
    fa fa5(s5,c8,s4,c5,X[1]&Y[3]);	    //Calculates partial sum and carry in column 5
    ha ha4(P[4],c9,s5,c6);		    //Product bit 4

    fa fa6(s6,c10,X[3]&Y[2],X[2]&Y[3],c7);  //Calculates partial sum and carry in column 6
    fa fa7(P[5],c11,s6,c8,c9);		    //Product bit 5

    fa fa8(P[6],P[7],X[3]&Y[3],c10,c11);    //Product bit 6 and carry is product bit 7
endmodule

module ha(s,c,a,b);
    input a,b;
    output s,c;
    
    assign s = a ^ b;
    assign c = a*b;
endmodule

module fa(s,c,a,b,cin);
    input a,b,cin;
    output s,c;
    
    assign s = a ^ b ^ cin;
    assign c = a*b | a*cin | b*cin;
    
endmodule




