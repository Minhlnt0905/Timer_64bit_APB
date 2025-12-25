onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /test_bench/clk
add wave -noupdate /test_bench/rst_n
add wave -noupdate /test_bench/psel
add wave -noupdate /test_bench/pwrite
add wave -noupdate /test_bench/penable
add wave -noupdate -radix hexadecimal /test_bench/pwdata
add wave -noupdate /test_bench/paddr
add wave -noupdate /test_bench/pready
add wave -noupdate -radix hexadecimal /test_bench/prdata
add wave -noupdate /test_bench/tim_int
add wave -noupdate -expand -group setup /test_bench/dut/inst_setup/wr_en
add wave -noupdate -expand -group setup /test_bench/dut/inst_setup/rd_en
add wave -noupdate -expand -group TCR -radix hexadecimal /test_bench/dut/inst_reg/TCR
add wave -noupdate -expand -group TCR -radix binary /test_bench/dut/inst_reg/TCR_pre_0
add wave -noupdate -expand -group TCR -radix binary /test_bench/dut/inst_reg/TCR_pre_1
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {376 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 223
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
WaveRestoreZoom {92 ns} {1036 ns}
