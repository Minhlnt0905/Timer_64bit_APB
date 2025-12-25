module counter (
	input 			clk, rst_n, timer_en, div_en, wr_DR0, wr_DR1, stop, 
	input	[3:0]		div_val, pstrb,
	input 	[31:0]		wdata,		
	output 	wire  [63:0]	count
);
	wire [7:0] internal;
	wire       fall0, fall_edge_timer;
	reg 	   fall1;

	int_cnt inst_internal (
		.clk (clk),
		.rst_n (rst_n),
		.fall_edge_timer (fall_edge_timer),
		.stop (stop),
		.timer_en (timer_en),
		.div_en (div_en),
		.div_val (div_val),
		.wr_DR0 (wr_DR0),
		.wr_DR1 (wr_DR1),
		.i (internal)
	);
	cnt_ctrl inst_cnt_ctrl (
		.clk (clk),
		.rst_n (rst_n),
		.fall_edge_timer (fall_edge_timer),
		.pstrb (pstrb),
		.stop (stop),
		.timer_en (timer_en),
		.div_en (div_en),
		.div_val (div_val),
		.wr_DR0 (wr_DR0),
		.wr_DR1 (wr_DR1),
		.wdata (wdata),
		.i (internal),
		.count (count)	
	);

	always @(posedge clk or negedge rst_n) begin
		if (!rst_n) begin
			fall1 <= 1'b0;
		end else begin
			fall1 <= timer_en;
		end
	end
	assign fall0 = !timer_en;
	assign fall_edge_timer = fall0 & fall1;
endmodule
