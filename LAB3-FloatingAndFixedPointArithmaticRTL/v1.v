`timescale 1ns / 1ps
// 10-bit Fixed = 5bit.5bit
// 10-bit Float = 1bit.5bit.4bit

module Lab3_sample(clk, reset, BTN, SW, out);

input clk, reset;
input BTN;
input [3:0] SW;

output reg [9:0] out;

// Internal signals
reg [3:0] state;
reg [1:0] operation;
reg signed [9:0] num1,num2, num3, temp, temp1;
reg [8:0] fixedTemp;
reg signed [19:0] out_temp;

wire [5:0] mantissa1,mantissa2, mantissa3;
wire signed [3:0] exponent1,exponent2, exponent3;

reg [3:0] exponentDiff;
reg [3:0] count;
reg [6:0] mantissaOp;
reg dummy;

//always @(*) begin
//
//num1 <= SW1;
//num2 <= SW2;
//num3 <= SW3;
//count = 0;
//
//end
//
always @(posedge clk or posedge reset) 
begin
	if(reset) begin
		state <= 2'd0;
	end
	else begin
		if(BTN) begin
			state <= state + 1'd1;
		end
	end
end

always @(posedge clk or posedge reset) 
begin
	if(reset) begin
		operation <= 2'd0;
		count <= 0;
	end
	else begin
		if(BTN) begin
			case(state)
			4'd0: begin operation <= SW[1:0]; end
			4'd1: begin num1[3:0] <= SW[3:0]; end
			4'd2: begin num1[7:4] <= SW[3:0]; end
			4'd3: begin num1[9:8] <= SW[1:0]; end 
			4'd4: begin num2[3:0] <= SW[3:0]; end			
			4'd5: begin num2[7:4] <= SW[3:0]; end
			4'd6: begin num2[9:8] <= SW[1:0]; end
			4'd7: begin num3[3:0] <= SW[3:0]; end
			4'd8: begin num3[7:4] <= SW[3:0]; end
			4'd9: begin num3[9:8] <= SW[1:0]; end
			default : dummy = 0;
			endcase
		end
	end
end




assign mantissa1 = {1'b1,num1[8:4]};
assign mantissa2 = {1'b1,num2[8:4]};
assign mantissa3 = {1'b1,num3[8:4]};
	




assign exponent1 = num1[3:0];
assign exponent2 = num2[3:0];
assign exponent3 = num3[3:0];


always @(*) begin
	
	if(operation == 2'd1 && state == 4'd10)
	//FIXED POINT BEGINS HERE
	begin
	// ADDITION
		temp = num1 + num2;
	// MULTIPLICATION
		if(temp[9] == 0 & num3[9] == 0) // both are positive
		begin
		out_temp = temp[8:0] * num3[8:0];
		out[9] = 0; // assign the sign bit of output
		out[8:0] = out_temp[13:5]; // push corresponding bits to the output
		end
		else if(temp[9] == 0 & num3[9] == 1)
		begin
			temp1 = ~(num3) + 1'b1; // makes positive the num3
			out_temp = temp[8:0]*temp1[8:0]; // multiplies
			out[8:0] = out_temp[13:5]; //positive result 
			out[8:0] = ~(out[8:0]) + 1'b1; // 2's complement
			out[9] = 1; // inverts the sign
		end
		else if(temp[9] == 1 & num3[9] == 0)
		begin
			temp1 = ~(temp) + 1'b1; // makes positive the num3
			out_temp = num3[8:0]*temp1[8:0]; // multiplies
			out[8:0] = out_temp[13:5]; //positive result 
			out[8:0] = ~(out[8:0]) + 1'b1; // 2's complement
			out[9] = 1; // inverts the sign
		end
		else if(temp[9] == 1 & num3[9] == 1)
		begin
			temp = ~(temp) + 1'b1; // makes positive the sum
			temp1 = ~(num3) + 1'b1;
			out_temp = temp[8:0]*temp1[8:0]; // multiplies
			out[8:0] = out_temp[13:5]; //positive result
			out[9] = 0;
		end
		else
		begin
			dummy = 0;
		end
		
	end
	else if(operation == 2'd2 & state == 4'd10) 
	begin
	
	//FLOATING POINT BEGINS HERE
	
	// ADDITION
			if(num1[9] == num2[9]) // If same sign
			begin 
					out[9] = num1[9];
					if(exponent1 >= exponent2) 
					begin
						exponentDiff = exponent1 - exponent2;
						
						mantissaOp = mantissa1 + (mantissa2>>exponentDiff);
						if(mantissaOp[6] == 1) 
						begin // overflow
							out[8:4] = mantissaOp[5:1];
							out[3:0] = exponent1 + 1;
						end
						else 
						begin
							out[8:4] = mantissaOp[4:0];
							out[3:0] = exponent1;
						end
					end
					else 
					begin
						exponentDiff = exponent2 - exponent1;
						
						mantissaOp = mantissa2 + (mantissa1>>exponentDiff);
						if(mantissaOp[6] == 1) 
						begin // overflow
							out[8:4] = mantissaOp[5:1];
							out[3:0] = exponent2 + 1;
						end
						else 
						begin
							out[8:4] = mantissaOp[4:0];
							out[3:0] = exponent2;
						end
					end
				end
				else // different sign
				begin
					
					if( exponent1 >= exponent2 )
					begin
						exponentDiff = exponent1 - exponent2;
						
						if(num1[9]) //Num1 is negative, num2 is positive
						begin
							if(mantissa1 > (mantissa2>>exponentDiff)) // num1 magnitude is > than num2
							begin
								out[9] = 1'b1; //output is negative
								mantissaOp = mantissa1 - (mantissa2>>exponentDiff);
								if(mantissaOp[6] == 1) 
								begin // overflow
									out[8:4] = mantissaOp[5:1];
									out[3:0] = exponent1 + 1;
								end
								else 
								begin
									out[8:4] = mantissaOp[4:0];
									out[3:0] = exponent1;
								end
							end
							else // num2 magnitude is > than num1
							begin
								out[9] = 1'b0; //output is positive
								mantissaOp = - mantissa1 + (mantissa2>>exponentDiff);
								if(mantissaOp[6] == 1) 
								begin // overflow
									out[8:4] = mantissaOp[5:1];
									out[3:0] = exponent1 + 1;
								end
								else 
								begin
									out[8:4] = mantissaOp[4:0];
									out[3:0] = exponent1;
								end
							
							end
						end
						if(num2[9]) //Num2 is negative, num1 is positive
						begin
							if(mantissa1 > (mantissa2>>exponentDiff)) // num1 magnitude is > than num2
							begin
								out[9] = 1'b0; //output is positive
								mantissaOp = mantissa1 - (mantissa2>>exponentDiff);
								if(mantissaOp[6] == 1) 
								begin // overflow
									out[8:4] = mantissaOp[5:1];
									out[3:0] = exponent1 + 1;
								end
								else 
								begin
									out[8:4] = mantissaOp[4:0];
									out[3:0] = exponent1;
								end
							end
							else // num2 magnitude is > than num1
							begin
								out[9] = 1'b1; //output is negative
								mantissaOp = - mantissa1 + (mantissa2>>exponentDiff);
								if(mantissaOp[6] == 1) 
								begin // overflow
									out[8:4] = mantissaOp[5:1];
									out[3:0] = exponent1 + 1;
								end
								else 
								begin
									out[8:4] = mantissaOp[4:0];
									out[3:0] = exponent1;
								end
							
							end
						end
					
					end
					else
					begin
						exponentDiff = exponent2 - exponent1;
						
						if(num1[9]) //Num1 is negative, num2 is positive
						begin
							if(mantissa2 > (mantissa1>>exponentDiff)) // num2 magnitude is > than num1
							begin
								out[9] = 1'b0; //output is positive
								mantissaOp = mantissa2 - (mantissa1>>exponentDiff);
								if(mantissaOp[6] == 1) 
								begin // overflow
									out[8:4] = mantissaOp[5:1];
									out[3:0] = exponent2 + 1;
								end
								else 
								begin
									out[8:4] = mantissaOp[4:0];
									out[3:0] = exponent2;
								end
							end
							else // num1 magnitude is > than num2
							begin
								out[9] = 1'b1; //output is negative
								mantissaOp = - mantissa2 + (mantissa1>>exponentDiff);
								if(mantissaOp[6] == 1) 
								begin // overflow
									out[8:4] = mantissaOp[5:1];
									out[3:0] = exponent2 + 1;
								end
								else 
								begin
									out[8:4] = mantissaOp[4:0];
									out[3:0] = exponent2;
								end
							
							end
						end
						if(num2[9]) //Num2 is negative, num1 is positive
						begin
							if(mantissa2 > (mantissa1>>exponentDiff)) // num2 magnitude is > than num1
							begin
								out[9] = 1'b1; //output is negative
								mantissaOp = mantissa2 - (mantissa1>>exponentDiff);
								if(mantissaOp[6] == 1) 
								begin // overflow
									out[8:4] = mantissaOp[5:1];
									out[3:0] = exponent2 + 1;
								end
								else 
								begin
									out[8:4] = mantissaOp[4:0];
									out[3:0] = exponent2;
								end
							end
							else // num1 magnitude is > than num2
							begin
								out[9] = 1'b0; //output is positive
								mantissaOp = - mantissa2 + (mantissa1>>exponentDiff);
								if(mantissaOp[6] == 1) 
								begin // overflow
									out[8:4] = mantissaOp[5:1];
									out[3:0] = exponent2 + 1;
								end
								else 
								begin
									out[8:4] = mantissaOp[4:0];
									out[3:0] = exponent2;
								end					
							end
						end
					end			
				end	// ADDITION ENDS
				
				//MULTIPLICATION BEGIN

				out[9] = num3[9] ^ out[9]; //adjust the sign
				out_temp = {1'b1,out[8:4]}*mantissa3;
				
				if(out_temp[11] == 1)
				begin
				out_temp = out_temp >> 1;
				count = 1;
				end
				else
				begin
				dummy	= 0;
				end
				
				out[3:0] = out[3:0] + num3[3:0] + count; // exponent
				out[8:4] = out_temp[9:5];
				count = 0;
				//MULTIPLICATION END 	S
	end
	else
	begin
	dummy = 0;
	end


end
endmodule
