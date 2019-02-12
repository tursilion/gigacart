SetActiveLib -work
comp -include "D:\work\TI\dragonslair\cart\cpld\design.vhd" 
comp -include "$dsn\src\TestBench\gigacart_TB.vhd" 
asim +access +r TESTBENCH_FOR_gigacart 
wave 
wave -noreg ti_adr
wave -noreg ti_data
wave -noreg ti_we
wave -noreg ti_rom
wave -noreg out_adr
wave -noreg out_data
wave -noreg out_rom
wave -noreg out_we
wave -noreg out_rom1
wave -noreg out_rom2
wave -noreg out_rom3
wave -noreg out_rom4
# The following lines can be used for timing simulation
# acom <backannotated_vhdl_file_name>
# comp -include "$dsn\src\TestBench\gigacart_TB_tim_cfg.vhd" 
# asim +access +r TIMING_FOR_gigacart 
