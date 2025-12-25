task run_test();
	reg fail_num;
	reg [31:0] out_rd;
	begin
		fail_num = 0;
		$display("==================================================================");
		$display("==========Pat name: TIER CHECK=====================================");
		$display("==================================================================");
		test_bench.rst_n=1'b0;  
		@(posedge test_bench.clk);
		#1;test_bench.rst_n=1'b1;
				
		test_bench.rd_transfer (12'h14, out_rd);
		if (out_rd == 32'h0000_0000) begin
			$display("==================================================================");
			$display("============PASSED: Correct initial value, 32'h0000_0000==========");
			$display("==================================================================");
		end else begin
			$display("=====================================================================================");
			$display("============ %t FAILED: Wrong initial value, exp: 32'h0000_0000, actual: 32'h%h==========", $time, out_rd);
			$display("=====================================================================================");
			fail_num = fail_num + 1;
		end
		
		test_bench.wr_transfer(12'h14, 32'h0000_0000);
		test_bench.rd_transfer(12'h14, out_rd);		
		if (out_rd == 32'h0000_0000) begin
			$display("==================================================================");
			$display("============PASSED: Correct 1st write case, 32'h0000_0000==========");
			$display("==================================================================");
		end else begin
			$display("=====================================================================================");
			$display("============ %t FAILED: Wrong 1st write case, exp: 32'h0000_0000, actual: 32'h%h==========", $time, out_rd);
			$display("=====================================================================================");
			fail_num = fail_num + 1;
		end

		test_bench.wr_transfer(12'h14, 32'hffff_ffff);
		test_bench.rd_transfer(12'h14, out_rd);		
		if (out_rd == 32'h0000_0001) begin
			$display("==================================================================");
			$display("============PASSED: Correct 2nd write case, 32'h0000_0001==========");
			$display("==================================================================");
		end else begin
			$display("=====================================================================================");
			$display("============%t FAILED: Wrong 2nd write case, exp: 32'h0000_0001, actual: 32'h%h==========", $time, out_rd);
			$display("=====================================================================================");
			fail_num = fail_num + 1;
		end

		test_bench.wr_transfer(12'h14, 32'h5555_5555);
		test_bench.rd_transfer(12'h14, out_rd);		
		if (out_rd == 32'h0000_0001) begin
			$display("==================================================================");
			$display("============PASSED: Correct 3rd write case, 32'h0000_0001==========");
			$display("==================================================================");
		end else begin
			$display("=====================================================================================");
			$display("============%t FAILED: Wrong 3rd write case, exp: 32'h0000_0001, actual: 32'h%h==========", $time, out_rd);
			$display("=====================================================================================");
			fail_num = fail_num + 1;
		end
		
		test_bench.wr_transfer(12'h14, 32'haaaa_aaaa);
		test_bench.rd_transfer(12'h14, out_rd);		
		if (out_rd == 32'h0000_0000) begin
			$display("==================================================================");
			$display("============PASSED: Correct 4th write case, 32'h0000_0000==========");
			$display("==================================================================");
		end else begin
			$display("=====================================================================================");
			$display("============%t FAILED: Wrong 4th write case, exp: 32'h0000_0000, actual: 32'h%h==========", $time,  out_rd);
			$display("=====================================================================================");
			fail_num = fail_num + 1;
		end

		$display("=====================BYTE ACCESS=====================================");
		test_bench.pstrb=4'h0;
		test_bench.wr_transfer(12'h14, 32'h3333_3333);
		test_bench.rd_transfer(12'h14, out_rd);		
		if (out_rd == 32'h0000_0000) begin
			$display("==================================================================");
			$display("============PASSED: Correct 1st byte access 4'b0000 pstrb, 32'h0000_0000==========");
			$display("==================================================================");
		end else begin
			$display("=====================================================================================");
			$display("============%t FAILED: Wrong 1st byte access 4'b0000 pstrb, exp: 32'h0000_0000, actual: 32'h%h==========", $time,  out_rd);
			$display("=====================================================================================");
			fail_num = fail_num + 1;
		end

		test_bench.pstrb=4'h1;
		test_bench.wr_transfer(12'h14, 32'h4444_4444);
		test_bench.rd_transfer(12'h14, out_rd);		
		if (out_rd == 32'h0000_0000) begin
			$display("==================================================================");
			$display("============PASSED: Correct 2nd byte access 4'b0001 pstrb, 32'h0000_0000==========");
			$display("==================================================================");
		end else begin
			$display("=====================================================================================");
			$display("============%t FAILED: Wrong 2nd byte access 4'b0001 pstrb, exp: 32'h0000_0000, actual: 32'h%h==========", $time,  out_rd);
			$display("=====================================================================================");
			fail_num = fail_num + 1;
		end

		test_bench.pstrb=4'h2;
		test_bench.wr_transfer(12'h14, 32'h6666_6666);
		test_bench.rd_transfer(12'h14, out_rd);		
		if (out_rd == 32'h0000_0000) begin
			$display("==================================================================");
			$display("============PASSED: Correct 3rd byte access 4'b0010 pstrb, 32'h0000_0000==========");
			$display("==================================================================");
		end else begin
			$display("=====================================================================================");
			$display("============%t FAILED: Wrong 3rd byte access 4'b0010 pstrb, exp: 32'h0000_0000, actual: 32'h%h==========", $time,  out_rd);
			$display("=====================================================================================");
			fail_num = fail_num + 1;
		end

		test_bench.pstrb=4'h4;
		test_bench.wr_transfer(12'h14, 32'h7777_7777);
		test_bench.rd_transfer(12'h14, out_rd);		
		if (out_rd == 32'h0000_0000) begin
			$display("==================================================================");
			$display("============PASSED: Correct 4th byte access 4'b0100 pstrb, 32'h0000_0000==========");
			$display("==================================================================");
		end else begin
			$display("=====================================================================================");
			$display("============%t FAILED: Wrong 4th byte access 4'b0100 pstrb, exp: 32'h0000_0000, actual: 32'h%h==========", $time,  out_rd);
			$display("=====================================================================================");
			fail_num = fail_num + 1;
		end

		test_bench.pstrb=4'h8;
		test_bench.wr_transfer(12'h14, 32'h8888_8888);
		test_bench.rd_transfer(12'h14, out_rd);		
		if (out_rd == 32'h0000_0000) begin
			$display("==================================================================");
			$display("===========PASSED: Correct 5th byte access 4'b1000 pstrb, 32'h0000_0000==========");
			$display("==================================================================");
		end else begin
			$display("=====================================================================================");
			$display("============%t FAILED: Wrong 5th byte access 4'b1000 pstrb, exp: 32'h0000_0000, actual: 32'h%h==========", $time,  out_rd);
			$display("=====================================================================================");
			fail_num = fail_num + 1;
		end

		test_bench.pstrb=4'h3;
		test_bench.wr_transfer(12'h14, 32'h1111_1111);
		test_bench.rd_transfer(12'h14, out_rd);		
		if (out_rd == 32'h0000_0001) begin
			$display("==================================================================");
			$display("============PASSED: Correct 6th byte access 4'b0011 pstrb, 32'h0000_0001==========");
			$display("==================================================================");
		end else begin
			$display("=====================================================================================");
			$display("============%t FAILED: Wrong 6th byte access 4'b0011 pstrb, exp: 32'h0000_0001, actual: 32'h%h==========", $time,  out_rd);
			$display("=====================================================================================");
			fail_num = fail_num + 1;
		end

		test_bench.pstrb=4'h6;
		test_bench.wr_transfer(12'h14, 32'h2222_2222);
		test_bench.rd_transfer(12'h14, out_rd);		
		if (out_rd == 32'h0000_0001) begin
			$display("==================================================================");
			$display("============PASSED: Correct 7th byte access 4'b0110 pstrb, 32'h0000_0001==========");
			$display("==================================================================");
		end else begin
			$display("=====================================================================================");
			$display("============%t FAILED: Wrong 7th byte access 4'b0110 pstrb, exp: 32'h0000_0001, actual: 32'h%h==========", $time,  out_rd);
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
