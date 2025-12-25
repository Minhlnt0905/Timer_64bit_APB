onerror {resume}
quietly virtual function -install /test_bench/dut/inst_cnt -env /test_bench/dut/inst_cnt { ((32'b00000000000000000000000000000001 << div_val[3:0] ) - 32'b00000000000000000000000000000001)} dbgTemp2_10
quietly virtual function -install /test_bench/dut/inst_reg -env /test_bench/dut/inst_reg { ( ~(bool)(rst_n ) )} dbgTemp2_17
quietly virtual function -install /test_bench/dut/inst_reg -env /test_bench/dut/inst_reg { ( ~(bool)(rst_n ) )} dbgTemp3_17
quietly WaveActivateNextPane {} 0
add wave -noupdate /test_bench/clk
add wave -noupdate /test_bench/rst_n
add wave -noupdate /test_bench/psel
add wave -noupdate /test_bench/pwrite
add wave -noupdate /test_bench/penable
add wave -noupdate -radix hexadecimal /test_bench/pwdata
add wave -noupdate /test_bench/paddr
add wave -noupdate /test_bench/pready
add wave -noupdate /test_bench/prdata
add wave -noupdate -expand -group {Controller reg} -radix hexadecimal /test_bench/dut/inst_reg/TCR
add wave -noupdate -expand -group Cnt_check -radix hexadecimal /test_bench/dut/inst_cnt/count
add wave -noupdate -expand -group Cnt_check -radix hexadecimal /test_bench/dut/inst_reg/TDR0
add wave -noupdate -expand -group Cnt_check -radix hexadecimal /test_bench/dut/inst_reg/TDR1
add wave -noupdate -expand -group Cnt_check -radix unsigned /test_bench/dut/inst_cnt/tmp
add wave -noupdate -expand -group Cnt_check -radix unsigned /test_bench/dut/inst_cnt/i
add wave -noupdate -expand -group Cnt_check /test_bench/dut/inst_cnt/div_val
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {450 ns} 0} {Trace {0 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 187
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
WaveRestoreZoom {0 ns} {1958 ns}
