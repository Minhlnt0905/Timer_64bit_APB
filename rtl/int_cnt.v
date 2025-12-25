module int_cnt (
	input 			clk, rst_n, timer_en, div_en, wr_DR0, wr_DR1, stop, fall_edge_timer, 
	input	[3:0]		div_val,
	output 	reg  [7:0]	i
);
	reg [7:0] tmp;

	always @(div_val) begin
		tmp = (1 << div_val) - 1;
	end 

	//Internal cnt
	always @(posedge clk or  negedge rst_n) begin 
		if (!rst_n || wr_DR0 || wr_DR1 || fall_edge_timer) begin
		        i <= 0;	
		end else if (!stop && timer_en && div_en) begin
			if (i == tmp) begin
				i <= 0;
			end else i <= i + 1;
		end 
	end
endmodule
