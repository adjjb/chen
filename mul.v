module mul(a,b,result);
 
    input [15:0]a,b;
    output [15:0]result;
     
    wire [15:0]p0,p1,p2,p3,p4,t1;
    wire [15:0]result;
    wire [23:0]q5,q6,t2,t3,t4;
     
    M8 z1(a[7:0],b[7:0],p0[15:0]);
    M8 z2(a[15:8],b[7:0],p1[15:0]);
    M8 z3(a[7:0],b[15:8],p2[15:0]);
    M8 z4(a[15:8],b[15:8],p3[15:0]);
    assign t1 ={8'b0,p0[15:8]};
    assign p4 = p1[15:0]+t1;
    assign t2 ={8'b0,p2[15:0]};
    assign t3 ={p3[15:0],8'b0};
    assign q5 = t2+t3;
    assign t4={8'b0,p4[15:0]};
     
    assign q6 = t4 + q5;
     
    //assign result[7:0]=p0[7:0];
    //assign result[15:8]=q6[7:0];

    assign result[15:0]=q6[23:0];

 
endmodule
 
module M2(a, b, c);
    input [1:0] a, b;
    output [3:0] c;
    wire [3:0] c, temp;
     
    assign c[0] = a[0]&b[0];
    assign temp[0] = a[1]&b[0];
    assign temp[1] = a[0]&b[1];
    assign temp[2] = a[1]&b[1];
    M1 m1(temp[0],temp[1],c[1],temp[3]);
    M1 m2(temp[2],temp[3],c[2],c[3]);
 
endmodule
 
module M4(a,b,c);
    input [3:0] a, b;
    output [7:0] c;
     
    wire [3:0] p0,p1,p2,p3,p4,t1;
     
    wire [7:0] c;
    wire [5:0] q5,q6,t2,t3,t4;
     
    M2 m1(a[1:0],b[1:0],p0[3:0]);
    M2 m2(a[3:2],b[1:0],p1[3:0]);
    M2 m3(a[1:0],b[3:2],p2[3:0]);
    M2 m4(a[3:2],b[3:2],p3[3:0]);
     
    assign t1 ={2'b0,p0[3:2]};
    assign p4 = p1[3:0]+t1;
    assign t2 ={2'b0,p2[3:0]};
    assign t3 ={p3[3:0],2'b0};
    assign q5 = t2+t3;
    assign t4={2'b0,p4[3:0]};
    assign q6 = t4+q5;
     
    assign c[1:0]=p0[1:0];
    assign c[7:2]=q6[5:0];
endmodule
 
module M8(a,b,c);
    input [7:0]a,b;
    output [15:0]c;
    wire [15:0]c;
    wire [7:0]p0,p1,p2,p3;
    wire [7:0]p4,t1;
    wire [11:0]q5,q6,t2,t3,t4;
     
    M4 z1(a[3:0],b[3:0],p0[7:0]);
    M4 z2(a[7:4],b[3:0],p1[7:0]);
    M4 z3(a[3:0],b[7:4],p2[7:0]);
    M4 z4(a[7:4],b[7:4],p3[7:0]);
     
    assign t1 ={4'b0,p0[7:4]};
    assign p4 = p1[7:0]+t1;
    assign t2 ={4'b0,p2[7:0]};
    assign t3 ={p3[7:0],4'b0};
    assign q5 = t2+t3;
    assign t4={4'b0,p4[7:0]};
     
    assign q6 = t4+q5;
    
    assign c[3:0]=p0[3:0];
    assign c[15:4]=q6[11:0];
endmodule


module M1(a,b,s,c);
    input a,b;
    output s,c;
     
    assign s = a^b;
    assign c = a&b;
endmodule

