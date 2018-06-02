`timescale 1ns / 1ps

module test;

reg clk, reset;
reg BTN;
reg [3:0] SW;

wire [9:0] out;

Lab3_sample	uut(clk, reset, BTN, SW, out);

initial begin

	clk = 0;
	reset = 0;
	
	#20;

	reset = 1;
	
	#20;
	
	reset = 0;
	
	#10;
	SW = 4'b0001; // Fixed Point Arithmetic
	//SW = 4'b0010; // Floating Point Arithmetic
	BTN = 1;
	
	
	#10
	
	BTN = 0;
	
	#10	
	SW = 4'b0001; //num1 begins
	BTN = 1;
	
	#10
	
	BTN = 0;
	
	#10
	SW = 4'b0001;
	BTN = 1;
	
	#10
	
	BTN = 0;
	
	#10
	SW = 4'b0001; //num1 ends
	BTN = 1;
	
	#10
	
	BTN = 0;
	
	#10
	SW = 4'b0001; //num2 begins
	BTN = 1;
	
	#10
	
	BTN = 0;
	
	#10
	SW = 4'b0001;
	BTN = 1;
	
	#10
	
	BTN = 0;
	
	#10
	SW = 4'b0001; //num2 ends
	BTN = 1;
	
	#10
	
	BTN = 0;
	
	#10
	SW = 4'b0001; //num3 begins
	BTN = 1;
	
	#10
	
	BTN = 0;
	
	#10
	SW = 4'b0001;
	BTN = 1;
	
	#10
	
	BTN = 0;
	
	#10
	SW = 4'b0001; //num3 ends
	BTN = 1;

end

always #5 clk = !clk;
    
endmodule

