task run_test();
	reg fail_num;
	reg [31:0] out_rd;
	begin
		fail_num = 0;
		$display("==================================================================");
		$display("==========Pat name: APB SETTING CHECK=====================================");
		$display("==================================================================");
		
		test_bench.rst_n=1'b0;  test_bench.psel=1'b1; test_bench.pwrite=1'b1; test_bench.penable = 1'b0; 
		@(posedge test_bench.clk);
		#1; test_bench.rst_n=1'b1;

		//Check wait state
			//Write transfer
		@(posedge test_bench.clk); #1;
		test_bench.psel=1'b1; test_bench.pwrite=1'b1;
		@(posedge test_bench.clk); #1;
		test_bench.penable=1'b1;
		@(posedge test_bench.clk); #1;
		if (test_bench.pready) begin
			$display("==================================================================");
			$display("============PASSED: Correct trigger APB's pready- write transfer==========");
			$display("==================================================================");
		end else begin 
			$display("==================================================================");
			$display("============%t FAILED: Wrong trigger APB's pready - write transfer==========", $time);
			$display("==================================================================");
		end

		@(posedge test_bench.clk); #1;
		test_bench.penable=1'b0; test_bench.psel=1'b0; test_bench.pwrite=1'b0;
		#1;
		if (!test_bench.pready) begin
			$display("==================================================================");
			$display("============PASSED: Correct toggle down APB's pready- write transfer==========");
			$display("==================================================================");
		end else begin 
			$display("==================================================================");
			$display("============%t FAILED: Wrong toggle down APB's pready - write transfer==========", $time);
			$display("==================================================================");
		end

			//Read transfer
		@(posedge test_bench.clk); #1;
		test_bench.psel=1'b1; test_bench.pwrite=1'b0;
		@(posedge test_bench.clk); #1;
		test_bench.penable=1'b1;
		@(posedge test_bench.clk); #1;
		if (test_bench.pready) begin
			$display("==================================================================");
			$display("============PASSED: Correct trigger APB's pready - read transfer==========");
			$display("==================================================================");
		end else begin 
			$display("==================================================================");
			$display("============%t FAILED: Wrong trigger APB's pready - read transfer==========", $time);
			$display("==================================================================");
		end

		@(posedge test_bench.clk); #1;
		test_bench.penable=1'b0; test_bench.psel=1'b0;
		#1;
		if (!test_bench.pready) begin
			$display("==================================================================");
			$display("============PASSED: Correct toggle down APB's pready- read transfer==========");
			$display("==================================================================");
		end else begin 
			$display("==================================================================");
			$display("============%t FAILED: Wrong toggle down APB's pready - read transfer==========", $time);
			$display("==================================================================");
		end


		$display("~~~~~~~~~~~~~~~ERROR RESPONSE CHECK~~~~~~~~~~~~~~");
		test_bench.pstrb=4'b1111;
		test_bench.wr_transfer(12'h0, 32'h0000_0503); //timer_en && div_val=5
		//Change div_val while timer_en
		@(posedge test_bench.clk); #1;
		test_bench.psel=1'b1; test_bench.pwrite=1'b1; test_bench.paddr=12'h0; test_bench.pwdata=32'h0000_0703;
		@(posedge test_bench.clk); #1;
		test_bench.penable=1'b1;
		wait(pready); #1;
		if (pslverr) begin
			$display("==================================================================");
			$display("============PASSED: Correct error response when modifying div_val during timer_en==========");
			$display("==================================================================");
		end else begin
			$display("==================================================================");
			$display("============%t FAILED: Wrong error response when modifying div_val during timer_en==========", $time);
			$display("==================================================================");
		end
		@(posedge test_bench.clk); #1;
		test_bench.psel=1'b0; test_bench.pwrite=1'b0; test_bench.penable=1'b0;
		
		//Change div_en while timer_en
		@(posedge test_bench.clk); #1;
		test_bench.psel=1'b1; test_bench.pwrite=1'b1; test_bench.paddr=12'h0; test_bench.pwdata=32'h0000_0701;
		@(posedge test_bench.clk); #1;
		test_bench.penable=1'b1;
		wait(pready); #1;
		if (pslverr) begin
			$display("==================================================================");
			$display("============PASSED: Correct error response when modifying div_en during timer_en==========");
			$display("==================================================================");
		end else begin
			$display("==================================================================");
			$display("============%t FAILED: Wrong error response when modifying div_en during timer_en==========", $time);
			$display("==================================================================");
		end
		@(posedge test_bench.clk); #1;
		test_bench.psel=1'b0; test_bench.pwrite=1'b0; test_bench.penable=1'b0;

		//Div_val > 8
		@(posedge test_bench.clk); #1;
		test_bench.psel=1'b1; test_bench.pwrite=1'b1; test_bench.paddr=12'h0; test_bench.pwdata=32'h0000_0c00;
		@(posedge test_bench.clk); #1;
		test_bench.penable=1'b1;
		wait(pready); #1;
		if (pslverr) begin
			$display("==================================================================");
			$display("============PASSED: Correct error response when writing prohibit div_val==========");
			$display("==================================================================");
		end else begin
			$display("==================================================================");
			$display("============%t FAILED: Wrong error response when writing prohibit div_val==========", $time);
			$display("==================================================================");
		end
		@(posedge test_bench.clk); #1;
		test_bench.psel=1'b0; test_bench.pwrite=1'b0; test_bench.penable=1'b0;



		$display("~~~~~~~~~~~~~~~WRONG APB CHECK~~~~~~~~~~~~~~");
		@(posedge test_bench.clk); #1;
		test_bench.psel=1'b1; test_bench.pwrite=1'b1; test_bench.paddr=12'h10; test_bench.pwdata=32'h0123_4567;
		@(posedge test_bench.clk); #1;
		test_bench.penable=1'b1; 
		wait(pready); test_bench.psel=1'b0; 
		@(posedge test_bench.clk); #1;
		test_bench.pwrite=1'b0; test_bench.penable=1'b0; 
		test_bench.rd_transfer(12'h10, out_rd);
		if (out_rd != 32'h0123_4567) begin
			$display("==================================================================");
			$display("============PASSED: Data is not written if setup is not successful==========");
			$display("==================================================================");
		end else begin
			$display("==================================================================");
			$display("============%t FAILED: Data is not written if setup is not successful==========", $time);
			$display("==================================================================");
		end
	
		@(posedge test_bench.clk); #1;
		test_bench.psel=1'b1; test_bench.pwrite=1'b0; test_bench.paddr=12'h10;
		@(posedge test_bench.clk); #1;
		test_bench.penable=1'b1; 
		wait(pready); test_bench.psel=1'b0; 
		@(posedge test_bench.clk); #1;
		test_bench.psel=1'b0; 
		#1;
		if (!test_bench.prdata) begin
			$display("==================================================================");
			$display("============PASSED: Data is not read if setup is not successful, as zero==========");
			$display("==================================================================");
		end else begin
			$display("==================================================================");
			$display("============%t FAILED: Data is not read if setup is not successful, expect:32'h0, actual: 32'h%h==========", $time, test_bench.prdata);
			$display("==================================================================");
		
		end

		if (!fail_num) begin
			$display("Test_result PASSED");
		end else begin
			$display("Test_result FAILED");
		end
	end
endtask 
