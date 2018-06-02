module buttonCorrect(clk, button, reset, buttonCor);

input clk;
input button;
input reset;
output reg buttonCor;

reg [9:0]counter;
reg [9:0]sum2;
reg buttonC;
reg state;

always @ (posedge clk or posedge reset)
begin
if(reset)
begin
	state <= 1'b0;
	buttonCor <= 1'b0;
end
else
begin
	case(state)
		0:
		begin
		if (buttonC)
		begin
		state <= 1'b1;
		buttonCor <= 1'b1;
		end
		end
		1:
		begin
		if (!buttonC)
		state <= 1'b0;
		buttonCor <= 1'b0;
		end
	endcase
end
end

always @ (posedge clk or posedge reset)
begin
if(reset)
counter<=1'b0;
else
counter<=counter+1'b1;
end

always @ (posedge clk or posedge reset)
begin
if(reset)
sum2<=1'b0;
else if (counter==1023)
sum2<=1'b0;
else
sum2<=sum2+button;
end

always @ (posedge clk or posedge reset)
begin
	if(reset)
	buttonC<=1'b0;
	else if (sum2==0 && counter==1023)
	buttonC<=1'b0;
	else if (counter==1023 && sum2!=0)
	buttonC<=1'b1;
	else
	buttonC<=buttonC;
end

endmodule
