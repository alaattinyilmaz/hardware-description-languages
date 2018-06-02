`timescale 1ns / 1ps

module intra_predictor_seq(clk, reset, start, I, J, K, L, M, N, O, P, done, a1,a2,a3,a4,b1,b2,b3,b4,c1,c2,c3,c4,d1,d2,d3,d4);
input clk, reset, start;
input [7:0] I, J, K, L, M, N, O, P;
output reg done;
output reg [7:0] a1,a2,a3,a4,b1,b2,b3,b4,c1,c2,c3,c4,d1,d2,d3,d4;

reg [17: 0] register;

reg [17:0] adder0_input0, adder1_input0, adder2_input0, adder3_input0, adder4_input0, adder5_input0, adder6_input0, 
			  adder7_input0, adder8_input0, adder0_input1, adder1_input1, adder2_input1, adder3_input1, adder4_input1, 
			  adder5_input1, adder6_input1, adder7_input1, adder8_input1, adder0_output, adder1_output, adder2_output, 
			  adder3_output, adder4_output, adder5_output, adder6_output, adder7_output, adder8_output, adder9_output, 
			  adder10_output, adder11_output, adder12_output, adder13_output, adder14_output, adder15_output;

reg [4:0] counter;
reg [2:0] flag;

always @ (posedge start)
begin
	flag <= 1;
end

always @ (posedge clk or posedge reset)
begin	
	if (reset)
	begin
		done <= 0;
		counter <= 0;
		flag <= 0;
	end
	else if (counter == 16)
		counter <= 0;
	else if(flag == 1)
		counter <= counter + 1;
end

always @ *
begin
	
	case (counter)
	//A
	1 : adder0_input0 = I << 4;
	2 : adder0_input0 = J << 5;
	3 : adder0_input0 = K << 6;
	4 : adder0_input0 = L << 6;
	//B
	5 : adder0_input0 = J << 4;
	6 : adder0_input0 = K << 5;
	7 : adder0_input0 = L << 6;
	8 : adder0_input0 = M << 6;
	//C
	9 : adder0_input0 = K << 4;
	10 : adder0_input0 = L << 5;
	11 : adder0_input0 = M << 6;
	12 : adder0_input0 = N << 6;
	//D
	13 : adder0_input0 = L << 4;
	14 : adder0_input0 = M << 5;
	15 : adder0_input0 = N << 6;
	16 : adder0_input0 = O << 6;
	
	default : adder0_input0 = 0;
	endcase

	case (counter)
	//A
	1 : adder0_input1 = I << 3;
	2 : adder0_input1 = J << 4;
	3 : adder0_input1 = K << 4;
	4 : adder0_input1 = L << 5;
	//B
	5 : adder0_input1 = J << 3;
	6 : adder0_input1 = K << 4;
	7 : adder0_input1 = L << 4;
	8 : adder0_input1 = M << 5;
	//C
	9 : adder0_input1 = K << 3;
	10 : adder0_input1 = L << 4;
	11 : adder0_input1 = M << 4;
	12 : adder0_input1 = N << 5;
	//D
	13 : adder0_input1 = L << 3;
	14 : adder0_input1 = M << 4;
	15 : adder0_input1 = N << 4;
	16 : adder0_input1 = O << 5;
	
	default : adder0_input1 = 0;
	endcase
	
	// Adder 0 end
	
	case (counter)
	//A
	1 : adder1_input0 = I << 2;
	2 : adder1_input0 = J << 3;
	3 : adder1_input0 = K << 3;
	4 : adder1_input0 = L << 4;
	//B
	5 : adder1_input0 = J << 2;
	6 : adder1_input0 = K << 3;
	7 : adder1_input0 = L << 3;
	8 : adder1_input0 = M << 4;
	//C
	9 : adder1_input0 = K << 2;
	10 : adder1_input0 = L << 3;
	11 : adder1_input0 = M << 3;
	12 : adder1_input0 = N << 4;
	//D
	13 : adder1_input0 = L << 2;
	14 : adder1_input0 = M << 3;
	15 : adder1_input0 = N << 3;
	16 : adder1_input0 = O << 4;
	
	
	default : adder1_input0 = 0;
	endcase

	case (counter)
	1 : adder1_input1 = I;
	2 : adder1_input1 = J << 2;
	3 : adder1_input1 = K;
	4 : adder1_input1 = L << 2;
	
	5 : adder1_input1 = J;
	6 : adder1_input1 = K << 2;
	7 : adder1_input1 = L;
	8 : adder1_input1 = M << 2;
	
	9 : adder1_input1 = K;
	10 : adder1_input1 = L << 2;
	11 : adder1_input1 = M;
	12 : adder1_input1 = N << 2;
	
	13 : adder1_input1 = L;
	14 : adder1_input1 = M << 2;
	15 : adder1_input1 = N;
	16 : adder1_input1 = O << 2;
	
	default : adder1_input1 = 0;
	endcase
	
	
	// adder 1 end
	
	
	case (counter)
	1 : adder2_input0 = J << 7;
	2 : adder2_input0 = J;
	3 : adder2_input0 = L << 7;
	4 : adder2_input0 = M << 7;
	
	5 : adder2_input0 = K << 7;
	6 : adder2_input0 = K;
	7 : adder2_input0 = M << 7;
	8 : adder2_input0 = N << 7;

	9 : adder2_input0 = L << 7;
	10 : adder2_input0 = L;
	11 : adder2_input0 = N << 7;
	12 : adder2_input0 = O << 7;
	
	13 : adder2_input0 = M << 7;
	14 : adder2_input0 = M;
	15 : adder2_input0 = O << 7;
	16 : adder2_input0 = P << 7;
	
	default : adder2_input0 = 0;
	endcase

	case (counter)
	1 : adder2_input1 = J << 6;
	2 : adder2_input1 = K << 7;
	3 : adder2_input1 = L << 6;
	4 : adder2_input1 = M << 4;
	
	5 : adder2_input1 = K << 6;
	6 : adder2_input1 = L << 7;
	7 : adder2_input1 = M << 6;
	8 : adder2_input1 = N << 4;
	
	9 : adder2_input1 = L << 6;
	10 : adder2_input1 = M << 7;
	11 : adder2_input1 = N << 6;
	12 : adder2_input1 = O << 4;
	
	13 : adder2_input1 = M << 6;
	14 : adder2_input1 = N << 7;
	15 : adder2_input1 = O << 6;
	16 : adder2_input1 = P << 4;
	
	default : adder2_input1 = 0;
	endcase
		
	// adder 2 end
	
	
	case (counter)
	1 : adder3_input0 = J << 5;
	2 : adder3_input0 = K << 6;
	3 : adder3_input0 = L << 1;
	4 : adder3_input0 = M << 3;
	
	5 : adder3_input0 = K << 5;
	6 : adder3_input0 = L << 6;
	7 : adder3_input0 = M << 1;
	8 : adder3_input0 = N << 3;

	9 : adder3_input0 = L << 5;
	10 : adder3_input0 = M << 6;
	11 : adder3_input0 = N << 1;
	12 : adder3_input0 = O << 3;

	13 : adder3_input0 = M << 5;
	14 : adder3_input0 = N << 6;
	15 : adder3_input0 = O << 1;
	16 : adder3_input0 = P << 3;	
	default : adder3_input0 = 0;
	endcase

	case (counter)
	1 : adder3_input1 = J << 3;
	2 : adder3_input1 = K << 4;
	3 : adder3_input1 = L;
	4 : adder3_input1 = M << 1;

	5 : adder3_input1 = K << 3;
	6 : adder3_input1 = L << 4;
	7 : adder3_input1 = M;
	8 : adder3_input1 = N << 1;

	9 : adder3_input1 = L << 3;
	10 : adder3_input1 = M << 4;
	11 : adder3_input1 = N;
	12 : adder3_input1 = O << 1;
	
	13 : adder3_input1 = M << 3;
	14 : adder3_input1 = N << 4;
	15 : adder3_input1 = O;
	16 : adder3_input1 = P << 1;
	
	default : adder3_input1 = 0;
	endcase
		
	// adder 3 end
	
	case (counter)
	1 : adder4_input0 = J << 2;
	2 : adder4_input0 = K << 3;
	3 : adder4_input0 = 0;
	4 : adder4_input0 = 0;
	
	5 : adder4_input0 = K << 2;
	6 : adder4_input0 = L << 3;
	7 : adder4_input0 = 0;
	8 : adder4_input0 = 0;
	
	9 : adder4_input0 = L << 2;
	10 : adder4_input0 = M << 3;
	11 : adder4_input0 = 0;
	12 : adder4_input0 = 0;
	
	13 : adder4_input0 = M << 2;
	14 : adder4_input0 = N << 3;
	15 : adder4_input0 = 0;
	16 : adder4_input0 = 0;
	
	default : adder4_input0 = 0;
	endcase

	case (counter)
	1 : adder4_input1 = 0; // ZERO
	2 : adder4_input1 = K;
	3 : adder4_input1 = 0;
	4 : adder4_input1 = 0;

	5 : adder4_input1 = 0; // ZERO
	6 : adder4_input1 = L;
	7 : adder4_input1 = 0;
	8 : adder4_input1 = 0;
	
	9 : adder4_input1 = 0; // ZERO
	10 : adder4_input1 = M;
	11 : adder4_input1 = 0;
	12 : adder4_input1 = 0;

	13 : adder4_input1 = 0; // ZERO
	14 : adder4_input1 = N;
	15 : adder4_input1 = 0;
	16 : adder4_input1 = 0;
	
	
	default : adder4_input1 = 0;
	endcase
		
	// adder4 end
	
	
	case (counter)
	1 : adder5_input0 = 0; 
	2 : adder5_input0 = 0;
	3 : adder5_input0 = 0;
	4 : adder5_input0 = 0;
	5 : adder5_input0 = 0; 
	6 : adder5_input0 = 0;
	7 : adder5_input0 = 0;
	8 : adder5_input0 = 0;
	9 : adder5_input0 = 0; 
	10 : adder5_input0 = 0;
	11 : adder5_input0 = 0;
	12 : adder5_input0 = 0;
	13 : adder5_input0 = 0; 
	14 : adder5_input0 = 0;
	15 : adder5_input0 = 0;
	16 : adder5_input0 = 0;
	
	default : adder5_input0 = 0;
	endcase

	case (counter)
	1 : adder5_input1 = 0; 
	2 : adder5_input1 = 0;
	3 : adder5_input1 = 0;
	4 : adder5_input1 = 0;
	5 : adder5_input1 = 0; 
	6 : adder5_input1 = 0;
	7 : adder5_input1 = 0;
	8 : adder5_input1 = 0;
	9 : adder5_input1 = 0; 
	10 : adder5_input1 = 0;
	11 : adder5_input1 = 0;
	12 : adder5_input1 = 0;
	13 : adder5_input1 = 0; 
	14 : adder5_input1 = 0;
	15 : adder5_input1 = 0;
	16 : adder5_input1 = 0;
	default : adder5_input1 = 0;
	endcase
		
	// adder5 end
	
	// 	SUBTRACTIONS ////
	/////////////////////////////////////////////////////////////////
	// ADDER 6-7-8 WILL BE USED AS SUBTRACTORS
	case (counter)
	1 : adder6_input0 = K << 3;
	2 : adder6_input0 = I << 3;
	3 : adder6_input0 = J << 3;
	4 : adder6_input0 = K << 3;

	5 : adder6_input0 = L << 3;
	6 : adder6_input0 = J << 3;
	7 : adder6_input0 = K << 3;
	8 : adder6_input0 = L << 3;
	
	9 : adder6_input0 = M << 3;
	10 : adder6_input0 = K << 3;
	11 : adder6_input0 = L << 3;
	12 : adder6_input0 = M << 3;
	
	13 : adder6_input0 = N << 3;
	14 : adder6_input0 = L << 3;
	15 : adder6_input0 = M << 3;
	16 : adder6_input0 = N << 3;
	
	default : adder6_input0 = 0;
	endcase

	case (counter)
	1 : adder6_input1 = K;
	2 : adder6_input1 = I;
	3 : adder6_input1 = J << 2;
	4 : adder6_input1 = K << 2;
	
	5 : adder6_input1 = L;
	6 : adder6_input1 = J;
	7 : adder6_input1 = K << 2;
	8 : adder6_input1 = L << 2;
	
	9 : adder6_input1 = M;
	10 : adder6_input1 = K;
	11 : adder6_input1 = L << 2;
	12 : adder6_input1 = M << 2;
	
	13 : adder6_input1 = N;
	14 : adder6_input1 = L;
	15 : adder6_input1 = M << 2;
	16 : adder6_input1 = N << 2;
	
	
	default : adder6_input1 = 0;
	endcase
	// adder6 end
	

	case (counter)
	1 : adder7_input0 = 0;
	2 : adder7_input0 = L << 3; 
	3 : adder7_input0 = M << 4;
	4 : adder7_input0 = K << 1;

	5 : adder7_input0 = 0;
	6 : adder7_input0 = M << 3; 
	7 : adder7_input0 = N << 4;
	8 : adder7_input0 = L << 1;

	9 : adder7_input0 = 0;
	10 : adder7_input0 = N << 3; 
	11 : adder7_input0 = O << 4;
	12 : adder7_input0 = M << 1;

	13 : adder7_input0 = 0;
	14 : adder7_input0 = O << 3; 
	15 : adder7_input0 = P << 4;
	16 : adder7_input0 = N << 1;	
	default : adder7_input0 = 0;
	endcase

	case (counter)
	1 : adder7_input1 = 0;
	2 : adder7_input1 = L << 2;
	3 : adder7_input1 = 0;
	4 : adder7_input1 = 0;
	
	5 : adder7_input1 = 0;
	6 : adder7_input1 = M << 2;
	7 : adder7_input1 = 0;
	8 : adder7_input1 = 0;
	
	9 : adder7_input1 = 0;
	10 : adder7_input1 = N << 2;
	11 : adder7_input1 = 0;
	12 : adder7_input1 = 0;
	
	13 : adder7_input1 = 0;
	14 : adder7_input1 = O << 2;
	15 : adder7_input1 = 0;
	16 : adder7_input1 = 0;
	
	default : adder7_input1 = 0;
	endcase
		
	// adder7 end
	
	// ADDER 8 INPUT0 WILL BE ZERO
	case (counter)
	1 : adder8_input0 = 0;
	2 : adder8_input0 = 0; 
	3 : adder8_input0 = 0;
	4 : adder8_input0 = 0;
	
	5 : adder8_input0 = 0;
	6 : adder8_input0 = 0; 
	7 : adder8_input0 = 0;
	8 : adder8_input0 = 0;
	
	9 : adder8_input0 = 0;
	10 : adder8_input0 = 0; 
	11 : adder8_input0 = 0;
	12 : adder8_input0 = 0;
	
	13 : adder8_input0 = 0;
	14 : adder8_input0 = 0; 
	15 : adder8_input0 = 0;
	16 : adder8_input0 = 0;
	
	default : adder8_input0 = 0;
	endcase

	case (counter)
	1 : adder8_input1 = 0;
	2 : adder8_input1 = L;
	3 : adder8_input1 = 0;
	4 : adder8_input1 = 0;
	
	5 : adder8_input1 = 0;
	6 : adder8_input1 = M;
	7 : adder8_input1 = 0;
	8 : adder8_input1 = 0;
	
	9 : adder8_input1 = 0;
	10 : adder8_input1 = N;
	11 : adder8_input1 = 0;
	12 : adder8_input1 = 0;
	
	13 : adder8_input1 = 0;
	14 : adder8_input1 = O;
	15 : adder8_input1 = 0;
	16 : adder8_input1 = 0;
	default : adder8_input1 = 0;
	endcase
	// adder8 end
	
	adder0_output = adder0_input0 + adder0_input1;
	adder1_output = adder1_input0 + adder1_input1;
	adder2_output = adder2_input0 + adder2_input1;
	adder3_output = adder3_input0 + adder3_input1;
	adder4_output = adder4_input0 + adder4_input1;
	adder5_output = adder5_input0 + adder5_input1;
	
	// SUBTRACTORS
	adder6_output = adder6_input0 + adder6_input1;
	adder7_output = adder7_input0 + adder7_input1;
	adder8_output = adder7_output + adder8_input1;

	adder9_output = adder0_output + adder1_output;
	adder10_output = adder2_output + adder3_output;
	adder11_output = adder4_output + adder5_output;
	adder12_output = adder6_output + adder8_output;
	
	adder13_output = adder9_output + adder10_output;
	adder14_output = adder11_output - adder12_output; // SUBTRACTION
	
	adder15_output = adder13_output + adder14_output;
	
	
	adder15_output = adder15_output >> 8;
	
	if (counter == 0)
	begin
	done = 0;
	end
	else if (counter == 1)
	a1 = adder15_output;
	else if(counter == 2)
	a2 = adder15_output;
	else if(counter == 3)
	a3 = adder15_output;
	else if(counter == 4)
	a4 = adder15_output;
	else if(counter == 5)
	b1 = adder15_output;
	else if(counter == 6)
	b2 = adder15_output;
	else if(counter == 7)
	b3 = adder15_output;
	else if(counter == 8)
	b4 = adder15_output;
	else if(counter == 9)
	c1 = adder15_output;
	else if(counter == 10)
	c2 = adder15_output;
	else if(counter == 11)
	c3 = adder15_output;
	else if(counter == 12)
	c4 = adder15_output;
	else if(counter == 13)
	d1 = adder15_output;
	else if(counter == 14)
	d2 = adder15_output;
	else if(counter == 15)
	d3 = adder15_output;
	else if(counter == 16)
	begin
	d4 = adder15_output;
	done = 1;
	flag = 0;
	end

end
endmodule
