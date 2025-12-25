onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /test_bench/dut/inst_cnt/inst_cnt_ctrl/clk
add wave -noupdate /test_bench/dut/inst_cnt/inst_cnt_ctrl/rst_n
add wave -noupdate /test_bench/dut/inst_reg/wr_en
add wave -noupdate /test_bench/dut/inst_reg/rd_en
add wave -noupdate /test_bench/dut/inst_reg/pready
add wave -noupdate /test_bench/dut/inst_cnt/inst_cnt_ctrl/wr_DR0
add wave -noupdate /test_bench/dut/inst_cnt/inst_cnt_ctrl/wr_DR1
add wave -noupdate /test_bench/dut/inst_cnt/inst_cnt_ctrl/fall_edge_timer
add wave -noupdate -radix binary /test_bench/dut/inst_cnt/inst_cnt_ctrl/pstrb
add wave -noupdate -radix hexadecimal /test_bench/dut/tim_paddr
add wave -noupdate -radix hexadecimal /test_bench/dut/inst_cnt/inst_cnt_ctrl/wdata
add wave -noupdate -radix unsigned /test_bench/dut/inst_cnt/inst_cnt_ctrl/i
add wave -noupdate -radix hexadecimal /test_bench/dut/inst_cnt/inst_cnt_ctrl/count
add wave -noupdate -radix hexadecimal /test_bench/dut/inst_reg/TDR1
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {701 ns} 0} {Trace {475 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 246
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {162 ns} {1843 ns}
