onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /test_bench/dut/inst_setup/psel
add wave -noupdate /test_bench/dut/inst_setup/pwrite
add wave -noupdate /test_bench/dut/inst_setup/penable
add wave -noupdate /test_bench/dut/inst_setup/clk
add wave -noupdate /test_bench/dut/inst_setup/rst_n
add wave -noupdate /test_bench/dut/inst_setup/pready
add wave -noupdate -radix binary /test_bench/dut/inst_reg/pstrb
add wave -noupdate -radix hexadecimal /test_bench/dut/inst_reg/rd_data
add wave -noupdate /test_bench/dut/inst_reg/TCR
add wave -noupdate /test_bench/dut/inst_setup/wr_en
add wave -noupdate /test_bench/dut/inst_setup/rd_en
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {374 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 227
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
WaveRestoreZoom {210 ns} {768 ns}
