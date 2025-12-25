onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /test_bench/clk
add wave -noupdate /test_bench/rst_n
add wave -noupdate /test_bench/psel
add wave -noupdate /test_bench/pwrite
add wave -noupdate /test_bench/penable
add wave -noupdate /test_bench/dut/inst_reg/wr_en
add wave -noupdate /test_bench/dut/inst_reg/rd_en
add wave -noupdate -radix hexadecimal /test_bench/pwdata
add wave -noupdate -radix hexadecimal /test_bench/paddr
add wave -noupdate /test_bench/pready
add wave -noupdate /test_bench/prdata
add wave -noupdate /test_bench/tim_int
add wave -noupdate -expand -group Interrupt /test_bench/dut/inst_reg/TIER
add wave -noupdate -expand -group Interrupt /test_bench/dut/inst_reg/TISR
add wave -noupdate -expand -group Interrupt /test_bench/dut/inst_reg/tim_int
add wave -noupdate -radix hexadecimal /test_bench/dut/inst_reg/count
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {654 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 216
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
WaveRestoreZoom {0 ns} {610 ns}
