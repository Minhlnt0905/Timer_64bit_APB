module setup (
	input 	 	psel, pwrite, penable, clk, rst_n, timer_en, div_en,
	input [3:0] 	div_val, pstrb,
	input [11:0] 	addr,
	input [31:0] 	wdata,
	output wire 	wr_en, rd_en, pready, pslverr
);
	wire 	apb_pre, err_st0, err_st1, err_st;
	reg 	apb_st;

	assign apb_pre = psel & penable;
	always @(posedge clk or negedge rst_n) begin
		if (!rst_n) begin
			apb_st <= 1'b0;
		end else begin
			apb_st <= apb_pre;
		end
	end
	assign pready = apb_st & psel & penable;
	assign wr_en = apb_st & pwrite & psel & penable;
	assign rd_en = apb_st & !pwrite & psel & penable;

	assign err_st0 = timer_en && (pstrb[1] && (wdata[11:8] != div_val) ||  pstrb[0] && (wdata[1] != div_en));
        assign err_st1 = pstrb[1] && (wdata[11:8] > 8);	
	assign err_st = err_st0 | err_st1;
	assign pslverr = (addr==12'h0) & wr_en & err_st;
endmodule 
