`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:38:17 05/19/2018 
// Design Name: 
// Module Name:    top_mod 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module top_mod(BTN, SW, Clock, Reset, LCD_Control, Data_Out);

input [3:0] SW;
input BTN;
input Clock, Reset;
output [2:0] LCD_Control;
output [3:0] Data_Out;


wire buttonOut;
wire [9:0] main_out;


buttonCorrect button(.clk(Clock), .button(BTN), .reset(Reset), .buttonCor(buttonOut));

Lab3_sample main(.clk(Clock), .reset(Reset), .BTN(buttonOut), .SW(SW), .out(main_out));

LCDI lcdi(.clk(Clock), .datain(main_out), .dataout(Data_Out), .control(LCD_Control));

endmodule
