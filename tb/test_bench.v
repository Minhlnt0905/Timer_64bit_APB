module test_bench;
	reg 		clk, rst_n, psel, pwrite, penable, dbg_mode;
	reg [3:0] 	pstrb;
	reg [31:0] 	pwdata;
	reg [11:0] 	paddr;
	wire 		pready, pslverr, tim_int;
	wire [31:0] 	prdata;

	top dut (
		.sys_clk (clk),
		.sys_rst_n (rst_n),
		.dbg_mode (dbg_mode),
		.tim_pstrb (pstrb),
		.tim_pwrite (pwrite),
		.tim_psel (psel),
		.tim_penable (penable),
		.tim_pwdata (pwdata),
		.tim_paddr (paddr),
		.tim_pready (pready),
		.tim_prdata (prdata),
		.tim_int (tim_int),
		.tim_pslverr (pslverr)
	);

	`include "run_test.v"

	initial begin
		clk = 0;
		forever #25 clk = ~clk;
	end

	initial begin
		psel=1'b0;
		pwrite=1'b0;
		penable=1'b0;
		dbg_mode=1'b0;
		pstrb=4'b1111; paddr=12'h0; pwdata=0;
	end

	initial begin
		#100;
		run_test();		
		repeat(10) @(posedge clk);
		$finish;
	end


	task wr_transfer (  //reg updates its new value at the end of this transfer
		input [11:0] 	addr,
		input [31:0] 	data
	);
		begin	
			//Setup phase
			@(posedge clk);
			#1; psel=1'b1; pwrite=1'b1; paddr=addr; pwdata=data;
			//Access phase
			@(posedge clk);
			#1; penable=1'b1;
			wait (pready==1);
			//End phase
			@(posedge clk);
			#1; psel=1'b0; penable=1'b0; pwrite=1'b0;
		end
	endtask

	task rd_transfer (
		input [11:0] addr,
		output [31:0] out
	);
		begin
			//Setup phase
			@(posedge clk);
			#1; 
			psel=1'b1; 
			paddr=addr; pwrite = 1'b0; 
			//Access phase
			@(posedge clk);
			#1; penable=1'b1; 
			wait (pready==1); //rd_en is enabled
			#1; out = prdata;
			//End phase
			@(posedge clk);
			#1; psel=1'b0; penable=1'b0; 		
		end
	endtask

endmodule 
