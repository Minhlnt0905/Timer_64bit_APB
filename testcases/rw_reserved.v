task run_test();
	reg fail_num;
	reg [31:0] out_rd;
	begin
		fail_num = 0;
		$display("==================================================================");
		$display("==========Pat name: RESERVED CHECK=====================================");
		$display("==================================================================");
		
		test_bench.rst_n=1'b0;  
		@(posedge test_bench.clk);
		#1; test_bench.rst_n=1'b1;
		test_bench.wr_transfer(12'h1D, 32'hffff_ffff);
		test_bench.rd_transfer(12'h1D, out_rd);		
		if (out_rd == 32'h0000_0000) begin
			$display("==================================================================");
			$display("============PASSED: Read reserved is always zero, 32'h0000_0000==========");
			$display("==================================================================");
		end else begin
			$display("=====================================================================================");
			$display("============ %t FAILED: Not read reserved as zero, exp: 32'h0000_0000, actual: 32'h%h==========", $time, out_rd);
			$display("=====================================================================================");
			fail_num = fail_num + 1;
		end

		test_bench.wr_transfer(12'h50, 32'hffff_ffff);
		test_bench.rd_transfer(12'h50, out_rd);		
		if (out_rd == 32'h0000_0000) begin
			$display("==================================================================");
			$display("============PASSED: Read reserved is always zero, 32'h0000_0000==========");
			$display("==================================================================");
		end else begin
			$display("=====================================================================================");
			$display("============%t FAILED: Not read reserved as zero, exp: 32'h0000_0000, actual: 32'h%h==========", $time, out_rd);
			$display("=====================================================================================");
			fail_num = fail_num + 1;
		end

		test_bench.wr_transfer(12'h3FC, 32'hffff_ffff);
		test_bench.rd_transfer(12'h3FC, out_rd);		
		if (out_rd == 32'h0000_0000) begin
			$display("==================================================================");
			$display("============PASSED: Read reserved is always zero, 32'h0000_0000==========");
			$display("==================================================================");
		end else begin
			$display("=====================================================================================");
			$display("============%t FAILED: Not read reserved as zero, exp: 32'h0000_0000, actual: 32'h%h==========", $time, out_rd);
			$display("=====================================================================================");
			fail_num = fail_num + 1;
		end
	
		if (!fail_num) begin
			$display("Test_result PASSED");
		end else begin
			$display("Test_result FAILED");
		end
	end
endtask 
