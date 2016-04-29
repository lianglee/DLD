
module twofour(a, b, c, d0, d1, d2, d3);
	input a, b, c;
	output d0, d1, d2, d3;
	
	wire an, bn;
	
	not m0(an, a);
	not m1(bn, b);
	
	and m2(d0, an, bn, c);
	and m3(d1, an, b, c);
	and m4(d2, a, bn, c);
	and m5(d3, a, b, c);
	
endmodule

module three_eight(a, b, c, d0, d1, d2, d3, d4, d5, d6, d7);
	input a, b, c;
	output d0, d1, d2, d3, d4, d5, d6, d7;
	
	wire an;
	not m0(an, a);
	
	twofour m1(b, c, an, d0, d1, d2, d3);
	twofour m2(b, c, a, d4, d5, d6, d7);
	
endmodule

module ROM(a, b, c, b0, b1, b2, b3, b4, b5);
	input a, b, c;
	output b0, b1, b2, b3, b4, b5;
	
	buf m0(b1, b);
	buf m1(b0, c);
	
	wire d0, d1, d2, d3, d4, d5, d6, d7;
	three_eight m2(a, b, c, d0, d1, d2, d3, d4, d5, d6, d7);
	
	or m3(b2, d6, d3, d4, d1);
	or m4(b3, d6, d5, d3, d2);
	or m5(b4, d6, d5, d4);
	or m6(b5, d7);
endmodule

module ROM_Test;
	reg a, b, c;
	wire b0, b1, b2, b3, b4, b5;
	
	ROM m0(a, b, c, b0, b1, b2, b3, b4, b5);
	initial begin
		#50 a=0; b=0; c=0;
		#50 a=0; b=0; c=1;
		#50 a=0; b=1; c=0;
		#50 a=0; b=1; c=1;
		#50 a=1; b=0; c=0;
		#50 a=1; b=0; c=1;
		#50 a=1; b=1; c=0;
		#50 a=1; b=1; c=1;
		#400 $finish;
	end
endmodule
