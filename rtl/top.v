module top(
	input  			sys_clk, sys_rst_n, tim_pwrite, tim_psel, tim_penable, dbg_mode,
	input  	    [3:0] 	tim_pstrb,
	input  	    [11:0] 	tim_paddr,
	input  wire [31:0] 	tim_pwdata,
	output wire 		tim_pready,
	output wire 		tim_int, tim_pslverr,
	output wire [31:0] 	tim_prdata
);
	wire 	wr_en, rd_en, timer_en, wr_DR0, wr_DR1, div_en, stop;
	wire [3:0]	div_val;
	wire [63:0] 	count;

	setup 	inst_setup (
		.clk (sys_clk),
		.rst_n (sys_rst_n),
		.addr (tim_paddr),
		.pwrite (tim_pwrite),
		.pstrb (tim_pstrb),
		.psel (tim_psel),
		.penable (tim_penable),
		.wr_en (wr_en),
		.rd_en (rd_en),
		.div_en(div_en),
		.div_val (div_val),
		.wdata (tim_pwdata),
		.timer_en (timer_en),
		.pready (tim_pready),
		.pslverr (tim_pslverr)
	);

	regFile inst_reg (
		.clk(sys_clk),
		.rst_n(sys_rst_n),
		.dbg_mode (dbg_mode),
		.wr_en (wr_en), 
		.rd_en (rd_en), 
		.addr (tim_paddr), 
		.wdata (tim_pwdata), 
		.pstrb (tim_pstrb),
		.pready (tim_pready),
		.pslverr (tim_pslverr),
		.pulse_en (timer_en), 
		.wr_DR0 (wr_DR0), 
		.wr_DR1 (wr_DR1), 
		.div_en (div_en),
		.div_val (div_val),
		.stop (stop),
		.count (count),
		.tim_int (tim_int),
		.rd_data (tim_prdata)
	);

	counter inst_cnt (
		.clk (sys_clk),
		.rst_n (sys_rst_n),
		.pstrb (tim_pstrb),
		.stop (stop),
		.wdata (tim_pwdata), 
		.timer_en (timer_en), 
		.wr_DR0 (wr_DR0), 
		.wr_DR1 (wr_DR1), 
		.div_en (div_en),
		.div_val (div_val),
		.count (count)
	);
endmodule 
