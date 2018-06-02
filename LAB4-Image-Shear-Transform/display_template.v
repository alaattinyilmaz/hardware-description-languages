// This module generates a synthetic image and writes it in a BlockRAM 
// After writing the image it reads back from it and sends to VGA controller
// to display it on a monitor

module display_template(clk, rst, BTN_EAST, BTN_WEST, LED1, LED2, hs, vs, R, G, B);

input clk;
input rst;
input BTN_EAST;
input BTN_WEST;
output hs;
output vs;
output LED1;
output LED2;
output R;
output G;
output B;

wire [10:0] hcount;
reg [10:0] hcount_tr_reg;
wire [10:0] vcount;
wire blank;
wire hs;
wire vs;
wire R;
wire G;
wire B;
wire [13:0] addr, addr_tr; // SRAM ADDR (16Kx1 )
wire high;
wire low;

//wire data_out;
wire [7:0] data_out;

reg [13:0] read_addr;
reg btn_east_flag, btn_west_flag;

//reg pixel_out;
reg pixel_out_r;
reg pixel_out_g;
reg pixel_out_b;
reg RESET;

assign high = 1'b1;
assign low = 1'b0;

reg prevState1;
reg prevState2;
reg LED1_flag, LED2_flag;


always @(rst)
begin
	if(rst)
	begin
		RESET <= 1;
		prevState1 <= 1'b0;
		prevState2 <= 1'b0;
	end
	else
	begin
		RESET <= 0;
		prevState1 <= btn_east_flag;
		prevState2 <= btn_west_flag;
	end
	
end

always @(BTN_EAST or BTN_WEST)
begin
	if(BTN_EAST)
	begin
		btn_east_flag <= 1'b1;
		btn_west_flag <= 1'b0;
		LED1_flag <= 1'b0;
		LED2_flag <= 1'b1;
	end
	else if(BTN_WEST)
		begin
		btn_west_flag <= 1'b1;
		btn_east_flag <= 1'b0;
		LED1_flag <= 1'b1;
		LED2_flag <= 1'b0;
	end
	else 
	begin
		btn_west_flag <= prevState2;
		btn_east_flag <= prevState1;
		LED1_flag <= prevState2;
		LED2_flag <= prevState1;
	end

end

// assign btn_east_wire = (BTN_EAST) ? a : (val==1) ?   b : 'bx ;


// This always block generates read address and read pixel values from blockram
always @(vcount or hcount or blank or data_out)
begin
	
	if ((vcount < 10'd128) && (hcount < 10'd128) && (btn_west_flag || btn_east_flag))
		read_addr = {vcount[6:0], hcount[6:0]};
	else if ((hcount[10:0]+vcount[10:0]) >= 10'd356 && (vcount <= 10'd128) && ((hcount[10:0]+vcount[10:0]) <= 10'd484) && btn_east_flag)
	begin
		hcount_tr_reg = hcount[10:0]+vcount[10:0]-10'd228;
		read_addr = {vcount[6:0], hcount_tr_reg[6:0]};
	end
	else 
		read_addr = 14'd0; // Read address uses hcount and vcount from VGA controller as read address to locate currently displayed pixel

	if (blank)
	begin	
		pixel_out_r = 1'b0;  // if blank, color outputs should be reset to 0 or black should be sent ot R,G, B ports
		pixel_out_g = 1'b0;  // if blank, color outputs should be reset to 0 or black should be sent ot R,G, B ports
		pixel_out_b = 1'b0;  // if blank, color outputs should be reset to 0 or black should be sent ot R,G, B ports
	end
	else if ((vcount < 10'd128) && (hcount < 10'd128) && (btn_west_flag || btn_east_flag)) 
	begin
		pixel_out_r = data_out[7];  // pixel values are read here
		pixel_out_g = data_out[7];
		pixel_out_b = data_out[7];
	end
	
	else if ((hcount[10:0]+vcount[10:0]) >= 10'd356 && (vcount <= 10'd128) && ((hcount[10:0]+vcount[10:0]) <= 10'd484) && btn_east_flag)
	begin
		pixel_out_r = data_out[7];  // pixel values are read here
		pixel_out_g = data_out[7];
		pixel_out_b = data_out[7];
	end

	else if (((hcount[10:0]+vcount[10:0]) < 10'd356  || ((hcount[10:0]+vcount[10:0]) > 10'd484)) && hcount > 10'd228 && hcount < 10'd484 && (vcount <= 10'd128) && btn_east_flag)
	begin
		pixel_out_r = 1'b0;  // pixel values are read here
		pixel_out_g = 1'b0;
		pixel_out_b = 1'b0;
	end
	
	else
	begin
		pixel_out_r = 1'b1; // outside of the image is white
		pixel_out_g = 1'b1; // outside of the image is white
		pixel_out_b = 1'b1; // outside of the image is white
	end
end

assign addr = read_addr;
assign R = pixel_out_r;
assign G = pixel_out_g;
assign B = pixel_out_b;
assign LED1 = LED1_flag;
assign LED2 = LED2_flag;

// Block RAM instantiation
lena_input lena_in(
	.addra(addr),
	.clka(clk),
	.douta(data_out));

// VGA controller instantiation
vga_controller_640_60 vga_cont (.clk(clk), 
				.rst(rst), 
				.HS(hs), 
				.VS(vs), 
				.hcount(hcount), 
				.vcount(vcount), 
				.blank(blank));

				
/*
// //sample blockram instantiation
 block_ram result(
 .clk(clk),
 .write_en(1),
 .read_addr(addr_tr),
 .write_addr(addr_tr),
 .write_data(data_out),
 .data_out(data_out_tr)
 );
 */

endmodule
