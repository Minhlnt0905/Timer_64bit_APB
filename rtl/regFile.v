module regFile (
	input  		clk, rst_n, wr_en, rd_en, pready, pslverr, dbg_mode,
      	input [31:0] 	wdata,
	input [11:0] 	addr,
	input [63:0] 	count,
	input wire [3:0] 	pstrb,
	output wire 		pulse_en, wr_DR0, wr_DR1, div_en, tim_int, stop, 
	output wire [3:0]	div_val,
	output wire [31:0] 	rd_data
);
	reg 		next1;
	reg [3:0] 	next;
	reg [31:0] 	tmp_rd, TCR, TCMP0, TCMP1, TIER, TISR, THCSR;
	wire 		next2, tmp_TCR, tmp_TCMP0, tmp_TCMP1, tmp_TIER, tmp_TISR, tmp_THCSR, TIER_pre, TISR_pre, THCSR_pre;
	wire [31:0]	TDR0, TDR1, TCR_pre, TCMP0_pre, TCMP1_pre;


	/*-----TCR REG---------*/
	always @(wdata or next) begin
		case (wdata[11:8]) 
			4'b0000: next = wdata[11:8];
			4'b0001: next = wdata[11:8];
			4'b0010: next = wdata[11:8];
			4'b0011: next = wdata[11:8];
			4'b0100: next = wdata[11:8];
			4'b0101: next = wdata[11:8];
			4'b0110: next = wdata[11:8];
			4'b0111: next = wdata[11:8];
			4'b1000: next = wdata[11:8];
			default: next = TCR[11:8];	
		endcase
	end
	
	assign tmp_TCR = (addr == 12'h0) & wr_en & pready & !pslverr;
	assign TCR_pre[1:0] = (tmp_TCR && pstrb[0]) ? wdata[1:0] : TCR[1:0];
	assign TCR_pre[11:8] = (tmp_TCR && pstrb[1]) ? next : TCR[11:8];

	always @(posedge clk or negedge rst_n) begin
		if (!rst_n) begin
			{TCR[11:8], TCR[1:0]} <= {4'h1, 2'h0};
		end else begin
			{TCR[11:8], TCR[1:0]} <= {TCR_pre[11:8], TCR_pre[1:0]};
		end
	end	

	assign pulse_en = TCR[0];
	assign div_en   = TCR[1];
	assign div_val  = TCR[11:8];
	
	/*------TDR0 REG-------*/
	assign wr_DR0 = (addr == 12'h4) & wr_en & pready & !pslverr;
	assign TDR0 = count[31:0];
	
	/*------TDR1 REG-------*/
	assign wr_DR1 = (addr == 12'h8) & wr_en & pready & !pslverr;
	assign TDR1 = count[63:32];

	/*------TCMP0 REG-------*/
	assign tmp_TCMP0 = (addr == 12'hc) & wr_en & pready & !pslverr;
	assign TCMP0_pre[31:24] = (tmp_TCMP0 && pstrb[3]) ? wdata[31:24] : TCMP0[31:24];
	assign TCMP0_pre[23:16] = (tmp_TCMP0 && pstrb[2]) ? wdata[23:16] : TCMP0[23:16];
	assign TCMP0_pre[15:8]  = (tmp_TCMP0 && pstrb[1]) ? wdata[15:8] : TCMP0[15:8];
	assign TCMP0_pre[7:0]   = (tmp_TCMP0 && pstrb[0]) ? wdata[7:0] : TCMP0[7:0];

	always @(posedge clk or negedge rst_n) begin
		if (!rst_n) begin
			TCMP0 <= 32'hffff_ffff;
		end else begin
			TCMP0 <= TCMP0_pre;
		end
	end

	/*------TCMP1 REG-------*/
	assign tmp_TCMP1 = (addr == 12'h10) & wr_en & pready & !pslverr;
	assign TCMP1_pre[31:24] = (tmp_TCMP1 && pstrb[3]) ? wdata[31:24] : TCMP1[31:24];
	assign TCMP1_pre[23:16] = (tmp_TCMP1 && pstrb[2]) ? wdata[23:16] : TCMP1[23:16];
	assign TCMP1_pre[15:8]  = (tmp_TCMP1 && pstrb[1]) ? wdata[15:8] : TCMP1[15:8];
	assign TCMP1_pre[7:0]   = (tmp_TCMP1 && pstrb[0]) ? wdata[7:0] : TCMP1[7:0];

	always @(posedge clk or negedge rst_n) begin
		if (!rst_n) begin
			TCMP1 <= 32'hffff_ffff;
		end else begin
			TCMP1 <= TCMP1_pre;
		end
	end

	/*------TIER------*/
	assign tmp_TIER = (addr == 12'h14) & wr_en & pready & !pslverr;
	assign TIER_pre = (tmp_TIER && pstrb[0]) ? wdata[0] : TIER[0];

	always @(posedge clk or negedge rst_n) begin
		if (!rst_n) begin
			TIER <= 32'h0;
		end else begin
			TIER[0] <= TIER_pre;
		end
	end

	/*------TISR------*/
	always @(wdata or TISR) begin
		case ({wdata[0], TISR[0]})
			2'b00: next1 = TISR[0];
			2'b01: next1 = TISR[0];
			2'b10: next1 = TISR[0];
			2'b11: next1 = 1'b0;
			default: next1 = 1'b0;
		endcase
	end 

	assign next2 = (TDR0 == TCMP0 && TDR1 == TCMP1) ? 1'b1 : TISR[0];
	assign tmp_TISR = (addr == 12'h18) & wr_en & pready & !pslverr;
	assign TISR_pre = (tmp_TISR && pstrb[0]) ? next1 : next2;

	always @(posedge clk or negedge rst_n) begin
		if (!rst_n) begin
			TISR <= 32'h0;
		end else begin
			TISR[0] <= TISR_pre;
		end
	end
	
	assign tim_int = TIER[0] & TISR[0];

	/*--------THCSR--------*/
	assign tmp_THCSR = (addr==12'h1C) & wr_en & pready & !pslverr;
	assign THCSR_pre = (tmp_THCSR && pstrb[0]) ? wdata[0] : THCSR[0];

	always @(posedge clk or negedge rst_n) begin
		if (!rst_n) begin
			THCSR <= 32'h0;
		end else begin
			THCSR[0] <= THCSR_pre;
		end
	end
	
	assign stop = dbg_mode & THCSR[0];
	always @(stop) begin
		THCSR[1] = stop;
	end

	/*----READ-----*/
	always @(addr, TCR, TDR0, TDR1, TCMP0, TCMP1, TIER, TISR, THCSR) begin
		case (addr) 
			12'h0: tmp_rd = {20'b0, TCR[11:8], 6'b0, TCR[1:0]};
			12'h4: tmp_rd = TDR0;
			12'h8: tmp_rd = TDR1;
			12'hc: tmp_rd = TCMP0;
			12'h10: tmp_rd = TCMP1;
			12'h14: tmp_rd = {31'b0, TIER[0]};
			12'h18: tmp_rd = {31'b0, TISR[0]};
			12'h1c: tmp_rd = {31'b0, THCSR[1:0]};
			default: tmp_rd = 32'h0;
		endcase 
	end
	
	assign rd_data = (rd_en && pready && !pslverr) ? tmp_rd : 32'h0;

endmodule
