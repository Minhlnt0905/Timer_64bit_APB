task run_test();
	reg [3:0] 	fail_num;
	reg [31:0]	out_rd;	
	begin
		fail_num = 0;
		$display("==================================================================");
		$display("==========Pat name: INTERRUPT CHECK=====================================");
		$display("==================================================================");
		
		test_bench.rst_n = 1'b0; test_bench.psel=1'b0; test_bench.pwrite=1'b0; test_bench.penable=1'b0;
		@(posedge test_bench.clk); #1; 
		test_bench.rst_n = 1'b1;

		//Compare value [63:0]
		test_bench.wr_transfer(12'hc, 32'h0000_00ff);  //TCMP0
		test_bench.wr_transfer(12'h10, 32'h0000_0001); //TCMP1
		test_bench.wr_transfer(12'h4, 32'hffff_ff00);
		test_bench.wr_transfer(12'h0, 32'h0000_0003); 
		repeat (255+256) @(posedge test_bench.clk);
		test_bench.rd_transfer(12'h18, out_rd);
	       	if (!test_bench.tim_int && out_rd == 32'h1) begin
			$display("==================================================================");
			$display("============PASSED: Correct interrupt output without enable, LOW state==========");
			$display("==================================================================");
		end else begin
			$display("==================================================================");
			$display("============%t FAILED: Wrong interrupt output without enable, exp: 1'b0, actual: 1'b%b==========", $time, test_bench.tim_int);
			$display("==================================================================");
			fail_num = fail_num + 1;
		end	

		//Enable interrupt
		test_bench.wr_transfer(12'h14, 32'h1); //TIER
		if (test_bench.tim_int) begin
			$display("==================================================================");
			$display("============PASSED: Correct interrupt output with enable, HIGH state==========");
			$display("==================================================================");
		end else begin
			$display("==================================================================");
			$display("============%t FAILED: Wrong interrupt output with enable, exp: 1'b1, actual: 1'b%b==========", $time, test_bench.tim_int);
			$display("==================================================================");
			fail_num = fail_num + 1;
		end	

		repeat (10) @(posedge test_bench.clk);
		test_bench.wr_transfer(12'h14, 32'h0);  //mask out interrupt
		test_bench.rd_transfer(12'h18, out_rd); //int_st still high
		if (!test_bench.tim_int && out_rd == 32'h1) begin
			$display("==================================================================");
			$display("============PASSED: Correct masking out interrupt output==========");
			$display("==================================================================");
		end else begin
			$display("==================================================================");
			$display("============%t FAILED: Wrong masking out interrupt output==========", $time);
			$display("==================================================================");
		end

		test_bench.wr_transfer(12'h18, 32'h0);
		test_bench.rd_transfer(12'h18, out_rd);
		if (out_rd ==32'h1) begin
			$display("==================================================================");
			$display("============PASSED: Not clear interrupt status until write 1==========");
			$display("==================================================================");
		end else begin
			$display("==================================================================");
			$display("============%t FAILED: Clear interrupt status though not write 1==========", $time);
			$display("==================================================================");
		end

		test_bench.wr_transfer(12'h18, 32'h1); //RW1C at TISR
		test_bench.rd_transfer(12'h18, out_rd);
		if (out_rd == 32'h0) begin
			$display("==================================================================");
			$display("============PASSED: Correct clear interrupt status==========");
			$display("==================================================================");
		end else begin
			$display("==================================================================");
			$display("============%t FAILED: Wrong clear interrupt status==========", $time);
			$display("==================================================================");
		end

		test_bench.wr_transfer(12'h0, 32'h0); //Toggle down div_en to retain the current counter and cover full coverage
		test_bench.wr_transfer(12'h4, 32'h0);
		test_bench.wr_transfer(12'h8, 32'h0);

		if (!fail_num) begin
			$display("Test_result PASSED");
		end else begin
			$display("Test_result FAILED");
		end
	end
endtask
