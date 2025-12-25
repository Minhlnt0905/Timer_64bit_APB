module cnt_ctrl(
	input 			clk, rst_n, timer_en, div_en, wr_DR0, wr_DR1, stop, fall_edge_timer,  
	input	[3:0]		div_val, pstrb,
	input 	[31:0]		wdata,
	input   [7:0] 		i,	
	output 	reg  [63:0]	count
);
	reg [7:0] tmp;
	wire [64:0] count_plus, count_pre, tmp1;

	always @(div_val) begin
		tmp = (1 << div_val) - 1;
	end 

	//Cnt control
	assign count_plus = count + 1;
        assign tmp1[63:56] = (!div_en || div_en && i==tmp) ? count_plus[63:56] : count[63:56];
        assign tmp1[55:48] = (!div_en || div_en && i==tmp) ? count_plus[55:48] : count[55:48];
        assign tmp1[47:40] = (!div_en || div_en && i==tmp) ? count_plus[47:40] : count[47:40];
        assign tmp1[39:32] = (!div_en || div_en && i==tmp) ? count_plus[39:32] : count[39:32];
        assign tmp1[31:24] = (!div_en || div_en && i==tmp) ? count_plus[31:24] : count[31:24];
        assign tmp1[23:16] = (!div_en || div_en && i==tmp) ? count_plus[23:16] : count[23:16];
        assign tmp1[15:8] = (!div_en || div_en && i==tmp) ? count_plus[15:8] : count[15:8];
        assign tmp1[7:0] = (!div_en || div_en && i==tmp) ? count_plus[7:0] : count[7:0];
	/*-----TDR1-----*/
	assign count_pre[63:56] =  (wr_DR1 && pstrb[3]) ? wdata[31:24] : stop 
							? count[63:56] : timer_en
				 			? tmp1[63:56]  : count[63:56];

	assign count_pre[55:48] =  (wr_DR1 && pstrb[2])	? wdata[23:16] : stop 
							? count[55:48] : timer_en
				 			? tmp1[55:48]  : count[55:48];

	assign count_pre[47:40] =  (wr_DR1 && pstrb[1]) ? wdata[15:8]  : stop 
							? count[47:40] : timer_en   
				 			? tmp1[47:40]  : count[47:40];

	assign count_pre[39:32] =  (wr_DR1 && pstrb[0]) ? wdata[7:0]   : stop 
							? count[39:32] : timer_en 
				   			? tmp1[39:32]  : count[39:32];
	/*-----TDR0-------*/
	assign count_pre[31:24] =  (wr_DR0 && pstrb[3]) ? wdata[31:24] : stop
       							? count[31:24] : timer_en 
				 			? tmp1[31:24]  : count[31:24];

	assign count_pre[23:16] =  (wr_DR0 && pstrb[2]) ? wdata[23:16] : stop 
							? count[23:16] : timer_en
				 			? tmp1[23:16]  : count[23:16];

	assign count_pre[15:08] =  (wr_DR0 && pstrb[1]) ? wdata[15:8]  : stop
       							? count[15:08] : timer_en  
				 			? tmp1[15:8]   : count[15:08];

	assign count_pre[7:0] =    (wr_DR0 && pstrb[0]) ? wdata[7:0]   : stop
       							? count[7:0]   : timer_en
				  			? tmp1[7:0]    : count[7:0];


       always @(posedge clk or negedge rst_n) begin
		if (!rst_n || fall_edge_timer) begin
			count <= 64'b0;
		end else 
			count <= count_pre;
       end
endmodule
