onerror {quit -f}
vlib work
vlog -work work mips.vo
vlog -work work mips.vt
vsim -novopt -c -t 1ps -L cycloneii_ver -L altera_ver -L altera_mf_ver -L 220model_ver -L sgate work.mips_vlg_vec_tst
vcd file -direction mips.msim.vcd
vcd add -internal mips_vlg_vec_tst/*
vcd add -internal mips_vlg_vec_tst/i1/*
add wave /*
run -all
