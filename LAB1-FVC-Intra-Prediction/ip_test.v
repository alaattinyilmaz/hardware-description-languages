`timescale 1ns / 1ps

module ip_test;

	// Inputs
	reg [7:0] I,J,K,L,M,N,O,P;

	// Outputs
	wire [7:0] a1,a2,a3,a4,b1,b2,b3,b4,c1,c2,c3,c4,d1,d2,d3,d4;
	
	reg [7:0] expected_a1, expected_a2, expected_a3, expected_a4,
				 expected_b1, expected_b2, expected_b3, expected_b4, 
				 expected_c1, expected_c2, expected_c3, expected_c4, 
				 expected_d1, expected_d2, expected_d3, expected_d4; 

	// Instantiation
	intra_predictor intraP (.I(I),.J(J),.K(K),.L(L),.M(M),.N(N),.O(O),.P(P),
	.a1(a1),.a2(a2),.a3(a3),.a4(a4),.b1(b1),.b2(b2),.b3(b3),.b4(b4),
	.c1(c1),.c2(c2),.c3(c3),.c4(c4),.d1(d1),.d2(d2),.d3(d3),.d4(d4));

	always @ *
	begin
	// They are expected results
		expected_a1 = ((29*I + 236*J - 9*K)/256);
		expected_a2 = (61*J - 9*I + 217*K - 13*L)/256;
		expected_a3 = (89*K - 12*J + 195*L - 16*M)/256;
		expected_a4 = (116*L - 14*K + 154*M)/256;
		
		expected_b1 = (29*J + 236*K - 9*L)/256;
		expected_b2 = (61*K - 9*J + 217*L - 13*M)/256;
		expected_b3 = (89*L - 12*K + 195*M - 16*N)/256;
		expected_b4 = (116*M - 14*L + 154*N)/256;

		expected_c1 = (29*K + 236*L - 9*M)/256;
		expected_c2 = (61*L - 9*K + 217*M - 13*N)/256;
		expected_c3 = (89*M - 12*L + 195*N - 16*O)/256;
		expected_c4 = (116*N - 14*M + 154*O)/256;	
		
		expected_d1 = (29*L + 236*M - 9*N)/256;
		expected_d2 = (61*M - 9*L + 217*N - 13*O)/256;
		expected_d3 = (89*N - 12*M + 195*O - 16*P)/256;
		expected_d4 = (116*O - 14*N + 154*P)/256;		
	end

	initial 
	begin
		// Test Inputs
		I = 89;
		J = 91;
		K = 35;
		L = 21;
		M = 17;
		N = 32;
		O = 78;
		P = 12;
		#10;
		
		I = 23;
		J = 38;
		K = 72;
		L = 123;
		M = 171;
		N = 61;
		O = 72;
		P = 42;
		#10;
		
		I = 123;
		J = 113;
		K = 18;
		L = 92;
		M = 55;
		N = 9;
		O = 32;
		P = 109;
		#10;
				
		I = 255;
		J = 255;
		K = 255;
		L = 255;
		M = 255;
		N = 255;
		O = 255;
		P = 255;
		#10;
		
		I = 1;
		J = 1;
		K = 1;
		L = 1;
		M = 1;
		N = 1;
		O = 1;
		P = 1;
		#10;

	end
      
endmodule

