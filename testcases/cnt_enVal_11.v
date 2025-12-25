task run_test();
	reg [3:0]	fail_num;
	reg [31:0]	out_rd;
	begin
		fail_num = 0;
		$display("==================================================================");
		$display("==========Pat name: COUNTER CHECK (EN_VAL = 11)=====================================");
		$display("==================================================================");
		
		test_bench.rst_n = 1'b0;
		@(posedge test_bench.clk); #1; 
		test_bench.rst_n = 1'b1;

		/*------div_en=1 & div_val=1------*/
		test_bench.wr_transfer(12'h0, 32'h0000_0103); //timer_en is asserted
		test_bench.wr_transfer(12'h4, 32'hffff_ff00);
		repeat (255*(1 << 1) - 2) @(posedge test_bench.clk);
		test_bench.rd_transfer(12'h4, out_rd);
	       	if (out_rd == 32'hffff_ffff) begin
			$display("==================================================================");
			$display("============PASSED: Correct bound count in (4'b0001) control mode, 32'hffff_ffff==========");
			$display("==================================================================");
		end else begin
			$display("==================================================================");
			$display("============%t FAILED: Wrong bound count in (4'b0001) control mode, exp: 32'hffff_ffff, actual: 32'h%h==========", $time, out_rd);
			$display("==================================================================");
			fail_num = fail_num + 1;
		end	

		test_bench.rd_transfer(12'h4, out_rd); //Read 32-bit LSB of count that counts again after ovf
		if (out_rd < 5) begin
			$display("==================================================================");
			$display("============PASSED: Correctly count again after overflow in (4'b0001) control mode (32-bit LSB), 32'h0000_0000==========");
			$display("==================================================================");
		end else begin
			$display("==================================================================");
			$display("============%t FAILED: Wrong count again after overflow in (4'b0001) control mode (32-bit LSB), exp: 32'h0000_0000, actual: 32'h%h==========", $time, out_rd);
			$display("==================================================================");
			fail_num = fail_num + 1;
		end
		
		test_bench.rd_transfer(12'h8, out_rd); //Read 32-bit LSB of count that counts again after ovf
		if (out_rd == 32'h1) begin
			$display("==================================================================");
			$display("============PASSED: Correctly count again after overflow in (4'b0001) control mode (32-bit MSB), 32'h0000_0001==========");
			$display("==================================================================");
		end else begin
			$display("==================================================================");
			$display("============%t FAILED: Wrong count again after overflow in (4'b0001) control mode (32-bit MSB), exp: 32'h0000_0001, actual: 32'h%h==========", $time, out_rd);
			$display("==================================================================");
			fail_num = fail_num + 1;
		end

		if (!fail_num) begin
			$display("Test_result PASSED");
		end else begin
			$display("Test_result FAILED");
		end
	end
endtask
