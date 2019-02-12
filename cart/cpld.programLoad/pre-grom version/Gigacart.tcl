
########## Tcl recorder starts at 02/11/18 00:43:07 ##########

set version "2.0"
set proj_dir "D:/work/TI/dragonslair/cart/cpld"
cd $proj_dir

# Get directory paths
set pver $version
regsub -all {\.} $pver {_} pver
set lscfile "lsc_"
append lscfile $pver ".ini"
set lsvini_dir [lindex [array get env LSC_INI_PATH] 1]
set lsvini_path [file join $lsvini_dir $lscfile]
if {[catch {set fid [open $lsvini_path]} msg]} {
	 puts "File Open Error: $lsvini_path"
	 return false
} else {set data [read $fid]; close $fid }
foreach line [split $data '\n'] { 
	set lline [string tolower $line]
	set lline [string trim $lline]
	if {[string compare $lline "\[paths\]"] == 0} { set path 1; continue}
	if {$path && [regexp {^\[} $lline]} {set path 0; break}
	if {$path && [regexp {^bin} $lline]} {set cpld_bin $line; continue}
	if {$path && [regexp {^fpgapath} $lline]} {set fpga_dir $line; continue}
	if {$path && [regexp {^fpgabinpath} $lline]} {set fpga_bin $line}}

set cpld_bin [string range $cpld_bin [expr [string first "=" $cpld_bin]+1] end]
regsub -all "\"" $cpld_bin "" cpld_bin
set cpld_bin [file join $cpld_bin]
set install_dir [string range $cpld_bin 0 [expr [string first "ispcpld" $cpld_bin]-2]]
regsub -all "\"" $install_dir "" install_dir
set install_dir [file join $install_dir]
set fpga_dir [string range $fpga_dir [expr [string first "=" $fpga_dir]+1] end]
regsub -all "\"" $fpga_dir "" fpga_dir
set fpga_dir [file join $fpga_dir]
set fpga_bin [string range $fpga_bin [expr [string first "=" $fpga_bin]+1] end]
regsub -all "\"" $fpga_bin "" fpga_bin
set fpga_bin [file join $fpga_bin]

if {[string match "*$fpga_bin;*" $env(PATH)] == 0 } {
   set env(PATH) "$fpga_bin;$env(PATH)" }

if {[string match "*$cpld_bin;*" $env(PATH)] == 0 } {
   set env(PATH) "$cpld_bin;$env(PATH)" }

lappend auto_path [file join $install_dir "ispcpld" "tcltk" "lib" "ispwidget" "runproc"]
package require runcmd

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vhd2jhd\" design.vhd -o design.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 02/11/18 00:43:07 ###########


########## Tcl recorder starts at 02/11/18 01:13:02 ##########

# Commands to make the Process: 
# Hierarchy Browser
# - none -
# Application to view the Process: 
# Hierarchy Browser
if [runCmd "\"$cpld_bin/hierbro\" gigacart.jid  gigacart"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 02/11/18 01:13:02 ###########


########## Tcl recorder starts at 02/11/18 01:13:13 ##########

# Commands to make the Process: 
# Synplify Synthesize VHDL File
if [catch {open gigacart.cmd w} rspFile] {
	puts stderr "Cannot create response file gigacart.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: gigacart.sty
PROJECT: gigacart
WORKING_PATH: \"$proj_dir\"
MODULE: gigacart
VHDL_FILE_LIST: design.vhd
OUTPUT_FILE_NAME: gigacart
SUFFIX_NAME: edi
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DEFAULT_ENUM_ENCODING: default
ARRANGE_VHDL_FILES: true
synthesis_onoff_pragma: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -e gigacart -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete gigacart.cmd

########## Tcl recorder end at 02/11/18 01:13:13 ###########


########## Tcl recorder starts at 02/11/18 01:22:38 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vhd2jhd\" design.vhd -o design.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 02/11/18 01:22:38 ###########


########## Tcl recorder starts at 02/11/18 01:22:42 ##########

# Commands to make the Process: 
# Synplify Synthesize VHDL File
if [catch {open gigacart.cmd w} rspFile] {
	puts stderr "Cannot create response file gigacart.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: gigacart.sty
PROJECT: gigacart
WORKING_PATH: \"$proj_dir\"
MODULE: gigacart
VHDL_FILE_LIST: design.vhd
OUTPUT_FILE_NAME: gigacart
SUFFIX_NAME: edi
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DEFAULT_ENUM_ENCODING: default
ARRANGE_VHDL_FILES: true
synthesis_onoff_pragma: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -e gigacart -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete gigacart.cmd

########## Tcl recorder end at 02/11/18 01:22:42 ###########


########## Tcl recorder starts at 02/11/18 01:23:19 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vhd2jhd\" design.vhd -o design.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 02/11/18 01:23:19 ###########


########## Tcl recorder starts at 02/11/18 01:23:25 ##########

# Commands to make the Process: 
# Synplify Synthesize VHDL File
if [catch {open gigacart.cmd w} rspFile] {
	puts stderr "Cannot create response file gigacart.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: gigacart.sty
PROJECT: gigacart
WORKING_PATH: \"$proj_dir\"
MODULE: gigacart
VHDL_FILE_LIST: design.vhd
OUTPUT_FILE_NAME: gigacart
SUFFIX_NAME: edi
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DEFAULT_ENUM_ENCODING: default
ARRANGE_VHDL_FILES: true
synthesis_onoff_pragma: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -e gigacart -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete gigacart.cmd

########## Tcl recorder end at 02/11/18 01:23:25 ###########


########## Tcl recorder starts at 02/11/18 01:30:44 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vhd2jhd\" design.vhd -o design.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 02/11/18 01:30:44 ###########


########## Tcl recorder starts at 02/11/18 01:30:48 ##########

# Commands to make the Process: 
# Synplify Synthesize VHDL File
if [catch {open gigacart.cmd w} rspFile] {
	puts stderr "Cannot create response file gigacart.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: gigacart.sty
PROJECT: gigacart
WORKING_PATH: \"$proj_dir\"
MODULE: gigacart
VHDL_FILE_LIST: design.vhd
OUTPUT_FILE_NAME: gigacart
SUFFIX_NAME: edi
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DEFAULT_ENUM_ENCODING: default
ARRANGE_VHDL_FILES: true
synthesis_onoff_pragma: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -e gigacart -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete gigacart.cmd

########## Tcl recorder end at 02/11/18 01:30:48 ###########


########## Tcl recorder starts at 02/11/18 01:32:33 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vhd2jhd\" design.vhd -o design.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 02/11/18 01:32:33 ###########


########## Tcl recorder starts at 02/11/18 01:32:39 ##########

# Commands to make the Process: 
# Synplify Synthesize VHDL File
if [catch {open gigacart.cmd w} rspFile] {
	puts stderr "Cannot create response file gigacart.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: gigacart.sty
PROJECT: gigacart
WORKING_PATH: \"$proj_dir\"
MODULE: gigacart
VHDL_FILE_LIST: design.vhd
OUTPUT_FILE_NAME: gigacart
SUFFIX_NAME: edi
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DEFAULT_ENUM_ENCODING: default
ARRANGE_VHDL_FILES: true
synthesis_onoff_pragma: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -e gigacart -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete gigacart.cmd

########## Tcl recorder end at 02/11/18 01:32:39 ###########


########## Tcl recorder starts at 02/11/18 01:49:10 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vhd2jhd\" design.vhd -o design.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 02/11/18 01:49:10 ###########


########## Tcl recorder starts at 02/11/18 01:49:39 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vhd2jhd\" design.vhd -o design.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 02/11/18 01:49:39 ###########


########## Tcl recorder starts at 02/11/18 01:49:42 ##########

# Commands to make the Process: 
# Synplify Synthesize VHDL File
if [catch {open gigacart.cmd w} rspFile] {
	puts stderr "Cannot create response file gigacart.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: gigacart.sty
PROJECT: gigacart
WORKING_PATH: \"$proj_dir\"
MODULE: gigacart
VHDL_FILE_LIST: design.vhd
OUTPUT_FILE_NAME: gigacart
SUFFIX_NAME: edi
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DEFAULT_ENUM_ENCODING: default
ARRANGE_VHDL_FILES: true
synthesis_onoff_pragma: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -e gigacart -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete gigacart.cmd

########## Tcl recorder end at 02/11/18 01:49:42 ###########


########## Tcl recorder starts at 02/11/18 01:50:45 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vhd2jhd\" design.vhd -o design.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 02/11/18 01:50:45 ###########


########## Tcl recorder starts at 02/11/18 01:50:48 ##########

# Commands to make the Process: 
# Synplify Synthesize VHDL File
if [catch {open gigacart.cmd w} rspFile] {
	puts stderr "Cannot create response file gigacart.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: gigacart.sty
PROJECT: gigacart
WORKING_PATH: \"$proj_dir\"
MODULE: gigacart
VHDL_FILE_LIST: design.vhd
OUTPUT_FILE_NAME: gigacart
SUFFIX_NAME: edi
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DEFAULT_ENUM_ENCODING: default
ARRANGE_VHDL_FILES: true
synthesis_onoff_pragma: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -e gigacart -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete gigacart.cmd

########## Tcl recorder end at 02/11/18 01:50:48 ###########


########## Tcl recorder starts at 02/11/18 01:51:17 ##########

# Commands to make the Process: 
# Compile EDIF File
if [runCmd "\"$cpld_bin/edif2blf\" -edf gigacart.edi -out gigacart.bl0 -err automake.err -log gigacart.log -prj gigacart -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 02/11/18 01:51:17 ###########


########## Tcl recorder starts at 02/11/18 01:52:11 ##########

# Commands to make the Process: 
# Compiled Equations
if [runCmd "\"$cpld_bin/blif2eqn\" gigacart.bl0 -o gigacart.eq0  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 02/11/18 01:52:11 ###########


########## Tcl recorder starts at 02/11/18 01:56:40 ##########

# Commands to make the Process: 
# VHDL Test Bench Template
if [runCmd "\"$cpld_bin/vhd2naf\" -tfi -proj gigacart -mod gigacart -out gigacart -tpl \"$install_dir/ispcpld/generic/vhdl/testbnch.tft\" -ext vht design.vhd"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 02/11/18 01:56:40 ###########


########## Tcl recorder starts at 02/11/18 01:57:16 ##########

# Commands to make the Process: 
# Generate Schematic Symbol
if [runCmd "\"$cpld_bin/naf2sym\" gigacart"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 02/11/18 01:57:16 ###########


########## Tcl recorder starts at 02/11/18 01:57:25 ##########

# Commands to make the Process: 
# ABEL Test Vector Template
if [runCmd "\"$cpld_bin/vhd2naf\" -tfi -proj gigacart -mod gigacart -out gigacart -tpl \"$install_dir/ispcpld/plsi/abel/plsiabt.tft\" -ext abt -p \"$install_dir/ispcpld/generic\" design.vhd"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 02/11/18 01:57:25 ###########


########## Tcl recorder starts at 02/11/18 01:58:23 ##########

# Commands to make the Process: 
# Generate Synthesize Tool Tcl Script
if [catch {open gigacart.cmd w} rspFile] {
	puts stderr "Cannot create response file gigacart.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: gigacart.sty
PROJECT: gigacart
WORKING_PATH: \"$proj_dir\"
MODULE: gigacart
VHDL_FILE_LIST: design.vhd
OUTPUT_FILE_NAME: gigacart
SUFFIX_NAME: edi
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DEFAULT_ENUM_ENCODING: default
ARRANGE_VHDL_FILES: true
synthesis_onoff_pragma: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -scriptonly \"gigacart_synplify.tcl\" -e gigacart -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete gigacart.cmd
# Application to view the Process: 
# Generate Synthesize Tool Tcl Script
if [runCmd "\"$cpld_bin/synedit\" -i \"gigacart_synplify.tcl\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 02/11/18 01:58:23 ###########


########## Tcl recorder starts at 02/11/18 01:58:51 ##########

# Commands to make the Process: 
# Aldec VHDL Functional Simulation
if [catch {open udo.rsp w} rspFile] {
	puts stderr "Cannot create response file udo.rsp: $rspFile"
} else {
	puts $rspFile "# ispDesignExpert VHDL Functional Simulation Template: testbench_vhdaf.udo.
# You may edit this file to control your simulation.
# You may specify your design unit.
# You may specify your waveforms.
add wave *
# You may specify your simulation run time.
run 1000 ns
"
	close $rspFile
}
if [catch {open testbench.rsp w} rspFile] {
	puts stderr "Cannot create response file testbench.rsp: $rspFile"
} else {
	puts $rspFile "#simulator Aldec
#insert # NOTE: Do not edit this file.
#insert # Auto generated by VHDL Functional Simulation Models
#insert #
#insert design create work .
#insert design open work
#insert adel -all
#path
#insert source {$cpld_bin/chipsim_cmd.tcl}
#prjInfo gigacart.sty
#do 
#vcomSrc   design.vhd
#vcom testbench.vhd
#stimulus vhdl gigacart testbench.vhd
#insert vsim +access +r %<StimModule>%
#youdo testbench_vhdaf.udo
#insert # End
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/chipsim\" testbench.rsp testbench.fado udo.rsp"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete udo.rsp
file delete testbench.rsp
# Application to view the Process: 
# Aldec VHDL Functional Simulation
if [catch {open testbench_activehdl.do w} rspFile] {
	puts stderr "Cannot create response file testbench_activehdl.do: $rspFile"
} else {
	puts $rspFile "set SIM_WORKING_FOLDER .
do -tcl testbench.fado
"
	close $rspFile
}
if [runCmd "\"$install_dir/active-hdl/BIN/avhdl\" -do \"testbench_activehdl.do\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 02/11/18 01:58:51 ###########


########## Tcl recorder starts at 02/11/18 02:02:25 ##########

# Commands to make the Process: 
# Aldec VHDL Functional Simulation
if [catch {open udo.rsp w} rspFile] {
	puts stderr "Cannot create response file udo.rsp: $rspFile"
} else {
	puts $rspFile "# ispDesignExpert VHDL Functional Simulation Template: testbench_vhdaf.udo.
# You may edit this file to control your simulation.
# You may specify your design unit.
# You may specify your waveforms.
add wave *
# You may specify your simulation run time.
run 1000 ns
"
	close $rspFile
}
if [catch {open testbench.rsp w} rspFile] {
	puts stderr "Cannot create response file testbench.rsp: $rspFile"
} else {
	puts $rspFile "#simulator Aldec
#insert # NOTE: Do not edit this file.
#insert # Auto generated by VHDL Functional Simulation Models
#insert #
#insert design create work .
#insert design open work
#insert adel -all
#path
#insert source {$cpld_bin/chipsim_cmd.tcl}
#prjInfo gigacart.sty
#do 
#vcomSrc   design.vhd
#vcom testbench.vhd
#stimulus vhdl gigacart testbench.vhd
#insert vsim +access +r %<StimModule>%
#youdo testbench_vhdaf.udo
#insert # End
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/chipsim\" testbench.rsp testbench.fado udo.rsp"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete udo.rsp
file delete testbench.rsp
# Application to view the Process: 
# Aldec VHDL Functional Simulation
if [catch {open testbench_activehdl.do w} rspFile] {
	puts stderr "Cannot create response file testbench_activehdl.do: $rspFile"
} else {
	puts $rspFile "set SIM_WORKING_FOLDER .
do -tcl testbench.fado
"
	close $rspFile
}
if [runCmd "\"$install_dir/active-hdl/BIN/avhdl\" -do \"testbench_activehdl.do\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 02/11/18 02:02:25 ###########


########## Tcl recorder starts at 02/11/18 02:10:20 ##########

# Commands to make the Process: 
# Aldec VHDL Functional Simulation
if [catch {open udo.rsp w} rspFile] {
	puts stderr "Cannot create response file udo.rsp: $rspFile"
} else {
	puts $rspFile "# ispDesignExpert VHDL Functional Simulation Template: testbench_vhdaf.udo.
# You may edit this file to control your simulation.
# You may specify your design unit.
# You may specify your waveforms.
add wave *
# You may specify your simulation run time.
run 1000 ns
"
	close $rspFile
}
if [catch {open testbench.rsp w} rspFile] {
	puts stderr "Cannot create response file testbench.rsp: $rspFile"
} else {
	puts $rspFile "#simulator Aldec
#insert # NOTE: Do not edit this file.
#insert # Auto generated by VHDL Functional Simulation Models
#insert #
#insert design create work .
#insert design open work
#insert adel -all
#path
#insert source {$cpld_bin/chipsim_cmd.tcl}
#prjInfo gigacart.sty
#do 
#vcomSrc   design.vhd
#vcom testbench.vhd
#stimulus vhdl gigacart testbench.vhd
#insert vsim +access +r %<StimModule>%
#youdo testbench_vhdaf.udo
#insert # End
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/chipsim\" testbench.rsp testbench.fado udo.rsp"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete udo.rsp
file delete testbench.rsp
# Application to view the Process: 
# Aldec VHDL Functional Simulation
if [catch {open testbench_activehdl.do w} rspFile] {
	puts stderr "Cannot create response file testbench_activehdl.do: $rspFile"
} else {
	puts $rspFile "set SIM_WORKING_FOLDER .
do -tcl testbench.fado
"
	close $rspFile
}
if [runCmd "\"$install_dir/active-hdl/BIN/avhdl\" -do \"testbench_activehdl.do\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 02/11/18 02:10:20 ###########


########## Tcl recorder starts at 02/11/18 02:17:29 ##########

# Commands to make the Process: 
# Aldec VHDL Functional Simulation
if [catch {open udo.rsp w} rspFile] {
	puts stderr "Cannot create response file udo.rsp: $rspFile"
} else {
	puts $rspFile "# ispDesignExpert VHDL Functional Simulation Template: testbench_vhdaf.udo.
# You may edit this file to control your simulation.
# You may specify your design unit.
# You may specify your waveforms.
add wave *
# You may specify your simulation run time.
run 1000 ns
"
	close $rspFile
}
if [catch {open testbench.rsp w} rspFile] {
	puts stderr "Cannot create response file testbench.rsp: $rspFile"
} else {
	puts $rspFile "#simulator Aldec
#insert # NOTE: Do not edit this file.
#insert # Auto generated by VHDL Functional Simulation Models
#insert #
#insert design create work .
#insert design open work
#insert adel -all
#path
#insert source {$cpld_bin/chipsim_cmd.tcl}
#prjInfo gigacart.sty
#do 
#vcomSrc   design.vhd
#vcom testbench.vhd
#stimulus vhdl gigacart testbench.vhd
#insert vsim +access +r %<StimModule>%
#youdo testbench_vhdaf.udo
#insert # End
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/chipsim\" testbench.rsp testbench.fado udo.rsp"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete udo.rsp
file delete testbench.rsp
# Application to view the Process: 
# Aldec VHDL Functional Simulation
if [catch {open testbench_activehdl.do w} rspFile] {
	puts stderr "Cannot create response file testbench_activehdl.do: $rspFile"
} else {
	puts $rspFile "set SIM_WORKING_FOLDER .
do -tcl testbench.fado
"
	close $rspFile
}
if [runCmd "\"$install_dir/active-hdl/BIN/avhdl\" -do \"testbench_activehdl.do\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 02/11/18 02:17:29 ###########


########## Tcl recorder starts at 02/11/18 02:26:21 ##########

# Commands to make the Process: 
# Aldec VHDL Functional Simulation
if [catch {open udo.rsp w} rspFile] {
	puts stderr "Cannot create response file udo.rsp: $rspFile"
} else {
	puts $rspFile "# ispDesignExpert VHDL Functional Simulation Template: testbench_vhdaf.udo.
# You may edit this file to control your simulation.
# You may specify your design unit.
# You may specify your waveforms.
add wave *
# You may specify your simulation run time.
run 1000 ns
"
	close $rspFile
}
if [catch {open testbench.rsp w} rspFile] {
	puts stderr "Cannot create response file testbench.rsp: $rspFile"
} else {
	puts $rspFile "#simulator Aldec
#insert # NOTE: Do not edit this file.
#insert # Auto generated by VHDL Functional Simulation Models
#insert #
#insert design create work .
#insert design open work
#insert adel -all
#path
#insert source {$cpld_bin/chipsim_cmd.tcl}
#prjInfo gigacart.sty
#do 
#vcomSrc   design.vhd
#vcom testbench.vhd
#stimulus vhdl gigacart testbench.vhd
#insert vsim +access +r %<StimModule>%
#youdo testbench_vhdaf.udo
#insert # End
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/chipsim\" testbench.rsp testbench.fado udo.rsp"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete udo.rsp
file delete testbench.rsp
# Application to view the Process: 
# Aldec VHDL Functional Simulation
if [catch {open testbench_activehdl.do w} rspFile] {
	puts stderr "Cannot create response file testbench_activehdl.do: $rspFile"
} else {
	puts $rspFile "set SIM_WORKING_FOLDER .
do -tcl testbench.fado
"
	close $rspFile
}
if [runCmd "\"$install_dir/active-hdl/BIN/avhdl\" -do \"testbench_activehdl.do\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 02/11/18 02:26:21 ###########


########## Tcl recorder starts at 02/11/18 02:51:28 ##########

# Commands to make the Process: 
# Optimization Constraint
if [runCmd "\"$cpld_bin/mblifopt\" gigacart.bl0 -collapse none -reduce none -keepwires  -err automake.err -family"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"gigacart.bl1\" -o \"gigacart.bl2\" -omod \"gigacart\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj gigacart -lci gigacart.lct -log gigacart.imp -err automake.err -tti gigacart.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
# Application to view the Process: 
# Optimization Constraint
if [catch {open opt_cmd.rs2 w} rspFile] {
	puts stderr "Cannot create response file opt_cmd.rs2: $rspFile"
} else {
	puts $rspFile "-global -lci gigacart.lct -touch gigacart.imp
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/optedit\" @opt_cmd.rs2"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 02/11/18 02:51:28 ###########


########## Tcl recorder starts at 02/11/18 02:52:13 ##########

# Commands to make the Process: 
# Constraint Editor
if [runCmd "\"$cpld_bin/abelvci\" -vci gigacart.lct -blifopt gigacart.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" gigacart.bl2 -sweep -mergefb -err automake.err -o gigacart.bl3 @gigacart.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci gigacart.lct -dev lc4k -diofft gigacart.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" gigacart.bl3 -family AMDMACH -idev van -o gigacart.bl4 -oxrf gigacart.xrf -err automake.err @gigacart.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci gigacart.lct -dev lc4k -prefit gigacart.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp gigacart.bl4 -out gigacart.bl5 -err automake.err -log gigacart.log -mod gigacart @gigacart.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/blifstat\" -i gigacart.bl5 -o gigacart.sif"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
# Application to view the Process: 
# Constraint Editor
if [catch {open lattice_cmd.rs2 w} rspFile] {
	puts stderr "Cannot create response file lattice_cmd.rs2: $rspFile"
} else {
	puts $rspFile "-nodal -src gigacart.bl5 -type BLIF -presrc gigacart.bl3 -crf gigacart.crf -sif gigacart.sif -devfile \"$install_dir/ispcpld/dat/lc4k/m4s_64_64.dev\" -lci gigacart.lct
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lciedit\" @lattice_cmd.rs2"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 02/11/18 02:52:13 ###########


########## Tcl recorder starts at 02/11/18 03:04:09 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open gigacart.rs1 w} rspFile] {
	puts stderr "Cannot create response file gigacart.rs1: $rspFile"
} else {
	puts $rspFile "-i gigacart.bl5 -lci gigacart.lct -d m4s_64_64 -lco gigacart.lco -html_rpt -fti gigacart.fti -fmt PLA -tto gigacart.tt4 -nojed -eqn gigacart.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open gigacart.rs2 w} rspFile] {
	puts stderr "Cannot create response file gigacart.rs2: $rspFile"
} else {
	puts $rspFile "-i gigacart.bl5 -lci gigacart.lct -d m4s_64_64 -lco gigacart.lco -html_rpt -fti gigacart.fti -fmt PLA -tto gigacart.tt4 -eqn gigacart.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@gigacart.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete gigacart.rs1
file delete gigacart.rs2
if [runCmd "\"$cpld_bin/tda\" -i gigacart.bl5 -o gigacart.tda -lci gigacart.lct -dev m4s_64_64 -family lc4k -mod gigacart -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj gigacart -if gigacart.jed -j2s -log gigacart.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 02/11/18 03:04:09 ###########


########## Tcl recorder starts at 02/11/18 03:04:31 ##########

# Commands to make the Process: 
# Pre-Fit Equations
if [runCmd "\"$cpld_bin/blif2eqn\" gigacart.bl5 -o gigacart.eq2 -use_short -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 02/11/18 03:04:31 ###########


########## Tcl recorder starts at 02/11/18 03:07:02 ##########

# Commands to make the Process: 
# Fitter Report (Text)
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj gigacart -if gigacart.jed -j2s -log gigacart.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 02/11/18 03:07:02 ###########


########## Tcl recorder starts at 02/11/18 03:16:17 ##########

# Commands to make the Process: 
# Post-Fit Pinouts
# - none -
# Application to view the Process: 
# Post-Fit Pinouts
if [catch {open lattice_cmd.rs2 w} rspFile] {
	puts stderr "Cannot create response file lattice_cmd.rs2: $rspFile"
} else {
	puts $rspFile "-src gigacart.tt4 -type PLA -devfile \"$install_dir/ispcpld/dat/lc4k/m4s_64_64.dev\" -postfit -lci gigacart.lco
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lciedit\" @lattice_cmd.rs2"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 02/11/18 03:16:17 ###########


########## Tcl recorder starts at 02/11/18 03:16:35 ##########

# Commands to make the Process: 
# Post-Fit Re-Compile
# - none -
# Application to view the Process: 
# Post-Fit Re-Compile
if [catch {open lattice_cmd.rs2 w} rspFile] {
	puts stderr "Cannot create response file lattice_cmd.rs2: $rspFile"
} else {
	puts $rspFile "-src gigacart.bl5 -type BLIF -devfile \"$install_dir/ispcpld/dat/lc4k/m4s_64_64.dev\" -lci gigacart.lct -prc gigacart.lco -log gigacart.log -touch gigacart.fti
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lciedit\" @lattice_cmd.rs2"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 02/11/18 03:16:35 ###########


########## Tcl recorder starts at 02/11/18 03:16:41 ##########

# Commands to make the Process: 
# JEDEC File
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj gigacart -if gigacart.jed -j2s -log gigacart.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 02/11/18 03:16:41 ###########


########## Tcl recorder starts at 02/11/18 03:16:46 ##########

# Commands to make the Process: 
# ISC-1532 File
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj gigacart -if gigacart.jed -j2i "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 02/11/18 03:16:46 ###########


########## Tcl recorder starts at 02/11/18 03:16:52 ##########

# Commands to make the Process: 
# Timing Report
if [runCmd "\"$cpld_bin/timer\" -inp \"gigacart.tt4\" -lci \"gigacart.lct\" -trp \"gigacart.trp\" -exf \"gigacart.exf\" -lco \"gigacart.lco\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 02/11/18 03:16:52 ###########


########## Tcl recorder starts at 02/11/18 03:18:04 ##########

# Commands to make the Process: 
# Report File
if [catch {open gigacart.rsp w} rspFile] {
	puts stderr "Cannot create response file gigacart.rsp: $rspFile"
} else {
	puts $rspFile "-i gigacart.tt4 -lib \"$install_dir/ispcpld/dat/lc4k\" -strategy top -sdfmdl \"$install_dir/ispcpld/dat/sdf.mdl\" -pla gigacart.tt4 -lci gigacart.lct -prj gigacart -dir \"$proj_dir\" -err automake.err -log gigacart.nrp -exf gigacart.exf 
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/sdf\" @gigacart.rsp"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete gigacart.rsp

########## Tcl recorder end at 02/11/18 03:18:04 ###########


########## Tcl recorder starts at 02/11/18 03:18:17 ##########

# Commands to make the Process: 
# Stamp Model File
if [runCmd "\"$cpld_bin/timer\" -inp \"gigacart.tt4\" -lci \"gigacart.lct\" -stamp \"gigacart.stamp\" -exf \"gigacart.exf\" -lco \"gigacart.lco\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/stamppar\" -i gigacart.stamp "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 02/11/18 03:18:17 ###########


########## Tcl recorder starts at 03/01/18 22:35:30 ##########

# Commands to make the Process: 
# Aldec VHDL Functional Simulation
if [catch {open udo.rsp w} rspFile] {
	puts stderr "Cannot create response file udo.rsp: $rspFile"
} else {
	puts $rspFile "# ispDesignExpert VHDL Functional Simulation Template: testbench_vhdaf.udo.
# You may edit this file to control your simulation.
# You may specify your design unit.
# You may specify your waveforms.
add wave *
# You may specify your simulation run time.
run 1000 ns
"
	close $rspFile
}
if [catch {open testbench.rsp w} rspFile] {
	puts stderr "Cannot create response file testbench.rsp: $rspFile"
} else {
	puts $rspFile "#simulator Aldec
#insert # NOTE: Do not edit this file.
#insert # Auto generated by VHDL Functional Simulation Models
#insert #
#insert design create work .
#insert design open work
#insert adel -all
#path
#insert source {$cpld_bin/chipsim_cmd.tcl}
#prjInfo gigacart.sty
#do 
#vcomSrc   design.vhd
#vcom testbench.vhd
#stimulus vhdl gigacart testbench.vhd
#insert vsim +access +r %<StimModule>%
#youdo testbench_vhdaf.udo
#insert # End
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/chipsim\" testbench.rsp testbench.fado udo.rsp"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete udo.rsp
file delete testbench.rsp
# Application to view the Process: 
# Aldec VHDL Functional Simulation
if [catch {open testbench_activehdl.do w} rspFile] {
	puts stderr "Cannot create response file testbench_activehdl.do: $rspFile"
} else {
	puts $rspFile "set SIM_WORKING_FOLDER .
do -tcl testbench.fado
"
	close $rspFile
}
if [runCmd "\"$install_dir/active-hdl/BIN/avhdl\" -do \"testbench_activehdl.do\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/01/18 22:35:30 ###########


########## Tcl recorder starts at 03/01/18 22:46:42 ##########

# Commands to make the Process: 
# Optimization Constraint
# - none -
# Application to view the Process: 
# Optimization Constraint
if [catch {open opt_cmd.rs2 w} rspFile] {
	puts stderr "Cannot create response file opt_cmd.rs2: $rspFile"
} else {
	puts $rspFile "-global -lci gigacart.lct -touch gigacart.imp
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/optedit\" @opt_cmd.rs2"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/01/18 22:46:42 ###########


########## Tcl recorder starts at 03/01/18 22:47:43 ##########

# Commands to make the Process: 
# Constraint Editor
if [runCmd "\"$cpld_bin/abelvci\" -vci gigacart.lct -blifopt gigacart.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" gigacart.bl2 -sweep -mergefb -err automake.err -o gigacart.bl3 @gigacart.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci gigacart.lct -dev lc4k -diofft gigacart.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" gigacart.bl3 -family AMDMACH -idev van -o gigacart.bl4 -oxrf gigacart.xrf -err automake.err @gigacart.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci gigacart.lct -dev lc4k -prefit gigacart.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp gigacart.bl4 -out gigacart.bl5 -err automake.err -log gigacart.log -mod gigacart @gigacart.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/blifstat\" -i gigacart.bl5 -o gigacart.sif"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
# Application to view the Process: 
# Constraint Editor
if [catch {open lattice_cmd.rs2 w} rspFile] {
	puts stderr "Cannot create response file lattice_cmd.rs2: $rspFile"
} else {
	puts $rspFile "-nodal -src gigacart.bl5 -type BLIF -presrc gigacart.bl3 -crf gigacart.crf -sif gigacart.sif -devfile \"$install_dir/ispcpld/dat/lc4k/m4s_64_64.dev\" -lci gigacart.lct
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lciedit\" @lattice_cmd.rs2"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/01/18 22:47:43 ###########


########## Tcl recorder starts at 03/01/18 23:58:09 ##########

# Commands to make the Process: 
# Pre-Fit Equations
if [runCmd "\"$cpld_bin/blif2eqn\" gigacart.bl5 -o gigacart.eq2 -use_short -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/01/18 23:58:09 ###########


########## Tcl recorder starts at 03/01/18 23:58:42 ##########

# Commands to make the Process: 
# Fitter Report (Text)
if [catch {open gigacart.rs1 w} rspFile] {
	puts stderr "Cannot create response file gigacart.rs1: $rspFile"
} else {
	puts $rspFile "-i gigacart.bl5 -lci gigacart.lct -d m4s_64_64 -lco gigacart.lco -html_rpt -fti gigacart.fti -fmt PLA -tto gigacart.tt4 -nojed -eqn gigacart.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open gigacart.rs2 w} rspFile] {
	puts stderr "Cannot create response file gigacart.rs2: $rspFile"
} else {
	puts $rspFile "-i gigacart.bl5 -lci gigacart.lct -d m4s_64_64 -lco gigacart.lco -html_rpt -fti gigacart.fti -fmt PLA -tto gigacart.tt4 -eqn gigacart.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@gigacart.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete gigacart.rs1
file delete gigacart.rs2
if [runCmd "\"$cpld_bin/tda\" -i gigacart.bl5 -o gigacart.tda -lci gigacart.lct -dev m4s_64_64 -family lc4k -mod gigacart -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj gigacart -if gigacart.jed -j2s -log gigacart.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/01/18 23:58:42 ###########


########## Tcl recorder starts at 03/02/18 00:00:00 ##########

# Commands to make the Process: 
# Post-Fit Pinouts
# - none -
# Application to view the Process: 
# Post-Fit Pinouts
if [catch {open lattice_cmd.rs2 w} rspFile] {
	puts stderr "Cannot create response file lattice_cmd.rs2: $rspFile"
} else {
	puts $rspFile "-src gigacart.tt4 -type PLA -devfile \"$install_dir/ispcpld/dat/lc4k/m4s_64_64.dev\" -postfit -lci gigacart.lco
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lciedit\" @lattice_cmd.rs2"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/02/18 00:00:00 ###########


########## Tcl recorder starts at 03/02/18 00:00:09 ##########

# Commands to make the Process: 
# Post-Fit Re-Compile
# - none -
# Application to view the Process: 
# Post-Fit Re-Compile
if [catch {open lattice_cmd.rs2 w} rspFile] {
	puts stderr "Cannot create response file lattice_cmd.rs2: $rspFile"
} else {
	puts $rspFile "-src gigacart.bl5 -type BLIF -devfile \"$install_dir/ispcpld/dat/lc4k/m4s_64_64.dev\" -lci gigacart.lct -prc gigacart.lco -log gigacart.log -touch gigacart.fti
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lciedit\" @lattice_cmd.rs2"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/02/18 00:00:09 ###########


########## Tcl recorder starts at 03/02/18 00:00:16 ##########

# Commands to make the Process: 
# JEDEC File
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj gigacart -if gigacart.jed -j2s -log gigacart.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/02/18 00:00:16 ###########


########## Tcl recorder starts at 03/02/18 00:00:19 ##########

# Commands to make the Process: 
# ISC-1532 File
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj gigacart -if gigacart.jed -j2i "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/02/18 00:00:19 ###########


########## Tcl recorder starts at 03/02/18 00:00:25 ##########

# Commands to make the Process: 
# Timing Analysis
# - none -
# Application to view the Process: 
# Timing Analysis
if [runCmd "\"$cpld_bin/timing\" -prj \"gigacart\" -tti \"gigacart.tt4\" -gui -dir \"$proj_dir\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/02/18 00:00:25 ###########


########## Tcl recorder starts at 03/02/18 00:00:33 ##########

# Commands to make the Process: 
# Timing Report
if [runCmd "\"$cpld_bin/timer\" -inp \"gigacart.tt4\" -lci \"gigacart.lct\" -trp \"gigacart.trp\" -exf \"gigacart.exf\" -lco \"gigacart.lco\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/02/18 00:00:33 ###########


########## Tcl recorder starts at 03/02/18 00:00:47 ##########

# Commands to make the Process: 
# Generate Timing Simulation Files
if [catch {open gigacart.rsp w} rspFile] {
	puts stderr "Cannot create response file gigacart.rsp: $rspFile"
} else {
	puts $rspFile "-i gigacart.tt4 -lib \"$install_dir/ispcpld/dat/lc4k\" -strategy top -sdfmdl \"$install_dir/ispcpld/dat/sdf.mdl\" -pla gigacart.tt4 -lci gigacart.lct -prj gigacart -dir \"$proj_dir\" -err automake.err -log gigacart.nrp -exf gigacart.exf 
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/sdf\" @gigacart.rsp"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete gigacart.rsp

########## Tcl recorder end at 03/02/18 00:00:47 ###########


########## Tcl recorder starts at 03/02/18 00:00:57 ##########

# Commands to make the Process: 
# Generate Board-level Stamp Model
if [runCmd "\"$cpld_bin/timer\" -inp \"gigacart.tt4\" -lci \"gigacart.lct\" -stamp \"gigacart.stamp\" -exf \"gigacart.exf\" -lco \"gigacart.lco\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/stamppar\" -i gigacart.stamp "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/02/18 00:00:57 ###########


########## Tcl recorder starts at 03/13/18 22:58:14 ##########

# Commands to make the Process: 
# Post-Fit Pinouts
# - none -
# Application to view the Process: 
# Post-Fit Pinouts
if [catch {open lattice_cmd.rs2 w} rspFile] {
	puts stderr "Cannot create response file lattice_cmd.rs2: $rspFile"
} else {
	puts $rspFile "-src gigacart.tt4 -type PLA -devfile \"$install_dir/ispcpld/dat/lc4k/m4s_64_64.dev\" -postfit -lci gigacart.lco
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lciedit\" @lattice_cmd.rs2"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/13/18 22:58:14 ###########


########## Tcl recorder starts at 03/13/18 23:08:45 ##########

# Commands to make the Process: 
# Optimization Constraint
# - none -
# Application to view the Process: 
# Optimization Constraint
if [catch {open opt_cmd.rs2 w} rspFile] {
	puts stderr "Cannot create response file opt_cmd.rs2: $rspFile"
} else {
	puts $rspFile "-global -lci gigacart.lct -touch gigacart.imp
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/optedit\" @opt_cmd.rs2"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/13/18 23:08:45 ###########


########## Tcl recorder starts at 03/13/18 23:09:01 ##########

# Commands to make the Process: 
# Constraint Editor
if [runCmd "\"$cpld_bin/blifstat\" -i gigacart.bl5 -o gigacart.sif"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
# Application to view the Process: 
# Constraint Editor
if [catch {open lattice_cmd.rs2 w} rspFile] {
	puts stderr "Cannot create response file lattice_cmd.rs2: $rspFile"
} else {
	puts $rspFile "-nodal -src gigacart.bl5 -type BLIF -presrc gigacart.bl3 -crf gigacart.crf -sif gigacart.sif -devfile \"$install_dir/ispcpld/dat/lc4k/m4s_64_64.dev\" -lci gigacart.lct
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lciedit\" @lattice_cmd.rs2"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/13/18 23:09:01 ###########


########## Tcl recorder starts at 03/14/18 21:00:09 ##########

# Commands to make the Process: 
# Post-Fit Pinouts
# - none -
# Application to view the Process: 
# Post-Fit Pinouts
if [catch {open lattice_cmd.rs2 w} rspFile] {
	puts stderr "Cannot create response file lattice_cmd.rs2: $rspFile"
} else {
	puts $rspFile "-src gigacart.tt4 -type PLA -devfile \"$install_dir/ispcpld/dat/lc4k/m4s_64_64.dev\" -postfit -lci gigacart.lco
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lciedit\" @lattice_cmd.rs2"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/14/18 21:00:09 ###########


########## Tcl recorder starts at 03/14/18 21:01:02 ##########

# Commands to make the Process: 
# Constraint Editor
# - none -
# Application to view the Process: 
# Constraint Editor
if [catch {open lattice_cmd.rs2 w} rspFile] {
	puts stderr "Cannot create response file lattice_cmd.rs2: $rspFile"
} else {
	puts $rspFile "-nodal -src gigacart.bl5 -type BLIF -presrc gigacart.bl3 -crf gigacart.crf -sif gigacart.sif -devfile \"$install_dir/ispcpld/dat/lc4k/m4s_64_64.dev\" -lci gigacart.lct
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lciedit\" @lattice_cmd.rs2"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/14/18 21:01:02 ###########


########## Tcl recorder starts at 03/18/18 22:36:37 ##########

# Commands to make the Process: 
# Constraint Editor
# - none -
# Application to view the Process: 
# Constraint Editor
if [catch {open lattice_cmd.rs2 w} rspFile] {
	puts stderr "Cannot create response file lattice_cmd.rs2: $rspFile"
} else {
	puts $rspFile "-nodal -src gigacart.bl5 -type BLIF -presrc gigacart.bl3 -crf gigacart.crf -sif gigacart.sif -devfile \"$install_dir/ispcpld/dat/lc4k/m4s_64_64.dev\" -lci gigacart.lct
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lciedit\" @lattice_cmd.rs2"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/18/18 22:36:37 ###########


########## Tcl recorder starts at 04/10/18 23:10:01 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vhd2jhd\" design.vhd -o design.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/10/18 23:10:01 ###########


########## Tcl recorder starts at 04/10/18 23:20:05 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vhd2jhd\" design.vhd -o design.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/10/18 23:20:05 ###########


########## Tcl recorder starts at 04/10/18 23:21:34 ##########

# Commands to make the Process: 
# Post-Fit Pinouts
if [catch {open gigacart.cmd w} rspFile] {
	puts stderr "Cannot create response file gigacart.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: gigacart.sty
PROJECT: gigacart
WORKING_PATH: \"$proj_dir\"
MODULE: gigacart
VHDL_FILE_LIST: design.vhd
OUTPUT_FILE_NAME: gigacart
SUFFIX_NAME: edi
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DEFAULT_ENUM_ENCODING: default
ARRANGE_VHDL_FILES: true
synthesis_onoff_pragma: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -e gigacart -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete gigacart.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf gigacart.edi -out gigacart.bl0 -err automake.err -log gigacart.log -prj gigacart -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" gigacart.bl0 -collapse none -reduce none -keepwires  -err automake.err -family"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"gigacart.bl1\" -o \"gigacart.bl2\" -omod \"gigacart\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj gigacart -lci gigacart.lct -log gigacart.imp -err automake.err -tti gigacart.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci gigacart.lct -blifopt gigacart.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" gigacart.bl2 -sweep -mergefb -err automake.err -o gigacart.bl3 @gigacart.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci gigacart.lct -dev lc4k -diofft gigacart.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" gigacart.bl3 -family AMDMACH -idev van -o gigacart.bl4 -oxrf gigacart.xrf -err automake.err @gigacart.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci gigacart.lct -dev lc4k -prefit gigacart.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp gigacart.bl4 -out gigacart.bl5 -err automake.err -log gigacart.log -mod gigacart @gigacart.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open gigacart.rs1 w} rspFile] {
	puts stderr "Cannot create response file gigacart.rs1: $rspFile"
} else {
	puts $rspFile "-i gigacart.bl5 -lci gigacart.lct -d m4s_64_64 -lco gigacart.lco -html_rpt -fti gigacart.fti -fmt PLA -tto gigacart.tt4 -nojed -eqn gigacart.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open gigacart.rs2 w} rspFile] {
	puts stderr "Cannot create response file gigacart.rs2: $rspFile"
} else {
	puts $rspFile "-i gigacart.bl5 -lci gigacart.lct -d m4s_64_64 -lco gigacart.lco -html_rpt -fti gigacart.fti -fmt PLA -tto gigacart.tt4 -eqn gigacart.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@gigacart.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete gigacart.rs1
file delete gigacart.rs2
if [runCmd "\"$cpld_bin/tda\" -i gigacart.bl5 -o gigacart.tda -lci gigacart.lct -dev m4s_64_64 -family lc4k -mod gigacart -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj gigacart -if gigacart.jed -j2s -log gigacart.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
# Application to view the Process: 
# Post-Fit Pinouts
if [catch {open lattice_cmd.rs2 w} rspFile] {
	puts stderr "Cannot create response file lattice_cmd.rs2: $rspFile"
} else {
	puts $rspFile "-src gigacart.tt4 -type PLA -devfile \"$install_dir/ispcpld/dat/lc4k/m4s_64_64.dev\" -postfit -lci gigacart.lco
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lciedit\" @lattice_cmd.rs2"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/10/18 23:21:34 ###########


########## Tcl recorder starts at 04/18/18 22:33:14 ##########

# Commands to make the Process: 
# Constraint Editor
if [runCmd "\"$cpld_bin/blifstat\" -i gigacart.bl5 -o gigacart.sif"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
# Application to view the Process: 
# Constraint Editor
if [catch {open lattice_cmd.rs2 w} rspFile] {
	puts stderr "Cannot create response file lattice_cmd.rs2: $rspFile"
} else {
	puts $rspFile "-nodal -src gigacart.bl5 -type BLIF -presrc gigacart.bl3 -crf gigacart.crf -sif gigacart.sif -devfile \"$install_dir/ispcpld/dat/lc4k/m4s_64_64.dev\" -lci gigacart.lct
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lciedit\" @lattice_cmd.rs2"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/18/18 22:33:14 ###########


########## Tcl recorder starts at 04/18/18 22:53:47 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vhd2jhd\" design.vhd -o design.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/18/18 22:53:47 ###########


########## Tcl recorder starts at 04/18/18 23:03:30 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vhd2jhd\" design.vhd -o design.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/18/18 23:03:30 ###########


########## Tcl recorder starts at 04/18/18 23:03:56 ##########

# Commands to make the Process: 
# Synplify Synthesize VHDL File
if [catch {open gigacart.cmd w} rspFile] {
	puts stderr "Cannot create response file gigacart.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: gigacart.sty
PROJECT: gigacart
WORKING_PATH: \"$proj_dir\"
MODULE: gigacart
VHDL_FILE_LIST: design.vhd
OUTPUT_FILE_NAME: gigacart
SUFFIX_NAME: edi
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DEFAULT_ENUM_ENCODING: default
ARRANGE_VHDL_FILES: true
synthesis_onoff_pragma: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -e gigacart -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete gigacart.cmd

########## Tcl recorder end at 04/18/18 23:03:56 ###########


########## Tcl recorder starts at 04/18/18 23:05:22 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vhd2jhd\" design.vhd -o design.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/18/18 23:05:22 ###########


########## Tcl recorder starts at 04/18/18 23:05:27 ##########

# Commands to make the Process: 
# Synplify Synthesize VHDL File
if [catch {open gigacart.cmd w} rspFile] {
	puts stderr "Cannot create response file gigacart.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: gigacart.sty
PROJECT: gigacart
WORKING_PATH: \"$proj_dir\"
MODULE: gigacart
VHDL_FILE_LIST: design.vhd
OUTPUT_FILE_NAME: gigacart
SUFFIX_NAME: edi
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DEFAULT_ENUM_ENCODING: default
ARRANGE_VHDL_FILES: true
synthesis_onoff_pragma: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -e gigacart -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete gigacart.cmd

########## Tcl recorder end at 04/18/18 23:05:27 ###########


########## Tcl recorder starts at 04/18/18 23:06:52 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vhd2jhd\" design.vhd -o design.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/18/18 23:06:52 ###########


########## Tcl recorder starts at 04/18/18 23:06:56 ##########

# Commands to make the Process: 
# Synplify Synthesize VHDL File
if [catch {open gigacart.cmd w} rspFile] {
	puts stderr "Cannot create response file gigacart.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: gigacart.sty
PROJECT: gigacart
WORKING_PATH: \"$proj_dir\"
MODULE: gigacart
VHDL_FILE_LIST: design.vhd
OUTPUT_FILE_NAME: gigacart
SUFFIX_NAME: edi
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DEFAULT_ENUM_ENCODING: default
ARRANGE_VHDL_FILES: true
synthesis_onoff_pragma: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -e gigacart -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete gigacart.cmd

########## Tcl recorder end at 04/18/18 23:06:56 ###########


########## Tcl recorder starts at 04/18/18 23:07:36 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vhd2jhd\" design.vhd -o design.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/18/18 23:07:36 ###########


########## Tcl recorder starts at 04/18/18 23:07:44 ##########

# Commands to make the Process: 
# Synplify Synthesize VHDL File
if [catch {open gigacart.cmd w} rspFile] {
	puts stderr "Cannot create response file gigacart.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: gigacart.sty
PROJECT: gigacart
WORKING_PATH: \"$proj_dir\"
MODULE: gigacart
VHDL_FILE_LIST: design.vhd
OUTPUT_FILE_NAME: gigacart
SUFFIX_NAME: edi
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DEFAULT_ENUM_ENCODING: default
ARRANGE_VHDL_FILES: true
synthesis_onoff_pragma: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -e gigacart -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete gigacart.cmd

########## Tcl recorder end at 04/18/18 23:07:44 ###########


########## Tcl recorder starts at 04/18/18 23:24:01 ##########

# Commands to make the Process: 
# Constraint Editor
if [runCmd "\"$cpld_bin/edif2blf\" -edf gigacart.edi -out gigacart.bl0 -err automake.err -log gigacart.log -prj gigacart -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" gigacart.bl0 -collapse none -reduce none -keepwires  -err automake.err -family"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"gigacart.bl1\" -o \"gigacart.bl2\" -omod \"gigacart\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj gigacart -lci gigacart.lct -log gigacart.imp -err automake.err -tti gigacart.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci gigacart.lct -blifopt gigacart.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" gigacart.bl2 -sweep -mergefb -err automake.err -o gigacart.bl3 @gigacart.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci gigacart.lct -dev lc4k -diofft gigacart.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" gigacart.bl3 -family AMDMACH -idev van -o gigacart.bl4 -oxrf gigacart.xrf -err automake.err @gigacart.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci gigacart.lct -dev lc4k -prefit gigacart.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp gigacart.bl4 -out gigacart.bl5 -err automake.err -log gigacart.log -mod gigacart @gigacart.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/blifstat\" -i gigacart.bl5 -o gigacart.sif"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
# Application to view the Process: 
# Constraint Editor
if [catch {open lattice_cmd.rs2 w} rspFile] {
	puts stderr "Cannot create response file lattice_cmd.rs2: $rspFile"
} else {
	puts $rspFile "-nodal -src gigacart.bl5 -type BLIF -presrc gigacart.bl3 -crf gigacart.crf -sif gigacart.sif -devfile \"$install_dir/ispcpld/dat/lc4k/m4s_64_64.dev\" -lci gigacart.lct
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lciedit\" @lattice_cmd.rs2"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/18/18 23:24:01 ###########


########## Tcl recorder starts at 04/18/18 23:53:31 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open gigacart.rs1 w} rspFile] {
	puts stderr "Cannot create response file gigacart.rs1: $rspFile"
} else {
	puts $rspFile "-i gigacart.bl5 -lci gigacart.lct -d m4s_64_64 -lco gigacart.lco -html_rpt -fti gigacart.fti -fmt PLA -tto gigacart.tt4 -nojed -eqn gigacart.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open gigacart.rs2 w} rspFile] {
	puts stderr "Cannot create response file gigacart.rs2: $rspFile"
} else {
	puts $rspFile "-i gigacart.bl5 -lci gigacart.lct -d m4s_64_64 -lco gigacart.lco -html_rpt -fti gigacart.fti -fmt PLA -tto gigacart.tt4 -eqn gigacart.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@gigacart.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete gigacart.rs1
file delete gigacart.rs2
if [runCmd "\"$cpld_bin/tda\" -i gigacart.bl5 -o gigacart.tda -lci gigacart.lct -dev m4s_64_64 -family lc4k -mod gigacart -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj gigacart -if gigacart.jed -j2s -log gigacart.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/18/18 23:53:31 ###########


########## Tcl recorder starts at 04/18/18 23:53:55 ##########

# Commands to make the Process: 
# JEDEC File
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj gigacart -if gigacart.jed -j2s -log gigacart.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/18/18 23:53:55 ###########


########## Tcl recorder starts at 04/18/18 23:54:12 ##########

# Commands to make the Process: 
# Fitter Report (Text)
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj gigacart -if gigacart.jed -j2s -log gigacart.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/18/18 23:54:12 ###########


########## Tcl recorder starts at 04/18/18 23:55:02 ##########

# Commands to make the Process: 
# Constraint Editor
if [runCmd "\"$cpld_bin/blifstat\" -i gigacart.bl5 -o gigacart.sif"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
# Application to view the Process: 
# Constraint Editor
if [catch {open lattice_cmd.rs2 w} rspFile] {
	puts stderr "Cannot create response file lattice_cmd.rs2: $rspFile"
} else {
	puts $rspFile "-nodal -src gigacart.bl5 -type BLIF -presrc gigacart.bl3 -crf gigacart.crf -sif gigacart.sif -devfile \"$install_dir/ispcpld/dat/lc4k/m4s_64_64.dev\" -lci gigacart.lct
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lciedit\" @lattice_cmd.rs2"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/18/18 23:55:03 ###########


########## Tcl recorder starts at 04/27/18 23:31:22 ##########

# Commands to make the Process: 
# Constraint Editor
# - none -
# Application to view the Process: 
# Constraint Editor
if [catch {open lattice_cmd.rs2 w} rspFile] {
	puts stderr "Cannot create response file lattice_cmd.rs2: $rspFile"
} else {
	puts $rspFile "-nodal -src gigacart.bl5 -type BLIF -presrc gigacart.bl3 -crf gigacart.crf -sif gigacart.sif -devfile \"$install_dir/ispcpld/dat/lc4k/m4s_64_64.dev\" -lci gigacart.lct
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lciedit\" @lattice_cmd.rs2"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/27/18 23:31:22 ###########


########## Tcl recorder starts at 04/27/18 23:39:48 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open gigacart.rs1 w} rspFile] {
	puts stderr "Cannot create response file gigacart.rs1: $rspFile"
} else {
	puts $rspFile "-i gigacart.bl5 -lci gigacart.lct -d m4s_64_64 -lco gigacart.lco -html_rpt -fti gigacart.fti -fmt PLA -tto gigacart.tt4 -nojed -eqn gigacart.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open gigacart.rs2 w} rspFile] {
	puts stderr "Cannot create response file gigacart.rs2: $rspFile"
} else {
	puts $rspFile "-i gigacart.bl5 -lci gigacart.lct -d m4s_64_64 -lco gigacart.lco -html_rpt -fti gigacart.fti -fmt PLA -tto gigacart.tt4 -eqn gigacart.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@gigacart.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete gigacart.rs1
file delete gigacart.rs2
if [runCmd "\"$cpld_bin/tda\" -i gigacart.bl5 -o gigacart.tda -lci gigacart.lct -dev m4s_64_64 -family lc4k -mod gigacart -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj gigacart -if gigacart.jed -j2s -log gigacart.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/27/18 23:39:48 ###########


########## Tcl recorder starts at 04/27/18 23:40:26 ##########

# Commands to make the Process: 
# JEDEC File
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj gigacart -if gigacart.jed -j2s -log gigacart.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/27/18 23:40:26 ###########


########## Tcl recorder starts at 04/27/18 23:40:35 ##########

# Commands to make the Process: 
# Post-Fit Pinouts
# - none -
# Application to view the Process: 
# Post-Fit Pinouts
if [catch {open lattice_cmd.rs2 w} rspFile] {
	puts stderr "Cannot create response file lattice_cmd.rs2: $rspFile"
} else {
	puts $rspFile "-src gigacart.tt4 -type PLA -devfile \"$install_dir/ispcpld/dat/lc4k/m4s_64_64.dev\" -postfit -lci gigacart.lco
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lciedit\" @lattice_cmd.rs2"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/27/18 23:40:35 ###########


########## Tcl recorder starts at 05/17/18 18:23:20 ##########

# Commands to make the Process: 
# JEDEC File
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj gigacart -if gigacart.jed -j2s -log gigacart.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/17/18 18:23:20 ###########


########## Tcl recorder starts at 05/17/18 18:23:30 ##########

# Commands to make the Process: 
# ISC-1532 File
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj gigacart -if gigacart.jed -j2i "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/17/18 18:23:30 ###########


########## Tcl recorder starts at 05/17/18 18:23:35 ##########

# Commands to make the Process: 
# JEDEC File
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj gigacart -if gigacart.jed -j2s -log gigacart.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/17/18 18:23:35 ###########


########## Tcl recorder starts at 05/17/18 18:24:07 ##########

# Commands to make the Process: 
# JEDEC File
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj gigacart -if gigacart.jed -j2s -log gigacart.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/17/18 18:24:07 ###########


########## Tcl recorder starts at 05/17/18 18:24:14 ##########

# Commands to make the Process: 
# JEDEC File
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj gigacart -if gigacart.jed -j2s -log gigacart.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/17/18 18:24:14 ###########


########## Tcl recorder starts at 05/17/18 22:28:50 ##########

# Commands to make the Process: 
# Post-Fit Pinouts
# - none -
# Application to view the Process: 
# Post-Fit Pinouts
if [catch {open lattice_cmd.rs2 w} rspFile] {
	puts stderr "Cannot create response file lattice_cmd.rs2: $rspFile"
} else {
	puts $rspFile "-src gigacart.tt4 -type PLA -devfile \"$install_dir/ispcpld/dat/lc4k/m4s_64_64.dev\" -postfit -lci gigacart.lco
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lciedit\" @lattice_cmd.rs2"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/17/18 22:28:50 ###########


########## Tcl recorder starts at 05/18/18 14:00:07 ##########

# Commands to make the Process: 
# Post-Fit Pinouts
# - none -
# Application to view the Process: 
# Post-Fit Pinouts
if [catch {open lattice_cmd.rs2 w} rspFile] {
	puts stderr "Cannot create response file lattice_cmd.rs2: $rspFile"
} else {
	puts $rspFile "-src gigacart.tt4 -type PLA -devfile \"$install_dir/ispcpld/dat/lc4k/m4s_64_64.dev\" -postfit -lci gigacart.lco
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lciedit\" @lattice_cmd.rs2"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/18/18 14:00:07 ###########


########## Tcl recorder starts at 05/20/18 00:14:54 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vhd2jhd\" design.vhd -o design.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/20/18 00:14:54 ###########


########## Tcl recorder starts at 05/20/18 00:15:25 ##########

# Commands to make the Process: 
# JEDEC File
if [catch {open gigacart.cmd w} rspFile] {
	puts stderr "Cannot create response file gigacart.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: gigacart.sty
PROJECT: gigacart
WORKING_PATH: \"$proj_dir\"
MODULE: gigacart
VHDL_FILE_LIST: design.vhd
OUTPUT_FILE_NAME: gigacart
SUFFIX_NAME: edi
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DEFAULT_ENUM_ENCODING: default
ARRANGE_VHDL_FILES: true
synthesis_onoff_pragma: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -e gigacart -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete gigacart.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf gigacart.edi -out gigacart.bl0 -err automake.err -log gigacart.log -prj gigacart -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" gigacart.bl0 -collapse none -reduce none -keepwires  -err automake.err -family"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"gigacart.bl1\" -o \"gigacart.bl2\" -omod \"gigacart\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj gigacart -lci gigacart.lct -log gigacart.imp -err automake.err -tti gigacart.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci gigacart.lct -blifopt gigacart.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" gigacart.bl2 -sweep -mergefb -err automake.err -o gigacart.bl3 @gigacart.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci gigacart.lct -dev lc4k -diofft gigacart.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" gigacart.bl3 -family AMDMACH -idev van -o gigacart.bl4 -oxrf gigacart.xrf -err automake.err @gigacart.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci gigacart.lct -dev lc4k -prefit gigacart.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp gigacart.bl4 -out gigacart.bl5 -err automake.err -log gigacart.log -mod gigacart @gigacart.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open gigacart.rs1 w} rspFile] {
	puts stderr "Cannot create response file gigacart.rs1: $rspFile"
} else {
	puts $rspFile "-i gigacart.bl5 -lci gigacart.lct -d m4s_64_64 -lco gigacart.lco -html_rpt -fti gigacart.fti -fmt PLA -tto gigacart.tt4 -nojed -eqn gigacart.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open gigacart.rs2 w} rspFile] {
	puts stderr "Cannot create response file gigacart.rs2: $rspFile"
} else {
	puts $rspFile "-i gigacart.bl5 -lci gigacart.lct -d m4s_64_64 -lco gigacart.lco -html_rpt -fti gigacart.fti -fmt PLA -tto gigacart.tt4 -eqn gigacart.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@gigacart.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete gigacart.rs1
file delete gigacart.rs2
if [runCmd "\"$cpld_bin/tda\" -i gigacart.bl5 -o gigacart.tda -lci gigacart.lct -dev m4s_64_64 -family lc4k -mod gigacart -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj gigacart -if gigacart.jed -j2s -log gigacart.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/20/18 00:15:26 ###########


########## Tcl recorder starts at 05/21/18 23:00:50 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vhd2jhd\" design.vhd -o design.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/21/18 23:00:50 ###########


########## Tcl recorder starts at 05/21/18 23:00:59 ##########

# Commands to make the Process: 
# JEDEC File
if [catch {open gigacart.cmd w} rspFile] {
	puts stderr "Cannot create response file gigacart.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: gigacart.sty
PROJECT: gigacart
WORKING_PATH: \"$proj_dir\"
MODULE: gigacart
VHDL_FILE_LIST: design.vhd
OUTPUT_FILE_NAME: gigacart
SUFFIX_NAME: edi
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DEFAULT_ENUM_ENCODING: default
ARRANGE_VHDL_FILES: true
synthesis_onoff_pragma: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -e gigacart -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete gigacart.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf gigacart.edi -out gigacart.bl0 -err automake.err -log gigacart.log -prj gigacart -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" gigacart.bl0 -collapse none -reduce none -keepwires  -err automake.err -family"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"gigacart.bl1\" -o \"gigacart.bl2\" -omod \"gigacart\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj gigacart -lci gigacart.lct -log gigacart.imp -err automake.err -tti gigacart.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci gigacart.lct -blifopt gigacart.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" gigacart.bl2 -sweep -mergefb -err automake.err -o gigacart.bl3 @gigacart.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci gigacart.lct -dev lc4k -diofft gigacart.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" gigacart.bl3 -family AMDMACH -idev van -o gigacart.bl4 -oxrf gigacart.xrf -err automake.err @gigacart.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci gigacart.lct -dev lc4k -prefit gigacart.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp gigacart.bl4 -out gigacart.bl5 -err automake.err -log gigacart.log -mod gigacart @gigacart.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open gigacart.rs1 w} rspFile] {
	puts stderr "Cannot create response file gigacart.rs1: $rspFile"
} else {
	puts $rspFile "-i gigacart.bl5 -lci gigacart.lct -d m4s_64_64 -lco gigacart.lco -html_rpt -fti gigacart.fti -fmt PLA -tto gigacart.tt4 -nojed -eqn gigacart.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open gigacart.rs2 w} rspFile] {
	puts stderr "Cannot create response file gigacart.rs2: $rspFile"
} else {
	puts $rspFile "-i gigacart.bl5 -lci gigacart.lct -d m4s_64_64 -lco gigacart.lco -html_rpt -fti gigacart.fti -fmt PLA -tto gigacart.tt4 -eqn gigacart.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@gigacart.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete gigacart.rs1
file delete gigacart.rs2
if [runCmd "\"$cpld_bin/tda\" -i gigacart.bl5 -o gigacart.tda -lci gigacart.lct -dev m4s_64_64 -family lc4k -mod gigacart -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj gigacart -if gigacart.jed -j2s -log gigacart.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/21/18 23:00:59 ###########


########## Tcl recorder starts at 05/22/18 01:06:50 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vhd2jhd\" design.vhd -o design.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/22/18 01:06:50 ###########


########## Tcl recorder starts at 05/22/18 01:06:56 ##########

# Commands to make the Process: 
# JEDEC File
if [catch {open gigacart.cmd w} rspFile] {
	puts stderr "Cannot create response file gigacart.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: gigacart.sty
PROJECT: gigacart
WORKING_PATH: \"$proj_dir\"
MODULE: gigacart
VHDL_FILE_LIST: design.vhd
OUTPUT_FILE_NAME: gigacart
SUFFIX_NAME: edi
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DEFAULT_ENUM_ENCODING: default
ARRANGE_VHDL_FILES: true
synthesis_onoff_pragma: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -e gigacart -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete gigacart.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf gigacart.edi -out gigacart.bl0 -err automake.err -log gigacart.log -prj gigacart -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" gigacart.bl0 -collapse none -reduce none -keepwires  -err automake.err -family"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"gigacart.bl1\" -o \"gigacart.bl2\" -omod \"gigacart\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj gigacart -lci gigacart.lct -log gigacart.imp -err automake.err -tti gigacart.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci gigacart.lct -blifopt gigacart.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" gigacart.bl2 -sweep -mergefb -err automake.err -o gigacart.bl3 @gigacart.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci gigacart.lct -dev lc4k -diofft gigacart.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" gigacart.bl3 -family AMDMACH -idev van -o gigacart.bl4 -oxrf gigacart.xrf -err automake.err @gigacart.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci gigacart.lct -dev lc4k -prefit gigacart.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp gigacart.bl4 -out gigacart.bl5 -err automake.err -log gigacart.log -mod gigacart @gigacart.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open gigacart.rs1 w} rspFile] {
	puts stderr "Cannot create response file gigacart.rs1: $rspFile"
} else {
	puts $rspFile "-i gigacart.bl5 -lci gigacart.lct -d m4s_64_64 -lco gigacart.lco -html_rpt -fti gigacart.fti -fmt PLA -tto gigacart.tt4 -nojed -eqn gigacart.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open gigacart.rs2 w} rspFile] {
	puts stderr "Cannot create response file gigacart.rs2: $rspFile"
} else {
	puts $rspFile "-i gigacart.bl5 -lci gigacart.lct -d m4s_64_64 -lco gigacart.lco -html_rpt -fti gigacart.fti -fmt PLA -tto gigacart.tt4 -eqn gigacart.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@gigacart.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete gigacart.rs1
file delete gigacart.rs2
if [runCmd "\"$cpld_bin/tda\" -i gigacart.bl5 -o gigacart.tda -lci gigacart.lct -dev m4s_64_64 -family lc4k -mod gigacart -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj gigacart -if gigacart.jed -j2s -log gigacart.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/22/18 01:06:56 ###########


########## Tcl recorder starts at 05/22/18 01:16:45 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vhd2jhd\" design.vhd -o design.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/22/18 01:16:45 ###########


########## Tcl recorder starts at 05/22/18 01:24:58 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vhd2jhd\" design.vhd -o design.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/22/18 01:24:58 ###########


########## Tcl recorder starts at 05/22/18 01:25:03 ##########

# Commands to make the Process: 
# JEDEC File
if [catch {open gigacart.cmd w} rspFile] {
	puts stderr "Cannot create response file gigacart.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: gigacart.sty
PROJECT: gigacart
WORKING_PATH: \"$proj_dir\"
MODULE: gigacart
VHDL_FILE_LIST: design.vhd
OUTPUT_FILE_NAME: gigacart
SUFFIX_NAME: edi
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DEFAULT_ENUM_ENCODING: default
ARRANGE_VHDL_FILES: true
synthesis_onoff_pragma: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -e gigacart -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete gigacart.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf gigacart.edi -out gigacart.bl0 -err automake.err -log gigacart.log -prj gigacart -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" gigacart.bl0 -collapse none -reduce none -keepwires  -err automake.err -family"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"gigacart.bl1\" -o \"gigacart.bl2\" -omod \"gigacart\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj gigacart -lci gigacart.lct -log gigacart.imp -err automake.err -tti gigacart.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci gigacart.lct -blifopt gigacart.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" gigacart.bl2 -sweep -mergefb -err automake.err -o gigacart.bl3 @gigacart.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci gigacart.lct -dev lc4k -diofft gigacart.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" gigacart.bl3 -family AMDMACH -idev van -o gigacart.bl4 -oxrf gigacart.xrf -err automake.err @gigacart.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci gigacart.lct -dev lc4k -prefit gigacart.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp gigacart.bl4 -out gigacart.bl5 -err automake.err -log gigacart.log -mod gigacart @gigacart.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open gigacart.rs1 w} rspFile] {
	puts stderr "Cannot create response file gigacart.rs1: $rspFile"
} else {
	puts $rspFile "-i gigacart.bl5 -lci gigacart.lct -d m4s_64_64 -lco gigacart.lco -html_rpt -fti gigacart.fti -fmt PLA -tto gigacart.tt4 -nojed -eqn gigacart.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open gigacart.rs2 w} rspFile] {
	puts stderr "Cannot create response file gigacart.rs2: $rspFile"
} else {
	puts $rspFile "-i gigacart.bl5 -lci gigacart.lct -d m4s_64_64 -lco gigacart.lco -html_rpt -fti gigacart.fti -fmt PLA -tto gigacart.tt4 -eqn gigacart.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@gigacart.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete gigacart.rs1
file delete gigacart.rs2
if [runCmd "\"$cpld_bin/tda\" -i gigacart.bl5 -o gigacart.tda -lci gigacart.lct -dev m4s_64_64 -family lc4k -mod gigacart -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj gigacart -if gigacart.jed -j2s -log gigacart.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/22/18 01:25:03 ###########


########## Tcl recorder starts at 05/22/18 01:26:14 ##########

# Commands to make the Process: 
# Synplify Synthesize VHDL File
if [catch {open gigacart.cmd w} rspFile] {
	puts stderr "Cannot create response file gigacart.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: gigacart.sty
PROJECT: gigacart
WORKING_PATH: \"$proj_dir\"
MODULE: gigacart
VHDL_FILE_LIST: design.vhd
OUTPUT_FILE_NAME: gigacart
SUFFIX_NAME: edi
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DEFAULT_ENUM_ENCODING: default
ARRANGE_VHDL_FILES: true
synthesis_onoff_pragma: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -e gigacart -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete gigacart.cmd

########## Tcl recorder end at 05/22/18 01:26:14 ###########


########## Tcl recorder starts at 05/22/18 01:28:09 ##########

# Commands to make the Process: 
# Synplify Synthesize VHDL File
if [catch {open gigacart.cmd w} rspFile] {
	puts stderr "Cannot create response file gigacart.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: gigacart.sty
PROJECT: gigacart
WORKING_PATH: \"$proj_dir\"
MODULE: gigacart
VHDL_FILE_LIST: design.vhd
OUTPUT_FILE_NAME: gigacart
SUFFIX_NAME: edi
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DEFAULT_ENUM_ENCODING: default
ARRANGE_VHDL_FILES: true
synthesis_onoff_pragma: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -e gigacart -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete gigacart.cmd

########## Tcl recorder end at 05/22/18 01:28:09 ###########


########## Tcl recorder starts at 05/22/18 01:28:55 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vhd2jhd\" design.vhd -o design.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/22/18 01:28:55 ###########


########## Tcl recorder starts at 05/22/18 01:28:58 ##########

# Commands to make the Process: 
# Synplify Synthesize VHDL File
if [catch {open gigacart.cmd w} rspFile] {
	puts stderr "Cannot create response file gigacart.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: gigacart.sty
PROJECT: gigacart
WORKING_PATH: \"$proj_dir\"
MODULE: gigacart
VHDL_FILE_LIST: design.vhd
OUTPUT_FILE_NAME: gigacart
SUFFIX_NAME: edi
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DEFAULT_ENUM_ENCODING: default
ARRANGE_VHDL_FILES: true
synthesis_onoff_pragma: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -e gigacart -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete gigacart.cmd

########## Tcl recorder end at 05/22/18 01:28:58 ###########


########## Tcl recorder starts at 05/22/18 01:29:55 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vhd2jhd\" design.vhd -o design.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/22/18 01:29:55 ###########


########## Tcl recorder starts at 05/22/18 01:29:57 ##########

# Commands to make the Process: 
# Synplify Synthesize VHDL File
if [catch {open gigacart.cmd w} rspFile] {
	puts stderr "Cannot create response file gigacart.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: gigacart.sty
PROJECT: gigacart
WORKING_PATH: \"$proj_dir\"
MODULE: gigacart
VHDL_FILE_LIST: design.vhd
OUTPUT_FILE_NAME: gigacart
SUFFIX_NAME: edi
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DEFAULT_ENUM_ENCODING: default
ARRANGE_VHDL_FILES: true
synthesis_onoff_pragma: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -e gigacart -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete gigacart.cmd

########## Tcl recorder end at 05/22/18 01:29:57 ###########


########## Tcl recorder starts at 05/22/18 01:34:33 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vhd2jhd\" design.vhd -o design.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/22/18 01:34:33 ###########


########## Tcl recorder starts at 05/22/18 01:34:36 ##########

# Commands to make the Process: 
# Synplify Synthesize VHDL File
if [catch {open gigacart.cmd w} rspFile] {
	puts stderr "Cannot create response file gigacart.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: gigacart.sty
PROJECT: gigacart
WORKING_PATH: \"$proj_dir\"
MODULE: gigacart
VHDL_FILE_LIST: design.vhd
OUTPUT_FILE_NAME: gigacart
SUFFIX_NAME: edi
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DEFAULT_ENUM_ENCODING: default
ARRANGE_VHDL_FILES: true
synthesis_onoff_pragma: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -e gigacart -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete gigacart.cmd

########## Tcl recorder end at 05/22/18 01:34:36 ###########


########## Tcl recorder starts at 05/22/18 01:35:06 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vhd2jhd\" design.vhd -o design.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/22/18 01:35:06 ###########


########## Tcl recorder starts at 05/22/18 01:35:08 ##########

# Commands to make the Process: 
# Synplify Synthesize VHDL File
if [catch {open gigacart.cmd w} rspFile] {
	puts stderr "Cannot create response file gigacart.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: gigacart.sty
PROJECT: gigacart
WORKING_PATH: \"$proj_dir\"
MODULE: gigacart
VHDL_FILE_LIST: design.vhd
OUTPUT_FILE_NAME: gigacart
SUFFIX_NAME: edi
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DEFAULT_ENUM_ENCODING: default
ARRANGE_VHDL_FILES: true
synthesis_onoff_pragma: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -e gigacart -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete gigacart.cmd

########## Tcl recorder end at 05/22/18 01:35:08 ###########


########## Tcl recorder starts at 05/22/18 01:35:37 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vhd2jhd\" design.vhd -o design.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/22/18 01:35:37 ###########


########## Tcl recorder starts at 05/22/18 01:35:39 ##########

# Commands to make the Process: 
# Synplify Synthesize VHDL File
if [catch {open gigacart.cmd w} rspFile] {
	puts stderr "Cannot create response file gigacart.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: gigacart.sty
PROJECT: gigacart
WORKING_PATH: \"$proj_dir\"
MODULE: gigacart
VHDL_FILE_LIST: design.vhd
OUTPUT_FILE_NAME: gigacart
SUFFIX_NAME: edi
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DEFAULT_ENUM_ENCODING: default
ARRANGE_VHDL_FILES: true
synthesis_onoff_pragma: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -e gigacart -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete gigacart.cmd

########## Tcl recorder end at 05/22/18 01:35:40 ###########


########## Tcl recorder starts at 05/22/18 01:37:35 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vhd2jhd\" design.vhd -o design.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/22/18 01:37:35 ###########


########## Tcl recorder starts at 05/22/18 01:37:39 ##########

# Commands to make the Process: 
# Synplify Synthesize VHDL File
if [catch {open gigacart.cmd w} rspFile] {
	puts stderr "Cannot create response file gigacart.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: gigacart.sty
PROJECT: gigacart
WORKING_PATH: \"$proj_dir\"
MODULE: gigacart
VHDL_FILE_LIST: design.vhd
OUTPUT_FILE_NAME: gigacart
SUFFIX_NAME: edi
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DEFAULT_ENUM_ENCODING: default
ARRANGE_VHDL_FILES: true
synthesis_onoff_pragma: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -e gigacart -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete gigacart.cmd

########## Tcl recorder end at 05/22/18 01:37:39 ###########


########## Tcl recorder starts at 05/22/18 01:38:03 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vhd2jhd\" design.vhd -o design.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/22/18 01:38:03 ###########


########## Tcl recorder starts at 05/22/18 01:38:05 ##########

# Commands to make the Process: 
# Synplify Synthesize VHDL File
if [catch {open gigacart.cmd w} rspFile] {
	puts stderr "Cannot create response file gigacart.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: gigacart.sty
PROJECT: gigacart
WORKING_PATH: \"$proj_dir\"
MODULE: gigacart
VHDL_FILE_LIST: design.vhd
OUTPUT_FILE_NAME: gigacart
SUFFIX_NAME: edi
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DEFAULT_ENUM_ENCODING: default
ARRANGE_VHDL_FILES: true
synthesis_onoff_pragma: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -e gigacart -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete gigacart.cmd

########## Tcl recorder end at 05/22/18 01:38:05 ###########


########## Tcl recorder starts at 05/22/18 01:38:44 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vhd2jhd\" design.vhd -o design.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/22/18 01:38:44 ###########


########## Tcl recorder starts at 05/22/18 01:38:46 ##########

# Commands to make the Process: 
# Synplify Synthesize VHDL File
if [catch {open gigacart.cmd w} rspFile] {
	puts stderr "Cannot create response file gigacart.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: gigacart.sty
PROJECT: gigacart
WORKING_PATH: \"$proj_dir\"
MODULE: gigacart
VHDL_FILE_LIST: design.vhd
OUTPUT_FILE_NAME: gigacart
SUFFIX_NAME: edi
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DEFAULT_ENUM_ENCODING: default
ARRANGE_VHDL_FILES: true
synthesis_onoff_pragma: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -e gigacart -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete gigacart.cmd

########## Tcl recorder end at 05/22/18 01:38:46 ###########


########## Tcl recorder starts at 05/22/18 01:42:27 ##########

# Commands to make the Process: 
# JEDEC File
if [runCmd "\"$cpld_bin/edif2blf\" -edf gigacart.edi -out gigacart.bl0 -err automake.err -log gigacart.log -prj gigacart -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" gigacart.bl0 -collapse none -reduce none -keepwires  -err automake.err -family"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"gigacart.bl1\" -o \"gigacart.bl2\" -omod \"gigacart\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj gigacart -lci gigacart.lct -log gigacart.imp -err automake.err -tti gigacart.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci gigacart.lct -blifopt gigacart.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" gigacart.bl2 -sweep -mergefb -err automake.err -o gigacart.bl3 @gigacart.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci gigacart.lct -dev lc4k -diofft gigacart.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" gigacart.bl3 -family AMDMACH -idev van -o gigacart.bl4 -oxrf gigacart.xrf -err automake.err @gigacart.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci gigacart.lct -dev lc4k -prefit gigacart.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp gigacart.bl4 -out gigacart.bl5 -err automake.err -log gigacart.log -mod gigacart @gigacart.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open gigacart.rs1 w} rspFile] {
	puts stderr "Cannot create response file gigacart.rs1: $rspFile"
} else {
	puts $rspFile "-i gigacart.bl5 -lci gigacart.lct -d m4s_64_64 -lco gigacart.lco -html_rpt -fti gigacart.fti -fmt PLA -tto gigacart.tt4 -nojed -eqn gigacart.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open gigacart.rs2 w} rspFile] {
	puts stderr "Cannot create response file gigacart.rs2: $rspFile"
} else {
	puts $rspFile "-i gigacart.bl5 -lci gigacart.lct -d m4s_64_64 -lco gigacart.lco -html_rpt -fti gigacart.fti -fmt PLA -tto gigacart.tt4 -eqn gigacart.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@gigacart.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete gigacart.rs1
file delete gigacart.rs2
if [runCmd "\"$cpld_bin/tda\" -i gigacart.bl5 -o gigacart.tda -lci gigacart.lct -dev m4s_64_64 -family lc4k -mod gigacart -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj gigacart -if gigacart.jed -j2s -log gigacart.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/22/18 01:42:27 ###########


########## Tcl recorder starts at 05/22/18 01:51:11 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vhd2jhd\" design.vhd -o design.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/22/18 01:51:11 ###########


########## Tcl recorder starts at 05/22/18 01:51:18 ##########

# Commands to make the Process: 
# JEDEC File
if [catch {open gigacart.cmd w} rspFile] {
	puts stderr "Cannot create response file gigacart.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: gigacart.sty
PROJECT: gigacart
WORKING_PATH: \"$proj_dir\"
MODULE: gigacart
VHDL_FILE_LIST: design.vhd
OUTPUT_FILE_NAME: gigacart
SUFFIX_NAME: edi
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DEFAULT_ENUM_ENCODING: default
ARRANGE_VHDL_FILES: true
synthesis_onoff_pragma: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -e gigacart -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete gigacart.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf gigacart.edi -out gigacart.bl0 -err automake.err -log gigacart.log -prj gigacart -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" gigacart.bl0 -collapse none -reduce none -keepwires  -err automake.err -family"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"gigacart.bl1\" -o \"gigacart.bl2\" -omod \"gigacart\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj gigacart -lci gigacart.lct -log gigacart.imp -err automake.err -tti gigacart.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci gigacart.lct -blifopt gigacart.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" gigacart.bl2 -sweep -mergefb -err automake.err -o gigacart.bl3 @gigacart.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci gigacart.lct -dev lc4k -diofft gigacart.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" gigacart.bl3 -family AMDMACH -idev van -o gigacart.bl4 -oxrf gigacart.xrf -err automake.err @gigacart.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci gigacart.lct -dev lc4k -prefit gigacart.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp gigacart.bl4 -out gigacart.bl5 -err automake.err -log gigacart.log -mod gigacart @gigacart.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open gigacart.rs1 w} rspFile] {
	puts stderr "Cannot create response file gigacart.rs1: $rspFile"
} else {
	puts $rspFile "-i gigacart.bl5 -lci gigacart.lct -d m4s_64_64 -lco gigacart.lco -html_rpt -fti gigacart.fti -fmt PLA -tto gigacart.tt4 -nojed -eqn gigacart.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open gigacart.rs2 w} rspFile] {
	puts stderr "Cannot create response file gigacart.rs2: $rspFile"
} else {
	puts $rspFile "-i gigacart.bl5 -lci gigacart.lct -d m4s_64_64 -lco gigacart.lco -html_rpt -fti gigacart.fti -fmt PLA -tto gigacart.tt4 -eqn gigacart.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@gigacart.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete gigacart.rs1
file delete gigacart.rs2
if [runCmd "\"$cpld_bin/tda\" -i gigacart.bl5 -o gigacart.tda -lci gigacart.lct -dev m4s_64_64 -family lc4k -mod gigacart -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj gigacart -if gigacart.jed -j2s -log gigacart.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/22/18 01:51:18 ###########


########## Tcl recorder starts at 05/22/18 02:01:43 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vhd2jhd\" design.vhd -o design.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/22/18 02:01:43 ###########


########## Tcl recorder starts at 05/22/18 02:01:46 ##########

# Commands to make the Process: 
# JEDEC File
if [catch {open gigacart.cmd w} rspFile] {
	puts stderr "Cannot create response file gigacart.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: gigacart.sty
PROJECT: gigacart
WORKING_PATH: \"$proj_dir\"
MODULE: gigacart
VHDL_FILE_LIST: design.vhd
OUTPUT_FILE_NAME: gigacart
SUFFIX_NAME: edi
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DEFAULT_ENUM_ENCODING: default
ARRANGE_VHDL_FILES: true
synthesis_onoff_pragma: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -e gigacart -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete gigacart.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf gigacart.edi -out gigacart.bl0 -err automake.err -log gigacart.log -prj gigacart -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" gigacart.bl0 -collapse none -reduce none -keepwires  -err automake.err -family"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"gigacart.bl1\" -o \"gigacart.bl2\" -omod \"gigacart\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj gigacart -lci gigacart.lct -log gigacart.imp -err automake.err -tti gigacart.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci gigacart.lct -blifopt gigacart.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" gigacart.bl2 -sweep -mergefb -err automake.err -o gigacart.bl3 @gigacart.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci gigacart.lct -dev lc4k -diofft gigacart.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" gigacart.bl3 -family AMDMACH -idev van -o gigacart.bl4 -oxrf gigacart.xrf -err automake.err @gigacart.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci gigacart.lct -dev lc4k -prefit gigacart.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp gigacart.bl4 -out gigacart.bl5 -err automake.err -log gigacart.log -mod gigacart @gigacart.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open gigacart.rs1 w} rspFile] {
	puts stderr "Cannot create response file gigacart.rs1: $rspFile"
} else {
	puts $rspFile "-i gigacart.bl5 -lci gigacart.lct -d m4s_64_64 -lco gigacart.lco -html_rpt -fti gigacart.fti -fmt PLA -tto gigacart.tt4 -nojed -eqn gigacart.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open gigacart.rs2 w} rspFile] {
	puts stderr "Cannot create response file gigacart.rs2: $rspFile"
} else {
	puts $rspFile "-i gigacart.bl5 -lci gigacart.lct -d m4s_64_64 -lco gigacart.lco -html_rpt -fti gigacart.fti -fmt PLA -tto gigacart.tt4 -eqn gigacart.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@gigacart.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete gigacart.rs1
file delete gigacart.rs2
if [runCmd "\"$cpld_bin/tda\" -i gigacart.bl5 -o gigacart.tda -lci gigacart.lct -dev m4s_64_64 -family lc4k -mod gigacart -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj gigacart -if gigacart.jed -j2s -log gigacart.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/22/18 02:01:46 ###########


########## Tcl recorder starts at 05/22/18 02:02:06 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vhd2jhd\" design.vhd -o design.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/22/18 02:02:06 ###########


########## Tcl recorder starts at 05/22/18 02:02:08 ##########

# Commands to make the Process: 
# JEDEC File
if [catch {open gigacart.cmd w} rspFile] {
	puts stderr "Cannot create response file gigacart.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: gigacart.sty
PROJECT: gigacart
WORKING_PATH: \"$proj_dir\"
MODULE: gigacart
VHDL_FILE_LIST: design.vhd
OUTPUT_FILE_NAME: gigacart
SUFFIX_NAME: edi
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DEFAULT_ENUM_ENCODING: default
ARRANGE_VHDL_FILES: true
synthesis_onoff_pragma: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -e gigacart -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete gigacart.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf gigacart.edi -out gigacart.bl0 -err automake.err -log gigacart.log -prj gigacart -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" gigacart.bl0 -collapse none -reduce none -keepwires  -err automake.err -family"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"gigacart.bl1\" -o \"gigacart.bl2\" -omod \"gigacart\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj gigacart -lci gigacart.lct -log gigacart.imp -err automake.err -tti gigacart.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci gigacart.lct -blifopt gigacart.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" gigacart.bl2 -sweep -mergefb -err automake.err -o gigacart.bl3 @gigacart.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci gigacart.lct -dev lc4k -diofft gigacart.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" gigacart.bl3 -family AMDMACH -idev van -o gigacart.bl4 -oxrf gigacart.xrf -err automake.err @gigacart.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci gigacart.lct -dev lc4k -prefit gigacart.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp gigacart.bl4 -out gigacart.bl5 -err automake.err -log gigacart.log -mod gigacart @gigacart.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open gigacart.rs1 w} rspFile] {
	puts stderr "Cannot create response file gigacart.rs1: $rspFile"
} else {
	puts $rspFile "-i gigacart.bl5 -lci gigacart.lct -d m4s_64_64 -lco gigacart.lco -html_rpt -fti gigacart.fti -fmt PLA -tto gigacart.tt4 -nojed -eqn gigacart.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open gigacart.rs2 w} rspFile] {
	puts stderr "Cannot create response file gigacart.rs2: $rspFile"
} else {
	puts $rspFile "-i gigacart.bl5 -lci gigacart.lct -d m4s_64_64 -lco gigacart.lco -html_rpt -fti gigacart.fti -fmt PLA -tto gigacart.tt4 -eqn gigacart.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@gigacart.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete gigacart.rs1
file delete gigacart.rs2
if [runCmd "\"$cpld_bin/tda\" -i gigacart.bl5 -o gigacart.tda -lci gigacart.lct -dev m4s_64_64 -family lc4k -mod gigacart -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj gigacart -if gigacart.jed -j2s -log gigacart.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/22/18 02:02:08 ###########


########## Tcl recorder starts at 05/22/18 02:02:59 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vhd2jhd\" design.vhd -o design.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/22/18 02:02:59 ###########


########## Tcl recorder starts at 05/22/18 02:03:03 ##########

# Commands to make the Process: 
# JEDEC File
if [catch {open gigacart.cmd w} rspFile] {
	puts stderr "Cannot create response file gigacart.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: gigacart.sty
PROJECT: gigacart
WORKING_PATH: \"$proj_dir\"
MODULE: gigacart
VHDL_FILE_LIST: design.vhd
OUTPUT_FILE_NAME: gigacart
SUFFIX_NAME: edi
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DEFAULT_ENUM_ENCODING: default
ARRANGE_VHDL_FILES: true
synthesis_onoff_pragma: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -e gigacart -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete gigacart.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf gigacart.edi -out gigacart.bl0 -err automake.err -log gigacart.log -prj gigacart -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" gigacart.bl0 -collapse none -reduce none -keepwires  -err automake.err -family"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"gigacart.bl1\" -o \"gigacart.bl2\" -omod \"gigacart\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj gigacart -lci gigacart.lct -log gigacart.imp -err automake.err -tti gigacart.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci gigacart.lct -blifopt gigacart.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" gigacart.bl2 -sweep -mergefb -err automake.err -o gigacart.bl3 @gigacart.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci gigacart.lct -dev lc4k -diofft gigacart.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" gigacart.bl3 -family AMDMACH -idev van -o gigacart.bl4 -oxrf gigacart.xrf -err automake.err @gigacart.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci gigacart.lct -dev lc4k -prefit gigacart.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp gigacart.bl4 -out gigacart.bl5 -err automake.err -log gigacart.log -mod gigacart @gigacart.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open gigacart.rs1 w} rspFile] {
	puts stderr "Cannot create response file gigacart.rs1: $rspFile"
} else {
	puts $rspFile "-i gigacart.bl5 -lci gigacart.lct -d m4s_64_64 -lco gigacart.lco -html_rpt -fti gigacart.fti -fmt PLA -tto gigacart.tt4 -nojed -eqn gigacart.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open gigacart.rs2 w} rspFile] {
	puts stderr "Cannot create response file gigacart.rs2: $rspFile"
} else {
	puts $rspFile "-i gigacart.bl5 -lci gigacart.lct -d m4s_64_64 -lco gigacart.lco -html_rpt -fti gigacart.fti -fmt PLA -tto gigacart.tt4 -eqn gigacart.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@gigacart.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete gigacart.rs1
file delete gigacart.rs2
if [runCmd "\"$cpld_bin/tda\" -i gigacart.bl5 -o gigacart.tda -lci gigacart.lct -dev m4s_64_64 -family lc4k -mod gigacart -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj gigacart -if gigacart.jed -j2s -log gigacart.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/22/18 02:03:03 ###########


########## Tcl recorder starts at 05/22/18 02:06:24 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vhd2jhd\" design.vhd -o design.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/22/18 02:06:24 ###########


########## Tcl recorder starts at 05/22/18 02:06:26 ##########

# Commands to make the Process: 
# JEDEC File
if [catch {open gigacart.cmd w} rspFile] {
	puts stderr "Cannot create response file gigacart.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: gigacart.sty
PROJECT: gigacart
WORKING_PATH: \"$proj_dir\"
MODULE: gigacart
VHDL_FILE_LIST: design.vhd
OUTPUT_FILE_NAME: gigacart
SUFFIX_NAME: edi
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DEFAULT_ENUM_ENCODING: default
ARRANGE_VHDL_FILES: true
synthesis_onoff_pragma: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -e gigacart -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete gigacart.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf gigacart.edi -out gigacart.bl0 -err automake.err -log gigacart.log -prj gigacart -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" gigacart.bl0 -collapse none -reduce none -keepwires  -err automake.err -family"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"gigacart.bl1\" -o \"gigacart.bl2\" -omod \"gigacart\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj gigacart -lci gigacart.lct -log gigacart.imp -err automake.err -tti gigacart.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci gigacart.lct -blifopt gigacart.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" gigacart.bl2 -sweep -mergefb -err automake.err -o gigacart.bl3 @gigacart.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci gigacart.lct -dev lc4k -diofft gigacart.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" gigacart.bl3 -family AMDMACH -idev van -o gigacart.bl4 -oxrf gigacart.xrf -err automake.err @gigacart.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci gigacart.lct -dev lc4k -prefit gigacart.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp gigacart.bl4 -out gigacart.bl5 -err automake.err -log gigacart.log -mod gigacart @gigacart.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open gigacart.rs1 w} rspFile] {
	puts stderr "Cannot create response file gigacart.rs1: $rspFile"
} else {
	puts $rspFile "-i gigacart.bl5 -lci gigacart.lct -d m4s_64_64 -lco gigacart.lco -html_rpt -fti gigacart.fti -fmt PLA -tto gigacart.tt4 -nojed -eqn gigacart.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open gigacart.rs2 w} rspFile] {
	puts stderr "Cannot create response file gigacart.rs2: $rspFile"
} else {
	puts $rspFile "-i gigacart.bl5 -lci gigacart.lct -d m4s_64_64 -lco gigacart.lco -html_rpt -fti gigacart.fti -fmt PLA -tto gigacart.tt4 -eqn gigacart.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@gigacart.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete gigacart.rs1
file delete gigacart.rs2
if [runCmd "\"$cpld_bin/tda\" -i gigacart.bl5 -o gigacart.tda -lci gigacart.lct -dev m4s_64_64 -family lc4k -mod gigacart -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj gigacart -if gigacart.jed -j2s -log gigacart.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/22/18 02:06:26 ###########


########## Tcl recorder starts at 05/22/18 02:07:01 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vhd2jhd\" design.vhd -o design.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/22/18 02:07:01 ###########


########## Tcl recorder starts at 05/22/18 02:07:05 ##########

# Commands to make the Process: 
# JEDEC File
if [catch {open gigacart.cmd w} rspFile] {
	puts stderr "Cannot create response file gigacart.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: gigacart.sty
PROJECT: gigacart
WORKING_PATH: \"$proj_dir\"
MODULE: gigacart
VHDL_FILE_LIST: design.vhd
OUTPUT_FILE_NAME: gigacart
SUFFIX_NAME: edi
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DEFAULT_ENUM_ENCODING: default
ARRANGE_VHDL_FILES: true
synthesis_onoff_pragma: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -e gigacart -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete gigacart.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf gigacart.edi -out gigacart.bl0 -err automake.err -log gigacart.log -prj gigacart -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" gigacart.bl0 -collapse none -reduce none -keepwires  -err automake.err -family"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"gigacart.bl1\" -o \"gigacart.bl2\" -omod \"gigacart\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj gigacart -lci gigacart.lct -log gigacart.imp -err automake.err -tti gigacart.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci gigacart.lct -blifopt gigacart.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" gigacart.bl2 -sweep -mergefb -err automake.err -o gigacart.bl3 @gigacart.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci gigacart.lct -dev lc4k -diofft gigacart.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" gigacart.bl3 -family AMDMACH -idev van -o gigacart.bl4 -oxrf gigacart.xrf -err automake.err @gigacart.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci gigacart.lct -dev lc4k -prefit gigacart.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp gigacart.bl4 -out gigacart.bl5 -err automake.err -log gigacart.log -mod gigacart @gigacart.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open gigacart.rs1 w} rspFile] {
	puts stderr "Cannot create response file gigacart.rs1: $rspFile"
} else {
	puts $rspFile "-i gigacart.bl5 -lci gigacart.lct -d m4s_64_64 -lco gigacart.lco -html_rpt -fti gigacart.fti -fmt PLA -tto gigacart.tt4 -nojed -eqn gigacart.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open gigacart.rs2 w} rspFile] {
	puts stderr "Cannot create response file gigacart.rs2: $rspFile"
} else {
	puts $rspFile "-i gigacart.bl5 -lci gigacart.lct -d m4s_64_64 -lco gigacart.lco -html_rpt -fti gigacart.fti -fmt PLA -tto gigacart.tt4 -eqn gigacart.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@gigacart.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete gigacart.rs1
file delete gigacart.rs2
if [runCmd "\"$cpld_bin/tda\" -i gigacart.bl5 -o gigacart.tda -lci gigacart.lct -dev m4s_64_64 -family lc4k -mod gigacart -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj gigacart -if gigacart.jed -j2s -log gigacart.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/22/18 02:07:05 ###########


########## Tcl recorder starts at 05/22/18 02:12:25 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vhd2jhd\" design.vhd -o design.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/22/18 02:12:25 ###########


########## Tcl recorder starts at 05/22/18 23:07:08 ##########

# Commands to make the Process: 
# Post-Fit Pinouts
if [catch {open gigacart.cmd w} rspFile] {
	puts stderr "Cannot create response file gigacart.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: gigacart.sty
PROJECT: gigacart
WORKING_PATH: \"$proj_dir\"
MODULE: gigacart
VHDL_FILE_LIST: design.vhd
OUTPUT_FILE_NAME: gigacart
SUFFIX_NAME: edi
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DEFAULT_ENUM_ENCODING: default
ARRANGE_VHDL_FILES: true
synthesis_onoff_pragma: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -e gigacart -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete gigacart.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf gigacart.edi -out gigacart.bl0 -err automake.err -log gigacart.log -prj gigacart -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" gigacart.bl0 -collapse none -reduce none -keepwires  -err automake.err -family"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"gigacart.bl1\" -o \"gigacart.bl2\" -omod \"gigacart\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj gigacart -lci gigacart.lct -log gigacart.imp -err automake.err -tti gigacart.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci gigacart.lct -blifopt gigacart.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" gigacart.bl2 -sweep -mergefb -err automake.err -o gigacart.bl3 @gigacart.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci gigacart.lct -dev lc4k -diofft gigacart.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" gigacart.bl3 -family AMDMACH -idev van -o gigacart.bl4 -oxrf gigacart.xrf -err automake.err @gigacart.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci gigacart.lct -dev lc4k -prefit gigacart.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp gigacart.bl4 -out gigacart.bl5 -err automake.err -log gigacart.log -mod gigacart @gigacart.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open gigacart.rs1 w} rspFile] {
	puts stderr "Cannot create response file gigacart.rs1: $rspFile"
} else {
	puts $rspFile "-i gigacart.bl5 -lci gigacart.lct -d m4s_64_64 -lco gigacart.lco -html_rpt -fti gigacart.fti -fmt PLA -tto gigacart.tt4 -nojed -eqn gigacart.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open gigacart.rs2 w} rspFile] {
	puts stderr "Cannot create response file gigacart.rs2: $rspFile"
} else {
	puts $rspFile "-i gigacart.bl5 -lci gigacart.lct -d m4s_64_64 -lco gigacart.lco -html_rpt -fti gigacart.fti -fmt PLA -tto gigacart.tt4 -eqn gigacart.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@gigacart.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete gigacart.rs1
file delete gigacart.rs2
if [runCmd "\"$cpld_bin/tda\" -i gigacart.bl5 -o gigacart.tda -lci gigacart.lct -dev m4s_64_64 -family lc4k -mod gigacart -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj gigacart -if gigacart.jed -j2s -log gigacart.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
# Application to view the Process: 
# Post-Fit Pinouts
if [catch {open lattice_cmd.rs2 w} rspFile] {
	puts stderr "Cannot create response file lattice_cmd.rs2: $rspFile"
} else {
	puts $rspFile "-src gigacart.tt4 -type PLA -devfile \"$install_dir/ispcpld/dat/lc4k/m4s_64_64.dev\" -postfit -lci gigacart.lco
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lciedit\" @lattice_cmd.rs2"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/22/18 23:07:08 ###########


########## Tcl recorder starts at 05/22/18 23:08:59 ##########

# Commands to make the Process: 
# Constraint Editor
if [runCmd "\"$cpld_bin/blifstat\" -i gigacart.bl5 -o gigacart.sif"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
# Application to view the Process: 
# Constraint Editor
if [catch {open lattice_cmd.rs2 w} rspFile] {
	puts stderr "Cannot create response file lattice_cmd.rs2: $rspFile"
} else {
	puts $rspFile "-nodal -src gigacart.bl5 -type BLIF -presrc gigacart.bl3 -crf gigacart.crf -sif gigacart.sif -devfile \"$install_dir/ispcpld/dat/lc4k/m4s_64_64.dev\" -lci gigacart.lct
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lciedit\" @lattice_cmd.rs2"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/22/18 23:08:59 ###########


########## Tcl recorder starts at 05/22/18 23:42:12 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vhd2jhd\" design.vhd -o design.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/22/18 23:42:12 ###########


########## Tcl recorder starts at 05/24/18 23:56:49 ##########

# Commands to make the Process: 
# Post-Fit Pinouts
if [catch {open gigacart.cmd w} rspFile] {
	puts stderr "Cannot create response file gigacart.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: gigacart.sty
PROJECT: gigacart
WORKING_PATH: \"$proj_dir\"
MODULE: gigacart
VHDL_FILE_LIST: design.vhd
OUTPUT_FILE_NAME: gigacart
SUFFIX_NAME: edi
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DEFAULT_ENUM_ENCODING: default
ARRANGE_VHDL_FILES: true
synthesis_onoff_pragma: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -e gigacart -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete gigacart.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf gigacart.edi -out gigacart.bl0 -err automake.err -log gigacart.log -prj gigacart -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" gigacart.bl0 -collapse none -reduce none -keepwires  -err automake.err -family"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"gigacart.bl1\" -o \"gigacart.bl2\" -omod \"gigacart\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj gigacart -lci gigacart.lct -log gigacart.imp -err automake.err -tti gigacart.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci gigacart.lct -blifopt gigacart.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" gigacart.bl2 -sweep -mergefb -err automake.err -o gigacart.bl3 @gigacart.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci gigacart.lct -dev lc4k -diofft gigacart.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" gigacart.bl3 -family AMDMACH -idev van -o gigacart.bl4 -oxrf gigacart.xrf -err automake.err @gigacart.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci gigacart.lct -dev lc4k -prefit gigacart.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp gigacart.bl4 -out gigacart.bl5 -err automake.err -log gigacart.log -mod gigacart @gigacart.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open gigacart.rs1 w} rspFile] {
	puts stderr "Cannot create response file gigacart.rs1: $rspFile"
} else {
	puts $rspFile "-i gigacart.bl5 -lci gigacart.lct -d m4s_64_64 -lco gigacart.lco -html_rpt -fti gigacart.fti -fmt PLA -tto gigacart.tt4 -nojed -eqn gigacart.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open gigacart.rs2 w} rspFile] {
	puts stderr "Cannot create response file gigacart.rs2: $rspFile"
} else {
	puts $rspFile "-i gigacart.bl5 -lci gigacart.lct -d m4s_64_64 -lco gigacart.lco -html_rpt -fti gigacart.fti -fmt PLA -tto gigacart.tt4 -eqn gigacart.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@gigacart.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete gigacart.rs1
file delete gigacart.rs2
if [runCmd "\"$cpld_bin/tda\" -i gigacart.bl5 -o gigacart.tda -lci gigacart.lct -dev m4s_64_64 -family lc4k -mod gigacart -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj gigacart -if gigacart.jed -j2s -log gigacart.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
# Application to view the Process: 
# Post-Fit Pinouts
if [catch {open lattice_cmd.rs2 w} rspFile] {
	puts stderr "Cannot create response file lattice_cmd.rs2: $rspFile"
} else {
	puts $rspFile "-src gigacart.tt4 -type PLA -devfile \"$install_dir/ispcpld/dat/lc4k/m4s_64_64.dev\" -postfit -lci gigacart.lco
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lciedit\" @lattice_cmd.rs2"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/24/18 23:56:49 ###########


########## Tcl recorder starts at 05/25/18 00:20:52 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vhd2jhd\" design.vhd -o design.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/25/18 00:20:52 ###########


########## Tcl recorder starts at 05/25/18 00:20:57 ##########

# Commands to make the Process: 
# Synplify Synthesize VHDL File
if [catch {open gigacart.cmd w} rspFile] {
	puts stderr "Cannot create response file gigacart.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: gigacart.sty
PROJECT: gigacart
WORKING_PATH: \"$proj_dir\"
MODULE: gigacart
VHDL_FILE_LIST: design.vhd
OUTPUT_FILE_NAME: gigacart
SUFFIX_NAME: edi
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DEFAULT_ENUM_ENCODING: default
ARRANGE_VHDL_FILES: true
synthesis_onoff_pragma: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -e gigacart -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete gigacart.cmd

########## Tcl recorder end at 05/25/18 00:20:57 ###########


########## Tcl recorder starts at 05/25/18 00:26:12 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vhd2jhd\" design.vhd -o design.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/25/18 00:26:12 ###########


########## Tcl recorder starts at 05/25/18 00:26:14 ##########

# Commands to make the Process: 
# Synplify Synthesize VHDL File
if [catch {open gigacart.cmd w} rspFile] {
	puts stderr "Cannot create response file gigacart.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: gigacart.sty
PROJECT: gigacart
WORKING_PATH: \"$proj_dir\"
MODULE: gigacart
VHDL_FILE_LIST: design.vhd
OUTPUT_FILE_NAME: gigacart
SUFFIX_NAME: edi
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DEFAULT_ENUM_ENCODING: default
ARRANGE_VHDL_FILES: true
synthesis_onoff_pragma: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -e gigacart -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete gigacart.cmd

########## Tcl recorder end at 05/25/18 00:26:14 ###########


########## Tcl recorder starts at 05/25/18 00:28:52 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vhd2jhd\" design.vhd -o design.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/25/18 00:28:52 ###########


########## Tcl recorder starts at 05/25/18 00:28:54 ##########

# Commands to make the Process: 
# Synplify Synthesize VHDL File
if [catch {open gigacart.cmd w} rspFile] {
	puts stderr "Cannot create response file gigacart.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: gigacart.sty
PROJECT: gigacart
WORKING_PATH: \"$proj_dir\"
MODULE: gigacart
VHDL_FILE_LIST: design.vhd
OUTPUT_FILE_NAME: gigacart
SUFFIX_NAME: edi
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DEFAULT_ENUM_ENCODING: default
ARRANGE_VHDL_FILES: true
synthesis_onoff_pragma: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -e gigacart -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete gigacart.cmd

########## Tcl recorder end at 05/25/18 00:28:54 ###########


########## Tcl recorder starts at 05/25/18 00:30:00 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vhd2jhd\" design.vhd -o design.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/25/18 00:30:00 ###########


########## Tcl recorder starts at 05/25/18 00:30:04 ##########

# Commands to make the Process: 
# Synplify Synthesize VHDL File
if [catch {open gigacart.cmd w} rspFile] {
	puts stderr "Cannot create response file gigacart.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: gigacart.sty
PROJECT: gigacart
WORKING_PATH: \"$proj_dir\"
MODULE: gigacart
VHDL_FILE_LIST: design.vhd
OUTPUT_FILE_NAME: gigacart
SUFFIX_NAME: edi
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DEFAULT_ENUM_ENCODING: default
ARRANGE_VHDL_FILES: true
synthesis_onoff_pragma: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -e gigacart -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete gigacart.cmd

########## Tcl recorder end at 05/25/18 00:30:04 ###########


########## Tcl recorder starts at 05/25/18 00:35:22 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vhd2jhd\" design.vhd -o design.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/25/18 00:35:22 ###########


########## Tcl recorder starts at 05/25/18 00:35:24 ##########

# Commands to make the Process: 
# Synplify Synthesize VHDL File
if [catch {open gigacart.cmd w} rspFile] {
	puts stderr "Cannot create response file gigacart.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: gigacart.sty
PROJECT: gigacart
WORKING_PATH: \"$proj_dir\"
MODULE: gigacart
VHDL_FILE_LIST: design.vhd
OUTPUT_FILE_NAME: gigacart
SUFFIX_NAME: edi
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DEFAULT_ENUM_ENCODING: default
ARRANGE_VHDL_FILES: true
synthesis_onoff_pragma: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -e gigacart -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete gigacart.cmd

########## Tcl recorder end at 05/25/18 00:35:24 ###########


########## Tcl recorder starts at 05/25/18 00:36:25 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vhd2jhd\" design.vhd -o design.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/25/18 00:36:25 ###########


########## Tcl recorder starts at 05/25/18 00:36:29 ##########

# Commands to make the Process: 
# Synplify Synthesize VHDL File
if [catch {open gigacart.cmd w} rspFile] {
	puts stderr "Cannot create response file gigacart.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: gigacart.sty
PROJECT: gigacart
WORKING_PATH: \"$proj_dir\"
MODULE: gigacart
VHDL_FILE_LIST: design.vhd
OUTPUT_FILE_NAME: gigacart
SUFFIX_NAME: edi
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DEFAULT_ENUM_ENCODING: default
ARRANGE_VHDL_FILES: true
synthesis_onoff_pragma: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -e gigacart -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete gigacart.cmd

########## Tcl recorder end at 05/25/18 00:36:29 ###########


########## Tcl recorder starts at 05/25/18 00:39:44 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vhd2jhd\" design.vhd -o design.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/25/18 00:39:44 ###########


########## Tcl recorder starts at 05/25/18 00:39:47 ##########

# Commands to make the Process: 
# Synplify Synthesize VHDL File
if [catch {open gigacart.cmd w} rspFile] {
	puts stderr "Cannot create response file gigacart.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: gigacart.sty
PROJECT: gigacart
WORKING_PATH: \"$proj_dir\"
MODULE: gigacart
VHDL_FILE_LIST: design.vhd
OUTPUT_FILE_NAME: gigacart
SUFFIX_NAME: edi
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DEFAULT_ENUM_ENCODING: default
ARRANGE_VHDL_FILES: true
synthesis_onoff_pragma: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -e gigacart -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete gigacart.cmd

########## Tcl recorder end at 05/25/18 00:39:47 ###########


########## Tcl recorder starts at 05/25/18 00:43:45 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vhd2jhd\" design.vhd -o design.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/25/18 00:43:45 ###########


########## Tcl recorder starts at 05/25/18 00:43:48 ##########

# Commands to make the Process: 
# Synplify Synthesize VHDL File
if [catch {open gigacart.cmd w} rspFile] {
	puts stderr "Cannot create response file gigacart.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: gigacart.sty
PROJECT: gigacart
WORKING_PATH: \"$proj_dir\"
MODULE: gigacart
VHDL_FILE_LIST: design.vhd
OUTPUT_FILE_NAME: gigacart
SUFFIX_NAME: edi
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DEFAULT_ENUM_ENCODING: default
ARRANGE_VHDL_FILES: true
synthesis_onoff_pragma: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -e gigacart -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete gigacart.cmd

########## Tcl recorder end at 05/25/18 00:43:48 ###########


########## Tcl recorder starts at 05/25/18 00:49:04 ##########

# Commands to make the Process: 
# Compiled Equations
if [catch {open gigacart.cmd w} rspFile] {
	puts stderr "Cannot create response file gigacart.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: gigacart.sty
PROJECT: gigacart
WORKING_PATH: \"$proj_dir\"
MODULE: gigacart
VHDL_FILE_LIST: design.vhd
OUTPUT_FILE_NAME: gigacart
SUFFIX_NAME: edi
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DEFAULT_ENUM_ENCODING: default
ARRANGE_VHDL_FILES: true
synthesis_onoff_pragma: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -e gigacart -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete gigacart.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf gigacart.edi -out gigacart.bl0 -err automake.err -log gigacart.log -prj gigacart -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/blif2eqn\" gigacart.bl0 -o gigacart.eq0  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/25/18 00:49:04 ###########


########## Tcl recorder starts at 05/25/18 00:49:21 ##########

# Commands to make the Process: 
# Signal Cross Reference
if [catch {open gigacart.cmd w} rspFile] {
	puts stderr "Cannot create response file gigacart.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: gigacart.sty
PROJECT: gigacart
WORKING_PATH: \"$proj_dir\"
MODULE: gigacart
VHDL_FILE_LIST: design.vhd
OUTPUT_FILE_NAME: gigacart
SUFFIX_NAME: edi
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DEFAULT_ENUM_ENCODING: default
ARRANGE_VHDL_FILES: true
synthesis_onoff_pragma: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -e gigacart -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete gigacart.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf gigacart.edi -out gigacart.bl0 -err automake.err -log gigacart.log -prj gigacart -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/25/18 00:49:21 ###########


########## Tcl recorder starts at 05/25/18 00:50:49 ##########

# Commands to make the Process: 
# Synplify Synthesize VHDL File
if [catch {open gigacart.cmd w} rspFile] {
	puts stderr "Cannot create response file gigacart.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: gigacart.sty
PROJECT: gigacart
WORKING_PATH: \"$proj_dir\"
MODULE: gigacart
VHDL_FILE_LIST: design.vhd
OUTPUT_FILE_NAME: gigacart
SUFFIX_NAME: edi
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DEFAULT_ENUM_ENCODING: default
ARRANGE_VHDL_FILES: true
synthesis_onoff_pragma: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -e gigacart -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete gigacart.cmd

########## Tcl recorder end at 05/25/18 00:50:49 ###########


########## Tcl recorder starts at 05/25/18 00:55:49 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vhd2jhd\" design.vhd -o design.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/25/18 00:55:49 ###########


########## Tcl recorder starts at 05/25/18 00:58:36 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vhd2jhd\" design.vhd -o design.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/25/18 00:58:36 ###########


########## Tcl recorder starts at 05/25/18 00:58:41 ##########

# Commands to make the Process: 
# Synplify Synthesize VHDL File
if [catch {open gigacart.cmd w} rspFile] {
	puts stderr "Cannot create response file gigacart.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: gigacart.sty
PROJECT: gigacart
WORKING_PATH: \"$proj_dir\"
MODULE: gigacart
VHDL_FILE_LIST: design.vhd
OUTPUT_FILE_NAME: gigacart
SUFFIX_NAME: edi
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DEFAULT_ENUM_ENCODING: default
ARRANGE_VHDL_FILES: true
synthesis_onoff_pragma: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -e gigacart -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete gigacart.cmd

########## Tcl recorder end at 05/25/18 00:58:41 ###########


########## Tcl recorder starts at 05/25/18 01:09:57 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vhd2jhd\" design.vhd -o design.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/25/18 01:09:57 ###########


########## Tcl recorder starts at 05/25/18 01:10:04 ##########

# Commands to make the Process: 
# Synplify Synthesize VHDL File
if [catch {open gigacart.cmd w} rspFile] {
	puts stderr "Cannot create response file gigacart.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: gigacart.sty
PROJECT: gigacart
WORKING_PATH: \"$proj_dir\"
MODULE: gigacart
VHDL_FILE_LIST: design.vhd
OUTPUT_FILE_NAME: gigacart
SUFFIX_NAME: edi
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DEFAULT_ENUM_ENCODING: default
ARRANGE_VHDL_FILES: true
synthesis_onoff_pragma: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -e gigacart -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete gigacart.cmd

########## Tcl recorder end at 05/25/18 01:10:04 ###########


########## Tcl recorder starts at 05/25/18 01:14:34 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vhd2jhd\" design.vhd -o design.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/25/18 01:14:34 ###########


########## Tcl recorder starts at 05/25/18 01:14:38 ##########

# Commands to make the Process: 
# Synplify Synthesize VHDL File
if [catch {open gigacart.cmd w} rspFile] {
	puts stderr "Cannot create response file gigacart.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: gigacart.sty
PROJECT: gigacart
WORKING_PATH: \"$proj_dir\"
MODULE: gigacart
VHDL_FILE_LIST: design.vhd
OUTPUT_FILE_NAME: gigacart
SUFFIX_NAME: edi
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DEFAULT_ENUM_ENCODING: default
ARRANGE_VHDL_FILES: true
synthesis_onoff_pragma: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -e gigacart -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete gigacart.cmd

########## Tcl recorder end at 05/25/18 01:14:38 ###########


########## Tcl recorder starts at 05/25/18 01:15:07 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vhd2jhd\" design.vhd -o design.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/25/18 01:15:07 ###########


########## Tcl recorder starts at 05/25/18 01:15:11 ##########

# Commands to make the Process: 
# Synplify Synthesize VHDL File
if [catch {open gigacart.cmd w} rspFile] {
	puts stderr "Cannot create response file gigacart.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: gigacart.sty
PROJECT: gigacart
WORKING_PATH: \"$proj_dir\"
MODULE: gigacart
VHDL_FILE_LIST: design.vhd
OUTPUT_FILE_NAME: gigacart
SUFFIX_NAME: edi
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DEFAULT_ENUM_ENCODING: default
ARRANGE_VHDL_FILES: true
synthesis_onoff_pragma: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -e gigacart -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete gigacart.cmd

########## Tcl recorder end at 05/25/18 01:15:11 ###########


########## Tcl recorder starts at 05/25/18 01:17:00 ##########

# Commands to make the Process: 
# Constraint Editor
if [runCmd "\"$cpld_bin/edif2blf\" -edf gigacart.edi -out gigacart.bl0 -err automake.err -log gigacart.log -prj gigacart -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" gigacart.bl0 -collapse none -reduce none -keepwires  -err automake.err -family"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"gigacart.bl1\" -o \"gigacart.bl2\" -omod \"gigacart\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj gigacart -lci gigacart.lct -log gigacart.imp -err automake.err -tti gigacart.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci gigacart.lct -blifopt gigacart.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" gigacart.bl2 -sweep -mergefb -err automake.err -o gigacart.bl3 @gigacart.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci gigacart.lct -dev lc4k -diofft gigacart.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" gigacart.bl3 -family AMDMACH -idev van -o gigacart.bl4 -oxrf gigacart.xrf -err automake.err @gigacart.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci gigacart.lct -dev lc4k -prefit gigacart.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp gigacart.bl4 -out gigacart.bl5 -err automake.err -log gigacart.log -mod gigacart @gigacart.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/blifstat\" -i gigacart.bl5 -o gigacart.sif"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
# Application to view the Process: 
# Constraint Editor
if [catch {open lattice_cmd.rs2 w} rspFile] {
	puts stderr "Cannot create response file lattice_cmd.rs2: $rspFile"
} else {
	puts $rspFile "-nodal -src gigacart.bl5 -type BLIF -presrc gigacart.bl3 -crf gigacart.crf -sif gigacart.sif -devfile \"$install_dir/ispcpld/dat/lc4k/m4s_64_64.dev\" -lci gigacart.lct
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lciedit\" @lattice_cmd.rs2"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/25/18 01:17:00 ###########


########## Tcl recorder starts at 05/25/18 01:19:37 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open gigacart.rs1 w} rspFile] {
	puts stderr "Cannot create response file gigacart.rs1: $rspFile"
} else {
	puts $rspFile "-i gigacart.bl5 -lci gigacart.lct -d m4s_64_64 -lco gigacart.lco -html_rpt -fti gigacart.fti -fmt PLA -tto gigacart.tt4 -nojed -eqn gigacart.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open gigacart.rs2 w} rspFile] {
	puts stderr "Cannot create response file gigacart.rs2: $rspFile"
} else {
	puts $rspFile "-i gigacart.bl5 -lci gigacart.lct -d m4s_64_64 -lco gigacart.lco -html_rpt -fti gigacart.fti -fmt PLA -tto gigacart.tt4 -eqn gigacart.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@gigacart.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete gigacart.rs1
file delete gigacart.rs2
if [runCmd "\"$cpld_bin/tda\" -i gigacart.bl5 -o gigacart.tda -lci gigacart.lct -dev m4s_64_64 -family lc4k -mod gigacart -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj gigacart -if gigacart.jed -j2s -log gigacart.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/25/18 01:19:37 ###########


########## Tcl recorder starts at 05/25/18 01:23:41 ##########

# Commands to make the Process: 
# Constraint Editor
if [runCmd "\"$cpld_bin/blifstat\" -i gigacart.bl5 -o gigacart.sif"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
# Application to view the Process: 
# Constraint Editor
if [catch {open lattice_cmd.rs2 w} rspFile] {
	puts stderr "Cannot create response file lattice_cmd.rs2: $rspFile"
} else {
	puts $rspFile "-nodal -src gigacart.bl5 -type BLIF -presrc gigacart.bl3 -crf gigacart.crf -sif gigacart.sif -devfile \"$install_dir/ispcpld/dat/lc4k/m4s_64_64.dev\" -lci gigacart.lct
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lciedit\" @lattice_cmd.rs2"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/25/18 01:23:41 ###########


########## Tcl recorder starts at 05/25/18 01:25:55 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vhd2jhd\" design.vhd -o design.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/25/18 01:25:55 ###########


########## Tcl recorder starts at 05/25/18 01:26:00 ##########

# Commands to make the Process: 
# JEDEC File
if [catch {open gigacart.cmd w} rspFile] {
	puts stderr "Cannot create response file gigacart.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: gigacart.sty
PROJECT: gigacart
WORKING_PATH: \"$proj_dir\"
MODULE: gigacart
VHDL_FILE_LIST: design.vhd
OUTPUT_FILE_NAME: gigacart
SUFFIX_NAME: edi
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DEFAULT_ENUM_ENCODING: default
ARRANGE_VHDL_FILES: true
synthesis_onoff_pragma: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -e gigacart -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete gigacart.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf gigacart.edi -out gigacart.bl0 -err automake.err -log gigacart.log -prj gigacart -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" gigacart.bl0 -collapse none -reduce none -keepwires  -err automake.err -family"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"gigacart.bl1\" -o \"gigacart.bl2\" -omod \"gigacart\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj gigacart -lci gigacart.lct -log gigacart.imp -err automake.err -tti gigacart.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci gigacart.lct -blifopt gigacart.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" gigacart.bl2 -sweep -mergefb -err automake.err -o gigacart.bl3 @gigacart.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci gigacart.lct -dev lc4k -diofft gigacart.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" gigacart.bl3 -family AMDMACH -idev van -o gigacart.bl4 -oxrf gigacart.xrf -err automake.err @gigacart.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci gigacart.lct -dev lc4k -prefit gigacart.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp gigacart.bl4 -out gigacart.bl5 -err automake.err -log gigacart.log -mod gigacart @gigacart.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open gigacart.rs1 w} rspFile] {
	puts stderr "Cannot create response file gigacart.rs1: $rspFile"
} else {
	puts $rspFile "-i gigacart.bl5 -lci gigacart.lct -d m4s_64_64 -lco gigacart.lco -html_rpt -fti gigacart.fti -fmt PLA -tto gigacart.tt4 -nojed -eqn gigacart.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open gigacart.rs2 w} rspFile] {
	puts stderr "Cannot create response file gigacart.rs2: $rspFile"
} else {
	puts $rspFile "-i gigacart.bl5 -lci gigacart.lct -d m4s_64_64 -lco gigacart.lco -html_rpt -fti gigacart.fti -fmt PLA -tto gigacart.tt4 -eqn gigacart.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@gigacart.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete gigacart.rs1
file delete gigacart.rs2
if [runCmd "\"$cpld_bin/tda\" -i gigacart.bl5 -o gigacart.tda -lci gigacart.lct -dev m4s_64_64 -family lc4k -mod gigacart -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj gigacart -if gigacart.jed -j2s -log gigacart.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/25/18 01:26:00 ###########


########## Tcl recorder starts at 05/25/18 20:35:20 ##########

# Commands to make the Process: 
# Post-Fit Pinouts
# - none -
# Application to view the Process: 
# Post-Fit Pinouts
if [catch {open lattice_cmd.rs2 w} rspFile] {
	puts stderr "Cannot create response file lattice_cmd.rs2: $rspFile"
} else {
	puts $rspFile "-src gigacart.tt4 -type PLA -devfile \"$install_dir/ispcpld/dat/lc4k/m4s_64_64.dev\" -postfit -lci gigacart.lco
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lciedit\" @lattice_cmd.rs2"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/25/18 20:35:20 ###########


########## Tcl recorder starts at 05/25/18 21:08:58 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vhd2jhd\" design.vhd -o design.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/25/18 21:08:58 ###########


########## Tcl recorder starts at 05/25/18 21:09:02 ##########

# Commands to make the Process: 
# Synplify Synthesize VHDL File
if [catch {open gigacart.cmd w} rspFile] {
	puts stderr "Cannot create response file gigacart.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: gigacart.sty
PROJECT: gigacart
WORKING_PATH: \"$proj_dir\"
MODULE: gigacart
VHDL_FILE_LIST: design.vhd
OUTPUT_FILE_NAME: gigacart
SUFFIX_NAME: edi
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DEFAULT_ENUM_ENCODING: default
ARRANGE_VHDL_FILES: true
synthesis_onoff_pragma: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -e gigacart -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete gigacart.cmd

########## Tcl recorder end at 05/25/18 21:09:02 ###########


########## Tcl recorder starts at 05/25/18 21:10:23 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vhd2jhd\" design.vhd -o design.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/25/18 21:10:23 ###########


########## Tcl recorder starts at 05/25/18 21:10:26 ##########

# Commands to make the Process: 
# Synplify Synthesize VHDL File
if [catch {open gigacart.cmd w} rspFile] {
	puts stderr "Cannot create response file gigacart.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: gigacart.sty
PROJECT: gigacart
WORKING_PATH: \"$proj_dir\"
MODULE: gigacart
VHDL_FILE_LIST: design.vhd
OUTPUT_FILE_NAME: gigacart
SUFFIX_NAME: edi
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DEFAULT_ENUM_ENCODING: default
ARRANGE_VHDL_FILES: true
synthesis_onoff_pragma: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -e gigacart -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete gigacart.cmd

########## Tcl recorder end at 05/25/18 21:10:26 ###########


########## Tcl recorder starts at 05/25/18 21:10:50 ##########

# Commands to make the Process: 
# JEDEC File
if [runCmd "\"$cpld_bin/edif2blf\" -edf gigacart.edi -out gigacart.bl0 -err automake.err -log gigacart.log -prj gigacart -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" gigacart.bl0 -collapse none -reduce none -keepwires  -err automake.err -family"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"gigacart.bl1\" -o \"gigacart.bl2\" -omod \"gigacart\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj gigacart -lci gigacart.lct -log gigacart.imp -err automake.err -tti gigacart.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci gigacart.lct -blifopt gigacart.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" gigacart.bl2 -sweep -mergefb -err automake.err -o gigacart.bl3 @gigacart.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci gigacart.lct -dev lc4k -diofft gigacart.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" gigacart.bl3 -family AMDMACH -idev van -o gigacart.bl4 -oxrf gigacart.xrf -err automake.err @gigacart.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci gigacart.lct -dev lc4k -prefit gigacart.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp gigacart.bl4 -out gigacart.bl5 -err automake.err -log gigacart.log -mod gigacart @gigacart.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open gigacart.rs1 w} rspFile] {
	puts stderr "Cannot create response file gigacart.rs1: $rspFile"
} else {
	puts $rspFile "-i gigacart.bl5 -lci gigacart.lct -d m4s_64_64 -lco gigacart.lco -html_rpt -fti gigacart.fti -fmt PLA -tto gigacart.tt4 -nojed -eqn gigacart.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open gigacart.rs2 w} rspFile] {
	puts stderr "Cannot create response file gigacart.rs2: $rspFile"
} else {
	puts $rspFile "-i gigacart.bl5 -lci gigacart.lct -d m4s_64_64 -lco gigacart.lco -html_rpt -fti gigacart.fti -fmt PLA -tto gigacart.tt4 -eqn gigacart.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@gigacart.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete gigacart.rs1
file delete gigacart.rs2
if [runCmd "\"$cpld_bin/tda\" -i gigacart.bl5 -o gigacart.tda -lci gigacart.lct -dev m4s_64_64 -family lc4k -mod gigacart -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj gigacart -if gigacart.jed -j2s -log gigacart.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/25/18 21:10:50 ###########


########## Tcl recorder starts at 05/25/18 21:13:37 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vhd2jhd\" design.vhd -o design.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/25/18 21:13:37 ###########


########## Tcl recorder starts at 05/25/18 21:13:40 ##########

# Commands to make the Process: 
# JEDEC File
if [catch {open gigacart.cmd w} rspFile] {
	puts stderr "Cannot create response file gigacart.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: gigacart.sty
PROJECT: gigacart
WORKING_PATH: \"$proj_dir\"
MODULE: gigacart
VHDL_FILE_LIST: design.vhd
OUTPUT_FILE_NAME: gigacart
SUFFIX_NAME: edi
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DEFAULT_ENUM_ENCODING: default
ARRANGE_VHDL_FILES: true
synthesis_onoff_pragma: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -e gigacart -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete gigacart.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf gigacart.edi -out gigacart.bl0 -err automake.err -log gigacart.log -prj gigacart -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" gigacart.bl0 -collapse none -reduce none -keepwires  -err automake.err -family"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"gigacart.bl1\" -o \"gigacart.bl2\" -omod \"gigacart\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj gigacart -lci gigacart.lct -log gigacart.imp -err automake.err -tti gigacart.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci gigacart.lct -blifopt gigacart.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" gigacart.bl2 -sweep -mergefb -err automake.err -o gigacart.bl3 @gigacart.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci gigacart.lct -dev lc4k -diofft gigacart.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" gigacart.bl3 -family AMDMACH -idev van -o gigacart.bl4 -oxrf gigacart.xrf -err automake.err @gigacart.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci gigacart.lct -dev lc4k -prefit gigacart.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp gigacart.bl4 -out gigacart.bl5 -err automake.err -log gigacart.log -mod gigacart @gigacart.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open gigacart.rs1 w} rspFile] {
	puts stderr "Cannot create response file gigacart.rs1: $rspFile"
} else {
	puts $rspFile "-i gigacart.bl5 -lci gigacart.lct -d m4s_64_64 -lco gigacart.lco -html_rpt -fti gigacart.fti -fmt PLA -tto gigacart.tt4 -nojed -eqn gigacart.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open gigacart.rs2 w} rspFile] {
	puts stderr "Cannot create response file gigacart.rs2: $rspFile"
} else {
	puts $rspFile "-i gigacart.bl5 -lci gigacart.lct -d m4s_64_64 -lco gigacart.lco -html_rpt -fti gigacart.fti -fmt PLA -tto gigacart.tt4 -eqn gigacart.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@gigacart.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete gigacart.rs1
file delete gigacart.rs2
if [runCmd "\"$cpld_bin/tda\" -i gigacart.bl5 -o gigacart.tda -lci gigacart.lct -dev m4s_64_64 -family lc4k -mod gigacart -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj gigacart -if gigacart.jed -j2s -log gigacart.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/25/18 21:13:40 ###########


########## Tcl recorder starts at 05/25/18 22:04:01 ##########

# Commands to make the Process: 
# Constraint Editor
if [runCmd "\"$cpld_bin/blifstat\" -i gigacart.bl5 -o gigacart.sif"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
# Application to view the Process: 
# Constraint Editor
if [catch {open lattice_cmd.rs2 w} rspFile] {
	puts stderr "Cannot create response file lattice_cmd.rs2: $rspFile"
} else {
	puts $rspFile "-nodal -src gigacart.bl5 -type BLIF -presrc gigacart.bl3 -crf gigacart.crf -sif gigacart.sif -devfile \"$install_dir/ispcpld/dat/lc4k/m4s_64_64.dev\" -lci gigacart.lct
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lciedit\" @lattice_cmd.rs2"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/25/18 22:04:01 ###########


########## Tcl recorder starts at 05/25/18 22:14:11 ##########

# Commands to make the Process: 
# Constraint Editor
# - none -
# Application to view the Process: 
# Constraint Editor
if [catch {open lattice_cmd.rs2 w} rspFile] {
	puts stderr "Cannot create response file lattice_cmd.rs2: $rspFile"
} else {
	puts $rspFile "-nodal -src gigacart.bl5 -type BLIF -presrc gigacart.bl3 -crf gigacart.crf -sif gigacart.sif -devfile \"$install_dir/ispcpld/dat/lc4k/m4s_64_64.dev\" -lci gigacart.lct
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lciedit\" @lattice_cmd.rs2"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/25/18 22:14:11 ###########


########## Tcl recorder starts at 05/25/18 23:06:12 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vhd2jhd\" design.vhd -o design.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/25/18 23:06:12 ###########


########## Tcl recorder starts at 05/25/18 23:06:16 ##########

# Commands to make the Process: 
# Synplify Synthesize VHDL File
if [catch {open gigacart.cmd w} rspFile] {
	puts stderr "Cannot create response file gigacart.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: gigacart.sty
PROJECT: gigacart
WORKING_PATH: \"$proj_dir\"
MODULE: gigacart
VHDL_FILE_LIST: design.vhd
OUTPUT_FILE_NAME: gigacart
SUFFIX_NAME: edi
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DEFAULT_ENUM_ENCODING: default
ARRANGE_VHDL_FILES: true
synthesis_onoff_pragma: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -e gigacart -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete gigacart.cmd

########## Tcl recorder end at 05/25/18 23:06:16 ###########


########## Tcl recorder starts at 05/25/18 23:06:36 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vhd2jhd\" design.vhd -o design.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/25/18 23:06:36 ###########


########## Tcl recorder starts at 05/25/18 23:06:38 ##########

# Commands to make the Process: 
# Synplify Synthesize VHDL File
if [catch {open gigacart.cmd w} rspFile] {
	puts stderr "Cannot create response file gigacart.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: gigacart.sty
PROJECT: gigacart
WORKING_PATH: \"$proj_dir\"
MODULE: gigacart
VHDL_FILE_LIST: design.vhd
OUTPUT_FILE_NAME: gigacart
SUFFIX_NAME: edi
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DEFAULT_ENUM_ENCODING: default
ARRANGE_VHDL_FILES: true
synthesis_onoff_pragma: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -e gigacart -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete gigacart.cmd

########## Tcl recorder end at 05/25/18 23:06:38 ###########


########## Tcl recorder starts at 05/25/18 23:08:06 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vhd2jhd\" design.vhd -o design.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/25/18 23:08:06 ###########


########## Tcl recorder starts at 05/25/18 23:08:08 ##########

# Commands to make the Process: 
# Synplify Synthesize VHDL File
if [catch {open gigacart.cmd w} rspFile] {
	puts stderr "Cannot create response file gigacart.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: gigacart.sty
PROJECT: gigacart
WORKING_PATH: \"$proj_dir\"
MODULE: gigacart
VHDL_FILE_LIST: design.vhd
OUTPUT_FILE_NAME: gigacart
SUFFIX_NAME: edi
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DEFAULT_ENUM_ENCODING: default
ARRANGE_VHDL_FILES: true
synthesis_onoff_pragma: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -e gigacart -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete gigacart.cmd

########## Tcl recorder end at 05/25/18 23:08:08 ###########


########## Tcl recorder starts at 05/25/18 23:08:39 ##########

# Commands to make the Process: 
# JEDEC File
if [runCmd "\"$cpld_bin/edif2blf\" -edf gigacart.edi -out gigacart.bl0 -err automake.err -log gigacart.log -prj gigacart -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" gigacart.bl0 -collapse none -reduce none -keepwires  -err automake.err -family"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"gigacart.bl1\" -o \"gigacart.bl2\" -omod \"gigacart\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj gigacart -lci gigacart.lct -log gigacart.imp -err automake.err -tti gigacart.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci gigacart.lct -blifopt gigacart.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" gigacart.bl2 -sweep -mergefb -err automake.err -o gigacart.bl3 @gigacart.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci gigacart.lct -dev lc4k -diofft gigacart.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" gigacart.bl3 -family AMDMACH -idev van -o gigacart.bl4 -oxrf gigacart.xrf -err automake.err @gigacart.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci gigacart.lct -dev lc4k -prefit gigacart.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp gigacart.bl4 -out gigacart.bl5 -err automake.err -log gigacart.log -mod gigacart @gigacart.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open gigacart.rs1 w} rspFile] {
	puts stderr "Cannot create response file gigacart.rs1: $rspFile"
} else {
	puts $rspFile "-i gigacart.bl5 -lci gigacart.lct -d m4s_64_64 -lco gigacart.lco -html_rpt -fti gigacart.fti -fmt PLA -tto gigacart.tt4 -nojed -eqn gigacart.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open gigacart.rs2 w} rspFile] {
	puts stderr "Cannot create response file gigacart.rs2: $rspFile"
} else {
	puts $rspFile "-i gigacart.bl5 -lci gigacart.lct -d m4s_64_64 -lco gigacart.lco -html_rpt -fti gigacart.fti -fmt PLA -tto gigacart.tt4 -eqn gigacart.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@gigacart.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete gigacart.rs1
file delete gigacart.rs2
if [runCmd "\"$cpld_bin/tda\" -i gigacart.bl5 -o gigacart.tda -lci gigacart.lct -dev m4s_64_64 -family lc4k -mod gigacart -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj gigacart -if gigacart.jed -j2s -log gigacart.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/25/18 23:08:39 ###########


########## Tcl recorder starts at 05/25/18 23:52:34 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vhd2jhd\" design.vhd -o design.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/25/18 23:52:34 ###########


########## Tcl recorder starts at 05/25/18 23:56:30 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vhd2jhd\" design.vhd -o design.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/25/18 23:56:30 ###########


########## Tcl recorder starts at 05/25/18 23:56:37 ##########

# Commands to make the Process: 
# JEDEC File
if [catch {open gigacart.cmd w} rspFile] {
	puts stderr "Cannot create response file gigacart.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: gigacart.sty
PROJECT: gigacart
WORKING_PATH: \"$proj_dir\"
MODULE: gigacart
VHDL_FILE_LIST: design.vhd
OUTPUT_FILE_NAME: gigacart
SUFFIX_NAME: edi
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DEFAULT_ENUM_ENCODING: default
ARRANGE_VHDL_FILES: true
synthesis_onoff_pragma: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -e gigacart -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete gigacart.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf gigacart.edi -out gigacart.bl0 -err automake.err -log gigacart.log -prj gigacart -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" gigacart.bl0 -collapse none -reduce none -keepwires  -err automake.err -family"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"gigacart.bl1\" -o \"gigacart.bl2\" -omod \"gigacart\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj gigacart -lci gigacart.lct -log gigacart.imp -err automake.err -tti gigacart.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci gigacart.lct -blifopt gigacart.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" gigacart.bl2 -sweep -mergefb -err automake.err -o gigacart.bl3 @gigacart.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci gigacart.lct -dev lc4k -diofft gigacart.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" gigacart.bl3 -family AMDMACH -idev van -o gigacart.bl4 -oxrf gigacart.xrf -err automake.err @gigacart.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci gigacart.lct -dev lc4k -prefit gigacart.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp gigacart.bl4 -out gigacart.bl5 -err automake.err -log gigacart.log -mod gigacart @gigacart.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open gigacart.rs1 w} rspFile] {
	puts stderr "Cannot create response file gigacart.rs1: $rspFile"
} else {
	puts $rspFile "-i gigacart.bl5 -lci gigacart.lct -d m4s_64_64 -lco gigacart.lco -html_rpt -fti gigacart.fti -fmt PLA -tto gigacart.tt4 -nojed -eqn gigacart.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open gigacart.rs2 w} rspFile] {
	puts stderr "Cannot create response file gigacart.rs2: $rspFile"
} else {
	puts $rspFile "-i gigacart.bl5 -lci gigacart.lct -d m4s_64_64 -lco gigacart.lco -html_rpt -fti gigacart.fti -fmt PLA -tto gigacart.tt4 -eqn gigacart.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@gigacart.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete gigacart.rs1
file delete gigacart.rs2
if [runCmd "\"$cpld_bin/tda\" -i gigacart.bl5 -o gigacart.tda -lci gigacart.lct -dev m4s_64_64 -family lc4k -mod gigacart -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj gigacart -if gigacart.jed -j2s -log gigacart.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/25/18 23:56:37 ###########


########## Tcl recorder starts at 05/25/18 23:57:32 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vhd2jhd\" design.vhd -o design.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/25/18 23:57:32 ###########


########## Tcl recorder starts at 05/25/18 23:57:34 ##########

# Commands to make the Process: 
# JEDEC File
if [catch {open gigacart.cmd w} rspFile] {
	puts stderr "Cannot create response file gigacart.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: gigacart.sty
PROJECT: gigacart
WORKING_PATH: \"$proj_dir\"
MODULE: gigacart
VHDL_FILE_LIST: design.vhd
OUTPUT_FILE_NAME: gigacart
SUFFIX_NAME: edi
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DEFAULT_ENUM_ENCODING: default
ARRANGE_VHDL_FILES: true
synthesis_onoff_pragma: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -e gigacart -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete gigacart.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf gigacart.edi -out gigacart.bl0 -err automake.err -log gigacart.log -prj gigacart -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" gigacart.bl0 -collapse none -reduce none -keepwires  -err automake.err -family"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"gigacart.bl1\" -o \"gigacart.bl2\" -omod \"gigacart\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj gigacart -lci gigacart.lct -log gigacart.imp -err automake.err -tti gigacart.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci gigacart.lct -blifopt gigacart.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" gigacart.bl2 -sweep -mergefb -err automake.err -o gigacart.bl3 @gigacart.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci gigacart.lct -dev lc4k -diofft gigacart.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" gigacart.bl3 -family AMDMACH -idev van -o gigacart.bl4 -oxrf gigacart.xrf -err automake.err @gigacart.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci gigacart.lct -dev lc4k -prefit gigacart.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp gigacart.bl4 -out gigacart.bl5 -err automake.err -log gigacart.log -mod gigacart @gigacart.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open gigacart.rs1 w} rspFile] {
	puts stderr "Cannot create response file gigacart.rs1: $rspFile"
} else {
	puts $rspFile "-i gigacart.bl5 -lci gigacart.lct -d m4s_64_64 -lco gigacart.lco -html_rpt -fti gigacart.fti -fmt PLA -tto gigacart.tt4 -nojed -eqn gigacart.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open gigacart.rs2 w} rspFile] {
	puts stderr "Cannot create response file gigacart.rs2: $rspFile"
} else {
	puts $rspFile "-i gigacart.bl5 -lci gigacart.lct -d m4s_64_64 -lco gigacart.lco -html_rpt -fti gigacart.fti -fmt PLA -tto gigacart.tt4 -eqn gigacart.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@gigacart.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete gigacart.rs1
file delete gigacart.rs2
if [runCmd "\"$cpld_bin/tda\" -i gigacart.bl5 -o gigacart.tda -lci gigacart.lct -dev m4s_64_64 -family lc4k -mod gigacart -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj gigacart -if gigacart.jed -j2s -log gigacart.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/25/18 23:57:34 ###########


########## Tcl recorder starts at 05/26/18 01:16:21 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vhd2jhd\" design.vhd -o design.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/26/18 01:16:21 ###########


########## Tcl recorder starts at 05/26/18 01:16:38 ##########

# Commands to make the Process: 
# JEDEC File
if [catch {open gigacart.cmd w} rspFile] {
	puts stderr "Cannot create response file gigacart.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: gigacart.sty
PROJECT: gigacart
WORKING_PATH: \"$proj_dir\"
MODULE: gigacart
VHDL_FILE_LIST: design.vhd
OUTPUT_FILE_NAME: gigacart
SUFFIX_NAME: edi
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DEFAULT_ENUM_ENCODING: default
ARRANGE_VHDL_FILES: true
synthesis_onoff_pragma: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -e gigacart -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete gigacart.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf gigacart.edi -out gigacart.bl0 -err automake.err -log gigacart.log -prj gigacart -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" gigacart.bl0 -collapse none -reduce none -keepwires  -err automake.err -family"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"gigacart.bl1\" -o \"gigacart.bl2\" -omod \"gigacart\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj gigacart -lci gigacart.lct -log gigacart.imp -err automake.err -tti gigacart.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci gigacart.lct -blifopt gigacart.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" gigacart.bl2 -sweep -mergefb -err automake.err -o gigacart.bl3 @gigacart.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci gigacart.lct -dev lc4k -diofft gigacart.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" gigacart.bl3 -family AMDMACH -idev van -o gigacart.bl4 -oxrf gigacart.xrf -err automake.err @gigacart.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci gigacart.lct -dev lc4k -prefit gigacart.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp gigacart.bl4 -out gigacart.bl5 -err automake.err -log gigacart.log -mod gigacart @gigacart.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open gigacart.rs1 w} rspFile] {
	puts stderr "Cannot create response file gigacart.rs1: $rspFile"
} else {
	puts $rspFile "-i gigacart.bl5 -lci gigacart.lct -d m4s_64_64 -lco gigacart.lco -html_rpt -fti gigacart.fti -fmt PLA -tto gigacart.tt4 -nojed -eqn gigacart.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open gigacart.rs2 w} rspFile] {
	puts stderr "Cannot create response file gigacart.rs2: $rspFile"
} else {
	puts $rspFile "-i gigacart.bl5 -lci gigacart.lct -d m4s_64_64 -lco gigacart.lco -html_rpt -fti gigacart.fti -fmt PLA -tto gigacart.tt4 -eqn gigacart.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@gigacart.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete gigacart.rs1
file delete gigacart.rs2
if [runCmd "\"$cpld_bin/tda\" -i gigacart.bl5 -o gigacart.tda -lci gigacart.lct -dev m4s_64_64 -family lc4k -mod gigacart -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj gigacart -if gigacart.jed -j2s -log gigacart.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/26/18 01:16:38 ###########


########## Tcl recorder starts at 07/01/18 19:12:23 ##########

# Commands to make the Process: 
# Post-Fit Pinouts
# - none -
# Application to view the Process: 
# Post-Fit Pinouts
if [catch {open lattice_cmd.rs2 w} rspFile] {
	puts stderr "Cannot create response file lattice_cmd.rs2: $rspFile"
} else {
	puts $rspFile "-src gigacart.tt4 -type PLA -devfile \"$install_dir/ispcpld/dat/lc4k/m4s_64_64.dev\" -postfit -lci gigacart.lco
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lciedit\" @lattice_cmd.rs2"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 07/01/18 19:12:23 ###########


########## Tcl recorder starts at 07/01/18 19:16:24 ##########

# Commands to make the Process: 
# Post-Fit Pinouts
# - none -
# Application to view the Process: 
# Post-Fit Pinouts
if [catch {open lattice_cmd.rs2 w} rspFile] {
	puts stderr "Cannot create response file lattice_cmd.rs2: $rspFile"
} else {
	puts $rspFile "-src gigacart.tt4 -type PLA -devfile \"$install_dir/ispcpld/dat/lc4k/m4s_64_64.dev\" -postfit -lci gigacart.lco
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lciedit\" @lattice_cmd.rs2"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 07/01/18 19:16:24 ###########


########## Tcl recorder starts at 07/01/18 19:32:36 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vhd2jhd\" design.vhd -o design.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 07/01/18 19:32:36 ###########


########## Tcl recorder starts at 07/01/18 19:41:52 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vhd2jhd\" design.vhd -o design.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 07/01/18 19:41:52 ###########


########## Tcl recorder starts at 07/01/18 19:41:57 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open gigacart.cmd w} rspFile] {
	puts stderr "Cannot create response file gigacart.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: gigacart.sty
PROJECT: gigacart
WORKING_PATH: \"$proj_dir\"
MODULE: gigacart
VHDL_FILE_LIST: design.vhd
OUTPUT_FILE_NAME: gigacart
SUFFIX_NAME: edi
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DEFAULT_ENUM_ENCODING: default
ARRANGE_VHDL_FILES: true
synthesis_onoff_pragma: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -e gigacart -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete gigacart.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf gigacart.edi -out gigacart.bl0 -err automake.err -log gigacart.log -prj gigacart -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" gigacart.bl0 -collapse none -reduce none -keepwires  -err automake.err -family"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"gigacart.bl1\" -o \"gigacart.bl2\" -omod \"gigacart\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj gigacart -lci gigacart.lct -log gigacart.imp -err automake.err -tti gigacart.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci gigacart.lct -blifopt gigacart.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" gigacart.bl2 -sweep -mergefb -err automake.err -o gigacart.bl3 @gigacart.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci gigacart.lct -dev lc4k -diofft gigacart.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" gigacart.bl3 -family AMDMACH -idev van -o gigacart.bl4 -oxrf gigacart.xrf -err automake.err @gigacart.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci gigacart.lct -dev lc4k -prefit gigacart.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp gigacart.bl4 -out gigacart.bl5 -err automake.err -log gigacart.log -mod gigacart @gigacart.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open gigacart.rs1 w} rspFile] {
	puts stderr "Cannot create response file gigacart.rs1: $rspFile"
} else {
	puts $rspFile "-i gigacart.bl5 -lci gigacart.lct -d m4s_64_64 -lco gigacart.lco -html_rpt -fti gigacart.fti -fmt PLA -tto gigacart.tt4 -nojed -eqn gigacart.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open gigacart.rs2 w} rspFile] {
	puts stderr "Cannot create response file gigacart.rs2: $rspFile"
} else {
	puts $rspFile "-i gigacart.bl5 -lci gigacart.lct -d m4s_64_64 -lco gigacart.lco -html_rpt -fti gigacart.fti -fmt PLA -tto gigacart.tt4 -eqn gigacart.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@gigacart.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete gigacart.rs1
file delete gigacart.rs2
if [runCmd "\"$cpld_bin/tda\" -i gigacart.bl5 -o gigacart.tda -lci gigacart.lct -dev m4s_64_64 -family lc4k -mod gigacart -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj gigacart -if gigacart.jed -j2s -log gigacart.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 07/01/18 19:41:57 ###########


########## Tcl recorder starts at 07/01/18 19:42:36 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vhd2jhd\" design.vhd -o design.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 07/01/18 19:42:36 ###########


########## Tcl recorder starts at 07/01/18 19:42:40 ##########

# Commands to make the Process: 
# Constraint Editor
if [catch {open gigacart.cmd w} rspFile] {
	puts stderr "Cannot create response file gigacart.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: gigacart.sty
PROJECT: gigacart
WORKING_PATH: \"$proj_dir\"
MODULE: gigacart
VHDL_FILE_LIST: design.vhd
OUTPUT_FILE_NAME: gigacart
SUFFIX_NAME: edi
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DEFAULT_ENUM_ENCODING: default
ARRANGE_VHDL_FILES: true
synthesis_onoff_pragma: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -e gigacart -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete gigacart.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf gigacart.edi -out gigacart.bl0 -err automake.err -log gigacart.log -prj gigacart -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" gigacart.bl0 -collapse none -reduce none -keepwires  -err automake.err -family"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"gigacart.bl1\" -o \"gigacart.bl2\" -omod \"gigacart\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj gigacart -lci gigacart.lct -log gigacart.imp -err automake.err -tti gigacart.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci gigacart.lct -blifopt gigacart.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" gigacart.bl2 -sweep -mergefb -err automake.err -o gigacart.bl3 @gigacart.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci gigacart.lct -dev lc4k -diofft gigacart.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" gigacart.bl3 -family AMDMACH -idev van -o gigacart.bl4 -oxrf gigacart.xrf -err automake.err @gigacart.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci gigacart.lct -dev lc4k -prefit gigacart.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp gigacart.bl4 -out gigacart.bl5 -err automake.err -log gigacart.log -mod gigacart @gigacart.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/blifstat\" -i gigacart.bl5 -o gigacart.sif"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
# Application to view the Process: 
# Constraint Editor
if [catch {open lattice_cmd.rs2 w} rspFile] {
	puts stderr "Cannot create response file lattice_cmd.rs2: $rspFile"
} else {
	puts $rspFile "-nodal -src gigacart.bl5 -type BLIF -presrc gigacart.bl3 -crf gigacart.crf -sif gigacart.sif -devfile \"$install_dir/ispcpld/dat/lc4k/m4s_64_64.dev\" -lci gigacart.lct
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lciedit\" @lattice_cmd.rs2"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 07/01/18 19:42:40 ###########


########## Tcl recorder starts at 07/01/18 19:55:53 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vhd2jhd\" design.vhd -o design.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 07/01/18 19:55:53 ###########


########## Tcl recorder starts at 07/01/18 19:56:02 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open gigacart.cmd w} rspFile] {
	puts stderr "Cannot create response file gigacart.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: gigacart.sty
PROJECT: gigacart
WORKING_PATH: \"$proj_dir\"
MODULE: gigacart
VHDL_FILE_LIST: design.vhd
OUTPUT_FILE_NAME: gigacart
SUFFIX_NAME: edi
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DEFAULT_ENUM_ENCODING: default
ARRANGE_VHDL_FILES: true
synthesis_onoff_pragma: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -e gigacart -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete gigacart.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf gigacart.edi -out gigacart.bl0 -err automake.err -log gigacart.log -prj gigacart -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" gigacart.bl0 -collapse none -reduce none -keepwires  -err automake.err -family"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"gigacart.bl1\" -o \"gigacart.bl2\" -omod \"gigacart\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj gigacart -lci gigacart.lct -log gigacart.imp -err automake.err -tti gigacart.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci gigacart.lct -blifopt gigacart.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" gigacart.bl2 -sweep -mergefb -err automake.err -o gigacart.bl3 @gigacart.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci gigacart.lct -dev lc4k -diofft gigacart.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" gigacart.bl3 -family AMDMACH -idev van -o gigacart.bl4 -oxrf gigacart.xrf -err automake.err @gigacart.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci gigacart.lct -dev lc4k -prefit gigacart.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp gigacart.bl4 -out gigacart.bl5 -err automake.err -log gigacart.log -mod gigacart @gigacart.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open gigacart.rs1 w} rspFile] {
	puts stderr "Cannot create response file gigacart.rs1: $rspFile"
} else {
	puts $rspFile "-i gigacart.bl5 -lci gigacart.lct -d m4s_64_64 -lco gigacart.lco -html_rpt -fti gigacart.fti -fmt PLA -tto gigacart.tt4 -nojed -eqn gigacart.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open gigacart.rs2 w} rspFile] {
	puts stderr "Cannot create response file gigacart.rs2: $rspFile"
} else {
	puts $rspFile "-i gigacart.bl5 -lci gigacart.lct -d m4s_64_64 -lco gigacart.lco -html_rpt -fti gigacart.fti -fmt PLA -tto gigacart.tt4 -eqn gigacart.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@gigacart.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete gigacart.rs1
file delete gigacart.rs2
if [runCmd "\"$cpld_bin/tda\" -i gigacart.bl5 -o gigacart.tda -lci gigacart.lct -dev m4s_64_64 -family lc4k -mod gigacart -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj gigacart -if gigacart.jed -j2s -log gigacart.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 07/01/18 19:56:02 ###########


########## Tcl recorder starts at 07/01/18 19:57:49 ##########

# Commands to make the Process: 
# Post-Fit Pinouts
# - none -
# Application to view the Process: 
# Post-Fit Pinouts
if [catch {open lattice_cmd.rs2 w} rspFile] {
	puts stderr "Cannot create response file lattice_cmd.rs2: $rspFile"
} else {
	puts $rspFile "-src gigacart.tt4 -type PLA -devfile \"$install_dir/ispcpld/dat/lc4k/m4s_64_64.dev\" -postfit -lci gigacart.lco
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lciedit\" @lattice_cmd.rs2"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 07/01/18 19:57:49 ###########


########## Tcl recorder starts at 07/01/18 20:24:02 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vhd2jhd\" design.vhd -o design.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 07/01/18 20:24:02 ###########


########## Tcl recorder starts at 07/01/18 20:24:12 ##########

# Commands to make the Process: 
# Constraint Editor
if [catch {open gigacart.cmd w} rspFile] {
	puts stderr "Cannot create response file gigacart.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: gigacart.sty
PROJECT: gigacart
WORKING_PATH: \"$proj_dir\"
MODULE: gigacart
VHDL_FILE_LIST: design.vhd
OUTPUT_FILE_NAME: gigacart
SUFFIX_NAME: edi
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DEFAULT_ENUM_ENCODING: default
ARRANGE_VHDL_FILES: true
synthesis_onoff_pragma: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -e gigacart -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete gigacart.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf gigacart.edi -out gigacart.bl0 -err automake.err -log gigacart.log -prj gigacart -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" gigacart.bl0 -collapse none -reduce none -keepwires  -err automake.err -family"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"gigacart.bl1\" -o \"gigacart.bl2\" -omod \"gigacart\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj gigacart -lci gigacart.lct -log gigacart.imp -err automake.err -tti gigacart.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci gigacart.lct -blifopt gigacart.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" gigacart.bl2 -sweep -mergefb -err automake.err -o gigacart.bl3 @gigacart.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci gigacart.lct -dev lc4k -diofft gigacart.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" gigacart.bl3 -family AMDMACH -idev van -o gigacart.bl4 -oxrf gigacart.xrf -err automake.err @gigacart.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci gigacart.lct -dev lc4k -prefit gigacart.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp gigacart.bl4 -out gigacart.bl5 -err automake.err -log gigacart.log -mod gigacart @gigacart.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/blifstat\" -i gigacart.bl5 -o gigacart.sif"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
# Application to view the Process: 
# Constraint Editor
if [catch {open lattice_cmd.rs2 w} rspFile] {
	puts stderr "Cannot create response file lattice_cmd.rs2: $rspFile"
} else {
	puts $rspFile "-nodal -src gigacart.bl5 -type BLIF -presrc gigacart.bl3 -crf gigacart.crf -sif gigacart.sif -devfile \"$install_dir/ispcpld/dat/lc4k/m4s_64_64.dev\" -lci gigacart.lct
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lciedit\" @lattice_cmd.rs2"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 07/01/18 20:24:12 ###########


########## Tcl recorder starts at 07/01/18 20:25:35 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open gigacart.rs1 w} rspFile] {
	puts stderr "Cannot create response file gigacart.rs1: $rspFile"
} else {
	puts $rspFile "-i gigacart.bl5 -lci gigacart.lct -d m4s_64_64 -lco gigacart.lco -html_rpt -fti gigacart.fti -fmt PLA -tto gigacart.tt4 -nojed -eqn gigacart.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open gigacart.rs2 w} rspFile] {
	puts stderr "Cannot create response file gigacart.rs2: $rspFile"
} else {
	puts $rspFile "-i gigacart.bl5 -lci gigacart.lct -d m4s_64_64 -lco gigacart.lco -html_rpt -fti gigacart.fti -fmt PLA -tto gigacart.tt4 -eqn gigacart.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@gigacart.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete gigacart.rs1
file delete gigacart.rs2
if [runCmd "\"$cpld_bin/tda\" -i gigacart.bl5 -o gigacart.tda -lci gigacart.lct -dev m4s_64_64 -family lc4k -mod gigacart -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj gigacart -if gigacart.jed -j2s -log gigacart.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 07/01/18 20:25:35 ###########


########## Tcl recorder starts at 07/01/18 20:27:10 ##########

# Commands to make the Process: 
# Post-Fit Pinouts
# - none -
# Application to view the Process: 
# Post-Fit Pinouts
if [catch {open lattice_cmd.rs2 w} rspFile] {
	puts stderr "Cannot create response file lattice_cmd.rs2: $rspFile"
} else {
	puts $rspFile "-src gigacart.tt4 -type PLA -devfile \"$install_dir/ispcpld/dat/lc4k/m4s_64_64.dev\" -postfit -lci gigacart.lco
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lciedit\" @lattice_cmd.rs2"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 07/01/18 20:27:10 ###########


########## Tcl recorder starts at 07/01/18 20:31:04 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vhd2jhd\" design.vhd -o design.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 07/01/18 20:31:04 ###########


########## Tcl recorder starts at 07/01/18 20:31:07 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open gigacart.cmd w} rspFile] {
	puts stderr "Cannot create response file gigacart.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: gigacart.sty
PROJECT: gigacart
WORKING_PATH: \"$proj_dir\"
MODULE: gigacart
VHDL_FILE_LIST: design.vhd
OUTPUT_FILE_NAME: gigacart
SUFFIX_NAME: edi
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DEFAULT_ENUM_ENCODING: default
ARRANGE_VHDL_FILES: true
synthesis_onoff_pragma: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -e gigacart -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete gigacart.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf gigacart.edi -out gigacart.bl0 -err automake.err -log gigacart.log -prj gigacart -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" gigacart.bl0 -collapse none -reduce none -keepwires  -err automake.err -family"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"gigacart.bl1\" -o \"gigacart.bl2\" -omod \"gigacart\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj gigacart -lci gigacart.lct -log gigacart.imp -err automake.err -tti gigacart.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci gigacart.lct -blifopt gigacart.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" gigacart.bl2 -sweep -mergefb -err automake.err -o gigacart.bl3 @gigacart.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci gigacart.lct -dev lc4k -diofft gigacart.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" gigacart.bl3 -family AMDMACH -idev van -o gigacart.bl4 -oxrf gigacart.xrf -err automake.err @gigacart.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci gigacart.lct -dev lc4k -prefit gigacart.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp gigacart.bl4 -out gigacart.bl5 -err automake.err -log gigacart.log -mod gigacart @gigacart.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open gigacart.rs1 w} rspFile] {
	puts stderr "Cannot create response file gigacart.rs1: $rspFile"
} else {
	puts $rspFile "-i gigacart.bl5 -lci gigacart.lct -d m4s_64_64 -lco gigacart.lco -html_rpt -fti gigacart.fti -fmt PLA -tto gigacart.tt4 -nojed -eqn gigacart.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open gigacart.rs2 w} rspFile] {
	puts stderr "Cannot create response file gigacart.rs2: $rspFile"
} else {
	puts $rspFile "-i gigacart.bl5 -lci gigacart.lct -d m4s_64_64 -lco gigacart.lco -html_rpt -fti gigacart.fti -fmt PLA -tto gigacart.tt4 -eqn gigacart.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@gigacart.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete gigacart.rs1
file delete gigacart.rs2
if [runCmd "\"$cpld_bin/tda\" -i gigacart.bl5 -o gigacart.tda -lci gigacart.lct -dev m4s_64_64 -family lc4k -mod gigacart -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj gigacart -if gigacart.jed -j2s -log gigacart.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 07/01/18 20:31:07 ###########


########## Tcl recorder starts at 07/01/18 20:32:47 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vhd2jhd\" design.vhd -o design.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 07/01/18 20:32:47 ###########


########## Tcl recorder starts at 07/01/18 20:32:50 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open gigacart.cmd w} rspFile] {
	puts stderr "Cannot create response file gigacart.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: gigacart.sty
PROJECT: gigacart
WORKING_PATH: \"$proj_dir\"
MODULE: gigacart
VHDL_FILE_LIST: design.vhd
OUTPUT_FILE_NAME: gigacart
SUFFIX_NAME: edi
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DEFAULT_ENUM_ENCODING: default
ARRANGE_VHDL_FILES: true
synthesis_onoff_pragma: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -e gigacart -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete gigacart.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf gigacart.edi -out gigacart.bl0 -err automake.err -log gigacart.log -prj gigacart -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" gigacart.bl0 -collapse none -reduce none -keepwires  -err automake.err -family"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"gigacart.bl1\" -o \"gigacart.bl2\" -omod \"gigacart\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj gigacart -lci gigacart.lct -log gigacart.imp -err automake.err -tti gigacart.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci gigacart.lct -blifopt gigacart.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" gigacart.bl2 -sweep -mergefb -err automake.err -o gigacart.bl3 @gigacart.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci gigacart.lct -dev lc4k -diofft gigacart.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" gigacart.bl3 -family AMDMACH -idev van -o gigacart.bl4 -oxrf gigacart.xrf -err automake.err @gigacart.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci gigacart.lct -dev lc4k -prefit gigacart.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp gigacart.bl4 -out gigacart.bl5 -err automake.err -log gigacart.log -mod gigacart @gigacart.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open gigacart.rs1 w} rspFile] {
	puts stderr "Cannot create response file gigacart.rs1: $rspFile"
} else {
	puts $rspFile "-i gigacart.bl5 -lci gigacart.lct -d m4s_64_64 -lco gigacart.lco -html_rpt -fti gigacart.fti -fmt PLA -tto gigacart.tt4 -nojed -eqn gigacart.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open gigacart.rs2 w} rspFile] {
	puts stderr "Cannot create response file gigacart.rs2: $rspFile"
} else {
	puts $rspFile "-i gigacart.bl5 -lci gigacart.lct -d m4s_64_64 -lco gigacart.lco -html_rpt -fti gigacart.fti -fmt PLA -tto gigacart.tt4 -eqn gigacart.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@gigacart.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete gigacart.rs1
file delete gigacart.rs2
if [runCmd "\"$cpld_bin/tda\" -i gigacart.bl5 -o gigacart.tda -lci gigacart.lct -dev m4s_64_64 -family lc4k -mod gigacart -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj gigacart -if gigacart.jed -j2s -log gigacart.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 07/01/18 20:32:50 ###########


########## Tcl recorder starts at 07/01/18 20:33:21 ##########

# Commands to make the Process: 
# JEDEC File
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj gigacart -if gigacart.jed -j2s -log gigacart.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 07/01/18 20:33:21 ###########


########## Tcl recorder starts at 07/01/18 20:33:45 ##########

# Commands to make the Process: 
# JEDEC File
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj gigacart -if gigacart.jed -j2s -log gigacart.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 07/01/18 20:33:45 ###########


########## Tcl recorder starts at 07/01/18 20:34:59 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vhd2jhd\" design.vhd -o design.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 07/01/18 20:34:59 ###########


########## Tcl recorder starts at 07/01/18 20:35:03 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open gigacart.cmd w} rspFile] {
	puts stderr "Cannot create response file gigacart.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: gigacart.sty
PROJECT: gigacart
WORKING_PATH: \"$proj_dir\"
MODULE: gigacart
VHDL_FILE_LIST: design.vhd
OUTPUT_FILE_NAME: gigacart
SUFFIX_NAME: edi
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DEFAULT_ENUM_ENCODING: default
ARRANGE_VHDL_FILES: true
synthesis_onoff_pragma: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -e gigacart -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete gigacart.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf gigacart.edi -out gigacart.bl0 -err automake.err -log gigacart.log -prj gigacart -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" gigacart.bl0 -collapse none -reduce none -keepwires  -err automake.err -family"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"gigacart.bl1\" -o \"gigacart.bl2\" -omod \"gigacart\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj gigacart -lci gigacart.lct -log gigacart.imp -err automake.err -tti gigacart.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci gigacart.lct -blifopt gigacart.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" gigacart.bl2 -sweep -mergefb -err automake.err -o gigacart.bl3 @gigacart.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci gigacart.lct -dev lc4k -diofft gigacart.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" gigacart.bl3 -family AMDMACH -idev van -o gigacart.bl4 -oxrf gigacart.xrf -err automake.err @gigacart.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci gigacart.lct -dev lc4k -prefit gigacart.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp gigacart.bl4 -out gigacart.bl5 -err automake.err -log gigacart.log -mod gigacart @gigacart.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open gigacart.rs1 w} rspFile] {
	puts stderr "Cannot create response file gigacart.rs1: $rspFile"
} else {
	puts $rspFile "-i gigacart.bl5 -lci gigacart.lct -d m4s_64_64 -lco gigacart.lco -html_rpt -fti gigacart.fti -fmt PLA -tto gigacart.tt4 -nojed -eqn gigacart.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open gigacart.rs2 w} rspFile] {
	puts stderr "Cannot create response file gigacart.rs2: $rspFile"
} else {
	puts $rspFile "-i gigacart.bl5 -lci gigacart.lct -d m4s_64_64 -lco gigacart.lco -html_rpt -fti gigacart.fti -fmt PLA -tto gigacart.tt4 -eqn gigacart.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@gigacart.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete gigacart.rs1
file delete gigacart.rs2
if [runCmd "\"$cpld_bin/tda\" -i gigacart.bl5 -o gigacart.tda -lci gigacart.lct -dev m4s_64_64 -family lc4k -mod gigacart -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj gigacart -if gigacart.jed -j2s -log gigacart.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 07/01/18 20:35:03 ###########


########## Tcl recorder starts at 07/01/18 20:36:02 ##########

# Commands to make the Process: 
# Post-Fit Pinouts
# - none -
# Application to view the Process: 
# Post-Fit Pinouts
if [catch {open lattice_cmd.rs2 w} rspFile] {
	puts stderr "Cannot create response file lattice_cmd.rs2: $rspFile"
} else {
	puts $rspFile "-src gigacart.tt4 -type PLA -devfile \"$install_dir/ispcpld/dat/lc4k/m4s_64_64.dev\" -postfit -lci gigacart.lco
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lciedit\" @lattice_cmd.rs2"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 07/01/18 20:36:02 ###########


########## Tcl recorder starts at 07/01/18 20:45:15 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vhd2jhd\" design.vhd -o design.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 07/01/18 20:45:15 ###########


########## Tcl recorder starts at 07/01/18 20:45:19 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open gigacart.cmd w} rspFile] {
	puts stderr "Cannot create response file gigacart.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: gigacart.sty
PROJECT: gigacart
WORKING_PATH: \"$proj_dir\"
MODULE: gigacart
VHDL_FILE_LIST: design.vhd
OUTPUT_FILE_NAME: gigacart
SUFFIX_NAME: edi
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DEFAULT_ENUM_ENCODING: default
ARRANGE_VHDL_FILES: true
synthesis_onoff_pragma: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -e gigacart -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete gigacart.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf gigacart.edi -out gigacart.bl0 -err automake.err -log gigacart.log -prj gigacart -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" gigacart.bl0 -collapse none -reduce none -keepwires  -err automake.err -family"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"gigacart.bl1\" -o \"gigacart.bl2\" -omod \"gigacart\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj gigacart -lci gigacart.lct -log gigacart.imp -err automake.err -tti gigacart.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci gigacart.lct -blifopt gigacart.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" gigacart.bl2 -sweep -mergefb -err automake.err -o gigacart.bl3 @gigacart.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci gigacart.lct -dev lc4k -diofft gigacart.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" gigacart.bl3 -family AMDMACH -idev van -o gigacart.bl4 -oxrf gigacart.xrf -err automake.err @gigacart.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci gigacart.lct -dev lc4k -prefit gigacart.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp gigacart.bl4 -out gigacart.bl5 -err automake.err -log gigacart.log -mod gigacart @gigacart.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open gigacart.rs1 w} rspFile] {
	puts stderr "Cannot create response file gigacart.rs1: $rspFile"
} else {
	puts $rspFile "-i gigacart.bl5 -lci gigacart.lct -d m4s_64_64 -lco gigacart.lco -html_rpt -fti gigacart.fti -fmt PLA -tto gigacart.tt4 -nojed -eqn gigacart.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open gigacart.rs2 w} rspFile] {
	puts stderr "Cannot create response file gigacart.rs2: $rspFile"
} else {
	puts $rspFile "-i gigacart.bl5 -lci gigacart.lct -d m4s_64_64 -lco gigacart.lco -html_rpt -fti gigacart.fti -fmt PLA -tto gigacart.tt4 -eqn gigacart.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@gigacart.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete gigacart.rs1
file delete gigacart.rs2
if [runCmd "\"$cpld_bin/tda\" -i gigacart.bl5 -o gigacart.tda -lci gigacart.lct -dev m4s_64_64 -family lc4k -mod gigacart -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj gigacart -if gigacart.jed -j2s -log gigacart.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 07/01/18 20:45:19 ###########


########## Tcl recorder starts at 07/02/18 20:30:30 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vhd2jhd\" design.vhd -o design.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 07/02/18 20:30:30 ###########


########## Tcl recorder starts at 07/02/18 20:30:37 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open gigacart.cmd w} rspFile] {
	puts stderr "Cannot create response file gigacart.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: gigacart.sty
PROJECT: gigacart
WORKING_PATH: \"$proj_dir\"
MODULE: gigacart
VHDL_FILE_LIST: design.vhd
OUTPUT_FILE_NAME: gigacart
SUFFIX_NAME: edi
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DEFAULT_ENUM_ENCODING: default
ARRANGE_VHDL_FILES: true
synthesis_onoff_pragma: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -e gigacart -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete gigacart.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf gigacart.edi -out gigacart.bl0 -err automake.err -log gigacart.log -prj gigacart -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" gigacart.bl0 -collapse none -reduce none -keepwires  -err automake.err -family"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"gigacart.bl1\" -o \"gigacart.bl2\" -omod \"gigacart\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj gigacart -lci gigacart.lct -log gigacart.imp -err automake.err -tti gigacart.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci gigacart.lct -blifopt gigacart.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" gigacart.bl2 -sweep -mergefb -err automake.err -o gigacart.bl3 @gigacart.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci gigacart.lct -dev lc4k -diofft gigacart.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" gigacart.bl3 -family AMDMACH -idev van -o gigacart.bl4 -oxrf gigacart.xrf -err automake.err @gigacart.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci gigacart.lct -dev lc4k -prefit gigacart.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp gigacart.bl4 -out gigacart.bl5 -err automake.err -log gigacart.log -mod gigacart @gigacart.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open gigacart.rs1 w} rspFile] {
	puts stderr "Cannot create response file gigacart.rs1: $rspFile"
} else {
	puts $rspFile "-i gigacart.bl5 -lci gigacart.lct -d m4s_64_64 -lco gigacart.lco -html_rpt -fti gigacart.fti -fmt PLA -tto gigacart.tt4 -nojed -eqn gigacart.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open gigacart.rs2 w} rspFile] {
	puts stderr "Cannot create response file gigacart.rs2: $rspFile"
} else {
	puts $rspFile "-i gigacart.bl5 -lci gigacart.lct -d m4s_64_64 -lco gigacart.lco -html_rpt -fti gigacart.fti -fmt PLA -tto gigacart.tt4 -eqn gigacart.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@gigacart.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete gigacart.rs1
file delete gigacart.rs2
if [runCmd "\"$cpld_bin/tda\" -i gigacart.bl5 -o gigacart.tda -lci gigacart.lct -dev m4s_64_64 -family lc4k -mod gigacart -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj gigacart -if gigacart.jed -j2s -log gigacart.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 07/02/18 20:30:37 ###########


########## Tcl recorder starts at 07/02/18 20:31:07 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vhd2jhd\" design.vhd -o design.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 07/02/18 20:31:07 ###########


########## Tcl recorder starts at 07/02/18 20:31:09 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open gigacart.cmd w} rspFile] {
	puts stderr "Cannot create response file gigacart.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: gigacart.sty
PROJECT: gigacart
WORKING_PATH: \"$proj_dir\"
MODULE: gigacart
VHDL_FILE_LIST: design.vhd
OUTPUT_FILE_NAME: gigacart
SUFFIX_NAME: edi
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DEFAULT_ENUM_ENCODING: default
ARRANGE_VHDL_FILES: true
synthesis_onoff_pragma: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -e gigacart -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete gigacart.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf gigacart.edi -out gigacart.bl0 -err automake.err -log gigacart.log -prj gigacart -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" gigacart.bl0 -collapse none -reduce none -keepwires  -err automake.err -family"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"gigacart.bl1\" -o \"gigacart.bl2\" -omod \"gigacart\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj gigacart -lci gigacart.lct -log gigacart.imp -err automake.err -tti gigacart.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci gigacart.lct -blifopt gigacart.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" gigacart.bl2 -sweep -mergefb -err automake.err -o gigacart.bl3 @gigacart.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci gigacart.lct -dev lc4k -diofft gigacart.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" gigacart.bl3 -family AMDMACH -idev van -o gigacart.bl4 -oxrf gigacart.xrf -err automake.err @gigacart.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci gigacart.lct -dev lc4k -prefit gigacart.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp gigacart.bl4 -out gigacart.bl5 -err automake.err -log gigacart.log -mod gigacart @gigacart.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open gigacart.rs1 w} rspFile] {
	puts stderr "Cannot create response file gigacart.rs1: $rspFile"
} else {
	puts $rspFile "-i gigacart.bl5 -lci gigacart.lct -d m4s_64_64 -lco gigacart.lco -html_rpt -fti gigacart.fti -fmt PLA -tto gigacart.tt4 -nojed -eqn gigacart.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open gigacart.rs2 w} rspFile] {
	puts stderr "Cannot create response file gigacart.rs2: $rspFile"
} else {
	puts $rspFile "-i gigacart.bl5 -lci gigacart.lct -d m4s_64_64 -lco gigacart.lco -html_rpt -fti gigacart.fti -fmt PLA -tto gigacart.tt4 -eqn gigacart.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@gigacart.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete gigacart.rs1
file delete gigacart.rs2
if [runCmd "\"$cpld_bin/tda\" -i gigacart.bl5 -o gigacart.tda -lci gigacart.lct -dev m4s_64_64 -family lc4k -mod gigacart -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj gigacart -if gigacart.jed -j2s -log gigacart.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 07/02/18 20:31:09 ###########


########## Tcl recorder starts at 07/02/18 20:32:10 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vhd2jhd\" design.vhd -o design.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 07/02/18 20:32:10 ###########


########## Tcl recorder starts at 07/02/18 20:32:12 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open gigacart.cmd w} rspFile] {
	puts stderr "Cannot create response file gigacart.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: gigacart.sty
PROJECT: gigacart
WORKING_PATH: \"$proj_dir\"
MODULE: gigacart
VHDL_FILE_LIST: design.vhd
OUTPUT_FILE_NAME: gigacart
SUFFIX_NAME: edi
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DEFAULT_ENUM_ENCODING: default
ARRANGE_VHDL_FILES: true
synthesis_onoff_pragma: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -e gigacart -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete gigacart.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf gigacart.edi -out gigacart.bl0 -err automake.err -log gigacart.log -prj gigacart -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" gigacart.bl0 -collapse none -reduce none -keepwires  -err automake.err -family"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"gigacart.bl1\" -o \"gigacart.bl2\" -omod \"gigacart\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj gigacart -lci gigacart.lct -log gigacart.imp -err automake.err -tti gigacart.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci gigacart.lct -blifopt gigacart.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" gigacart.bl2 -sweep -mergefb -err automake.err -o gigacart.bl3 @gigacart.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci gigacart.lct -dev lc4k -diofft gigacart.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" gigacart.bl3 -family AMDMACH -idev van -o gigacart.bl4 -oxrf gigacart.xrf -err automake.err @gigacart.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci gigacart.lct -dev lc4k -prefit gigacart.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp gigacart.bl4 -out gigacart.bl5 -err automake.err -log gigacart.log -mod gigacart @gigacart.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open gigacart.rs1 w} rspFile] {
	puts stderr "Cannot create response file gigacart.rs1: $rspFile"
} else {
	puts $rspFile "-i gigacart.bl5 -lci gigacart.lct -d m4s_64_64 -lco gigacart.lco -html_rpt -fti gigacart.fti -fmt PLA -tto gigacart.tt4 -nojed -eqn gigacart.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open gigacart.rs2 w} rspFile] {
	puts stderr "Cannot create response file gigacart.rs2: $rspFile"
} else {
	puts $rspFile "-i gigacart.bl5 -lci gigacart.lct -d m4s_64_64 -lco gigacart.lco -html_rpt -fti gigacart.fti -fmt PLA -tto gigacart.tt4 -eqn gigacart.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@gigacart.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete gigacart.rs1
file delete gigacart.rs2
if [runCmd "\"$cpld_bin/tda\" -i gigacart.bl5 -o gigacart.tda -lci gigacart.lct -dev m4s_64_64 -family lc4k -mod gigacart -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj gigacart -if gigacart.jed -j2s -log gigacart.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 07/02/18 20:32:12 ###########


########## Tcl recorder starts at 07/02/18 20:35:10 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vhd2jhd\" design.vhd -o design.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 07/02/18 20:35:10 ###########


########## Tcl recorder starts at 07/02/18 20:35:15 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open gigacart.cmd w} rspFile] {
	puts stderr "Cannot create response file gigacart.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: gigacart.sty
PROJECT: gigacart
WORKING_PATH: \"$proj_dir\"
MODULE: gigacart
VHDL_FILE_LIST: design.vhd
OUTPUT_FILE_NAME: gigacart
SUFFIX_NAME: edi
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DEFAULT_ENUM_ENCODING: default
ARRANGE_VHDL_FILES: true
synthesis_onoff_pragma: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -e gigacart -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete gigacart.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf gigacart.edi -out gigacart.bl0 -err automake.err -log gigacart.log -prj gigacart -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" gigacart.bl0 -collapse none -reduce none -keepwires  -err automake.err -family"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"gigacart.bl1\" -o \"gigacart.bl2\" -omod \"gigacart\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj gigacart -lci gigacart.lct -log gigacart.imp -err automake.err -tti gigacart.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci gigacart.lct -blifopt gigacart.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" gigacart.bl2 -sweep -mergefb -err automake.err -o gigacart.bl3 @gigacart.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci gigacart.lct -dev lc4k -diofft gigacart.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" gigacart.bl3 -family AMDMACH -idev van -o gigacart.bl4 -oxrf gigacart.xrf -err automake.err @gigacart.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci gigacart.lct -dev lc4k -prefit gigacart.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp gigacart.bl4 -out gigacart.bl5 -err automake.err -log gigacart.log -mod gigacart @gigacart.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open gigacart.rs1 w} rspFile] {
	puts stderr "Cannot create response file gigacart.rs1: $rspFile"
} else {
	puts $rspFile "-i gigacart.bl5 -lci gigacart.lct -d m4s_64_64 -lco gigacart.lco -html_rpt -fti gigacart.fti -fmt PLA -tto gigacart.tt4 -nojed -eqn gigacart.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open gigacart.rs2 w} rspFile] {
	puts stderr "Cannot create response file gigacart.rs2: $rspFile"
} else {
	puts $rspFile "-i gigacart.bl5 -lci gigacart.lct -d m4s_64_64 -lco gigacart.lco -html_rpt -fti gigacart.fti -fmt PLA -tto gigacart.tt4 -eqn gigacart.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@gigacart.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete gigacart.rs1
file delete gigacart.rs2
if [runCmd "\"$cpld_bin/tda\" -i gigacart.bl5 -o gigacart.tda -lci gigacart.lct -dev m4s_64_64 -family lc4k -mod gigacart -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj gigacart -if gigacart.jed -j2s -log gigacart.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 07/02/18 20:35:15 ###########


########## Tcl recorder starts at 07/02/18 20:44:59 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vhd2jhd\" design.vhd -o design.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 07/02/18 20:44:59 ###########


########## Tcl recorder starts at 07/02/18 20:45:05 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open gigacart.cmd w} rspFile] {
	puts stderr "Cannot create response file gigacart.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: gigacart.sty
PROJECT: gigacart
WORKING_PATH: \"$proj_dir\"
MODULE: gigacart
VHDL_FILE_LIST: design.vhd
OUTPUT_FILE_NAME: gigacart
SUFFIX_NAME: edi
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DEFAULT_ENUM_ENCODING: default
ARRANGE_VHDL_FILES: true
synthesis_onoff_pragma: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -e gigacart -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete gigacart.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf gigacart.edi -out gigacart.bl0 -err automake.err -log gigacart.log -prj gigacart -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" gigacart.bl0 -collapse none -reduce none -keepwires  -err automake.err -family"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"gigacart.bl1\" -o \"gigacart.bl2\" -omod \"gigacart\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj gigacart -lci gigacart.lct -log gigacart.imp -err automake.err -tti gigacart.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci gigacart.lct -blifopt gigacart.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" gigacart.bl2 -sweep -mergefb -err automake.err -o gigacart.bl3 @gigacart.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci gigacart.lct -dev lc4k -diofft gigacart.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" gigacart.bl3 -family AMDMACH -idev van -o gigacart.bl4 -oxrf gigacart.xrf -err automake.err @gigacart.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci gigacart.lct -dev lc4k -prefit gigacart.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp gigacart.bl4 -out gigacart.bl5 -err automake.err -log gigacart.log -mod gigacart @gigacart.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open gigacart.rs1 w} rspFile] {
	puts stderr "Cannot create response file gigacart.rs1: $rspFile"
} else {
	puts $rspFile "-i gigacart.bl5 -lci gigacart.lct -d m4s_64_64 -lco gigacart.lco -html_rpt -fti gigacart.fti -fmt PLA -tto gigacart.tt4 -nojed -eqn gigacart.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open gigacart.rs2 w} rspFile] {
	puts stderr "Cannot create response file gigacart.rs2: $rspFile"
} else {
	puts $rspFile "-i gigacart.bl5 -lci gigacart.lct -d m4s_64_64 -lco gigacart.lco -html_rpt -fti gigacart.fti -fmt PLA -tto gigacart.tt4 -eqn gigacart.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@gigacart.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete gigacart.rs1
file delete gigacart.rs2
if [runCmd "\"$cpld_bin/tda\" -i gigacart.bl5 -o gigacart.tda -lci gigacart.lct -dev m4s_64_64 -family lc4k -mod gigacart -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj gigacart -if gigacart.jed -j2s -log gigacart.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 07/02/18 20:45:05 ###########


########## Tcl recorder starts at 07/02/18 20:47:59 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vhd2jhd\" design.vhd -o design.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 07/02/18 20:47:59 ###########


########## Tcl recorder starts at 07/02/18 20:50:43 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vhd2jhd\" design.vhd -o design.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 07/02/18 20:50:43 ###########


########## Tcl recorder starts at 07/02/18 20:50:47 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open gigacart.cmd w} rspFile] {
	puts stderr "Cannot create response file gigacart.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: gigacart.sty
PROJECT: gigacart
WORKING_PATH: \"$proj_dir\"
MODULE: gigacart
VHDL_FILE_LIST: design.vhd
OUTPUT_FILE_NAME: gigacart
SUFFIX_NAME: edi
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DEFAULT_ENUM_ENCODING: default
ARRANGE_VHDL_FILES: true
synthesis_onoff_pragma: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -e gigacart -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete gigacart.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf gigacart.edi -out gigacart.bl0 -err automake.err -log gigacart.log -prj gigacart -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" gigacart.bl0 -collapse none -reduce none -keepwires  -err automake.err -family"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"gigacart.bl1\" -o \"gigacart.bl2\" -omod \"gigacart\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj gigacart -lci gigacart.lct -log gigacart.imp -err automake.err -tti gigacart.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci gigacart.lct -blifopt gigacart.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" gigacart.bl2 -sweep -mergefb -err automake.err -o gigacart.bl3 @gigacart.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci gigacart.lct -dev lc4k -diofft gigacart.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" gigacart.bl3 -family AMDMACH -idev van -o gigacart.bl4 -oxrf gigacart.xrf -err automake.err @gigacart.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci gigacart.lct -dev lc4k -prefit gigacart.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp gigacart.bl4 -out gigacart.bl5 -err automake.err -log gigacart.log -mod gigacart @gigacart.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open gigacart.rs1 w} rspFile] {
	puts stderr "Cannot create response file gigacart.rs1: $rspFile"
} else {
	puts $rspFile "-i gigacart.bl5 -lci gigacart.lct -d m4s_64_64 -lco gigacart.lco -html_rpt -fti gigacart.fti -fmt PLA -tto gigacart.tt4 -nojed -eqn gigacart.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open gigacart.rs2 w} rspFile] {
	puts stderr "Cannot create response file gigacart.rs2: $rspFile"
} else {
	puts $rspFile "-i gigacart.bl5 -lci gigacart.lct -d m4s_64_64 -lco gigacart.lco -html_rpt -fti gigacart.fti -fmt PLA -tto gigacart.tt4 -eqn gigacart.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@gigacart.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete gigacart.rs1
file delete gigacart.rs2
if [runCmd "\"$cpld_bin/tda\" -i gigacart.bl5 -o gigacart.tda -lci gigacart.lct -dev m4s_64_64 -family lc4k -mod gigacart -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj gigacart -if gigacart.jed -j2s -log gigacart.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 07/02/18 20:50:47 ###########


########## Tcl recorder starts at 07/02/18 20:51:28 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vhd2jhd\" design.vhd -o design.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 07/02/18 20:51:28 ###########


########## Tcl recorder starts at 07/02/18 20:51:33 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open gigacart.cmd w} rspFile] {
	puts stderr "Cannot create response file gigacart.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: gigacart.sty
PROJECT: gigacart
WORKING_PATH: \"$proj_dir\"
MODULE: gigacart
VHDL_FILE_LIST: design.vhd
OUTPUT_FILE_NAME: gigacart
SUFFIX_NAME: edi
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DEFAULT_ENUM_ENCODING: default
ARRANGE_VHDL_FILES: true
synthesis_onoff_pragma: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -e gigacart -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete gigacart.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf gigacart.edi -out gigacart.bl0 -err automake.err -log gigacart.log -prj gigacart -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" gigacart.bl0 -collapse none -reduce none -keepwires  -err automake.err -family"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"gigacart.bl1\" -o \"gigacart.bl2\" -omod \"gigacart\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj gigacart -lci gigacart.lct -log gigacart.imp -err automake.err -tti gigacart.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci gigacart.lct -blifopt gigacart.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" gigacart.bl2 -sweep -mergefb -err automake.err -o gigacart.bl3 @gigacart.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci gigacart.lct -dev lc4k -diofft gigacart.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" gigacart.bl3 -family AMDMACH -idev van -o gigacart.bl4 -oxrf gigacart.xrf -err automake.err @gigacart.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci gigacart.lct -dev lc4k -prefit gigacart.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp gigacart.bl4 -out gigacart.bl5 -err automake.err -log gigacart.log -mod gigacart @gigacart.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open gigacart.rs1 w} rspFile] {
	puts stderr "Cannot create response file gigacart.rs1: $rspFile"
} else {
	puts $rspFile "-i gigacart.bl5 -lci gigacart.lct -d m4s_64_64 -lco gigacart.lco -html_rpt -fti gigacart.fti -fmt PLA -tto gigacart.tt4 -nojed -eqn gigacart.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open gigacart.rs2 w} rspFile] {
	puts stderr "Cannot create response file gigacart.rs2: $rspFile"
} else {
	puts $rspFile "-i gigacart.bl5 -lci gigacart.lct -d m4s_64_64 -lco gigacart.lco -html_rpt -fti gigacart.fti -fmt PLA -tto gigacart.tt4 -eqn gigacart.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@gigacart.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete gigacart.rs1
file delete gigacart.rs2
if [runCmd "\"$cpld_bin/tda\" -i gigacart.bl5 -o gigacart.tda -lci gigacart.lct -dev m4s_64_64 -family lc4k -mod gigacart -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj gigacart -if gigacart.jed -j2s -log gigacart.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 07/02/18 20:51:33 ###########


########## Tcl recorder starts at 07/02/18 20:55:19 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vhd2jhd\" design.vhd -o design.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 07/02/18 20:55:19 ###########


########## Tcl recorder starts at 07/02/18 20:55:21 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open gigacart.cmd w} rspFile] {
	puts stderr "Cannot create response file gigacart.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: gigacart.sty
PROJECT: gigacart
WORKING_PATH: \"$proj_dir\"
MODULE: gigacart
VHDL_FILE_LIST: design.vhd
OUTPUT_FILE_NAME: gigacart
SUFFIX_NAME: edi
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DEFAULT_ENUM_ENCODING: default
ARRANGE_VHDL_FILES: true
synthesis_onoff_pragma: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -e gigacart -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete gigacart.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf gigacart.edi -out gigacart.bl0 -err automake.err -log gigacart.log -prj gigacart -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" gigacart.bl0 -collapse none -reduce none -keepwires  -err automake.err -family"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"gigacart.bl1\" -o \"gigacart.bl2\" -omod \"gigacart\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj gigacart -lci gigacart.lct -log gigacart.imp -err automake.err -tti gigacart.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci gigacart.lct -blifopt gigacart.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" gigacart.bl2 -sweep -mergefb -err automake.err -o gigacart.bl3 @gigacart.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci gigacart.lct -dev lc4k -diofft gigacart.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" gigacart.bl3 -family AMDMACH -idev van -o gigacart.bl4 -oxrf gigacart.xrf -err automake.err @gigacart.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci gigacart.lct -dev lc4k -prefit gigacart.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp gigacart.bl4 -out gigacart.bl5 -err automake.err -log gigacart.log -mod gigacart @gigacart.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open gigacart.rs1 w} rspFile] {
	puts stderr "Cannot create response file gigacart.rs1: $rspFile"
} else {
	puts $rspFile "-i gigacart.bl5 -lci gigacart.lct -d m4s_64_64 -lco gigacart.lco -html_rpt -fti gigacart.fti -fmt PLA -tto gigacart.tt4 -nojed -eqn gigacart.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open gigacart.rs2 w} rspFile] {
	puts stderr "Cannot create response file gigacart.rs2: $rspFile"
} else {
	puts $rspFile "-i gigacart.bl5 -lci gigacart.lct -d m4s_64_64 -lco gigacart.lco -html_rpt -fti gigacart.fti -fmt PLA -tto gigacart.tt4 -eqn gigacart.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@gigacart.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete gigacart.rs1
file delete gigacart.rs2
if [runCmd "\"$cpld_bin/tda\" -i gigacart.bl5 -o gigacart.tda -lci gigacart.lct -dev m4s_64_64 -family lc4k -mod gigacart -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj gigacart -if gigacart.jed -j2s -log gigacart.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 07/02/18 20:55:21 ###########


########## Tcl recorder starts at 07/02/18 20:57:44 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vhd2jhd\" design.vhd -o design.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 07/02/18 20:57:44 ###########


########## Tcl recorder starts at 07/02/18 20:57:48 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open gigacart.cmd w} rspFile] {
	puts stderr "Cannot create response file gigacart.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: gigacart.sty
PROJECT: gigacart
WORKING_PATH: \"$proj_dir\"
MODULE: gigacart
VHDL_FILE_LIST: design.vhd
OUTPUT_FILE_NAME: gigacart
SUFFIX_NAME: edi
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DEFAULT_ENUM_ENCODING: default
ARRANGE_VHDL_FILES: true
synthesis_onoff_pragma: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -e gigacart -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete gigacart.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf gigacart.edi -out gigacart.bl0 -err automake.err -log gigacart.log -prj gigacart -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" gigacart.bl0 -collapse none -reduce none -keepwires  -err automake.err -family"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"gigacart.bl1\" -o \"gigacart.bl2\" -omod \"gigacart\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj gigacart -lci gigacart.lct -log gigacart.imp -err automake.err -tti gigacart.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci gigacart.lct -blifopt gigacart.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" gigacart.bl2 -sweep -mergefb -err automake.err -o gigacart.bl3 @gigacart.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci gigacart.lct -dev lc4k -diofft gigacart.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" gigacart.bl3 -family AMDMACH -idev van -o gigacart.bl4 -oxrf gigacart.xrf -err automake.err @gigacart.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci gigacart.lct -dev lc4k -prefit gigacart.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp gigacart.bl4 -out gigacart.bl5 -err automake.err -log gigacart.log -mod gigacart @gigacart.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open gigacart.rs1 w} rspFile] {
	puts stderr "Cannot create response file gigacart.rs1: $rspFile"
} else {
	puts $rspFile "-i gigacart.bl5 -lci gigacart.lct -d m4s_64_64 -lco gigacart.lco -html_rpt -fti gigacart.fti -fmt PLA -tto gigacart.tt4 -nojed -eqn gigacart.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open gigacart.rs2 w} rspFile] {
	puts stderr "Cannot create response file gigacart.rs2: $rspFile"
} else {
	puts $rspFile "-i gigacart.bl5 -lci gigacart.lct -d m4s_64_64 -lco gigacart.lco -html_rpt -fti gigacart.fti -fmt PLA -tto gigacart.tt4 -eqn gigacart.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@gigacart.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete gigacart.rs1
file delete gigacart.rs2
if [runCmd "\"$cpld_bin/tda\" -i gigacart.bl5 -o gigacart.tda -lci gigacart.lct -dev m4s_64_64 -family lc4k -mod gigacart -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj gigacart -if gigacart.jed -j2s -log gigacart.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 07/02/18 20:57:48 ###########


########## Tcl recorder starts at 07/02/18 21:00:30 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vhd2jhd\" design.vhd -o design.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 07/02/18 21:00:30 ###########


########## Tcl recorder starts at 07/02/18 21:00:36 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open gigacart.cmd w} rspFile] {
	puts stderr "Cannot create response file gigacart.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: gigacart.sty
PROJECT: gigacart
WORKING_PATH: \"$proj_dir\"
MODULE: gigacart
VHDL_FILE_LIST: design.vhd
OUTPUT_FILE_NAME: gigacart
SUFFIX_NAME: edi
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DEFAULT_ENUM_ENCODING: default
ARRANGE_VHDL_FILES: true
synthesis_onoff_pragma: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -e gigacart -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete gigacart.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf gigacart.edi -out gigacart.bl0 -err automake.err -log gigacart.log -prj gigacart -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" gigacart.bl0 -collapse none -reduce none -keepwires  -err automake.err -family"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"gigacart.bl1\" -o \"gigacart.bl2\" -omod \"gigacart\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj gigacart -lci gigacart.lct -log gigacart.imp -err automake.err -tti gigacart.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci gigacart.lct -blifopt gigacart.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" gigacart.bl2 -sweep -mergefb -err automake.err -o gigacart.bl3 @gigacart.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci gigacart.lct -dev lc4k -diofft gigacart.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" gigacart.bl3 -family AMDMACH -idev van -o gigacart.bl4 -oxrf gigacart.xrf -err automake.err @gigacart.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci gigacart.lct -dev lc4k -prefit gigacart.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp gigacart.bl4 -out gigacart.bl5 -err automake.err -log gigacart.log -mod gigacart @gigacart.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open gigacart.rs1 w} rspFile] {
	puts stderr "Cannot create response file gigacart.rs1: $rspFile"
} else {
	puts $rspFile "-i gigacart.bl5 -lci gigacart.lct -d m4s_64_64 -lco gigacart.lco -html_rpt -fti gigacart.fti -fmt PLA -tto gigacart.tt4 -nojed -eqn gigacart.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open gigacart.rs2 w} rspFile] {
	puts stderr "Cannot create response file gigacart.rs2: $rspFile"
} else {
	puts $rspFile "-i gigacart.bl5 -lci gigacart.lct -d m4s_64_64 -lco gigacart.lco -html_rpt -fti gigacart.fti -fmt PLA -tto gigacart.tt4 -eqn gigacart.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@gigacart.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete gigacart.rs1
file delete gigacart.rs2
if [runCmd "\"$cpld_bin/tda\" -i gigacart.bl5 -o gigacart.tda -lci gigacart.lct -dev m4s_64_64 -family lc4k -mod gigacart -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj gigacart -if gigacart.jed -j2s -log gigacart.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 07/02/18 21:00:36 ###########


########## Tcl recorder starts at 07/02/18 21:04:46 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vhd2jhd\" design.vhd -o design.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 07/02/18 21:04:46 ###########


########## Tcl recorder starts at 07/02/18 21:04:49 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open gigacart.cmd w} rspFile] {
	puts stderr "Cannot create response file gigacart.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: gigacart.sty
PROJECT: gigacart
WORKING_PATH: \"$proj_dir\"
MODULE: gigacart
VHDL_FILE_LIST: design.vhd
OUTPUT_FILE_NAME: gigacart
SUFFIX_NAME: edi
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DEFAULT_ENUM_ENCODING: default
ARRANGE_VHDL_FILES: true
synthesis_onoff_pragma: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -e gigacart -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete gigacart.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf gigacart.edi -out gigacart.bl0 -err automake.err -log gigacart.log -prj gigacart -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" gigacart.bl0 -collapse none -reduce none -keepwires  -err automake.err -family"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"gigacart.bl1\" -o \"gigacart.bl2\" -omod \"gigacart\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj gigacart -lci gigacart.lct -log gigacart.imp -err automake.err -tti gigacart.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci gigacart.lct -blifopt gigacart.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" gigacart.bl2 -sweep -mergefb -err automake.err -o gigacart.bl3 @gigacart.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci gigacart.lct -dev lc4k -diofft gigacart.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" gigacart.bl3 -family AMDMACH -idev van -o gigacart.bl4 -oxrf gigacart.xrf -err automake.err @gigacart.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci gigacart.lct -dev lc4k -prefit gigacart.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp gigacart.bl4 -out gigacart.bl5 -err automake.err -log gigacart.log -mod gigacart @gigacart.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open gigacart.rs1 w} rspFile] {
	puts stderr "Cannot create response file gigacart.rs1: $rspFile"
} else {
	puts $rspFile "-i gigacart.bl5 -lci gigacart.lct -d m4s_64_64 -lco gigacart.lco -html_rpt -fti gigacart.fti -fmt PLA -tto gigacart.tt4 -nojed -eqn gigacart.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open gigacart.rs2 w} rspFile] {
	puts stderr "Cannot create response file gigacart.rs2: $rspFile"
} else {
	puts $rspFile "-i gigacart.bl5 -lci gigacart.lct -d m4s_64_64 -lco gigacart.lco -html_rpt -fti gigacart.fti -fmt PLA -tto gigacart.tt4 -eqn gigacart.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@gigacart.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete gigacart.rs1
file delete gigacart.rs2
if [runCmd "\"$cpld_bin/tda\" -i gigacart.bl5 -o gigacart.tda -lci gigacart.lct -dev m4s_64_64 -family lc4k -mod gigacart -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj gigacart -if gigacart.jed -j2s -log gigacart.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 07/02/18 21:04:49 ###########


########## Tcl recorder starts at 07/02/18 21:08:35 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vhd2jhd\" design.vhd -o design.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 07/02/18 21:08:35 ###########


########## Tcl recorder starts at 07/02/18 21:08:39 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open gigacart.cmd w} rspFile] {
	puts stderr "Cannot create response file gigacart.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: gigacart.sty
PROJECT: gigacart
WORKING_PATH: \"$proj_dir\"
MODULE: gigacart
VHDL_FILE_LIST: design.vhd
OUTPUT_FILE_NAME: gigacart
SUFFIX_NAME: edi
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DEFAULT_ENUM_ENCODING: default
ARRANGE_VHDL_FILES: true
synthesis_onoff_pragma: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -e gigacart -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete gigacart.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf gigacart.edi -out gigacart.bl0 -err automake.err -log gigacart.log -prj gigacart -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" gigacart.bl0 -collapse none -reduce none -keepwires  -err automake.err -family"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"gigacart.bl1\" -o \"gigacart.bl2\" -omod \"gigacart\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj gigacart -lci gigacart.lct -log gigacart.imp -err automake.err -tti gigacart.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci gigacart.lct -blifopt gigacart.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" gigacart.bl2 -sweep -mergefb -err automake.err -o gigacart.bl3 @gigacart.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci gigacart.lct -dev lc4k -diofft gigacart.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" gigacart.bl3 -family AMDMACH -idev van -o gigacart.bl4 -oxrf gigacart.xrf -err automake.err @gigacart.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci gigacart.lct -dev lc4k -prefit gigacart.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp gigacart.bl4 -out gigacart.bl5 -err automake.err -log gigacart.log -mod gigacart @gigacart.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open gigacart.rs1 w} rspFile] {
	puts stderr "Cannot create response file gigacart.rs1: $rspFile"
} else {
	puts $rspFile "-i gigacart.bl5 -lci gigacart.lct -d m4s_64_64 -lco gigacart.lco -html_rpt -fti gigacart.fti -fmt PLA -tto gigacart.tt4 -nojed -eqn gigacart.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open gigacart.rs2 w} rspFile] {
	puts stderr "Cannot create response file gigacart.rs2: $rspFile"
} else {
	puts $rspFile "-i gigacart.bl5 -lci gigacart.lct -d m4s_64_64 -lco gigacart.lco -html_rpt -fti gigacart.fti -fmt PLA -tto gigacart.tt4 -eqn gigacart.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@gigacart.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete gigacart.rs1
file delete gigacart.rs2
if [runCmd "\"$cpld_bin/tda\" -i gigacart.bl5 -o gigacart.tda -lci gigacart.lct -dev m4s_64_64 -family lc4k -mod gigacart -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj gigacart -if gigacart.jed -j2s -log gigacart.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 07/02/18 21:08:39 ###########


########## Tcl recorder starts at 07/02/18 21:09:29 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vhd2jhd\" design.vhd -o design.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 07/02/18 21:09:29 ###########


########## Tcl recorder starts at 07/02/18 21:09:32 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open gigacart.cmd w} rspFile] {
	puts stderr "Cannot create response file gigacart.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: gigacart.sty
PROJECT: gigacart
WORKING_PATH: \"$proj_dir\"
MODULE: gigacart
VHDL_FILE_LIST: design.vhd
OUTPUT_FILE_NAME: gigacart
SUFFIX_NAME: edi
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DEFAULT_ENUM_ENCODING: default
ARRANGE_VHDL_FILES: true
synthesis_onoff_pragma: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -e gigacart -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete gigacart.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf gigacart.edi -out gigacart.bl0 -err automake.err -log gigacart.log -prj gigacart -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" gigacart.bl0 -collapse none -reduce none -keepwires  -err automake.err -family"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"gigacart.bl1\" -o \"gigacart.bl2\" -omod \"gigacart\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj gigacart -lci gigacart.lct -log gigacart.imp -err automake.err -tti gigacart.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci gigacart.lct -blifopt gigacart.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" gigacart.bl2 -sweep -mergefb -err automake.err -o gigacart.bl3 @gigacart.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci gigacart.lct -dev lc4k -diofft gigacart.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" gigacart.bl3 -family AMDMACH -idev van -o gigacart.bl4 -oxrf gigacart.xrf -err automake.err @gigacart.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci gigacart.lct -dev lc4k -prefit gigacart.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp gigacart.bl4 -out gigacart.bl5 -err automake.err -log gigacart.log -mod gigacart @gigacart.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open gigacart.rs1 w} rspFile] {
	puts stderr "Cannot create response file gigacart.rs1: $rspFile"
} else {
	puts $rspFile "-i gigacart.bl5 -lci gigacart.lct -d m4s_64_64 -lco gigacart.lco -html_rpt -fti gigacart.fti -fmt PLA -tto gigacart.tt4 -nojed -eqn gigacart.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open gigacart.rs2 w} rspFile] {
	puts stderr "Cannot create response file gigacart.rs2: $rspFile"
} else {
	puts $rspFile "-i gigacart.bl5 -lci gigacart.lct -d m4s_64_64 -lco gigacart.lco -html_rpt -fti gigacart.fti -fmt PLA -tto gigacart.tt4 -eqn gigacart.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@gigacart.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete gigacart.rs1
file delete gigacart.rs2
if [runCmd "\"$cpld_bin/tda\" -i gigacart.bl5 -o gigacart.tda -lci gigacart.lct -dev m4s_64_64 -family lc4k -mod gigacart -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj gigacart -if gigacart.jed -j2s -log gigacart.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 07/02/18 21:09:32 ###########


########## Tcl recorder starts at 07/02/18 21:09:51 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vhd2jhd\" design.vhd -o design.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 07/02/18 21:09:51 ###########


########## Tcl recorder starts at 07/02/18 21:09:54 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open gigacart.cmd w} rspFile] {
	puts stderr "Cannot create response file gigacart.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: gigacart.sty
PROJECT: gigacart
WORKING_PATH: \"$proj_dir\"
MODULE: gigacart
VHDL_FILE_LIST: design.vhd
OUTPUT_FILE_NAME: gigacart
SUFFIX_NAME: edi
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DEFAULT_ENUM_ENCODING: default
ARRANGE_VHDL_FILES: true
synthesis_onoff_pragma: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -e gigacart -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete gigacart.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf gigacart.edi -out gigacart.bl0 -err automake.err -log gigacart.log -prj gigacart -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" gigacart.bl0 -collapse none -reduce none -keepwires  -err automake.err -family"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"gigacart.bl1\" -o \"gigacart.bl2\" -omod \"gigacart\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj gigacart -lci gigacart.lct -log gigacart.imp -err automake.err -tti gigacart.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci gigacart.lct -blifopt gigacart.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" gigacart.bl2 -sweep -mergefb -err automake.err -o gigacart.bl3 @gigacart.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci gigacart.lct -dev lc4k -diofft gigacart.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" gigacart.bl3 -family AMDMACH -idev van -o gigacart.bl4 -oxrf gigacart.xrf -err automake.err @gigacart.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci gigacart.lct -dev lc4k -prefit gigacart.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp gigacart.bl4 -out gigacart.bl5 -err automake.err -log gigacart.log -mod gigacart @gigacart.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open gigacart.rs1 w} rspFile] {
	puts stderr "Cannot create response file gigacart.rs1: $rspFile"
} else {
	puts $rspFile "-i gigacart.bl5 -lci gigacart.lct -d m4s_64_64 -lco gigacart.lco -html_rpt -fti gigacart.fti -fmt PLA -tto gigacart.tt4 -nojed -eqn gigacart.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open gigacart.rs2 w} rspFile] {
	puts stderr "Cannot create response file gigacart.rs2: $rspFile"
} else {
	puts $rspFile "-i gigacart.bl5 -lci gigacart.lct -d m4s_64_64 -lco gigacart.lco -html_rpt -fti gigacart.fti -fmt PLA -tto gigacart.tt4 -eqn gigacart.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@gigacart.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete gigacart.rs1
file delete gigacart.rs2
if [runCmd "\"$cpld_bin/tda\" -i gigacart.bl5 -o gigacart.tda -lci gigacart.lct -dev m4s_64_64 -family lc4k -mod gigacart -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj gigacart -if gigacart.jed -j2s -log gigacart.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 07/02/18 21:09:54 ###########


########## Tcl recorder starts at 07/02/18 21:10:52 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vhd2jhd\" design.vhd -o design.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 07/02/18 21:10:52 ###########


########## Tcl recorder starts at 07/02/18 21:11:00 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open gigacart.cmd w} rspFile] {
	puts stderr "Cannot create response file gigacart.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: gigacart.sty
PROJECT: gigacart
WORKING_PATH: \"$proj_dir\"
MODULE: gigacart
VHDL_FILE_LIST: design.vhd
OUTPUT_FILE_NAME: gigacart
SUFFIX_NAME: edi
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DEFAULT_ENUM_ENCODING: default
ARRANGE_VHDL_FILES: true
synthesis_onoff_pragma: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -e gigacart -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete gigacart.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf gigacart.edi -out gigacart.bl0 -err automake.err -log gigacart.log -prj gigacart -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" gigacart.bl0 -collapse none -reduce none -keepwires  -err automake.err -family"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"gigacart.bl1\" -o \"gigacart.bl2\" -omod \"gigacart\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj gigacart -lci gigacart.lct -log gigacart.imp -err automake.err -tti gigacart.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci gigacart.lct -blifopt gigacart.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" gigacart.bl2 -sweep -mergefb -err automake.err -o gigacart.bl3 @gigacart.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci gigacart.lct -dev lc4k -diofft gigacart.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" gigacart.bl3 -family AMDMACH -idev van -o gigacart.bl4 -oxrf gigacart.xrf -err automake.err @gigacart.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci gigacart.lct -dev lc4k -prefit gigacart.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp gigacart.bl4 -out gigacart.bl5 -err automake.err -log gigacart.log -mod gigacart @gigacart.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open gigacart.rs1 w} rspFile] {
	puts stderr "Cannot create response file gigacart.rs1: $rspFile"
} else {
	puts $rspFile "-i gigacart.bl5 -lci gigacart.lct -d m4s_64_64 -lco gigacart.lco -html_rpt -fti gigacart.fti -fmt PLA -tto gigacart.tt4 -nojed -eqn gigacart.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open gigacart.rs2 w} rspFile] {
	puts stderr "Cannot create response file gigacart.rs2: $rspFile"
} else {
	puts $rspFile "-i gigacart.bl5 -lci gigacart.lct -d m4s_64_64 -lco gigacart.lco -html_rpt -fti gigacart.fti -fmt PLA -tto gigacart.tt4 -eqn gigacart.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@gigacart.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete gigacart.rs1
file delete gigacart.rs2
if [runCmd "\"$cpld_bin/tda\" -i gigacart.bl5 -o gigacart.tda -lci gigacart.lct -dev m4s_64_64 -family lc4k -mod gigacart -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj gigacart -if gigacart.jed -j2s -log gigacart.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 07/02/18 21:11:00 ###########


########## Tcl recorder starts at 07/02/18 21:11:53 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vhd2jhd\" design.vhd -o design.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 07/02/18 21:11:53 ###########


########## Tcl recorder starts at 07/02/18 21:11:56 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open gigacart.cmd w} rspFile] {
	puts stderr "Cannot create response file gigacart.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: gigacart.sty
PROJECT: gigacart
WORKING_PATH: \"$proj_dir\"
MODULE: gigacart
VHDL_FILE_LIST: design.vhd
OUTPUT_FILE_NAME: gigacart
SUFFIX_NAME: edi
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DEFAULT_ENUM_ENCODING: default
ARRANGE_VHDL_FILES: true
synthesis_onoff_pragma: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -e gigacart -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete gigacart.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf gigacart.edi -out gigacart.bl0 -err automake.err -log gigacart.log -prj gigacart -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" gigacart.bl0 -collapse none -reduce none -keepwires  -err automake.err -family"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"gigacart.bl1\" -o \"gigacart.bl2\" -omod \"gigacart\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj gigacart -lci gigacart.lct -log gigacart.imp -err automake.err -tti gigacart.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci gigacart.lct -blifopt gigacart.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" gigacart.bl2 -sweep -mergefb -err automake.err -o gigacart.bl3 @gigacart.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci gigacart.lct -dev lc4k -diofft gigacart.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" gigacart.bl3 -family AMDMACH -idev van -o gigacart.bl4 -oxrf gigacart.xrf -err automake.err @gigacart.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci gigacart.lct -dev lc4k -prefit gigacart.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp gigacart.bl4 -out gigacart.bl5 -err automake.err -log gigacart.log -mod gigacart @gigacart.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open gigacart.rs1 w} rspFile] {
	puts stderr "Cannot create response file gigacart.rs1: $rspFile"
} else {
	puts $rspFile "-i gigacart.bl5 -lci gigacart.lct -d m4s_64_64 -lco gigacart.lco -html_rpt -fti gigacart.fti -fmt PLA -tto gigacart.tt4 -nojed -eqn gigacart.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open gigacart.rs2 w} rspFile] {
	puts stderr "Cannot create response file gigacart.rs2: $rspFile"
} else {
	puts $rspFile "-i gigacart.bl5 -lci gigacart.lct -d m4s_64_64 -lco gigacart.lco -html_rpt -fti gigacart.fti -fmt PLA -tto gigacart.tt4 -eqn gigacart.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@gigacart.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete gigacart.rs1
file delete gigacart.rs2
if [runCmd "\"$cpld_bin/tda\" -i gigacart.bl5 -o gigacart.tda -lci gigacart.lct -dev m4s_64_64 -family lc4k -mod gigacart -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj gigacart -if gigacart.jed -j2s -log gigacart.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 07/02/18 21:11:56 ###########


########## Tcl recorder starts at 07/02/18 21:15:59 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vhd2jhd\" design.vhd -o design.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 07/02/18 21:15:59 ###########


########## Tcl recorder starts at 07/02/18 21:16:02 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open gigacart.cmd w} rspFile] {
	puts stderr "Cannot create response file gigacart.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: gigacart.sty
PROJECT: gigacart
WORKING_PATH: \"$proj_dir\"
MODULE: gigacart
VHDL_FILE_LIST: design.vhd
OUTPUT_FILE_NAME: gigacart
SUFFIX_NAME: edi
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DEFAULT_ENUM_ENCODING: default
ARRANGE_VHDL_FILES: true
synthesis_onoff_pragma: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -e gigacart -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete gigacart.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf gigacart.edi -out gigacart.bl0 -err automake.err -log gigacart.log -prj gigacart -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" gigacart.bl0 -collapse none -reduce none -keepwires  -err automake.err -family"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"gigacart.bl1\" -o \"gigacart.bl2\" -omod \"gigacart\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj gigacart -lci gigacart.lct -log gigacart.imp -err automake.err -tti gigacart.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci gigacart.lct -blifopt gigacart.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" gigacart.bl2 -sweep -mergefb -err automake.err -o gigacart.bl3 @gigacart.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci gigacart.lct -dev lc4k -diofft gigacart.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" gigacart.bl3 -family AMDMACH -idev van -o gigacart.bl4 -oxrf gigacart.xrf -err automake.err @gigacart.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci gigacart.lct -dev lc4k -prefit gigacart.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp gigacart.bl4 -out gigacart.bl5 -err automake.err -log gigacart.log -mod gigacart @gigacart.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open gigacart.rs1 w} rspFile] {
	puts stderr "Cannot create response file gigacart.rs1: $rspFile"
} else {
	puts $rspFile "-i gigacart.bl5 -lci gigacart.lct -d m4s_64_64 -lco gigacart.lco -html_rpt -fti gigacart.fti -fmt PLA -tto gigacart.tt4 -nojed -eqn gigacart.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open gigacart.rs2 w} rspFile] {
	puts stderr "Cannot create response file gigacart.rs2: $rspFile"
} else {
	puts $rspFile "-i gigacart.bl5 -lci gigacart.lct -d m4s_64_64 -lco gigacart.lco -html_rpt -fti gigacart.fti -fmt PLA -tto gigacart.tt4 -eqn gigacart.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@gigacart.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete gigacart.rs1
file delete gigacart.rs2
if [runCmd "\"$cpld_bin/tda\" -i gigacart.bl5 -o gigacart.tda -lci gigacart.lct -dev m4s_64_64 -family lc4k -mod gigacart -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj gigacart -if gigacart.jed -j2s -log gigacart.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 07/02/18 21:16:02 ###########


########## Tcl recorder starts at 07/02/18 21:17:20 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vhd2jhd\" design.vhd -o design.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 07/02/18 21:17:20 ###########


########## Tcl recorder starts at 07/02/18 21:17:23 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open gigacart.cmd w} rspFile] {
	puts stderr "Cannot create response file gigacart.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: gigacart.sty
PROJECT: gigacart
WORKING_PATH: \"$proj_dir\"
MODULE: gigacart
VHDL_FILE_LIST: design.vhd
OUTPUT_FILE_NAME: gigacart
SUFFIX_NAME: edi
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DEFAULT_ENUM_ENCODING: default
ARRANGE_VHDL_FILES: true
synthesis_onoff_pragma: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -e gigacart -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete gigacart.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf gigacart.edi -out gigacart.bl0 -err automake.err -log gigacart.log -prj gigacart -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" gigacart.bl0 -collapse none -reduce none -keepwires  -err automake.err -family"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"gigacart.bl1\" -o \"gigacart.bl2\" -omod \"gigacart\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj gigacart -lci gigacart.lct -log gigacart.imp -err automake.err -tti gigacart.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci gigacart.lct -blifopt gigacart.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" gigacart.bl2 -sweep -mergefb -err automake.err -o gigacart.bl3 @gigacart.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci gigacart.lct -dev lc4k -diofft gigacart.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" gigacart.bl3 -family AMDMACH -idev van -o gigacart.bl4 -oxrf gigacart.xrf -err automake.err @gigacart.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci gigacart.lct -dev lc4k -prefit gigacart.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp gigacart.bl4 -out gigacart.bl5 -err automake.err -log gigacart.log -mod gigacart @gigacart.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open gigacart.rs1 w} rspFile] {
	puts stderr "Cannot create response file gigacart.rs1: $rspFile"
} else {
	puts $rspFile "-i gigacart.bl5 -lci gigacart.lct -d m4s_64_64 -lco gigacart.lco -html_rpt -fti gigacart.fti -fmt PLA -tto gigacart.tt4 -nojed -eqn gigacart.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open gigacart.rs2 w} rspFile] {
	puts stderr "Cannot create response file gigacart.rs2: $rspFile"
} else {
	puts $rspFile "-i gigacart.bl5 -lci gigacart.lct -d m4s_64_64 -lco gigacart.lco -html_rpt -fti gigacart.fti -fmt PLA -tto gigacart.tt4 -eqn gigacart.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@gigacart.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete gigacart.rs1
file delete gigacart.rs2
if [runCmd "\"$cpld_bin/tda\" -i gigacart.bl5 -o gigacart.tda -lci gigacart.lct -dev m4s_64_64 -family lc4k -mod gigacart -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj gigacart -if gigacart.jed -j2s -log gigacart.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 07/02/18 21:17:23 ###########


########## Tcl recorder starts at 07/02/18 21:18:18 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vhd2jhd\" design.vhd -o design.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 07/02/18 21:18:18 ###########


########## Tcl recorder starts at 07/02/18 21:18:23 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open gigacart.cmd w} rspFile] {
	puts stderr "Cannot create response file gigacart.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: gigacart.sty
PROJECT: gigacart
WORKING_PATH: \"$proj_dir\"
MODULE: gigacart
VHDL_FILE_LIST: design.vhd
OUTPUT_FILE_NAME: gigacart
SUFFIX_NAME: edi
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DEFAULT_ENUM_ENCODING: default
ARRANGE_VHDL_FILES: true
synthesis_onoff_pragma: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -e gigacart -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete gigacart.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf gigacart.edi -out gigacart.bl0 -err automake.err -log gigacart.log -prj gigacart -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" gigacart.bl0 -collapse none -reduce none -keepwires  -err automake.err -family"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"gigacart.bl1\" -o \"gigacart.bl2\" -omod \"gigacart\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj gigacart -lci gigacart.lct -log gigacart.imp -err automake.err -tti gigacart.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci gigacart.lct -blifopt gigacart.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" gigacart.bl2 -sweep -mergefb -err automake.err -o gigacart.bl3 @gigacart.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci gigacart.lct -dev lc4k -diofft gigacart.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" gigacart.bl3 -family AMDMACH -idev van -o gigacart.bl4 -oxrf gigacart.xrf -err automake.err @gigacart.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci gigacart.lct -dev lc4k -prefit gigacart.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp gigacart.bl4 -out gigacart.bl5 -err automake.err -log gigacart.log -mod gigacart @gigacart.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open gigacart.rs1 w} rspFile] {
	puts stderr "Cannot create response file gigacart.rs1: $rspFile"
} else {
	puts $rspFile "-i gigacart.bl5 -lci gigacart.lct -d m4s_64_64 -lco gigacart.lco -html_rpt -fti gigacart.fti -fmt PLA -tto gigacart.tt4 -nojed -eqn gigacart.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open gigacart.rs2 w} rspFile] {
	puts stderr "Cannot create response file gigacart.rs2: $rspFile"
} else {
	puts $rspFile "-i gigacart.bl5 -lci gigacart.lct -d m4s_64_64 -lco gigacart.lco -html_rpt -fti gigacart.fti -fmt PLA -tto gigacart.tt4 -eqn gigacart.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@gigacart.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete gigacart.rs1
file delete gigacart.rs2
if [runCmd "\"$cpld_bin/tda\" -i gigacart.bl5 -o gigacart.tda -lci gigacart.lct -dev m4s_64_64 -family lc4k -mod gigacart -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj gigacart -if gigacart.jed -j2s -log gigacart.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 07/02/18 21:18:23 ###########


########## Tcl recorder starts at 07/02/18 21:24:00 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vhd2jhd\" design.vhd -o design.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 07/02/18 21:24:00 ###########


########## Tcl recorder starts at 07/02/18 21:24:05 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open gigacart.cmd w} rspFile] {
	puts stderr "Cannot create response file gigacart.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: gigacart.sty
PROJECT: gigacart
WORKING_PATH: \"$proj_dir\"
MODULE: gigacart
VHDL_FILE_LIST: design.vhd
OUTPUT_FILE_NAME: gigacart
SUFFIX_NAME: edi
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DEFAULT_ENUM_ENCODING: default
ARRANGE_VHDL_FILES: true
synthesis_onoff_pragma: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -e gigacart -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete gigacart.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf gigacart.edi -out gigacart.bl0 -err automake.err -log gigacart.log -prj gigacart -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" gigacart.bl0 -collapse none -reduce none -keepwires  -err automake.err -family"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"gigacart.bl1\" -o \"gigacart.bl2\" -omod \"gigacart\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj gigacart -lci gigacart.lct -log gigacart.imp -err automake.err -tti gigacart.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci gigacart.lct -blifopt gigacart.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" gigacart.bl2 -sweep -mergefb -err automake.err -o gigacart.bl3 @gigacart.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci gigacart.lct -dev lc4k -diofft gigacart.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" gigacart.bl3 -family AMDMACH -idev van -o gigacart.bl4 -oxrf gigacart.xrf -err automake.err @gigacart.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci gigacart.lct -dev lc4k -prefit gigacart.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp gigacart.bl4 -out gigacart.bl5 -err automake.err -log gigacart.log -mod gigacart @gigacart.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open gigacart.rs1 w} rspFile] {
	puts stderr "Cannot create response file gigacart.rs1: $rspFile"
} else {
	puts $rspFile "-i gigacart.bl5 -lci gigacart.lct -d m4s_64_64 -lco gigacart.lco -html_rpt -fti gigacart.fti -fmt PLA -tto gigacart.tt4 -nojed -eqn gigacart.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open gigacart.rs2 w} rspFile] {
	puts stderr "Cannot create response file gigacart.rs2: $rspFile"
} else {
	puts $rspFile "-i gigacart.bl5 -lci gigacart.lct -d m4s_64_64 -lco gigacart.lco -html_rpt -fti gigacart.fti -fmt PLA -tto gigacart.tt4 -eqn gigacart.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@gigacart.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete gigacart.rs1
file delete gigacart.rs2
if [runCmd "\"$cpld_bin/tda\" -i gigacart.bl5 -o gigacart.tda -lci gigacart.lct -dev m4s_64_64 -family lc4k -mod gigacart -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj gigacart -if gigacart.jed -j2s -log gigacart.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 07/02/18 21:24:05 ###########


########## Tcl recorder starts at 07/02/18 21:25:20 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vhd2jhd\" design.vhd -o design.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 07/02/18 21:25:20 ###########


########## Tcl recorder starts at 07/02/18 21:25:24 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open gigacart.cmd w} rspFile] {
	puts stderr "Cannot create response file gigacart.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: gigacart.sty
PROJECT: gigacart
WORKING_PATH: \"$proj_dir\"
MODULE: gigacart
VHDL_FILE_LIST: design.vhd
OUTPUT_FILE_NAME: gigacart
SUFFIX_NAME: edi
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DEFAULT_ENUM_ENCODING: default
ARRANGE_VHDL_FILES: true
synthesis_onoff_pragma: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -e gigacart -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete gigacart.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf gigacart.edi -out gigacart.bl0 -err automake.err -log gigacart.log -prj gigacart -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" gigacart.bl0 -collapse none -reduce none -keepwires  -err automake.err -family"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"gigacart.bl1\" -o \"gigacart.bl2\" -omod \"gigacart\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj gigacart -lci gigacart.lct -log gigacart.imp -err automake.err -tti gigacart.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci gigacart.lct -blifopt gigacart.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" gigacart.bl2 -sweep -mergefb -err automake.err -o gigacart.bl3 @gigacart.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci gigacart.lct -dev lc4k -diofft gigacart.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" gigacart.bl3 -family AMDMACH -idev van -o gigacart.bl4 -oxrf gigacart.xrf -err automake.err @gigacart.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci gigacart.lct -dev lc4k -prefit gigacart.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp gigacart.bl4 -out gigacart.bl5 -err automake.err -log gigacart.log -mod gigacart @gigacart.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open gigacart.rs1 w} rspFile] {
	puts stderr "Cannot create response file gigacart.rs1: $rspFile"
} else {
	puts $rspFile "-i gigacart.bl5 -lci gigacart.lct -d m4s_64_64 -lco gigacart.lco -html_rpt -fti gigacart.fti -fmt PLA -tto gigacart.tt4 -nojed -eqn gigacart.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open gigacart.rs2 w} rspFile] {
	puts stderr "Cannot create response file gigacart.rs2: $rspFile"
} else {
	puts $rspFile "-i gigacart.bl5 -lci gigacart.lct -d m4s_64_64 -lco gigacart.lco -html_rpt -fti gigacart.fti -fmt PLA -tto gigacart.tt4 -eqn gigacart.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@gigacart.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete gigacart.rs1
file delete gigacart.rs2
if [runCmd "\"$cpld_bin/tda\" -i gigacart.bl5 -o gigacart.tda -lci gigacart.lct -dev m4s_64_64 -family lc4k -mod gigacart -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj gigacart -if gigacart.jed -j2s -log gigacart.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 07/02/18 21:25:24 ###########


########## Tcl recorder starts at 07/02/18 21:26:20 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vhd2jhd\" design.vhd -o design.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 07/02/18 21:26:20 ###########


########## Tcl recorder starts at 07/02/18 21:26:23 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open gigacart.cmd w} rspFile] {
	puts stderr "Cannot create response file gigacart.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: gigacart.sty
PROJECT: gigacart
WORKING_PATH: \"$proj_dir\"
MODULE: gigacart
VHDL_FILE_LIST: design.vhd
OUTPUT_FILE_NAME: gigacart
SUFFIX_NAME: edi
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DEFAULT_ENUM_ENCODING: default
ARRANGE_VHDL_FILES: true
synthesis_onoff_pragma: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -e gigacart -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete gigacart.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf gigacart.edi -out gigacart.bl0 -err automake.err -log gigacart.log -prj gigacart -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" gigacart.bl0 -collapse none -reduce none -keepwires  -err automake.err -family"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"gigacart.bl1\" -o \"gigacart.bl2\" -omod \"gigacart\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj gigacart -lci gigacart.lct -log gigacart.imp -err automake.err -tti gigacart.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci gigacart.lct -blifopt gigacart.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" gigacart.bl2 -sweep -mergefb -err automake.err -o gigacart.bl3 @gigacart.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci gigacart.lct -dev lc4k -diofft gigacart.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" gigacart.bl3 -family AMDMACH -idev van -o gigacart.bl4 -oxrf gigacart.xrf -err automake.err @gigacart.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci gigacart.lct -dev lc4k -prefit gigacart.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp gigacart.bl4 -out gigacart.bl5 -err automake.err -log gigacart.log -mod gigacart @gigacart.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open gigacart.rs1 w} rspFile] {
	puts stderr "Cannot create response file gigacart.rs1: $rspFile"
} else {
	puts $rspFile "-i gigacart.bl5 -lci gigacart.lct -d m4s_64_64 -lco gigacart.lco -html_rpt -fti gigacart.fti -fmt PLA -tto gigacart.tt4 -nojed -eqn gigacart.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open gigacart.rs2 w} rspFile] {
	puts stderr "Cannot create response file gigacart.rs2: $rspFile"
} else {
	puts $rspFile "-i gigacart.bl5 -lci gigacart.lct -d m4s_64_64 -lco gigacart.lco -html_rpt -fti gigacart.fti -fmt PLA -tto gigacart.tt4 -eqn gigacart.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@gigacart.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete gigacart.rs1
file delete gigacart.rs2
if [runCmd "\"$cpld_bin/tda\" -i gigacart.bl5 -o gigacart.tda -lci gigacart.lct -dev m4s_64_64 -family lc4k -mod gigacart -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj gigacart -if gigacart.jed -j2s -log gigacart.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 07/02/18 21:26:23 ###########


########## Tcl recorder starts at 07/02/18 21:28:31 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vhd2jhd\" design.vhd -o design.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 07/02/18 21:28:31 ###########


########## Tcl recorder starts at 07/02/18 21:28:34 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open gigacart.cmd w} rspFile] {
	puts stderr "Cannot create response file gigacart.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: gigacart.sty
PROJECT: gigacart
WORKING_PATH: \"$proj_dir\"
MODULE: gigacart
VHDL_FILE_LIST: design.vhd
OUTPUT_FILE_NAME: gigacart
SUFFIX_NAME: edi
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DEFAULT_ENUM_ENCODING: default
ARRANGE_VHDL_FILES: true
synthesis_onoff_pragma: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -e gigacart -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete gigacart.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf gigacart.edi -out gigacart.bl0 -err automake.err -log gigacart.log -prj gigacart -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" gigacart.bl0 -collapse none -reduce none -keepwires  -err automake.err -family"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"gigacart.bl1\" -o \"gigacart.bl2\" -omod \"gigacart\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj gigacart -lci gigacart.lct -log gigacart.imp -err automake.err -tti gigacart.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci gigacart.lct -blifopt gigacart.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" gigacart.bl2 -sweep -mergefb -err automake.err -o gigacart.bl3 @gigacart.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci gigacart.lct -dev lc4k -diofft gigacart.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" gigacart.bl3 -family AMDMACH -idev van -o gigacart.bl4 -oxrf gigacart.xrf -err automake.err @gigacart.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci gigacart.lct -dev lc4k -prefit gigacart.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp gigacart.bl4 -out gigacart.bl5 -err automake.err -log gigacart.log -mod gigacart @gigacart.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open gigacart.rs1 w} rspFile] {
	puts stderr "Cannot create response file gigacart.rs1: $rspFile"
} else {
	puts $rspFile "-i gigacart.bl5 -lci gigacart.lct -d m4s_64_64 -lco gigacart.lco -html_rpt -fti gigacart.fti -fmt PLA -tto gigacart.tt4 -nojed -eqn gigacart.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open gigacart.rs2 w} rspFile] {
	puts stderr "Cannot create response file gigacart.rs2: $rspFile"
} else {
	puts $rspFile "-i gigacart.bl5 -lci gigacart.lct -d m4s_64_64 -lco gigacart.lco -html_rpt -fti gigacart.fti -fmt PLA -tto gigacart.tt4 -eqn gigacart.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@gigacart.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete gigacart.rs1
file delete gigacart.rs2
if [runCmd "\"$cpld_bin/tda\" -i gigacart.bl5 -o gigacart.tda -lci gigacart.lct -dev m4s_64_64 -family lc4k -mod gigacart -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj gigacart -if gigacart.jed -j2s -log gigacart.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 07/02/18 21:28:34 ###########


########## Tcl recorder starts at 07/02/18 21:30:03 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vhd2jhd\" design.vhd -o design.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 07/02/18 21:30:03 ###########


########## Tcl recorder starts at 07/02/18 21:30:06 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open gigacart.cmd w} rspFile] {
	puts stderr "Cannot create response file gigacart.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: gigacart.sty
PROJECT: gigacart
WORKING_PATH: \"$proj_dir\"
MODULE: gigacart
VHDL_FILE_LIST: design.vhd
OUTPUT_FILE_NAME: gigacart
SUFFIX_NAME: edi
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DEFAULT_ENUM_ENCODING: default
ARRANGE_VHDL_FILES: true
synthesis_onoff_pragma: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -e gigacart -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete gigacart.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf gigacart.edi -out gigacart.bl0 -err automake.err -log gigacart.log -prj gigacart -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" gigacart.bl0 -collapse none -reduce none -keepwires  -err automake.err -family"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"gigacart.bl1\" -o \"gigacart.bl2\" -omod \"gigacart\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj gigacart -lci gigacart.lct -log gigacart.imp -err automake.err -tti gigacart.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci gigacart.lct -blifopt gigacart.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" gigacart.bl2 -sweep -mergefb -err automake.err -o gigacart.bl3 @gigacart.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci gigacart.lct -dev lc4k -diofft gigacart.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" gigacart.bl3 -family AMDMACH -idev van -o gigacart.bl4 -oxrf gigacart.xrf -err automake.err @gigacart.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci gigacart.lct -dev lc4k -prefit gigacart.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp gigacart.bl4 -out gigacart.bl5 -err automake.err -log gigacart.log -mod gigacart @gigacart.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open gigacart.rs1 w} rspFile] {
	puts stderr "Cannot create response file gigacart.rs1: $rspFile"
} else {
	puts $rspFile "-i gigacart.bl5 -lci gigacart.lct -d m4s_64_64 -lco gigacart.lco -html_rpt -fti gigacart.fti -fmt PLA -tto gigacart.tt4 -nojed -eqn gigacart.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open gigacart.rs2 w} rspFile] {
	puts stderr "Cannot create response file gigacart.rs2: $rspFile"
} else {
	puts $rspFile "-i gigacart.bl5 -lci gigacart.lct -d m4s_64_64 -lco gigacart.lco -html_rpt -fti gigacart.fti -fmt PLA -tto gigacart.tt4 -eqn gigacart.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@gigacart.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete gigacart.rs1
file delete gigacart.rs2
if [runCmd "\"$cpld_bin/tda\" -i gigacart.bl5 -o gigacart.tda -lci gigacart.lct -dev m4s_64_64 -family lc4k -mod gigacart -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj gigacart -if gigacart.jed -j2s -log gigacart.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 07/02/18 21:30:06 ###########


########## Tcl recorder starts at 07/02/18 21:32:49 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vhd2jhd\" design.vhd -o design.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 07/02/18 21:32:49 ###########


########## Tcl recorder starts at 07/02/18 21:32:53 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open gigacart.cmd w} rspFile] {
	puts stderr "Cannot create response file gigacart.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: gigacart.sty
PROJECT: gigacart
WORKING_PATH: \"$proj_dir\"
MODULE: gigacart
VHDL_FILE_LIST: design.vhd
OUTPUT_FILE_NAME: gigacart
SUFFIX_NAME: edi
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DEFAULT_ENUM_ENCODING: default
ARRANGE_VHDL_FILES: true
synthesis_onoff_pragma: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -e gigacart -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete gigacart.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf gigacart.edi -out gigacart.bl0 -err automake.err -log gigacart.log -prj gigacart -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" gigacart.bl0 -collapse none -reduce none -keepwires  -err automake.err -family"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"gigacart.bl1\" -o \"gigacart.bl2\" -omod \"gigacart\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj gigacart -lci gigacart.lct -log gigacart.imp -err automake.err -tti gigacart.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci gigacart.lct -blifopt gigacart.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" gigacart.bl2 -sweep -mergefb -err automake.err -o gigacart.bl3 @gigacart.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci gigacart.lct -dev lc4k -diofft gigacart.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" gigacart.bl3 -family AMDMACH -idev van -o gigacart.bl4 -oxrf gigacart.xrf -err automake.err @gigacart.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci gigacart.lct -dev lc4k -prefit gigacart.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp gigacart.bl4 -out gigacart.bl5 -err automake.err -log gigacart.log -mod gigacart @gigacart.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open gigacart.rs1 w} rspFile] {
	puts stderr "Cannot create response file gigacart.rs1: $rspFile"
} else {
	puts $rspFile "-i gigacart.bl5 -lci gigacart.lct -d m4s_64_64 -lco gigacart.lco -html_rpt -fti gigacart.fti -fmt PLA -tto gigacart.tt4 -nojed -eqn gigacart.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open gigacart.rs2 w} rspFile] {
	puts stderr "Cannot create response file gigacart.rs2: $rspFile"
} else {
	puts $rspFile "-i gigacart.bl5 -lci gigacart.lct -d m4s_64_64 -lco gigacart.lco -html_rpt -fti gigacart.fti -fmt PLA -tto gigacart.tt4 -eqn gigacart.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@gigacart.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete gigacart.rs1
file delete gigacart.rs2
if [runCmd "\"$cpld_bin/tda\" -i gigacart.bl5 -o gigacart.tda -lci gigacart.lct -dev m4s_64_64 -family lc4k -mod gigacart -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj gigacart -if gigacart.jed -j2s -log gigacart.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 07/02/18 21:32:53 ###########


########## Tcl recorder starts at 07/02/18 21:35:02 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vhd2jhd\" design.vhd -o design.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 07/02/18 21:35:02 ###########


########## Tcl recorder starts at 07/02/18 21:35:06 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open gigacart.cmd w} rspFile] {
	puts stderr "Cannot create response file gigacart.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: gigacart.sty
PROJECT: gigacart
WORKING_PATH: \"$proj_dir\"
MODULE: gigacart
VHDL_FILE_LIST: design.vhd
OUTPUT_FILE_NAME: gigacart
SUFFIX_NAME: edi
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DEFAULT_ENUM_ENCODING: default
ARRANGE_VHDL_FILES: true
synthesis_onoff_pragma: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -e gigacart -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete gigacart.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf gigacart.edi -out gigacart.bl0 -err automake.err -log gigacart.log -prj gigacart -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" gigacart.bl0 -collapse none -reduce none -keepwires  -err automake.err -family"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"gigacart.bl1\" -o \"gigacart.bl2\" -omod \"gigacart\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj gigacart -lci gigacart.lct -log gigacart.imp -err automake.err -tti gigacart.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci gigacart.lct -blifopt gigacart.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" gigacart.bl2 -sweep -mergefb -err automake.err -o gigacart.bl3 @gigacart.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci gigacart.lct -dev lc4k -diofft gigacart.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" gigacart.bl3 -family AMDMACH -idev van -o gigacart.bl4 -oxrf gigacart.xrf -err automake.err @gigacart.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci gigacart.lct -dev lc4k -prefit gigacart.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp gigacart.bl4 -out gigacart.bl5 -err automake.err -log gigacart.log -mod gigacart @gigacart.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open gigacart.rs1 w} rspFile] {
	puts stderr "Cannot create response file gigacart.rs1: $rspFile"
} else {
	puts $rspFile "-i gigacart.bl5 -lci gigacart.lct -d m4s_64_64 -lco gigacart.lco -html_rpt -fti gigacart.fti -fmt PLA -tto gigacart.tt4 -nojed -eqn gigacart.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open gigacart.rs2 w} rspFile] {
	puts stderr "Cannot create response file gigacart.rs2: $rspFile"
} else {
	puts $rspFile "-i gigacart.bl5 -lci gigacart.lct -d m4s_64_64 -lco gigacart.lco -html_rpt -fti gigacart.fti -fmt PLA -tto gigacart.tt4 -eqn gigacart.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@gigacart.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete gigacart.rs1
file delete gigacart.rs2
if [runCmd "\"$cpld_bin/tda\" -i gigacart.bl5 -o gigacart.tda -lci gigacart.lct -dev m4s_64_64 -family lc4k -mod gigacart -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj gigacart -if gigacart.jed -j2s -log gigacart.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 07/02/18 21:35:06 ###########


########## Tcl recorder starts at 07/02/18 21:38:10 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vhd2jhd\" design.vhd -o design.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 07/02/18 21:38:10 ###########


########## Tcl recorder starts at 07/02/18 21:38:15 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open gigacart.cmd w} rspFile] {
	puts stderr "Cannot create response file gigacart.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: gigacart.sty
PROJECT: gigacart
WORKING_PATH: \"$proj_dir\"
MODULE: gigacart
VHDL_FILE_LIST: design.vhd
OUTPUT_FILE_NAME: gigacart
SUFFIX_NAME: edi
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DEFAULT_ENUM_ENCODING: default
ARRANGE_VHDL_FILES: true
synthesis_onoff_pragma: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -e gigacart -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete gigacart.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf gigacart.edi -out gigacart.bl0 -err automake.err -log gigacart.log -prj gigacart -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" gigacart.bl0 -collapse none -reduce none -keepwires  -err automake.err -family"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"gigacart.bl1\" -o \"gigacart.bl2\" -omod \"gigacart\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj gigacart -lci gigacart.lct -log gigacart.imp -err automake.err -tti gigacart.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci gigacart.lct -blifopt gigacart.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" gigacart.bl2 -sweep -mergefb -err automake.err -o gigacart.bl3 @gigacart.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci gigacart.lct -dev lc4k -diofft gigacart.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" gigacart.bl3 -family AMDMACH -idev van -o gigacart.bl4 -oxrf gigacart.xrf -err automake.err @gigacart.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci gigacart.lct -dev lc4k -prefit gigacart.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp gigacart.bl4 -out gigacart.bl5 -err automake.err -log gigacart.log -mod gigacart @gigacart.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open gigacart.rs1 w} rspFile] {
	puts stderr "Cannot create response file gigacart.rs1: $rspFile"
} else {
	puts $rspFile "-i gigacart.bl5 -lci gigacart.lct -d m4s_64_64 -lco gigacart.lco -html_rpt -fti gigacart.fti -fmt PLA -tto gigacart.tt4 -nojed -eqn gigacart.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open gigacart.rs2 w} rspFile] {
	puts stderr "Cannot create response file gigacart.rs2: $rspFile"
} else {
	puts $rspFile "-i gigacart.bl5 -lci gigacart.lct -d m4s_64_64 -lco gigacart.lco -html_rpt -fti gigacart.fti -fmt PLA -tto gigacart.tt4 -eqn gigacart.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@gigacart.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete gigacart.rs1
file delete gigacart.rs2
if [runCmd "\"$cpld_bin/tda\" -i gigacart.bl5 -o gigacart.tda -lci gigacart.lct -dev m4s_64_64 -family lc4k -mod gigacart -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj gigacart -if gigacart.jed -j2s -log gigacart.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 07/02/18 21:38:15 ###########


########## Tcl recorder starts at 07/02/18 21:38:44 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vhd2jhd\" design.vhd -o design.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 07/02/18 21:38:44 ###########


########## Tcl recorder starts at 07/02/18 21:38:47 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open gigacart.cmd w} rspFile] {
	puts stderr "Cannot create response file gigacart.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: gigacart.sty
PROJECT: gigacart
WORKING_PATH: \"$proj_dir\"
MODULE: gigacart
VHDL_FILE_LIST: design.vhd
OUTPUT_FILE_NAME: gigacart
SUFFIX_NAME: edi
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DEFAULT_ENUM_ENCODING: default
ARRANGE_VHDL_FILES: true
synthesis_onoff_pragma: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -e gigacart -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete gigacart.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf gigacart.edi -out gigacart.bl0 -err automake.err -log gigacart.log -prj gigacart -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" gigacart.bl0 -collapse none -reduce none -keepwires  -err automake.err -family"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"gigacart.bl1\" -o \"gigacart.bl2\" -omod \"gigacart\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj gigacart -lci gigacart.lct -log gigacart.imp -err automake.err -tti gigacart.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci gigacart.lct -blifopt gigacart.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" gigacart.bl2 -sweep -mergefb -err automake.err -o gigacart.bl3 @gigacart.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci gigacart.lct -dev lc4k -diofft gigacart.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" gigacart.bl3 -family AMDMACH -idev van -o gigacart.bl4 -oxrf gigacart.xrf -err automake.err @gigacart.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci gigacart.lct -dev lc4k -prefit gigacart.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp gigacart.bl4 -out gigacart.bl5 -err automake.err -log gigacart.log -mod gigacart @gigacart.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open gigacart.rs1 w} rspFile] {
	puts stderr "Cannot create response file gigacart.rs1: $rspFile"
} else {
	puts $rspFile "-i gigacart.bl5 -lci gigacart.lct -d m4s_64_64 -lco gigacart.lco -html_rpt -fti gigacart.fti -fmt PLA -tto gigacart.tt4 -nojed -eqn gigacart.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open gigacart.rs2 w} rspFile] {
	puts stderr "Cannot create response file gigacart.rs2: $rspFile"
} else {
	puts $rspFile "-i gigacart.bl5 -lci gigacart.lct -d m4s_64_64 -lco gigacart.lco -html_rpt -fti gigacart.fti -fmt PLA -tto gigacart.tt4 -eqn gigacart.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@gigacart.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete gigacart.rs1
file delete gigacart.rs2
if [runCmd "\"$cpld_bin/tda\" -i gigacart.bl5 -o gigacart.tda -lci gigacart.lct -dev m4s_64_64 -family lc4k -mod gigacart -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj gigacart -if gigacart.jed -j2s -log gigacart.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 07/02/18 21:38:47 ###########


########## Tcl recorder starts at 07/02/18 21:42:03 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vhd2jhd\" design.vhd -o design.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 07/02/18 21:42:03 ###########


########## Tcl recorder starts at 07/02/18 21:42:07 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open gigacart.cmd w} rspFile] {
	puts stderr "Cannot create response file gigacart.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: gigacart.sty
PROJECT: gigacart
WORKING_PATH: \"$proj_dir\"
MODULE: gigacart
VHDL_FILE_LIST: design.vhd
OUTPUT_FILE_NAME: gigacart
SUFFIX_NAME: edi
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DEFAULT_ENUM_ENCODING: default
ARRANGE_VHDL_FILES: true
synthesis_onoff_pragma: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -e gigacart -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete gigacart.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf gigacart.edi -out gigacart.bl0 -err automake.err -log gigacart.log -prj gigacart -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" gigacart.bl0 -collapse none -reduce none -keepwires  -err automake.err -family"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"gigacart.bl1\" -o \"gigacart.bl2\" -omod \"gigacart\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj gigacart -lci gigacart.lct -log gigacart.imp -err automake.err -tti gigacart.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci gigacart.lct -blifopt gigacart.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" gigacart.bl2 -sweep -mergefb -err automake.err -o gigacart.bl3 @gigacart.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci gigacart.lct -dev lc4k -diofft gigacart.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" gigacart.bl3 -family AMDMACH -idev van -o gigacart.bl4 -oxrf gigacart.xrf -err automake.err @gigacart.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci gigacart.lct -dev lc4k -prefit gigacart.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp gigacart.bl4 -out gigacart.bl5 -err automake.err -log gigacart.log -mod gigacart @gigacart.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open gigacart.rs1 w} rspFile] {
	puts stderr "Cannot create response file gigacart.rs1: $rspFile"
} else {
	puts $rspFile "-i gigacart.bl5 -lci gigacart.lct -d m4s_64_64 -lco gigacart.lco -html_rpt -fti gigacart.fti -fmt PLA -tto gigacart.tt4 -nojed -eqn gigacart.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open gigacart.rs2 w} rspFile] {
	puts stderr "Cannot create response file gigacart.rs2: $rspFile"
} else {
	puts $rspFile "-i gigacart.bl5 -lci gigacart.lct -d m4s_64_64 -lco gigacart.lco -html_rpt -fti gigacart.fti -fmt PLA -tto gigacart.tt4 -eqn gigacart.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@gigacart.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete gigacart.rs1
file delete gigacart.rs2
if [runCmd "\"$cpld_bin/tda\" -i gigacart.bl5 -o gigacart.tda -lci gigacart.lct -dev m4s_64_64 -family lc4k -mod gigacart -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj gigacart -if gigacart.jed -j2s -log gigacart.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 07/02/18 21:42:07 ###########


########## Tcl recorder starts at 07/02/18 21:42:38 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vhd2jhd\" design.vhd -o design.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 07/02/18 21:42:38 ###########


########## Tcl recorder starts at 07/02/18 21:42:41 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open gigacart.cmd w} rspFile] {
	puts stderr "Cannot create response file gigacart.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: gigacart.sty
PROJECT: gigacart
WORKING_PATH: \"$proj_dir\"
MODULE: gigacart
VHDL_FILE_LIST: design.vhd
OUTPUT_FILE_NAME: gigacart
SUFFIX_NAME: edi
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DEFAULT_ENUM_ENCODING: default
ARRANGE_VHDL_FILES: true
synthesis_onoff_pragma: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -e gigacart -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete gigacart.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf gigacart.edi -out gigacart.bl0 -err automake.err -log gigacart.log -prj gigacart -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" gigacart.bl0 -collapse none -reduce none -keepwires  -err automake.err -family"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"gigacart.bl1\" -o \"gigacart.bl2\" -omod \"gigacart\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj gigacart -lci gigacart.lct -log gigacart.imp -err automake.err -tti gigacart.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci gigacart.lct -blifopt gigacart.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" gigacart.bl2 -sweep -mergefb -err automake.err -o gigacart.bl3 @gigacart.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci gigacart.lct -dev lc4k -diofft gigacart.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" gigacart.bl3 -family AMDMACH -idev van -o gigacart.bl4 -oxrf gigacart.xrf -err automake.err @gigacart.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci gigacart.lct -dev lc4k -prefit gigacart.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp gigacart.bl4 -out gigacart.bl5 -err automake.err -log gigacart.log -mod gigacart @gigacart.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open gigacart.rs1 w} rspFile] {
	puts stderr "Cannot create response file gigacart.rs1: $rspFile"
} else {
	puts $rspFile "-i gigacart.bl5 -lci gigacart.lct -d m4s_64_64 -lco gigacart.lco -html_rpt -fti gigacart.fti -fmt PLA -tto gigacart.tt4 -nojed -eqn gigacart.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open gigacart.rs2 w} rspFile] {
	puts stderr "Cannot create response file gigacart.rs2: $rspFile"
} else {
	puts $rspFile "-i gigacart.bl5 -lci gigacart.lct -d m4s_64_64 -lco gigacart.lco -html_rpt -fti gigacart.fti -fmt PLA -tto gigacart.tt4 -eqn gigacart.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@gigacart.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete gigacart.rs1
file delete gigacart.rs2
if [runCmd "\"$cpld_bin/tda\" -i gigacart.bl5 -o gigacart.tda -lci gigacart.lct -dev m4s_64_64 -family lc4k -mod gigacart -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj gigacart -if gigacart.jed -j2s -log gigacart.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 07/02/18 21:42:41 ###########


########## Tcl recorder starts at 07/02/18 21:43:34 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vhd2jhd\" design.vhd -o design.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 07/02/18 21:43:34 ###########


########## Tcl recorder starts at 07/02/18 21:43:37 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open gigacart.cmd w} rspFile] {
	puts stderr "Cannot create response file gigacart.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: gigacart.sty
PROJECT: gigacart
WORKING_PATH: \"$proj_dir\"
MODULE: gigacart
VHDL_FILE_LIST: design.vhd
OUTPUT_FILE_NAME: gigacart
SUFFIX_NAME: edi
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DEFAULT_ENUM_ENCODING: default
ARRANGE_VHDL_FILES: true
synthesis_onoff_pragma: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -e gigacart -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete gigacart.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf gigacart.edi -out gigacart.bl0 -err automake.err -log gigacart.log -prj gigacart -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" gigacart.bl0 -collapse none -reduce none -keepwires  -err automake.err -family"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"gigacart.bl1\" -o \"gigacart.bl2\" -omod \"gigacart\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj gigacart -lci gigacart.lct -log gigacart.imp -err automake.err -tti gigacart.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci gigacart.lct -blifopt gigacart.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" gigacart.bl2 -sweep -mergefb -err automake.err -o gigacart.bl3 @gigacart.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci gigacart.lct -dev lc4k -diofft gigacart.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" gigacart.bl3 -family AMDMACH -idev van -o gigacart.bl4 -oxrf gigacart.xrf -err automake.err @gigacart.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci gigacart.lct -dev lc4k -prefit gigacart.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp gigacart.bl4 -out gigacart.bl5 -err automake.err -log gigacart.log -mod gigacart @gigacart.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open gigacart.rs1 w} rspFile] {
	puts stderr "Cannot create response file gigacart.rs1: $rspFile"
} else {
	puts $rspFile "-i gigacart.bl5 -lci gigacart.lct -d m4s_64_64 -lco gigacart.lco -html_rpt -fti gigacart.fti -fmt PLA -tto gigacart.tt4 -nojed -eqn gigacart.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open gigacart.rs2 w} rspFile] {
	puts stderr "Cannot create response file gigacart.rs2: $rspFile"
} else {
	puts $rspFile "-i gigacart.bl5 -lci gigacart.lct -d m4s_64_64 -lco gigacart.lco -html_rpt -fti gigacart.fti -fmt PLA -tto gigacart.tt4 -eqn gigacart.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@gigacart.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete gigacart.rs1
file delete gigacart.rs2
if [runCmd "\"$cpld_bin/tda\" -i gigacart.bl5 -o gigacart.tda -lci gigacart.lct -dev m4s_64_64 -family lc4k -mod gigacart -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj gigacart -if gigacart.jed -j2s -log gigacart.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 07/02/18 21:43:37 ###########


########## Tcl recorder starts at 07/02/18 21:44:58 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vhd2jhd\" design.vhd -o design.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 07/02/18 21:44:58 ###########


########## Tcl recorder starts at 07/02/18 21:45:03 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open gigacart.cmd w} rspFile] {
	puts stderr "Cannot create response file gigacart.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: gigacart.sty
PROJECT: gigacart
WORKING_PATH: \"$proj_dir\"
MODULE: gigacart
VHDL_FILE_LIST: design.vhd
OUTPUT_FILE_NAME: gigacart
SUFFIX_NAME: edi
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DEFAULT_ENUM_ENCODING: default
ARRANGE_VHDL_FILES: true
synthesis_onoff_pragma: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -e gigacart -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete gigacart.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf gigacart.edi -out gigacart.bl0 -err automake.err -log gigacart.log -prj gigacart -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" gigacart.bl0 -collapse none -reduce none -keepwires  -err automake.err -family"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"gigacart.bl1\" -o \"gigacart.bl2\" -omod \"gigacart\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj gigacart -lci gigacart.lct -log gigacart.imp -err automake.err -tti gigacart.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci gigacart.lct -blifopt gigacart.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" gigacart.bl2 -sweep -mergefb -err automake.err -o gigacart.bl3 @gigacart.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci gigacart.lct -dev lc4k -diofft gigacart.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" gigacart.bl3 -family AMDMACH -idev van -o gigacart.bl4 -oxrf gigacart.xrf -err automake.err @gigacart.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci gigacart.lct -dev lc4k -prefit gigacart.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp gigacart.bl4 -out gigacart.bl5 -err automake.err -log gigacart.log -mod gigacart @gigacart.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open gigacart.rs1 w} rspFile] {
	puts stderr "Cannot create response file gigacart.rs1: $rspFile"
} else {
	puts $rspFile "-i gigacart.bl5 -lci gigacart.lct -d m4s_64_64 -lco gigacart.lco -html_rpt -fti gigacart.fti -fmt PLA -tto gigacart.tt4 -nojed -eqn gigacart.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open gigacart.rs2 w} rspFile] {
	puts stderr "Cannot create response file gigacart.rs2: $rspFile"
} else {
	puts $rspFile "-i gigacart.bl5 -lci gigacart.lct -d m4s_64_64 -lco gigacart.lco -html_rpt -fti gigacart.fti -fmt PLA -tto gigacart.tt4 -eqn gigacart.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@gigacart.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete gigacart.rs1
file delete gigacart.rs2
if [runCmd "\"$cpld_bin/tda\" -i gigacart.bl5 -o gigacart.tda -lci gigacart.lct -dev m4s_64_64 -family lc4k -mod gigacart -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj gigacart -if gigacart.jed -j2s -log gigacart.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 07/02/18 21:45:03 ###########


########## Tcl recorder starts at 07/02/18 21:45:41 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vhd2jhd\" design.vhd -o design.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 07/02/18 21:45:41 ###########


########## Tcl recorder starts at 07/02/18 21:45:44 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open gigacart.cmd w} rspFile] {
	puts stderr "Cannot create response file gigacart.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: gigacart.sty
PROJECT: gigacart
WORKING_PATH: \"$proj_dir\"
MODULE: gigacart
VHDL_FILE_LIST: design.vhd
OUTPUT_FILE_NAME: gigacart
SUFFIX_NAME: edi
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DEFAULT_ENUM_ENCODING: default
ARRANGE_VHDL_FILES: true
synthesis_onoff_pragma: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -e gigacart -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete gigacart.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf gigacart.edi -out gigacart.bl0 -err automake.err -log gigacart.log -prj gigacart -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" gigacart.bl0 -collapse none -reduce none -keepwires  -err automake.err -family"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"gigacart.bl1\" -o \"gigacart.bl2\" -omod \"gigacart\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj gigacart -lci gigacart.lct -log gigacart.imp -err automake.err -tti gigacart.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci gigacart.lct -blifopt gigacart.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" gigacart.bl2 -sweep -mergefb -err automake.err -o gigacart.bl3 @gigacart.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci gigacart.lct -dev lc4k -diofft gigacart.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" gigacart.bl3 -family AMDMACH -idev van -o gigacart.bl4 -oxrf gigacart.xrf -err automake.err @gigacart.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci gigacart.lct -dev lc4k -prefit gigacart.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp gigacart.bl4 -out gigacart.bl5 -err automake.err -log gigacart.log -mod gigacart @gigacart.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open gigacart.rs1 w} rspFile] {
	puts stderr "Cannot create response file gigacart.rs1: $rspFile"
} else {
	puts $rspFile "-i gigacart.bl5 -lci gigacart.lct -d m4s_64_64 -lco gigacart.lco -html_rpt -fti gigacart.fti -fmt PLA -tto gigacart.tt4 -nojed -eqn gigacart.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open gigacart.rs2 w} rspFile] {
	puts stderr "Cannot create response file gigacart.rs2: $rspFile"
} else {
	puts $rspFile "-i gigacart.bl5 -lci gigacart.lct -d m4s_64_64 -lco gigacart.lco -html_rpt -fti gigacart.fti -fmt PLA -tto gigacart.tt4 -eqn gigacart.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@gigacart.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete gigacart.rs1
file delete gigacart.rs2
if [runCmd "\"$cpld_bin/tda\" -i gigacart.bl5 -o gigacart.tda -lci gigacart.lct -dev m4s_64_64 -family lc4k -mod gigacart -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj gigacart -if gigacart.jed -j2s -log gigacart.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 07/02/18 21:45:44 ###########


########## Tcl recorder starts at 07/02/18 21:54:14 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vhd2jhd\" design.vhd -o design.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 07/02/18 21:54:14 ###########


########## Tcl recorder starts at 07/02/18 21:54:17 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open gigacart.cmd w} rspFile] {
	puts stderr "Cannot create response file gigacart.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: gigacart.sty
PROJECT: gigacart
WORKING_PATH: \"$proj_dir\"
MODULE: gigacart
VHDL_FILE_LIST: design.vhd
OUTPUT_FILE_NAME: gigacart
SUFFIX_NAME: edi
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DEFAULT_ENUM_ENCODING: default
ARRANGE_VHDL_FILES: true
synthesis_onoff_pragma: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -e gigacart -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete gigacart.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf gigacart.edi -out gigacart.bl0 -err automake.err -log gigacart.log -prj gigacart -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" gigacart.bl0 -collapse none -reduce none -keepwires  -err automake.err -family"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"gigacart.bl1\" -o \"gigacart.bl2\" -omod \"gigacart\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj gigacart -lci gigacart.lct -log gigacart.imp -err automake.err -tti gigacart.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci gigacart.lct -blifopt gigacart.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" gigacart.bl2 -sweep -mergefb -err automake.err -o gigacart.bl3 @gigacart.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci gigacart.lct -dev lc4k -diofft gigacart.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" gigacart.bl3 -family AMDMACH -idev van -o gigacart.bl4 -oxrf gigacart.xrf -err automake.err @gigacart.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci gigacart.lct -dev lc4k -prefit gigacart.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp gigacart.bl4 -out gigacart.bl5 -err automake.err -log gigacart.log -mod gigacart @gigacart.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open gigacart.rs1 w} rspFile] {
	puts stderr "Cannot create response file gigacart.rs1: $rspFile"
} else {
	puts $rspFile "-i gigacart.bl5 -lci gigacart.lct -d m4s_64_64 -lco gigacart.lco -html_rpt -fti gigacart.fti -fmt PLA -tto gigacart.tt4 -nojed -eqn gigacart.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open gigacart.rs2 w} rspFile] {
	puts stderr "Cannot create response file gigacart.rs2: $rspFile"
} else {
	puts $rspFile "-i gigacart.bl5 -lci gigacart.lct -d m4s_64_64 -lco gigacart.lco -html_rpt -fti gigacart.fti -fmt PLA -tto gigacart.tt4 -eqn gigacart.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@gigacart.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete gigacart.rs1
file delete gigacart.rs2
if [runCmd "\"$cpld_bin/tda\" -i gigacart.bl5 -o gigacart.tda -lci gigacart.lct -dev m4s_64_64 -family lc4k -mod gigacart -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj gigacart -if gigacart.jed -j2s -log gigacart.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 07/02/18 21:54:17 ###########


########## Tcl recorder starts at 07/02/18 21:56:38 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vhd2jhd\" design.vhd -o design.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 07/02/18 21:56:38 ###########


########## Tcl recorder starts at 07/02/18 21:57:18 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open gigacart.rs1 w} rspFile] {
	puts stderr "Cannot create response file gigacart.rs1: $rspFile"
} else {
	puts $rspFile "-i gigacart.bl5 -lci gigacart.lct -d m4s_64_64 -lco gigacart.lco -html_rpt -fti gigacart.fti -fmt PLA -tto gigacart.tt4 -nojed -eqn gigacart.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open gigacart.rs2 w} rspFile] {
	puts stderr "Cannot create response file gigacart.rs2: $rspFile"
} else {
	puts $rspFile "-i gigacart.bl5 -lci gigacart.lct -d m4s_64_64 -lco gigacart.lco -html_rpt -fti gigacart.fti -fmt PLA -tto gigacart.tt4 -eqn gigacart.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@gigacart.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete gigacart.rs1
file delete gigacart.rs2
if [runCmd "\"$cpld_bin/tda\" -i gigacart.bl5 -o gigacart.tda -lci gigacart.lct -dev m4s_64_64 -family lc4k -mod gigacart -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj gigacart -if gigacart.jed -j2s -log gigacart.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 07/02/18 21:57:18 ###########


########## Tcl recorder starts at 07/02/18 21:57:30 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vhd2jhd\" design.vhd -o design.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 07/02/18 21:57:30 ###########


########## Tcl recorder starts at 07/02/18 21:57:37 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open gigacart.cmd w} rspFile] {
	puts stderr "Cannot create response file gigacart.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: gigacart.sty
PROJECT: gigacart
WORKING_PATH: \"$proj_dir\"
MODULE: gigacart
VHDL_FILE_LIST: design.vhd
OUTPUT_FILE_NAME: gigacart
SUFFIX_NAME: edi
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DEFAULT_ENUM_ENCODING: default
ARRANGE_VHDL_FILES: true
synthesis_onoff_pragma: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -e gigacart -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete gigacart.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf gigacart.edi -out gigacart.bl0 -err automake.err -log gigacart.log -prj gigacart -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" gigacart.bl0 -collapse none -reduce none -keepwires  -err automake.err -family"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"gigacart.bl1\" -o \"gigacart.bl2\" -omod \"gigacart\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj gigacart -lci gigacart.lct -log gigacart.imp -err automake.err -tti gigacart.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci gigacart.lct -blifopt gigacart.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" gigacart.bl2 -sweep -mergefb -err automake.err -o gigacart.bl3 @gigacart.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci gigacart.lct -dev lc4k -diofft gigacart.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" gigacart.bl3 -family AMDMACH -idev van -o gigacart.bl4 -oxrf gigacart.xrf -err automake.err @gigacart.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci gigacart.lct -dev lc4k -prefit gigacart.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp gigacart.bl4 -out gigacart.bl5 -err automake.err -log gigacart.log -mod gigacart @gigacart.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open gigacart.rs1 w} rspFile] {
	puts stderr "Cannot create response file gigacart.rs1: $rspFile"
} else {
	puts $rspFile "-i gigacart.bl5 -lci gigacart.lct -d m4s_64_64 -lco gigacart.lco -html_rpt -fti gigacart.fti -fmt PLA -tto gigacart.tt4 -nojed -eqn gigacart.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open gigacart.rs2 w} rspFile] {
	puts stderr "Cannot create response file gigacart.rs2: $rspFile"
} else {
	puts $rspFile "-i gigacart.bl5 -lci gigacart.lct -d m4s_64_64 -lco gigacart.lco -html_rpt -fti gigacart.fti -fmt PLA -tto gigacart.tt4 -eqn gigacart.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@gigacart.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete gigacart.rs1
file delete gigacart.rs2
if [runCmd "\"$cpld_bin/tda\" -i gigacart.bl5 -o gigacart.tda -lci gigacart.lct -dev m4s_64_64 -family lc4k -mod gigacart -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj gigacart -if gigacart.jed -j2s -log gigacart.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 07/02/18 21:57:37 ###########


########## Tcl recorder starts at 07/03/18 21:19:15 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vhd2jhd\" design.vhd -o design.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 07/03/18 21:19:15 ###########


########## Tcl recorder starts at 07/03/18 21:19:27 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vhd2jhd\" design.vhd -o design.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 07/03/18 21:19:27 ###########


########## Tcl recorder starts at 07/03/18 21:19:32 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open gigacart.cmd w} rspFile] {
	puts stderr "Cannot create response file gigacart.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: gigacart.sty
PROJECT: gigacart
WORKING_PATH: \"$proj_dir\"
MODULE: gigacart
VHDL_FILE_LIST: design.vhd
OUTPUT_FILE_NAME: gigacart
SUFFIX_NAME: edi
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DEFAULT_ENUM_ENCODING: default
ARRANGE_VHDL_FILES: true
synthesis_onoff_pragma: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -e gigacart -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete gigacart.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf gigacart.edi -out gigacart.bl0 -err automake.err -log gigacart.log -prj gigacart -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" gigacart.bl0 -collapse none -reduce none -keepwires  -err automake.err -family"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"gigacart.bl1\" -o \"gigacart.bl2\" -omod \"gigacart\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj gigacart -lci gigacart.lct -log gigacart.imp -err automake.err -tti gigacart.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci gigacart.lct -blifopt gigacart.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" gigacart.bl2 -sweep -mergefb -err automake.err -o gigacart.bl3 @gigacart.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci gigacart.lct -dev lc4k -diofft gigacart.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" gigacart.bl3 -family AMDMACH -idev van -o gigacart.bl4 -oxrf gigacart.xrf -err automake.err @gigacart.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci gigacart.lct -dev lc4k -prefit gigacart.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp gigacart.bl4 -out gigacart.bl5 -err automake.err -log gigacart.log -mod gigacart @gigacart.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open gigacart.rs1 w} rspFile] {
	puts stderr "Cannot create response file gigacart.rs1: $rspFile"
} else {
	puts $rspFile "-i gigacart.bl5 -lci gigacart.lct -d m4s_64_64 -lco gigacart.lco -html_rpt -fti gigacart.fti -fmt PLA -tto gigacart.tt4 -nojed -eqn gigacart.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open gigacart.rs2 w} rspFile] {
	puts stderr "Cannot create response file gigacart.rs2: $rspFile"
} else {
	puts $rspFile "-i gigacart.bl5 -lci gigacart.lct -d m4s_64_64 -lco gigacart.lco -html_rpt -fti gigacart.fti -fmt PLA -tto gigacart.tt4 -eqn gigacart.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@gigacart.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete gigacart.rs1
file delete gigacart.rs2
if [runCmd "\"$cpld_bin/tda\" -i gigacart.bl5 -o gigacart.tda -lci gigacart.lct -dev m4s_64_64 -family lc4k -mod gigacart -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj gigacart -if gigacart.jed -j2s -log gigacart.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 07/03/18 21:19:32 ###########


########## Tcl recorder starts at 07/03/18 21:20:31 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vhd2jhd\" design.vhd -o design.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 07/03/18 21:20:31 ###########


########## Tcl recorder starts at 07/03/18 21:20:34 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open gigacart.cmd w} rspFile] {
	puts stderr "Cannot create response file gigacart.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: gigacart.sty
PROJECT: gigacart
WORKING_PATH: \"$proj_dir\"
MODULE: gigacart
VHDL_FILE_LIST: design.vhd
OUTPUT_FILE_NAME: gigacart
SUFFIX_NAME: edi
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DEFAULT_ENUM_ENCODING: default
ARRANGE_VHDL_FILES: true
synthesis_onoff_pragma: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -e gigacart -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete gigacart.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf gigacart.edi -out gigacart.bl0 -err automake.err -log gigacart.log -prj gigacart -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" gigacart.bl0 -collapse none -reduce none -keepwires  -err automake.err -family"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"gigacart.bl1\" -o \"gigacart.bl2\" -omod \"gigacart\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj gigacart -lci gigacart.lct -log gigacart.imp -err automake.err -tti gigacart.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci gigacart.lct -blifopt gigacart.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" gigacart.bl2 -sweep -mergefb -err automake.err -o gigacart.bl3 @gigacart.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci gigacart.lct -dev lc4k -diofft gigacart.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" gigacart.bl3 -family AMDMACH -idev van -o gigacart.bl4 -oxrf gigacart.xrf -err automake.err @gigacart.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci gigacart.lct -dev lc4k -prefit gigacart.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp gigacart.bl4 -out gigacart.bl5 -err automake.err -log gigacart.log -mod gigacart @gigacart.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open gigacart.rs1 w} rspFile] {
	puts stderr "Cannot create response file gigacart.rs1: $rspFile"
} else {
	puts $rspFile "-i gigacart.bl5 -lci gigacart.lct -d m4s_64_64 -lco gigacart.lco -html_rpt -fti gigacart.fti -fmt PLA -tto gigacart.tt4 -nojed -eqn gigacart.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open gigacart.rs2 w} rspFile] {
	puts stderr "Cannot create response file gigacart.rs2: $rspFile"
} else {
	puts $rspFile "-i gigacart.bl5 -lci gigacart.lct -d m4s_64_64 -lco gigacart.lco -html_rpt -fti gigacart.fti -fmt PLA -tto gigacart.tt4 -eqn gigacart.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@gigacart.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete gigacart.rs1
file delete gigacart.rs2
if [runCmd "\"$cpld_bin/tda\" -i gigacart.bl5 -o gigacart.tda -lci gigacart.lct -dev m4s_64_64 -family lc4k -mod gigacart -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj gigacart -if gigacart.jed -j2s -log gigacart.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 07/03/18 21:20:34 ###########


########## Tcl recorder starts at 07/03/18 21:21:11 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vhd2jhd\" design.vhd -o design.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 07/03/18 21:21:11 ###########


########## Tcl recorder starts at 07/03/18 21:21:14 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open gigacart.cmd w} rspFile] {
	puts stderr "Cannot create response file gigacart.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: gigacart.sty
PROJECT: gigacart
WORKING_PATH: \"$proj_dir\"
MODULE: gigacart
VHDL_FILE_LIST: design.vhd
OUTPUT_FILE_NAME: gigacart
SUFFIX_NAME: edi
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DEFAULT_ENUM_ENCODING: default
ARRANGE_VHDL_FILES: true
synthesis_onoff_pragma: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -e gigacart -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete gigacart.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf gigacart.edi -out gigacart.bl0 -err automake.err -log gigacart.log -prj gigacart -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" gigacart.bl0 -collapse none -reduce none -keepwires  -err automake.err -family"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"gigacart.bl1\" -o \"gigacart.bl2\" -omod \"gigacart\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj gigacart -lci gigacart.lct -log gigacart.imp -err automake.err -tti gigacart.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci gigacart.lct -blifopt gigacart.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" gigacart.bl2 -sweep -mergefb -err automake.err -o gigacart.bl3 @gigacart.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci gigacart.lct -dev lc4k -diofft gigacart.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" gigacart.bl3 -family AMDMACH -idev van -o gigacart.bl4 -oxrf gigacart.xrf -err automake.err @gigacart.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci gigacart.lct -dev lc4k -prefit gigacart.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp gigacart.bl4 -out gigacart.bl5 -err automake.err -log gigacart.log -mod gigacart @gigacart.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open gigacart.rs1 w} rspFile] {
	puts stderr "Cannot create response file gigacart.rs1: $rspFile"
} else {
	puts $rspFile "-i gigacart.bl5 -lci gigacart.lct -d m4s_64_64 -lco gigacart.lco -html_rpt -fti gigacart.fti -fmt PLA -tto gigacart.tt4 -nojed -eqn gigacart.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open gigacart.rs2 w} rspFile] {
	puts stderr "Cannot create response file gigacart.rs2: $rspFile"
} else {
	puts $rspFile "-i gigacart.bl5 -lci gigacart.lct -d m4s_64_64 -lco gigacart.lco -html_rpt -fti gigacart.fti -fmt PLA -tto gigacart.tt4 -eqn gigacart.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@gigacart.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete gigacart.rs1
file delete gigacart.rs2
if [runCmd "\"$cpld_bin/tda\" -i gigacart.bl5 -o gigacart.tda -lci gigacart.lct -dev m4s_64_64 -family lc4k -mod gigacart -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj gigacart -if gigacart.jed -j2s -log gigacart.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 07/03/18 21:21:14 ###########


########## Tcl recorder starts at 07/03/18 21:25:42 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vhd2jhd\" design.vhd -o design.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 07/03/18 21:25:42 ###########


########## Tcl recorder starts at 07/03/18 21:25:45 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open gigacart.cmd w} rspFile] {
	puts stderr "Cannot create response file gigacart.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: gigacart.sty
PROJECT: gigacart
WORKING_PATH: \"$proj_dir\"
MODULE: gigacart
VHDL_FILE_LIST: design.vhd
OUTPUT_FILE_NAME: gigacart
SUFFIX_NAME: edi
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DEFAULT_ENUM_ENCODING: default
ARRANGE_VHDL_FILES: true
synthesis_onoff_pragma: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -e gigacart -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete gigacart.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf gigacart.edi -out gigacart.bl0 -err automake.err -log gigacart.log -prj gigacart -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" gigacart.bl0 -collapse none -reduce none -keepwires  -err automake.err -family"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"gigacart.bl1\" -o \"gigacart.bl2\" -omod \"gigacart\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj gigacart -lci gigacart.lct -log gigacart.imp -err automake.err -tti gigacart.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci gigacart.lct -blifopt gigacart.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" gigacart.bl2 -sweep -mergefb -err automake.err -o gigacart.bl3 @gigacart.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci gigacart.lct -dev lc4k -diofft gigacart.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" gigacart.bl3 -family AMDMACH -idev van -o gigacart.bl4 -oxrf gigacart.xrf -err automake.err @gigacart.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci gigacart.lct -dev lc4k -prefit gigacart.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp gigacart.bl4 -out gigacart.bl5 -err automake.err -log gigacart.log -mod gigacart @gigacart.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open gigacart.rs1 w} rspFile] {
	puts stderr "Cannot create response file gigacart.rs1: $rspFile"
} else {
	puts $rspFile "-i gigacart.bl5 -lci gigacart.lct -d m4s_64_64 -lco gigacart.lco -html_rpt -fti gigacart.fti -fmt PLA -tto gigacart.tt4 -nojed -eqn gigacart.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open gigacart.rs2 w} rspFile] {
	puts stderr "Cannot create response file gigacart.rs2: $rspFile"
} else {
	puts $rspFile "-i gigacart.bl5 -lci gigacart.lct -d m4s_64_64 -lco gigacart.lco -html_rpt -fti gigacart.fti -fmt PLA -tto gigacart.tt4 -eqn gigacart.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@gigacart.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete gigacart.rs1
file delete gigacart.rs2
if [runCmd "\"$cpld_bin/tda\" -i gigacart.bl5 -o gigacart.tda -lci gigacart.lct -dev m4s_64_64 -family lc4k -mod gigacart -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj gigacart -if gigacart.jed -j2s -log gigacart.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 07/03/18 21:25:45 ###########


########## Tcl recorder starts at 07/03/18 21:28:11 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vhd2jhd\" design.vhd -o design.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 07/03/18 21:28:11 ###########


########## Tcl recorder starts at 07/03/18 21:28:14 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open gigacart.cmd w} rspFile] {
	puts stderr "Cannot create response file gigacart.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: gigacart.sty
PROJECT: gigacart
WORKING_PATH: \"$proj_dir\"
MODULE: gigacart
VHDL_FILE_LIST: design.vhd
OUTPUT_FILE_NAME: gigacart
SUFFIX_NAME: edi
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DEFAULT_ENUM_ENCODING: default
ARRANGE_VHDL_FILES: true
synthesis_onoff_pragma: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -e gigacart -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete gigacart.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf gigacart.edi -out gigacart.bl0 -err automake.err -log gigacart.log -prj gigacart -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" gigacart.bl0 -collapse none -reduce none -keepwires  -err automake.err -family"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"gigacart.bl1\" -o \"gigacart.bl2\" -omod \"gigacart\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj gigacart -lci gigacart.lct -log gigacart.imp -err automake.err -tti gigacart.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci gigacart.lct -blifopt gigacart.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" gigacart.bl2 -sweep -mergefb -err automake.err -o gigacart.bl3 @gigacart.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci gigacart.lct -dev lc4k -diofft gigacart.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" gigacart.bl3 -family AMDMACH -idev van -o gigacart.bl4 -oxrf gigacart.xrf -err automake.err @gigacart.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci gigacart.lct -dev lc4k -prefit gigacart.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp gigacart.bl4 -out gigacart.bl5 -err automake.err -log gigacart.log -mod gigacart @gigacart.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open gigacart.rs1 w} rspFile] {
	puts stderr "Cannot create response file gigacart.rs1: $rspFile"
} else {
	puts $rspFile "-i gigacart.bl5 -lci gigacart.lct -d m4s_64_64 -lco gigacart.lco -html_rpt -fti gigacart.fti -fmt PLA -tto gigacart.tt4 -nojed -eqn gigacart.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open gigacart.rs2 w} rspFile] {
	puts stderr "Cannot create response file gigacart.rs2: $rspFile"
} else {
	puts $rspFile "-i gigacart.bl5 -lci gigacart.lct -d m4s_64_64 -lco gigacart.lco -html_rpt -fti gigacart.fti -fmt PLA -tto gigacart.tt4 -eqn gigacart.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@gigacart.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete gigacart.rs1
file delete gigacart.rs2
if [runCmd "\"$cpld_bin/tda\" -i gigacart.bl5 -o gigacart.tda -lci gigacart.lct -dev m4s_64_64 -family lc4k -mod gigacart -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj gigacart -if gigacart.jed -j2s -log gigacart.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 07/03/18 21:28:14 ###########


########## Tcl recorder starts at 07/03/18 21:28:37 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vhd2jhd\" design.vhd -o design.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 07/03/18 21:28:37 ###########


########## Tcl recorder starts at 07/03/18 21:28:40 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open gigacart.cmd w} rspFile] {
	puts stderr "Cannot create response file gigacart.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: gigacart.sty
PROJECT: gigacart
WORKING_PATH: \"$proj_dir\"
MODULE: gigacart
VHDL_FILE_LIST: design.vhd
OUTPUT_FILE_NAME: gigacart
SUFFIX_NAME: edi
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DEFAULT_ENUM_ENCODING: default
ARRANGE_VHDL_FILES: true
synthesis_onoff_pragma: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -e gigacart -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete gigacart.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf gigacart.edi -out gigacart.bl0 -err automake.err -log gigacart.log -prj gigacart -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" gigacart.bl0 -collapse none -reduce none -keepwires  -err automake.err -family"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"gigacart.bl1\" -o \"gigacart.bl2\" -omod \"gigacart\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj gigacart -lci gigacart.lct -log gigacart.imp -err automake.err -tti gigacart.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci gigacart.lct -blifopt gigacart.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" gigacart.bl2 -sweep -mergefb -err automake.err -o gigacart.bl3 @gigacart.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci gigacart.lct -dev lc4k -diofft gigacart.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" gigacart.bl3 -family AMDMACH -idev van -o gigacart.bl4 -oxrf gigacart.xrf -err automake.err @gigacart.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci gigacart.lct -dev lc4k -prefit gigacart.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp gigacart.bl4 -out gigacart.bl5 -err automake.err -log gigacart.log -mod gigacart @gigacart.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open gigacart.rs1 w} rspFile] {
	puts stderr "Cannot create response file gigacart.rs1: $rspFile"
} else {
	puts $rspFile "-i gigacart.bl5 -lci gigacart.lct -d m4s_64_64 -lco gigacart.lco -html_rpt -fti gigacart.fti -fmt PLA -tto gigacart.tt4 -nojed -eqn gigacart.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open gigacart.rs2 w} rspFile] {
	puts stderr "Cannot create response file gigacart.rs2: $rspFile"
} else {
	puts $rspFile "-i gigacart.bl5 -lci gigacart.lct -d m4s_64_64 -lco gigacart.lco -html_rpt -fti gigacart.fti -fmt PLA -tto gigacart.tt4 -eqn gigacart.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@gigacart.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete gigacart.rs1
file delete gigacart.rs2
if [runCmd "\"$cpld_bin/tda\" -i gigacart.bl5 -o gigacart.tda -lci gigacart.lct -dev m4s_64_64 -family lc4k -mod gigacart -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj gigacart -if gigacart.jed -j2s -log gigacart.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 07/03/18 21:28:40 ###########


########## Tcl recorder starts at 07/03/18 21:30:43 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vhd2jhd\" design.vhd -o design.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 07/03/18 21:30:43 ###########


########## Tcl recorder starts at 07/03/18 21:30:47 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open gigacart.cmd w} rspFile] {
	puts stderr "Cannot create response file gigacart.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: gigacart.sty
PROJECT: gigacart
WORKING_PATH: \"$proj_dir\"
MODULE: gigacart
VHDL_FILE_LIST: design.vhd
OUTPUT_FILE_NAME: gigacart
SUFFIX_NAME: edi
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DEFAULT_ENUM_ENCODING: default
ARRANGE_VHDL_FILES: true
synthesis_onoff_pragma: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -e gigacart -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete gigacart.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf gigacart.edi -out gigacart.bl0 -err automake.err -log gigacart.log -prj gigacart -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" gigacart.bl0 -collapse none -reduce none -keepwires  -err automake.err -family"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"gigacart.bl1\" -o \"gigacart.bl2\" -omod \"gigacart\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj gigacart -lci gigacart.lct -log gigacart.imp -err automake.err -tti gigacart.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci gigacart.lct -blifopt gigacart.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" gigacart.bl2 -sweep -mergefb -err automake.err -o gigacart.bl3 @gigacart.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci gigacart.lct -dev lc4k -diofft gigacart.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" gigacart.bl3 -family AMDMACH -idev van -o gigacart.bl4 -oxrf gigacart.xrf -err automake.err @gigacart.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci gigacart.lct -dev lc4k -prefit gigacart.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp gigacart.bl4 -out gigacart.bl5 -err automake.err -log gigacart.log -mod gigacart @gigacart.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open gigacart.rs1 w} rspFile] {
	puts stderr "Cannot create response file gigacart.rs1: $rspFile"
} else {
	puts $rspFile "-i gigacart.bl5 -lci gigacart.lct -d m4s_64_64 -lco gigacart.lco -html_rpt -fti gigacart.fti -fmt PLA -tto gigacart.tt4 -nojed -eqn gigacart.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open gigacart.rs2 w} rspFile] {
	puts stderr "Cannot create response file gigacart.rs2: $rspFile"
} else {
	puts $rspFile "-i gigacart.bl5 -lci gigacart.lct -d m4s_64_64 -lco gigacart.lco -html_rpt -fti gigacart.fti -fmt PLA -tto gigacart.tt4 -eqn gigacart.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@gigacart.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete gigacart.rs1
file delete gigacart.rs2
if [runCmd "\"$cpld_bin/tda\" -i gigacart.bl5 -o gigacart.tda -lci gigacart.lct -dev m4s_64_64 -family lc4k -mod gigacart -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj gigacart -if gigacart.jed -j2s -log gigacart.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 07/03/18 21:30:47 ###########


########## Tcl recorder starts at 07/03/18 21:45:10 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vhd2jhd\" design.vhd -o design.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 07/03/18 21:45:10 ###########


########## Tcl recorder starts at 07/03/18 21:45:14 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open gigacart.cmd w} rspFile] {
	puts stderr "Cannot create response file gigacart.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: gigacart.sty
PROJECT: gigacart
WORKING_PATH: \"$proj_dir\"
MODULE: gigacart
VHDL_FILE_LIST: design.vhd
OUTPUT_FILE_NAME: gigacart
SUFFIX_NAME: edi
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DEFAULT_ENUM_ENCODING: default
ARRANGE_VHDL_FILES: true
synthesis_onoff_pragma: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -e gigacart -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete gigacart.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf gigacart.edi -out gigacart.bl0 -err automake.err -log gigacart.log -prj gigacart -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" gigacart.bl0 -collapse none -reduce none -keepwires  -err automake.err -family"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"gigacart.bl1\" -o \"gigacart.bl2\" -omod \"gigacart\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj gigacart -lci gigacart.lct -log gigacart.imp -err automake.err -tti gigacart.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci gigacart.lct -blifopt gigacart.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" gigacart.bl2 -sweep -mergefb -err automake.err -o gigacart.bl3 @gigacart.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci gigacart.lct -dev lc4k -diofft gigacart.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" gigacart.bl3 -family AMDMACH -idev van -o gigacart.bl4 -oxrf gigacart.xrf -err automake.err @gigacart.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci gigacart.lct -dev lc4k -prefit gigacart.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp gigacart.bl4 -out gigacart.bl5 -err automake.err -log gigacart.log -mod gigacart @gigacart.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open gigacart.rs1 w} rspFile] {
	puts stderr "Cannot create response file gigacart.rs1: $rspFile"
} else {
	puts $rspFile "-i gigacart.bl5 -lci gigacart.lct -d m4s_64_64 -lco gigacart.lco -html_rpt -fti gigacart.fti -fmt PLA -tto gigacart.tt4 -nojed -eqn gigacart.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open gigacart.rs2 w} rspFile] {
	puts stderr "Cannot create response file gigacart.rs2: $rspFile"
} else {
	puts $rspFile "-i gigacart.bl5 -lci gigacart.lct -d m4s_64_64 -lco gigacart.lco -html_rpt -fti gigacart.fti -fmt PLA -tto gigacart.tt4 -eqn gigacart.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@gigacart.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete gigacart.rs1
file delete gigacart.rs2
if [runCmd "\"$cpld_bin/tda\" -i gigacart.bl5 -o gigacart.tda -lci gigacart.lct -dev m4s_64_64 -family lc4k -mod gigacart -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj gigacart -if gigacart.jed -j2s -log gigacart.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 07/03/18 21:45:15 ###########


########## Tcl recorder starts at 07/03/18 21:46:18 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vhd2jhd\" design.vhd -o design.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 07/03/18 21:46:18 ###########


########## Tcl recorder starts at 07/03/18 21:46:23 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open gigacart.cmd w} rspFile] {
	puts stderr "Cannot create response file gigacart.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: gigacart.sty
PROJECT: gigacart
WORKING_PATH: \"$proj_dir\"
MODULE: gigacart
VHDL_FILE_LIST: design.vhd
OUTPUT_FILE_NAME: gigacart
SUFFIX_NAME: edi
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DEFAULT_ENUM_ENCODING: default
ARRANGE_VHDL_FILES: true
synthesis_onoff_pragma: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -e gigacart -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete gigacart.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf gigacart.edi -out gigacart.bl0 -err automake.err -log gigacart.log -prj gigacart -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" gigacart.bl0 -collapse none -reduce none -keepwires  -err automake.err -family"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"gigacart.bl1\" -o \"gigacart.bl2\" -omod \"gigacart\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj gigacart -lci gigacart.lct -log gigacart.imp -err automake.err -tti gigacart.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci gigacart.lct -blifopt gigacart.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" gigacart.bl2 -sweep -mergefb -err automake.err -o gigacart.bl3 @gigacart.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci gigacart.lct -dev lc4k -diofft gigacart.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" gigacart.bl3 -family AMDMACH -idev van -o gigacart.bl4 -oxrf gigacart.xrf -err automake.err @gigacart.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci gigacart.lct -dev lc4k -prefit gigacart.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp gigacart.bl4 -out gigacart.bl5 -err automake.err -log gigacart.log -mod gigacart @gigacart.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open gigacart.rs1 w} rspFile] {
	puts stderr "Cannot create response file gigacart.rs1: $rspFile"
} else {
	puts $rspFile "-i gigacart.bl5 -lci gigacart.lct -d m4s_64_64 -lco gigacart.lco -html_rpt -fti gigacart.fti -fmt PLA -tto gigacart.tt4 -nojed -eqn gigacart.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open gigacart.rs2 w} rspFile] {
	puts stderr "Cannot create response file gigacart.rs2: $rspFile"
} else {
	puts $rspFile "-i gigacart.bl5 -lci gigacart.lct -d m4s_64_64 -lco gigacart.lco -html_rpt -fti gigacart.fti -fmt PLA -tto gigacart.tt4 -eqn gigacart.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@gigacart.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete gigacart.rs1
file delete gigacart.rs2
if [runCmd "\"$cpld_bin/tda\" -i gigacart.bl5 -o gigacart.tda -lci gigacart.lct -dev m4s_64_64 -family lc4k -mod gigacart -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj gigacart -if gigacart.jed -j2s -log gigacart.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 07/03/18 21:46:23 ###########


########## Tcl recorder starts at 07/03/18 21:48:48 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vhd2jhd\" design.vhd -o design.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 07/03/18 21:48:48 ###########


########## Tcl recorder starts at 07/03/18 21:48:54 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open gigacart.cmd w} rspFile] {
	puts stderr "Cannot create response file gigacart.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: gigacart.sty
PROJECT: gigacart
WORKING_PATH: \"$proj_dir\"
MODULE: gigacart
VHDL_FILE_LIST: design.vhd
OUTPUT_FILE_NAME: gigacart
SUFFIX_NAME: edi
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DEFAULT_ENUM_ENCODING: default
ARRANGE_VHDL_FILES: true
synthesis_onoff_pragma: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -e gigacart -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete gigacart.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf gigacart.edi -out gigacart.bl0 -err automake.err -log gigacart.log -prj gigacart -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" gigacart.bl0 -collapse none -reduce none -keepwires  -err automake.err -family"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"gigacart.bl1\" -o \"gigacart.bl2\" -omod \"gigacart\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj gigacart -lci gigacart.lct -log gigacart.imp -err automake.err -tti gigacart.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci gigacart.lct -blifopt gigacart.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" gigacart.bl2 -sweep -mergefb -err automake.err -o gigacart.bl3 @gigacart.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci gigacart.lct -dev lc4k -diofft gigacart.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" gigacart.bl3 -family AMDMACH -idev van -o gigacart.bl4 -oxrf gigacart.xrf -err automake.err @gigacart.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci gigacart.lct -dev lc4k -prefit gigacart.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp gigacart.bl4 -out gigacart.bl5 -err automake.err -log gigacart.log -mod gigacart @gigacart.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open gigacart.rs1 w} rspFile] {
	puts stderr "Cannot create response file gigacart.rs1: $rspFile"
} else {
	puts $rspFile "-i gigacart.bl5 -lci gigacart.lct -d m4s_64_64 -lco gigacart.lco -html_rpt -fti gigacart.fti -fmt PLA -tto gigacart.tt4 -nojed -eqn gigacart.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open gigacart.rs2 w} rspFile] {
	puts stderr "Cannot create response file gigacart.rs2: $rspFile"
} else {
	puts $rspFile "-i gigacart.bl5 -lci gigacart.lct -d m4s_64_64 -lco gigacart.lco -html_rpt -fti gigacart.fti -fmt PLA -tto gigacart.tt4 -eqn gigacart.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@gigacart.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete gigacart.rs1
file delete gigacart.rs2
if [runCmd "\"$cpld_bin/tda\" -i gigacart.bl5 -o gigacart.tda -lci gigacart.lct -dev m4s_64_64 -family lc4k -mod gigacart -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj gigacart -if gigacart.jed -j2s -log gigacart.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 07/03/18 21:48:54 ###########


########## Tcl recorder starts at 07/03/18 21:51:42 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vhd2jhd\" design.vhd -o design.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 07/03/18 21:51:42 ###########


########## Tcl recorder starts at 07/03/18 21:51:45 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open gigacart.cmd w} rspFile] {
	puts stderr "Cannot create response file gigacart.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: gigacart.sty
PROJECT: gigacart
WORKING_PATH: \"$proj_dir\"
MODULE: gigacart
VHDL_FILE_LIST: design.vhd
OUTPUT_FILE_NAME: gigacart
SUFFIX_NAME: edi
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DEFAULT_ENUM_ENCODING: default
ARRANGE_VHDL_FILES: true
synthesis_onoff_pragma: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -e gigacart -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete gigacart.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf gigacart.edi -out gigacart.bl0 -err automake.err -log gigacart.log -prj gigacart -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" gigacart.bl0 -collapse none -reduce none -keepwires  -err automake.err -family"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"gigacart.bl1\" -o \"gigacart.bl2\" -omod \"gigacart\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj gigacart -lci gigacart.lct -log gigacart.imp -err automake.err -tti gigacart.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci gigacart.lct -blifopt gigacart.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" gigacart.bl2 -sweep -mergefb -err automake.err -o gigacart.bl3 @gigacart.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci gigacart.lct -dev lc4k -diofft gigacart.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" gigacart.bl3 -family AMDMACH -idev van -o gigacart.bl4 -oxrf gigacart.xrf -err automake.err @gigacart.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci gigacart.lct -dev lc4k -prefit gigacart.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp gigacart.bl4 -out gigacart.bl5 -err automake.err -log gigacart.log -mod gigacart @gigacart.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open gigacart.rs1 w} rspFile] {
	puts stderr "Cannot create response file gigacart.rs1: $rspFile"
} else {
	puts $rspFile "-i gigacart.bl5 -lci gigacart.lct -d m4s_64_64 -lco gigacart.lco -html_rpt -fti gigacart.fti -fmt PLA -tto gigacart.tt4 -nojed -eqn gigacart.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open gigacart.rs2 w} rspFile] {
	puts stderr "Cannot create response file gigacart.rs2: $rspFile"
} else {
	puts $rspFile "-i gigacart.bl5 -lci gigacart.lct -d m4s_64_64 -lco gigacart.lco -html_rpt -fti gigacart.fti -fmt PLA -tto gigacart.tt4 -eqn gigacart.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@gigacart.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete gigacart.rs1
file delete gigacart.rs2
if [runCmd "\"$cpld_bin/tda\" -i gigacart.bl5 -o gigacart.tda -lci gigacart.lct -dev m4s_64_64 -family lc4k -mod gigacart -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj gigacart -if gigacart.jed -j2s -log gigacart.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 07/03/18 21:51:45 ###########


########## Tcl recorder starts at 07/03/18 21:53:39 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vhd2jhd\" design.vhd -o design.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 07/03/18 21:53:39 ###########


########## Tcl recorder starts at 07/03/18 21:53:45 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open gigacart.cmd w} rspFile] {
	puts stderr "Cannot create response file gigacart.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: gigacart.sty
PROJECT: gigacart
WORKING_PATH: \"$proj_dir\"
MODULE: gigacart
VHDL_FILE_LIST: design.vhd
OUTPUT_FILE_NAME: gigacart
SUFFIX_NAME: edi
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DEFAULT_ENUM_ENCODING: default
ARRANGE_VHDL_FILES: true
synthesis_onoff_pragma: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -e gigacart -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete gigacart.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf gigacart.edi -out gigacart.bl0 -err automake.err -log gigacart.log -prj gigacart -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" gigacart.bl0 -collapse none -reduce none -keepwires  -err automake.err -family"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"gigacart.bl1\" -o \"gigacart.bl2\" -omod \"gigacart\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj gigacart -lci gigacart.lct -log gigacart.imp -err automake.err -tti gigacart.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci gigacart.lct -blifopt gigacart.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" gigacart.bl2 -sweep -mergefb -err automake.err -o gigacart.bl3 @gigacart.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci gigacart.lct -dev lc4k -diofft gigacart.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" gigacart.bl3 -family AMDMACH -idev van -o gigacart.bl4 -oxrf gigacart.xrf -err automake.err @gigacart.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci gigacart.lct -dev lc4k -prefit gigacart.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp gigacart.bl4 -out gigacart.bl5 -err automake.err -log gigacart.log -mod gigacart @gigacart.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open gigacart.rs1 w} rspFile] {
	puts stderr "Cannot create response file gigacart.rs1: $rspFile"
} else {
	puts $rspFile "-i gigacart.bl5 -lci gigacart.lct -d m4s_64_64 -lco gigacart.lco -html_rpt -fti gigacart.fti -fmt PLA -tto gigacart.tt4 -nojed -eqn gigacart.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open gigacart.rs2 w} rspFile] {
	puts stderr "Cannot create response file gigacart.rs2: $rspFile"
} else {
	puts $rspFile "-i gigacart.bl5 -lci gigacart.lct -d m4s_64_64 -lco gigacart.lco -html_rpt -fti gigacart.fti -fmt PLA -tto gigacart.tt4 -eqn gigacart.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@gigacart.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete gigacart.rs1
file delete gigacart.rs2
if [runCmd "\"$cpld_bin/tda\" -i gigacart.bl5 -o gigacart.tda -lci gigacart.lct -dev m4s_64_64 -family lc4k -mod gigacart -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj gigacart -if gigacart.jed -j2s -log gigacart.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 07/03/18 21:53:45 ###########


########## Tcl recorder starts at 07/03/18 21:54:10 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vhd2jhd\" design.vhd -o design.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 07/03/18 21:54:10 ###########


########## Tcl recorder starts at 07/03/18 21:54:13 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open gigacart.cmd w} rspFile] {
	puts stderr "Cannot create response file gigacart.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: gigacart.sty
PROJECT: gigacart
WORKING_PATH: \"$proj_dir\"
MODULE: gigacart
VHDL_FILE_LIST: design.vhd
OUTPUT_FILE_NAME: gigacart
SUFFIX_NAME: edi
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DEFAULT_ENUM_ENCODING: default
ARRANGE_VHDL_FILES: true
synthesis_onoff_pragma: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -e gigacart -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete gigacart.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf gigacart.edi -out gigacart.bl0 -err automake.err -log gigacart.log -prj gigacart -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" gigacart.bl0 -collapse none -reduce none -keepwires  -err automake.err -family"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"gigacart.bl1\" -o \"gigacart.bl2\" -omod \"gigacart\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj gigacart -lci gigacart.lct -log gigacart.imp -err automake.err -tti gigacart.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci gigacart.lct -blifopt gigacart.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" gigacart.bl2 -sweep -mergefb -err automake.err -o gigacart.bl3 @gigacart.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci gigacart.lct -dev lc4k -diofft gigacart.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" gigacart.bl3 -family AMDMACH -idev van -o gigacart.bl4 -oxrf gigacart.xrf -err automake.err @gigacart.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci gigacart.lct -dev lc4k -prefit gigacart.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp gigacart.bl4 -out gigacart.bl5 -err automake.err -log gigacart.log -mod gigacart @gigacart.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open gigacart.rs1 w} rspFile] {
	puts stderr "Cannot create response file gigacart.rs1: $rspFile"
} else {
	puts $rspFile "-i gigacart.bl5 -lci gigacart.lct -d m4s_64_64 -lco gigacart.lco -html_rpt -fti gigacart.fti -fmt PLA -tto gigacart.tt4 -nojed -eqn gigacart.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open gigacart.rs2 w} rspFile] {
	puts stderr "Cannot create response file gigacart.rs2: $rspFile"
} else {
	puts $rspFile "-i gigacart.bl5 -lci gigacart.lct -d m4s_64_64 -lco gigacart.lco -html_rpt -fti gigacart.fti -fmt PLA -tto gigacart.tt4 -eqn gigacart.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@gigacart.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete gigacart.rs1
file delete gigacart.rs2
if [runCmd "\"$cpld_bin/tda\" -i gigacart.bl5 -o gigacart.tda -lci gigacart.lct -dev m4s_64_64 -family lc4k -mod gigacart -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj gigacart -if gigacart.jed -j2s -log gigacart.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 07/03/18 21:54:13 ###########


########## Tcl recorder starts at 07/03/18 21:55:29 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vhd2jhd\" design.vhd -o design.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 07/03/18 21:55:29 ###########


########## Tcl recorder starts at 07/03/18 21:55:32 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open gigacart.cmd w} rspFile] {
	puts stderr "Cannot create response file gigacart.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: gigacart.sty
PROJECT: gigacart
WORKING_PATH: \"$proj_dir\"
MODULE: gigacart
VHDL_FILE_LIST: design.vhd
OUTPUT_FILE_NAME: gigacart
SUFFIX_NAME: edi
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DEFAULT_ENUM_ENCODING: default
ARRANGE_VHDL_FILES: true
synthesis_onoff_pragma: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -e gigacart -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete gigacart.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf gigacart.edi -out gigacart.bl0 -err automake.err -log gigacart.log -prj gigacart -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" gigacart.bl0 -collapse none -reduce none -keepwires  -err automake.err -family"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"gigacart.bl1\" -o \"gigacart.bl2\" -omod \"gigacart\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj gigacart -lci gigacart.lct -log gigacart.imp -err automake.err -tti gigacart.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci gigacart.lct -blifopt gigacart.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" gigacart.bl2 -sweep -mergefb -err automake.err -o gigacart.bl3 @gigacart.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci gigacart.lct -dev lc4k -diofft gigacart.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" gigacart.bl3 -family AMDMACH -idev van -o gigacart.bl4 -oxrf gigacart.xrf -err automake.err @gigacart.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci gigacart.lct -dev lc4k -prefit gigacart.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp gigacart.bl4 -out gigacart.bl5 -err automake.err -log gigacart.log -mod gigacart @gigacart.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open gigacart.rs1 w} rspFile] {
	puts stderr "Cannot create response file gigacart.rs1: $rspFile"
} else {
	puts $rspFile "-i gigacart.bl5 -lci gigacart.lct -d m4s_64_64 -lco gigacart.lco -html_rpt -fti gigacart.fti -fmt PLA -tto gigacart.tt4 -nojed -eqn gigacart.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open gigacart.rs2 w} rspFile] {
	puts stderr "Cannot create response file gigacart.rs2: $rspFile"
} else {
	puts $rspFile "-i gigacart.bl5 -lci gigacart.lct -d m4s_64_64 -lco gigacart.lco -html_rpt -fti gigacart.fti -fmt PLA -tto gigacart.tt4 -eqn gigacart.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@gigacart.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete gigacart.rs1
file delete gigacart.rs2
if [runCmd "\"$cpld_bin/tda\" -i gigacart.bl5 -o gigacart.tda -lci gigacart.lct -dev m4s_64_64 -family lc4k -mod gigacart -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj gigacart -if gigacart.jed -j2s -log gigacart.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 07/03/18 21:55:32 ###########


########## Tcl recorder starts at 07/03/18 22:06:53 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vhd2jhd\" design.vhd -o design.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 07/03/18 22:06:53 ###########


########## Tcl recorder starts at 07/03/18 22:06:57 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open gigacart.cmd w} rspFile] {
	puts stderr "Cannot create response file gigacart.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: gigacart.sty
PROJECT: gigacart
WORKING_PATH: \"$proj_dir\"
MODULE: gigacart
VHDL_FILE_LIST: design.vhd
OUTPUT_FILE_NAME: gigacart
SUFFIX_NAME: edi
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DEFAULT_ENUM_ENCODING: default
ARRANGE_VHDL_FILES: true
synthesis_onoff_pragma: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -e gigacart -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete gigacart.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf gigacart.edi -out gigacart.bl0 -err automake.err -log gigacart.log -prj gigacart -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" gigacart.bl0 -collapse none -reduce none -keepwires  -err automake.err -family"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"gigacart.bl1\" -o \"gigacart.bl2\" -omod \"gigacart\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj gigacart -lci gigacart.lct -log gigacart.imp -err automake.err -tti gigacart.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci gigacart.lct -blifopt gigacart.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" gigacart.bl2 -sweep -mergefb -err automake.err -o gigacart.bl3 @gigacart.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci gigacart.lct -dev lc4k -diofft gigacart.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" gigacart.bl3 -family AMDMACH -idev van -o gigacart.bl4 -oxrf gigacart.xrf -err automake.err @gigacart.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci gigacart.lct -dev lc4k -prefit gigacart.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp gigacart.bl4 -out gigacart.bl5 -err automake.err -log gigacart.log -mod gigacart @gigacart.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open gigacart.rs1 w} rspFile] {
	puts stderr "Cannot create response file gigacart.rs1: $rspFile"
} else {
	puts $rspFile "-i gigacart.bl5 -lci gigacart.lct -d m4s_64_64 -lco gigacart.lco -html_rpt -fti gigacart.fti -fmt PLA -tto gigacart.tt4 -nojed -eqn gigacart.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open gigacart.rs2 w} rspFile] {
	puts stderr "Cannot create response file gigacart.rs2: $rspFile"
} else {
	puts $rspFile "-i gigacart.bl5 -lci gigacart.lct -d m4s_64_64 -lco gigacart.lco -html_rpt -fti gigacart.fti -fmt PLA -tto gigacart.tt4 -eqn gigacart.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@gigacart.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete gigacart.rs1
file delete gigacart.rs2
if [runCmd "\"$cpld_bin/tda\" -i gigacart.bl5 -o gigacart.tda -lci gigacart.lct -dev m4s_64_64 -family lc4k -mod gigacart -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj gigacart -if gigacart.jed -j2s -log gigacart.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 07/03/18 22:06:57 ###########


########## Tcl recorder starts at 07/03/18 22:08:33 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vhd2jhd\" design.vhd -o design.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 07/03/18 22:08:33 ###########


########## Tcl recorder starts at 07/03/18 22:08:37 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open gigacart.cmd w} rspFile] {
	puts stderr "Cannot create response file gigacart.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: gigacart.sty
PROJECT: gigacart
WORKING_PATH: \"$proj_dir\"
MODULE: gigacart
VHDL_FILE_LIST: design.vhd
OUTPUT_FILE_NAME: gigacart
SUFFIX_NAME: edi
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DEFAULT_ENUM_ENCODING: default
ARRANGE_VHDL_FILES: true
synthesis_onoff_pragma: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -e gigacart -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete gigacart.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf gigacart.edi -out gigacart.bl0 -err automake.err -log gigacart.log -prj gigacart -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" gigacart.bl0 -collapse none -reduce none -keepwires  -err automake.err -family"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"gigacart.bl1\" -o \"gigacart.bl2\" -omod \"gigacart\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj gigacart -lci gigacart.lct -log gigacart.imp -err automake.err -tti gigacart.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci gigacart.lct -blifopt gigacart.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" gigacart.bl2 -sweep -mergefb -err automake.err -o gigacart.bl3 @gigacart.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci gigacart.lct -dev lc4k -diofft gigacart.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" gigacart.bl3 -family AMDMACH -idev van -o gigacart.bl4 -oxrf gigacart.xrf -err automake.err @gigacart.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci gigacart.lct -dev lc4k -prefit gigacart.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp gigacart.bl4 -out gigacart.bl5 -err automake.err -log gigacart.log -mod gigacart @gigacart.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open gigacart.rs1 w} rspFile] {
	puts stderr "Cannot create response file gigacart.rs1: $rspFile"
} else {
	puts $rspFile "-i gigacart.bl5 -lci gigacart.lct -d m4s_64_64 -lco gigacart.lco -html_rpt -fti gigacart.fti -fmt PLA -tto gigacart.tt4 -nojed -eqn gigacart.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open gigacart.rs2 w} rspFile] {
	puts stderr "Cannot create response file gigacart.rs2: $rspFile"
} else {
	puts $rspFile "-i gigacart.bl5 -lci gigacart.lct -d m4s_64_64 -lco gigacart.lco -html_rpt -fti gigacart.fti -fmt PLA -tto gigacart.tt4 -eqn gigacart.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@gigacart.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete gigacart.rs1
file delete gigacart.rs2
if [runCmd "\"$cpld_bin/tda\" -i gigacart.bl5 -o gigacart.tda -lci gigacart.lct -dev m4s_64_64 -family lc4k -mod gigacart -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj gigacart -if gigacart.jed -j2s -log gigacart.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 07/03/18 22:08:37 ###########


########## Tcl recorder starts at 07/03/18 22:10:39 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vhd2jhd\" design.vhd -o design.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 07/03/18 22:10:39 ###########


########## Tcl recorder starts at 07/03/18 22:10:43 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open gigacart.cmd w} rspFile] {
	puts stderr "Cannot create response file gigacart.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: gigacart.sty
PROJECT: gigacart
WORKING_PATH: \"$proj_dir\"
MODULE: gigacart
VHDL_FILE_LIST: design.vhd
OUTPUT_FILE_NAME: gigacart
SUFFIX_NAME: edi
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DEFAULT_ENUM_ENCODING: default
ARRANGE_VHDL_FILES: true
synthesis_onoff_pragma: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -e gigacart -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete gigacart.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf gigacart.edi -out gigacart.bl0 -err automake.err -log gigacart.log -prj gigacart -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" gigacart.bl0 -collapse none -reduce none -keepwires  -err automake.err -family"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"gigacart.bl1\" -o \"gigacart.bl2\" -omod \"gigacart\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj gigacart -lci gigacart.lct -log gigacart.imp -err automake.err -tti gigacart.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci gigacart.lct -blifopt gigacart.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" gigacart.bl2 -sweep -mergefb -err automake.err -o gigacart.bl3 @gigacart.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci gigacart.lct -dev lc4k -diofft gigacart.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" gigacart.bl3 -family AMDMACH -idev van -o gigacart.bl4 -oxrf gigacart.xrf -err automake.err @gigacart.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci gigacart.lct -dev lc4k -prefit gigacart.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp gigacart.bl4 -out gigacart.bl5 -err automake.err -log gigacart.log -mod gigacart @gigacart.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open gigacart.rs1 w} rspFile] {
	puts stderr "Cannot create response file gigacart.rs1: $rspFile"
} else {
	puts $rspFile "-i gigacart.bl5 -lci gigacart.lct -d m4s_64_64 -lco gigacart.lco -html_rpt -fti gigacart.fti -fmt PLA -tto gigacart.tt4 -nojed -eqn gigacart.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open gigacart.rs2 w} rspFile] {
	puts stderr "Cannot create response file gigacart.rs2: $rspFile"
} else {
	puts $rspFile "-i gigacart.bl5 -lci gigacart.lct -d m4s_64_64 -lco gigacart.lco -html_rpt -fti gigacart.fti -fmt PLA -tto gigacart.tt4 -eqn gigacart.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@gigacart.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete gigacart.rs1
file delete gigacart.rs2
if [runCmd "\"$cpld_bin/tda\" -i gigacart.bl5 -o gigacart.tda -lci gigacart.lct -dev m4s_64_64 -family lc4k -mod gigacart -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj gigacart -if gigacart.jed -j2s -log gigacart.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 07/03/18 22:10:43 ###########


########## Tcl recorder starts at 07/03/18 22:11:48 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vhd2jhd\" design.vhd -o design.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 07/03/18 22:11:48 ###########


########## Tcl recorder starts at 07/03/18 22:11:51 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open gigacart.cmd w} rspFile] {
	puts stderr "Cannot create response file gigacart.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: gigacart.sty
PROJECT: gigacart
WORKING_PATH: \"$proj_dir\"
MODULE: gigacart
VHDL_FILE_LIST: design.vhd
OUTPUT_FILE_NAME: gigacart
SUFFIX_NAME: edi
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DEFAULT_ENUM_ENCODING: default
ARRANGE_VHDL_FILES: true
synthesis_onoff_pragma: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -e gigacart -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete gigacart.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf gigacart.edi -out gigacart.bl0 -err automake.err -log gigacart.log -prj gigacart -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" gigacart.bl0 -collapse none -reduce none -keepwires  -err automake.err -family"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"gigacart.bl1\" -o \"gigacart.bl2\" -omod \"gigacart\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj gigacart -lci gigacart.lct -log gigacart.imp -err automake.err -tti gigacart.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci gigacart.lct -blifopt gigacart.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" gigacart.bl2 -sweep -mergefb -err automake.err -o gigacart.bl3 @gigacart.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci gigacart.lct -dev lc4k -diofft gigacart.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" gigacart.bl3 -family AMDMACH -idev van -o gigacart.bl4 -oxrf gigacart.xrf -err automake.err @gigacart.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci gigacart.lct -dev lc4k -prefit gigacart.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp gigacart.bl4 -out gigacart.bl5 -err automake.err -log gigacart.log -mod gigacart @gigacart.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open gigacart.rs1 w} rspFile] {
	puts stderr "Cannot create response file gigacart.rs1: $rspFile"
} else {
	puts $rspFile "-i gigacart.bl5 -lci gigacart.lct -d m4s_64_64 -lco gigacart.lco -html_rpt -fti gigacart.fti -fmt PLA -tto gigacart.tt4 -nojed -eqn gigacart.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open gigacart.rs2 w} rspFile] {
	puts stderr "Cannot create response file gigacart.rs2: $rspFile"
} else {
	puts $rspFile "-i gigacart.bl5 -lci gigacart.lct -d m4s_64_64 -lco gigacart.lco -html_rpt -fti gigacart.fti -fmt PLA -tto gigacart.tt4 -eqn gigacart.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@gigacart.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete gigacart.rs1
file delete gigacart.rs2
if [runCmd "\"$cpld_bin/tda\" -i gigacart.bl5 -o gigacart.tda -lci gigacart.lct -dev m4s_64_64 -family lc4k -mod gigacart -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj gigacart -if gigacart.jed -j2s -log gigacart.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 07/03/18 22:11:51 ###########


########## Tcl recorder starts at 07/03/18 22:12:23 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vhd2jhd\" design.vhd -o design.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 07/03/18 22:12:23 ###########


########## Tcl recorder starts at 07/03/18 22:12:27 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open gigacart.cmd w} rspFile] {
	puts stderr "Cannot create response file gigacart.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: gigacart.sty
PROJECT: gigacart
WORKING_PATH: \"$proj_dir\"
MODULE: gigacart
VHDL_FILE_LIST: design.vhd
OUTPUT_FILE_NAME: gigacart
SUFFIX_NAME: edi
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DEFAULT_ENUM_ENCODING: default
ARRANGE_VHDL_FILES: true
synthesis_onoff_pragma: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -e gigacart -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete gigacart.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf gigacart.edi -out gigacart.bl0 -err automake.err -log gigacart.log -prj gigacart -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" gigacart.bl0 -collapse none -reduce none -keepwires  -err automake.err -family"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"gigacart.bl1\" -o \"gigacart.bl2\" -omod \"gigacart\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj gigacart -lci gigacart.lct -log gigacart.imp -err automake.err -tti gigacart.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci gigacart.lct -blifopt gigacart.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" gigacart.bl2 -sweep -mergefb -err automake.err -o gigacart.bl3 @gigacart.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci gigacart.lct -dev lc4k -diofft gigacart.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" gigacart.bl3 -family AMDMACH -idev van -o gigacart.bl4 -oxrf gigacart.xrf -err automake.err @gigacart.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci gigacart.lct -dev lc4k -prefit gigacart.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp gigacart.bl4 -out gigacart.bl5 -err automake.err -log gigacart.log -mod gigacart @gigacart.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open gigacart.rs1 w} rspFile] {
	puts stderr "Cannot create response file gigacart.rs1: $rspFile"
} else {
	puts $rspFile "-i gigacart.bl5 -lci gigacart.lct -d m4s_64_64 -lco gigacart.lco -html_rpt -fti gigacart.fti -fmt PLA -tto gigacart.tt4 -nojed -eqn gigacart.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open gigacart.rs2 w} rspFile] {
	puts stderr "Cannot create response file gigacart.rs2: $rspFile"
} else {
	puts $rspFile "-i gigacart.bl5 -lci gigacart.lct -d m4s_64_64 -lco gigacart.lco -html_rpt -fti gigacart.fti -fmt PLA -tto gigacart.tt4 -eqn gigacart.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@gigacart.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete gigacart.rs1
file delete gigacart.rs2
if [runCmd "\"$cpld_bin/tda\" -i gigacart.bl5 -o gigacart.tda -lci gigacart.lct -dev m4s_64_64 -family lc4k -mod gigacart -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj gigacart -if gigacart.jed -j2s -log gigacart.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 07/03/18 22:12:27 ###########


########## Tcl recorder starts at 07/03/18 22:16:52 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vhd2jhd\" design.vhd -o design.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 07/03/18 22:16:52 ###########


########## Tcl recorder starts at 07/03/18 22:16:56 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open gigacart.cmd w} rspFile] {
	puts stderr "Cannot create response file gigacart.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: gigacart.sty
PROJECT: gigacart
WORKING_PATH: \"$proj_dir\"
MODULE: gigacart
VHDL_FILE_LIST: design.vhd
OUTPUT_FILE_NAME: gigacart
SUFFIX_NAME: edi
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DEFAULT_ENUM_ENCODING: default
ARRANGE_VHDL_FILES: true
synthesis_onoff_pragma: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -e gigacart -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete gigacart.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf gigacart.edi -out gigacart.bl0 -err automake.err -log gigacart.log -prj gigacart -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" gigacart.bl0 -collapse none -reduce none -keepwires  -err automake.err -family"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"gigacart.bl1\" -o \"gigacart.bl2\" -omod \"gigacart\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj gigacart -lci gigacart.lct -log gigacart.imp -err automake.err -tti gigacart.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci gigacart.lct -blifopt gigacart.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" gigacart.bl2 -sweep -mergefb -err automake.err -o gigacart.bl3 @gigacart.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci gigacart.lct -dev lc4k -diofft gigacart.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" gigacart.bl3 -family AMDMACH -idev van -o gigacart.bl4 -oxrf gigacart.xrf -err automake.err @gigacart.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci gigacart.lct -dev lc4k -prefit gigacart.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp gigacart.bl4 -out gigacart.bl5 -err automake.err -log gigacart.log -mod gigacart @gigacart.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open gigacart.rs1 w} rspFile] {
	puts stderr "Cannot create response file gigacart.rs1: $rspFile"
} else {
	puts $rspFile "-i gigacart.bl5 -lci gigacart.lct -d m4s_64_64 -lco gigacart.lco -html_rpt -fti gigacart.fti -fmt PLA -tto gigacart.tt4 -nojed -eqn gigacart.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open gigacart.rs2 w} rspFile] {
	puts stderr "Cannot create response file gigacart.rs2: $rspFile"
} else {
	puts $rspFile "-i gigacart.bl5 -lci gigacart.lct -d m4s_64_64 -lco gigacart.lco -html_rpt -fti gigacart.fti -fmt PLA -tto gigacart.tt4 -eqn gigacart.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@gigacart.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete gigacart.rs1
file delete gigacart.rs2
if [runCmd "\"$cpld_bin/tda\" -i gigacart.bl5 -o gigacart.tda -lci gigacart.lct -dev m4s_64_64 -family lc4k -mod gigacart -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj gigacart -if gigacart.jed -j2s -log gigacart.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 07/03/18 22:16:56 ###########


########## Tcl recorder starts at 07/03/18 22:19:18 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vhd2jhd\" design.vhd -o design.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 07/03/18 22:19:18 ###########


########## Tcl recorder starts at 07/03/18 22:19:22 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open gigacart.cmd w} rspFile] {
	puts stderr "Cannot create response file gigacart.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: gigacart.sty
PROJECT: gigacart
WORKING_PATH: \"$proj_dir\"
MODULE: gigacart
VHDL_FILE_LIST: design.vhd
OUTPUT_FILE_NAME: gigacart
SUFFIX_NAME: edi
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DEFAULT_ENUM_ENCODING: default
ARRANGE_VHDL_FILES: true
synthesis_onoff_pragma: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -e gigacart -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete gigacart.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf gigacart.edi -out gigacart.bl0 -err automake.err -log gigacart.log -prj gigacart -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" gigacart.bl0 -collapse none -reduce none -keepwires  -err automake.err -family"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"gigacart.bl1\" -o \"gigacart.bl2\" -omod \"gigacart\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj gigacart -lci gigacart.lct -log gigacart.imp -err automake.err -tti gigacart.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci gigacart.lct -blifopt gigacart.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" gigacart.bl2 -sweep -mergefb -err automake.err -o gigacart.bl3 @gigacart.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci gigacart.lct -dev lc4k -diofft gigacart.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" gigacart.bl3 -family AMDMACH -idev van -o gigacart.bl4 -oxrf gigacart.xrf -err automake.err @gigacart.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci gigacart.lct -dev lc4k -prefit gigacart.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp gigacart.bl4 -out gigacart.bl5 -err automake.err -log gigacart.log -mod gigacart @gigacart.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open gigacart.rs1 w} rspFile] {
	puts stderr "Cannot create response file gigacart.rs1: $rspFile"
} else {
	puts $rspFile "-i gigacart.bl5 -lci gigacart.lct -d m4s_64_64 -lco gigacart.lco -html_rpt -fti gigacart.fti -fmt PLA -tto gigacart.tt4 -nojed -eqn gigacart.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open gigacart.rs2 w} rspFile] {
	puts stderr "Cannot create response file gigacart.rs2: $rspFile"
} else {
	puts $rspFile "-i gigacart.bl5 -lci gigacart.lct -d m4s_64_64 -lco gigacart.lco -html_rpt -fti gigacart.fti -fmt PLA -tto gigacart.tt4 -eqn gigacart.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@gigacart.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete gigacart.rs1
file delete gigacart.rs2
if [runCmd "\"$cpld_bin/tda\" -i gigacart.bl5 -o gigacart.tda -lci gigacart.lct -dev m4s_64_64 -family lc4k -mod gigacart -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj gigacart -if gigacart.jed -j2s -log gigacart.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 07/03/18 22:19:22 ###########


########## Tcl recorder starts at 07/03/18 22:21:57 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vhd2jhd\" design.vhd -o design.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 07/03/18 22:21:57 ###########


########## Tcl recorder starts at 07/03/18 22:22:00 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open gigacart.cmd w} rspFile] {
	puts stderr "Cannot create response file gigacart.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: gigacart.sty
PROJECT: gigacart
WORKING_PATH: \"$proj_dir\"
MODULE: gigacart
VHDL_FILE_LIST: design.vhd
OUTPUT_FILE_NAME: gigacart
SUFFIX_NAME: edi
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DEFAULT_ENUM_ENCODING: default
ARRANGE_VHDL_FILES: true
synthesis_onoff_pragma: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -e gigacart -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete gigacart.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf gigacart.edi -out gigacart.bl0 -err automake.err -log gigacart.log -prj gigacart -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" gigacart.bl0 -collapse none -reduce none -keepwires  -err automake.err -family"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"gigacart.bl1\" -o \"gigacart.bl2\" -omod \"gigacart\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj gigacart -lci gigacart.lct -log gigacart.imp -err automake.err -tti gigacart.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci gigacart.lct -blifopt gigacart.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" gigacart.bl2 -sweep -mergefb -err automake.err -o gigacart.bl3 @gigacart.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci gigacart.lct -dev lc4k -diofft gigacart.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" gigacart.bl3 -family AMDMACH -idev van -o gigacart.bl4 -oxrf gigacart.xrf -err automake.err @gigacart.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci gigacart.lct -dev lc4k -prefit gigacart.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp gigacart.bl4 -out gigacart.bl5 -err automake.err -log gigacart.log -mod gigacart @gigacart.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open gigacart.rs1 w} rspFile] {
	puts stderr "Cannot create response file gigacart.rs1: $rspFile"
} else {
	puts $rspFile "-i gigacart.bl5 -lci gigacart.lct -d m4s_64_64 -lco gigacart.lco -html_rpt -fti gigacart.fti -fmt PLA -tto gigacart.tt4 -nojed -eqn gigacart.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open gigacart.rs2 w} rspFile] {
	puts stderr "Cannot create response file gigacart.rs2: $rspFile"
} else {
	puts $rspFile "-i gigacart.bl5 -lci gigacart.lct -d m4s_64_64 -lco gigacart.lco -html_rpt -fti gigacart.fti -fmt PLA -tto gigacart.tt4 -eqn gigacart.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@gigacart.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete gigacart.rs1
file delete gigacart.rs2
if [runCmd "\"$cpld_bin/tda\" -i gigacart.bl5 -o gigacart.tda -lci gigacart.lct -dev m4s_64_64 -family lc4k -mod gigacart -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj gigacart -if gigacart.jed -j2s -log gigacart.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 07/03/18 22:22:00 ###########


########## Tcl recorder starts at 07/03/18 22:25:12 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vhd2jhd\" design.vhd -o design.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 07/03/18 22:25:12 ###########


########## Tcl recorder starts at 07/03/18 22:25:15 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open gigacart.cmd w} rspFile] {
	puts stderr "Cannot create response file gigacart.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: gigacart.sty
PROJECT: gigacart
WORKING_PATH: \"$proj_dir\"
MODULE: gigacart
VHDL_FILE_LIST: design.vhd
OUTPUT_FILE_NAME: gigacart
SUFFIX_NAME: edi
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DEFAULT_ENUM_ENCODING: default
ARRANGE_VHDL_FILES: true
synthesis_onoff_pragma: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -e gigacart -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete gigacart.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf gigacart.edi -out gigacart.bl0 -err automake.err -log gigacart.log -prj gigacart -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" gigacart.bl0 -collapse none -reduce none -keepwires  -err automake.err -family"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"gigacart.bl1\" -o \"gigacart.bl2\" -omod \"gigacart\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj gigacart -lci gigacart.lct -log gigacart.imp -err automake.err -tti gigacart.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci gigacart.lct -blifopt gigacart.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" gigacart.bl2 -sweep -mergefb -err automake.err -o gigacart.bl3 @gigacart.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci gigacart.lct -dev lc4k -diofft gigacart.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" gigacart.bl3 -family AMDMACH -idev van -o gigacart.bl4 -oxrf gigacart.xrf -err automake.err @gigacart.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci gigacart.lct -dev lc4k -prefit gigacart.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp gigacart.bl4 -out gigacart.bl5 -err automake.err -log gigacart.log -mod gigacart @gigacart.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open gigacart.rs1 w} rspFile] {
	puts stderr "Cannot create response file gigacart.rs1: $rspFile"
} else {
	puts $rspFile "-i gigacart.bl5 -lci gigacart.lct -d m4s_64_64 -lco gigacart.lco -html_rpt -fti gigacart.fti -fmt PLA -tto gigacart.tt4 -nojed -eqn gigacart.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open gigacart.rs2 w} rspFile] {
	puts stderr "Cannot create response file gigacart.rs2: $rspFile"
} else {
	puts $rspFile "-i gigacart.bl5 -lci gigacart.lct -d m4s_64_64 -lco gigacart.lco -html_rpt -fti gigacart.fti -fmt PLA -tto gigacart.tt4 -eqn gigacart.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@gigacart.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete gigacart.rs1
file delete gigacart.rs2
if [runCmd "\"$cpld_bin/tda\" -i gigacart.bl5 -o gigacart.tda -lci gigacart.lct -dev m4s_64_64 -family lc4k -mod gigacart -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj gigacart -if gigacart.jed -j2s -log gigacart.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 07/03/18 22:25:15 ###########


########## Tcl recorder starts at 07/03/18 22:31:19 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vhd2jhd\" design.vhd -o design.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 07/03/18 22:31:19 ###########


########## Tcl recorder starts at 07/03/18 22:31:30 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open gigacart.cmd w} rspFile] {
	puts stderr "Cannot create response file gigacart.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: gigacart.sty
PROJECT: gigacart
WORKING_PATH: \"$proj_dir\"
MODULE: gigacart
VHDL_FILE_LIST: design.vhd
OUTPUT_FILE_NAME: gigacart
SUFFIX_NAME: edi
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DEFAULT_ENUM_ENCODING: default
ARRANGE_VHDL_FILES: true
synthesis_onoff_pragma: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -e gigacart -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete gigacart.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf gigacart.edi -out gigacart.bl0 -err automake.err -log gigacart.log -prj gigacart -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" gigacart.bl0 -collapse none -reduce none -keepwires  -err automake.err -family"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"gigacart.bl1\" -o \"gigacart.bl2\" -omod \"gigacart\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj gigacart -lci gigacart.lct -log gigacart.imp -err automake.err -tti gigacart.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci gigacart.lct -blifopt gigacart.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" gigacart.bl2 -sweep -mergefb -err automake.err -o gigacart.bl3 @gigacart.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci gigacart.lct -dev lc4k -diofft gigacart.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" gigacart.bl3 -family AMDMACH -idev van -o gigacart.bl4 -oxrf gigacart.xrf -err automake.err @gigacart.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci gigacart.lct -dev lc4k -prefit gigacart.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp gigacart.bl4 -out gigacart.bl5 -err automake.err -log gigacart.log -mod gigacart @gigacart.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open gigacart.rs1 w} rspFile] {
	puts stderr "Cannot create response file gigacart.rs1: $rspFile"
} else {
	puts $rspFile "-i gigacart.bl5 -lci gigacart.lct -d m4s_64_64 -lco gigacart.lco -html_rpt -fti gigacart.fti -fmt PLA -tto gigacart.tt4 -nojed -eqn gigacart.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open gigacart.rs2 w} rspFile] {
	puts stderr "Cannot create response file gigacart.rs2: $rspFile"
} else {
	puts $rspFile "-i gigacart.bl5 -lci gigacart.lct -d m4s_64_64 -lco gigacart.lco -html_rpt -fti gigacart.fti -fmt PLA -tto gigacart.tt4 -eqn gigacart.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@gigacart.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete gigacart.rs1
file delete gigacart.rs2
if [runCmd "\"$cpld_bin/tda\" -i gigacart.bl5 -o gigacart.tda -lci gigacart.lct -dev m4s_64_64 -family lc4k -mod gigacart -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj gigacart -if gigacart.jed -j2s -log gigacart.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 07/03/18 22:31:30 ###########


########## Tcl recorder starts at 07/03/18 22:31:58 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vhd2jhd\" design.vhd -o design.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 07/03/18 22:31:58 ###########


########## Tcl recorder starts at 07/03/18 22:32:02 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open gigacart.cmd w} rspFile] {
	puts stderr "Cannot create response file gigacart.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: gigacart.sty
PROJECT: gigacart
WORKING_PATH: \"$proj_dir\"
MODULE: gigacart
VHDL_FILE_LIST: design.vhd
OUTPUT_FILE_NAME: gigacart
SUFFIX_NAME: edi
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DEFAULT_ENUM_ENCODING: default
ARRANGE_VHDL_FILES: true
synthesis_onoff_pragma: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -e gigacart -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete gigacart.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf gigacart.edi -out gigacart.bl0 -err automake.err -log gigacart.log -prj gigacart -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" gigacart.bl0 -collapse none -reduce none -keepwires  -err automake.err -family"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"gigacart.bl1\" -o \"gigacart.bl2\" -omod \"gigacart\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj gigacart -lci gigacart.lct -log gigacart.imp -err automake.err -tti gigacart.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci gigacart.lct -blifopt gigacart.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" gigacart.bl2 -sweep -mergefb -err automake.err -o gigacart.bl3 @gigacart.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci gigacart.lct -dev lc4k -diofft gigacart.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" gigacart.bl3 -family AMDMACH -idev van -o gigacart.bl4 -oxrf gigacart.xrf -err automake.err @gigacart.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci gigacart.lct -dev lc4k -prefit gigacart.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp gigacart.bl4 -out gigacart.bl5 -err automake.err -log gigacart.log -mod gigacart @gigacart.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open gigacart.rs1 w} rspFile] {
	puts stderr "Cannot create response file gigacart.rs1: $rspFile"
} else {
	puts $rspFile "-i gigacart.bl5 -lci gigacart.lct -d m4s_64_64 -lco gigacart.lco -html_rpt -fti gigacart.fti -fmt PLA -tto gigacart.tt4 -nojed -eqn gigacart.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open gigacart.rs2 w} rspFile] {
	puts stderr "Cannot create response file gigacart.rs2: $rspFile"
} else {
	puts $rspFile "-i gigacart.bl5 -lci gigacart.lct -d m4s_64_64 -lco gigacart.lco -html_rpt -fti gigacart.fti -fmt PLA -tto gigacart.tt4 -eqn gigacart.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@gigacart.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete gigacart.rs1
file delete gigacart.rs2
if [runCmd "\"$cpld_bin/tda\" -i gigacart.bl5 -o gigacart.tda -lci gigacart.lct -dev m4s_64_64 -family lc4k -mod gigacart -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj gigacart -if gigacart.jed -j2s -log gigacart.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 07/03/18 22:32:02 ###########


########## Tcl recorder starts at 07/03/18 22:32:59 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vhd2jhd\" design.vhd -o design.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 07/03/18 22:32:59 ###########


########## Tcl recorder starts at 07/03/18 22:33:02 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open gigacart.cmd w} rspFile] {
	puts stderr "Cannot create response file gigacart.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: gigacart.sty
PROJECT: gigacart
WORKING_PATH: \"$proj_dir\"
MODULE: gigacart
VHDL_FILE_LIST: design.vhd
OUTPUT_FILE_NAME: gigacart
SUFFIX_NAME: edi
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DEFAULT_ENUM_ENCODING: default
ARRANGE_VHDL_FILES: true
synthesis_onoff_pragma: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -e gigacart -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete gigacart.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf gigacart.edi -out gigacart.bl0 -err automake.err -log gigacart.log -prj gigacart -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" gigacart.bl0 -collapse none -reduce none -keepwires  -err automake.err -family"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"gigacart.bl1\" -o \"gigacart.bl2\" -omod \"gigacart\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj gigacart -lci gigacart.lct -log gigacart.imp -err automake.err -tti gigacart.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci gigacart.lct -blifopt gigacart.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" gigacart.bl2 -sweep -mergefb -err automake.err -o gigacart.bl3 @gigacart.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci gigacart.lct -dev lc4k -diofft gigacart.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" gigacart.bl3 -family AMDMACH -idev van -o gigacart.bl4 -oxrf gigacart.xrf -err automake.err @gigacart.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci gigacart.lct -dev lc4k -prefit gigacart.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp gigacart.bl4 -out gigacart.bl5 -err automake.err -log gigacart.log -mod gigacart @gigacart.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open gigacart.rs1 w} rspFile] {
	puts stderr "Cannot create response file gigacart.rs1: $rspFile"
} else {
	puts $rspFile "-i gigacart.bl5 -lci gigacart.lct -d m4s_64_64 -lco gigacart.lco -html_rpt -fti gigacart.fti -fmt PLA -tto gigacart.tt4 -nojed -eqn gigacart.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open gigacart.rs2 w} rspFile] {
	puts stderr "Cannot create response file gigacart.rs2: $rspFile"
} else {
	puts $rspFile "-i gigacart.bl5 -lci gigacart.lct -d m4s_64_64 -lco gigacart.lco -html_rpt -fti gigacart.fti -fmt PLA -tto gigacart.tt4 -eqn gigacart.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@gigacart.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete gigacart.rs1
file delete gigacart.rs2
if [runCmd "\"$cpld_bin/tda\" -i gigacart.bl5 -o gigacart.tda -lci gigacart.lct -dev m4s_64_64 -family lc4k -mod gigacart -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj gigacart -if gigacart.jed -j2s -log gigacart.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 07/03/18 22:33:02 ###########


########## Tcl recorder starts at 07/03/18 22:34:47 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vhd2jhd\" design.vhd -o design.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 07/03/18 22:34:47 ###########


########## Tcl recorder starts at 07/03/18 22:34:50 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open gigacart.cmd w} rspFile] {
	puts stderr "Cannot create response file gigacart.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: gigacart.sty
PROJECT: gigacart
WORKING_PATH: \"$proj_dir\"
MODULE: gigacart
VHDL_FILE_LIST: design.vhd
OUTPUT_FILE_NAME: gigacart
SUFFIX_NAME: edi
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DEFAULT_ENUM_ENCODING: default
ARRANGE_VHDL_FILES: true
synthesis_onoff_pragma: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -e gigacart -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete gigacart.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf gigacart.edi -out gigacart.bl0 -err automake.err -log gigacart.log -prj gigacart -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" gigacart.bl0 -collapse none -reduce none -keepwires  -err automake.err -family"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"gigacart.bl1\" -o \"gigacart.bl2\" -omod \"gigacart\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj gigacart -lci gigacart.lct -log gigacart.imp -err automake.err -tti gigacart.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci gigacart.lct -blifopt gigacart.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" gigacart.bl2 -sweep -mergefb -err automake.err -o gigacart.bl3 @gigacart.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci gigacart.lct -dev lc4k -diofft gigacart.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" gigacart.bl3 -family AMDMACH -idev van -o gigacart.bl4 -oxrf gigacart.xrf -err automake.err @gigacart.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci gigacart.lct -dev lc4k -prefit gigacart.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp gigacart.bl4 -out gigacart.bl5 -err automake.err -log gigacart.log -mod gigacart @gigacart.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open gigacart.rs1 w} rspFile] {
	puts stderr "Cannot create response file gigacart.rs1: $rspFile"
} else {
	puts $rspFile "-i gigacart.bl5 -lci gigacart.lct -d m4s_64_64 -lco gigacart.lco -html_rpt -fti gigacart.fti -fmt PLA -tto gigacart.tt4 -nojed -eqn gigacart.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open gigacart.rs2 w} rspFile] {
	puts stderr "Cannot create response file gigacart.rs2: $rspFile"
} else {
	puts $rspFile "-i gigacart.bl5 -lci gigacart.lct -d m4s_64_64 -lco gigacart.lco -html_rpt -fti gigacart.fti -fmt PLA -tto gigacart.tt4 -eqn gigacart.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@gigacart.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete gigacart.rs1
file delete gigacart.rs2
if [runCmd "\"$cpld_bin/tda\" -i gigacart.bl5 -o gigacart.tda -lci gigacart.lct -dev m4s_64_64 -family lc4k -mod gigacart -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj gigacart -if gigacart.jed -j2s -log gigacart.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 07/03/18 22:34:50 ###########


########## Tcl recorder starts at 07/03/18 22:38:57 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vhd2jhd\" design.vhd -o design.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 07/03/18 22:38:58 ###########


########## Tcl recorder starts at 07/03/18 22:39:01 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open gigacart.cmd w} rspFile] {
	puts stderr "Cannot create response file gigacart.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: gigacart.sty
PROJECT: gigacart
WORKING_PATH: \"$proj_dir\"
MODULE: gigacart
VHDL_FILE_LIST: design.vhd
OUTPUT_FILE_NAME: gigacart
SUFFIX_NAME: edi
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DEFAULT_ENUM_ENCODING: default
ARRANGE_VHDL_FILES: true
synthesis_onoff_pragma: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -e gigacart -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete gigacart.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf gigacart.edi -out gigacart.bl0 -err automake.err -log gigacart.log -prj gigacart -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" gigacart.bl0 -collapse none -reduce none -keepwires  -err automake.err -family"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"gigacart.bl1\" -o \"gigacart.bl2\" -omod \"gigacart\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj gigacart -lci gigacart.lct -log gigacart.imp -err automake.err -tti gigacart.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci gigacart.lct -blifopt gigacart.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" gigacart.bl2 -sweep -mergefb -err automake.err -o gigacart.bl3 @gigacart.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci gigacart.lct -dev lc4k -diofft gigacart.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" gigacart.bl3 -family AMDMACH -idev van -o gigacart.bl4 -oxrf gigacart.xrf -err automake.err @gigacart.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci gigacart.lct -dev lc4k -prefit gigacart.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp gigacart.bl4 -out gigacart.bl5 -err automake.err -log gigacart.log -mod gigacart @gigacart.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open gigacart.rs1 w} rspFile] {
	puts stderr "Cannot create response file gigacart.rs1: $rspFile"
} else {
	puts $rspFile "-i gigacart.bl5 -lci gigacart.lct -d m4s_64_64 -lco gigacart.lco -html_rpt -fti gigacart.fti -fmt PLA -tto gigacart.tt4 -nojed -eqn gigacart.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open gigacart.rs2 w} rspFile] {
	puts stderr "Cannot create response file gigacart.rs2: $rspFile"
} else {
	puts $rspFile "-i gigacart.bl5 -lci gigacart.lct -d m4s_64_64 -lco gigacart.lco -html_rpt -fti gigacart.fti -fmt PLA -tto gigacart.tt4 -eqn gigacart.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@gigacart.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete gigacart.rs1
file delete gigacart.rs2
if [runCmd "\"$cpld_bin/tda\" -i gigacart.bl5 -o gigacart.tda -lci gigacart.lct -dev m4s_64_64 -family lc4k -mod gigacart -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj gigacart -if gigacart.jed -j2s -log gigacart.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 07/03/18 22:39:01 ###########


########## Tcl recorder starts at 07/03/18 22:39:55 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vhd2jhd\" design.vhd -o design.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 07/03/18 22:39:55 ###########


########## Tcl recorder starts at 07/03/18 22:39:59 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open gigacart.cmd w} rspFile] {
	puts stderr "Cannot create response file gigacart.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: gigacart.sty
PROJECT: gigacart
WORKING_PATH: \"$proj_dir\"
MODULE: gigacart
VHDL_FILE_LIST: design.vhd
OUTPUT_FILE_NAME: gigacart
SUFFIX_NAME: edi
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DEFAULT_ENUM_ENCODING: default
ARRANGE_VHDL_FILES: true
synthesis_onoff_pragma: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -e gigacart -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete gigacart.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf gigacart.edi -out gigacart.bl0 -err automake.err -log gigacart.log -prj gigacart -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" gigacart.bl0 -collapse none -reduce none -keepwires  -err automake.err -family"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"gigacart.bl1\" -o \"gigacart.bl2\" -omod \"gigacart\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj gigacart -lci gigacart.lct -log gigacart.imp -err automake.err -tti gigacart.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci gigacart.lct -blifopt gigacart.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" gigacart.bl2 -sweep -mergefb -err automake.err -o gigacart.bl3 @gigacart.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci gigacart.lct -dev lc4k -diofft gigacart.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" gigacart.bl3 -family AMDMACH -idev van -o gigacart.bl4 -oxrf gigacart.xrf -err automake.err @gigacart.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci gigacart.lct -dev lc4k -prefit gigacart.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp gigacart.bl4 -out gigacart.bl5 -err automake.err -log gigacart.log -mod gigacart @gigacart.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open gigacart.rs1 w} rspFile] {
	puts stderr "Cannot create response file gigacart.rs1: $rspFile"
} else {
	puts $rspFile "-i gigacart.bl5 -lci gigacart.lct -d m4s_64_64 -lco gigacart.lco -html_rpt -fti gigacart.fti -fmt PLA -tto gigacart.tt4 -nojed -eqn gigacart.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open gigacart.rs2 w} rspFile] {
	puts stderr "Cannot create response file gigacart.rs2: $rspFile"
} else {
	puts $rspFile "-i gigacart.bl5 -lci gigacart.lct -d m4s_64_64 -lco gigacart.lco -html_rpt -fti gigacart.fti -fmt PLA -tto gigacart.tt4 -eqn gigacart.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@gigacart.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete gigacart.rs1
file delete gigacart.rs2
if [runCmd "\"$cpld_bin/tda\" -i gigacart.bl5 -o gigacart.tda -lci gigacart.lct -dev m4s_64_64 -family lc4k -mod gigacart -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj gigacart -if gigacart.jed -j2s -log gigacart.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 07/03/18 22:39:59 ###########


########## Tcl recorder starts at 07/03/18 22:41:05 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vhd2jhd\" design.vhd -o design.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 07/03/18 22:41:05 ###########


########## Tcl recorder starts at 07/03/18 22:56:14 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vhd2jhd\" design.vhd -o design.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 07/03/18 22:56:14 ###########


########## Tcl recorder starts at 07/03/18 22:56:19 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open gigacart.cmd w} rspFile] {
	puts stderr "Cannot create response file gigacart.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: gigacart.sty
PROJECT: gigacart
WORKING_PATH: \"$proj_dir\"
MODULE: gigacart
VHDL_FILE_LIST: design.vhd
OUTPUT_FILE_NAME: gigacart
SUFFIX_NAME: edi
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DEFAULT_ENUM_ENCODING: default
ARRANGE_VHDL_FILES: true
synthesis_onoff_pragma: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -e gigacart -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete gigacart.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf gigacart.edi -out gigacart.bl0 -err automake.err -log gigacart.log -prj gigacart -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" gigacart.bl0 -collapse none -reduce none -keepwires  -err automake.err -family"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"gigacart.bl1\" -o \"gigacart.bl2\" -omod \"gigacart\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj gigacart -lci gigacart.lct -log gigacart.imp -err automake.err -tti gigacart.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci gigacart.lct -blifopt gigacart.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" gigacart.bl2 -sweep -mergefb -err automake.err -o gigacart.bl3 @gigacart.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci gigacart.lct -dev lc4k -diofft gigacart.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" gigacart.bl3 -family AMDMACH -idev van -o gigacart.bl4 -oxrf gigacart.xrf -err automake.err @gigacart.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci gigacart.lct -dev lc4k -prefit gigacart.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp gigacart.bl4 -out gigacart.bl5 -err automake.err -log gigacart.log -mod gigacart @gigacart.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open gigacart.rs1 w} rspFile] {
	puts stderr "Cannot create response file gigacart.rs1: $rspFile"
} else {
	puts $rspFile "-i gigacart.bl5 -lci gigacart.lct -d m4s_64_64 -lco gigacart.lco -html_rpt -fti gigacart.fti -fmt PLA -tto gigacart.tt4 -nojed -eqn gigacart.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open gigacart.rs2 w} rspFile] {
	puts stderr "Cannot create response file gigacart.rs2: $rspFile"
} else {
	puts $rspFile "-i gigacart.bl5 -lci gigacart.lct -d m4s_64_64 -lco gigacart.lco -html_rpt -fti gigacart.fti -fmt PLA -tto gigacart.tt4 -eqn gigacart.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@gigacart.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete gigacart.rs1
file delete gigacart.rs2
if [runCmd "\"$cpld_bin/tda\" -i gigacart.bl5 -o gigacart.tda -lci gigacart.lct -dev m4s_64_64 -family lc4k -mod gigacart -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj gigacart -if gigacart.jed -j2s -log gigacart.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 07/03/18 22:56:19 ###########


########## Tcl recorder starts at 07/03/18 23:07:02 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vhd2jhd\" design.vhd -o design.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 07/03/18 23:07:02 ###########


########## Tcl recorder starts at 07/03/18 23:07:07 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open gigacart.cmd w} rspFile] {
	puts stderr "Cannot create response file gigacart.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: gigacart.sty
PROJECT: gigacart
WORKING_PATH: \"$proj_dir\"
MODULE: gigacart
VHDL_FILE_LIST: design.vhd
OUTPUT_FILE_NAME: gigacart
SUFFIX_NAME: edi
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DEFAULT_ENUM_ENCODING: default
ARRANGE_VHDL_FILES: true
synthesis_onoff_pragma: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -e gigacart -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete gigacart.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf gigacart.edi -out gigacart.bl0 -err automake.err -log gigacart.log -prj gigacart -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" gigacart.bl0 -collapse none -reduce none -keepwires  -err automake.err -family"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"gigacart.bl1\" -o \"gigacart.bl2\" -omod \"gigacart\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj gigacart -lci gigacart.lct -log gigacart.imp -err automake.err -tti gigacart.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci gigacart.lct -blifopt gigacart.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" gigacart.bl2 -sweep -mergefb -err automake.err -o gigacart.bl3 @gigacart.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci gigacart.lct -dev lc4k -diofft gigacart.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" gigacart.bl3 -family AMDMACH -idev van -o gigacart.bl4 -oxrf gigacart.xrf -err automake.err @gigacart.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci gigacart.lct -dev lc4k -prefit gigacart.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp gigacart.bl4 -out gigacart.bl5 -err automake.err -log gigacart.log -mod gigacart @gigacart.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open gigacart.rs1 w} rspFile] {
	puts stderr "Cannot create response file gigacart.rs1: $rspFile"
} else {
	puts $rspFile "-i gigacart.bl5 -lci gigacart.lct -d m4s_64_64 -lco gigacart.lco -html_rpt -fti gigacart.fti -fmt PLA -tto gigacart.tt4 -nojed -eqn gigacart.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open gigacart.rs2 w} rspFile] {
	puts stderr "Cannot create response file gigacart.rs2: $rspFile"
} else {
	puts $rspFile "-i gigacart.bl5 -lci gigacart.lct -d m4s_64_64 -lco gigacart.lco -html_rpt -fti gigacart.fti -fmt PLA -tto gigacart.tt4 -eqn gigacart.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@gigacart.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete gigacart.rs1
file delete gigacart.rs2
if [runCmd "\"$cpld_bin/tda\" -i gigacart.bl5 -o gigacart.tda -lci gigacart.lct -dev m4s_64_64 -family lc4k -mod gigacart -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj gigacart -if gigacart.jed -j2s -log gigacart.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 07/03/18 23:07:07 ###########


########## Tcl recorder starts at 07/03/18 23:07:30 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vhd2jhd\" design.vhd -o design.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 07/03/18 23:07:30 ###########


########## Tcl recorder starts at 07/03/18 23:07:33 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open gigacart.cmd w} rspFile] {
	puts stderr "Cannot create response file gigacart.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: gigacart.sty
PROJECT: gigacart
WORKING_PATH: \"$proj_dir\"
MODULE: gigacart
VHDL_FILE_LIST: design.vhd
OUTPUT_FILE_NAME: gigacart
SUFFIX_NAME: edi
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DEFAULT_ENUM_ENCODING: default
ARRANGE_VHDL_FILES: true
synthesis_onoff_pragma: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -e gigacart -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete gigacart.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf gigacart.edi -out gigacart.bl0 -err automake.err -log gigacart.log -prj gigacart -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" gigacart.bl0 -collapse none -reduce none -keepwires  -err automake.err -family"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"gigacart.bl1\" -o \"gigacart.bl2\" -omod \"gigacart\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj gigacart -lci gigacart.lct -log gigacart.imp -err automake.err -tti gigacart.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci gigacart.lct -blifopt gigacart.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" gigacart.bl2 -sweep -mergefb -err automake.err -o gigacart.bl3 @gigacart.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci gigacart.lct -dev lc4k -diofft gigacart.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" gigacart.bl3 -family AMDMACH -idev van -o gigacart.bl4 -oxrf gigacart.xrf -err automake.err @gigacart.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci gigacart.lct -dev lc4k -prefit gigacart.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp gigacart.bl4 -out gigacart.bl5 -err automake.err -log gigacart.log -mod gigacart @gigacart.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open gigacart.rs1 w} rspFile] {
	puts stderr "Cannot create response file gigacart.rs1: $rspFile"
} else {
	puts $rspFile "-i gigacart.bl5 -lci gigacart.lct -d m4s_64_64 -lco gigacart.lco -html_rpt -fti gigacart.fti -fmt PLA -tto gigacart.tt4 -nojed -eqn gigacart.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open gigacart.rs2 w} rspFile] {
	puts stderr "Cannot create response file gigacart.rs2: $rspFile"
} else {
	puts $rspFile "-i gigacart.bl5 -lci gigacart.lct -d m4s_64_64 -lco gigacart.lco -html_rpt -fti gigacart.fti -fmt PLA -tto gigacart.tt4 -eqn gigacart.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@gigacart.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete gigacart.rs1
file delete gigacart.rs2
if [runCmd "\"$cpld_bin/tda\" -i gigacart.bl5 -o gigacart.tda -lci gigacart.lct -dev m4s_64_64 -family lc4k -mod gigacart -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj gigacart -if gigacart.jed -j2s -log gigacart.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 07/03/18 23:07:33 ###########


########## Tcl recorder starts at 07/03/18 23:12:00 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vhd2jhd\" design.vhd -o design.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 07/03/18 23:12:00 ###########


########## Tcl recorder starts at 07/03/18 23:12:09 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open gigacart.cmd w} rspFile] {
	puts stderr "Cannot create response file gigacart.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: gigacart.sty
PROJECT: gigacart
WORKING_PATH: \"$proj_dir\"
MODULE: gigacart
VHDL_FILE_LIST: design.vhd
OUTPUT_FILE_NAME: gigacart
SUFFIX_NAME: edi
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DEFAULT_ENUM_ENCODING: default
ARRANGE_VHDL_FILES: true
synthesis_onoff_pragma: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -e gigacart -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete gigacart.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf gigacart.edi -out gigacart.bl0 -err automake.err -log gigacart.log -prj gigacart -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" gigacart.bl0 -collapse none -reduce none -keepwires  -err automake.err -family"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"gigacart.bl1\" -o \"gigacart.bl2\" -omod \"gigacart\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj gigacart -lci gigacart.lct -log gigacart.imp -err automake.err -tti gigacart.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci gigacart.lct -blifopt gigacart.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" gigacart.bl2 -sweep -mergefb -err automake.err -o gigacart.bl3 @gigacart.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci gigacart.lct -dev lc4k -diofft gigacart.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" gigacart.bl3 -family AMDMACH -idev van -o gigacart.bl4 -oxrf gigacart.xrf -err automake.err @gigacart.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci gigacart.lct -dev lc4k -prefit gigacart.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp gigacart.bl4 -out gigacart.bl5 -err automake.err -log gigacart.log -mod gigacart @gigacart.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open gigacart.rs1 w} rspFile] {
	puts stderr "Cannot create response file gigacart.rs1: $rspFile"
} else {
	puts $rspFile "-i gigacart.bl5 -lci gigacart.lct -d m4s_64_64 -lco gigacart.lco -html_rpt -fti gigacart.fti -fmt PLA -tto gigacart.tt4 -nojed -eqn gigacart.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open gigacart.rs2 w} rspFile] {
	puts stderr "Cannot create response file gigacart.rs2: $rspFile"
} else {
	puts $rspFile "-i gigacart.bl5 -lci gigacart.lct -d m4s_64_64 -lco gigacart.lco -html_rpt -fti gigacart.fti -fmt PLA -tto gigacart.tt4 -eqn gigacart.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@gigacart.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete gigacart.rs1
file delete gigacart.rs2
if [runCmd "\"$cpld_bin/tda\" -i gigacart.bl5 -o gigacart.tda -lci gigacart.lct -dev m4s_64_64 -family lc4k -mod gigacart -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj gigacart -if gigacart.jed -j2s -log gigacart.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 07/03/18 23:12:09 ###########


########## Tcl recorder starts at 07/03/18 23:13:13 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vhd2jhd\" design.vhd -o design.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 07/03/18 23:13:13 ###########


########## Tcl recorder starts at 07/03/18 23:16:43 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vhd2jhd\" design.vhd -o design.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 07/03/18 23:16:43 ###########


########## Tcl recorder starts at 07/03/18 23:16:46 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open gigacart.cmd w} rspFile] {
	puts stderr "Cannot create response file gigacart.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: gigacart.sty
PROJECT: gigacart
WORKING_PATH: \"$proj_dir\"
MODULE: gigacart
VHDL_FILE_LIST: design.vhd
OUTPUT_FILE_NAME: gigacart
SUFFIX_NAME: edi
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DEFAULT_ENUM_ENCODING: default
ARRANGE_VHDL_FILES: true
synthesis_onoff_pragma: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -e gigacart -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete gigacart.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf gigacart.edi -out gigacart.bl0 -err automake.err -log gigacart.log -prj gigacart -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" gigacart.bl0 -collapse none -reduce none -keepwires  -err automake.err -family"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"gigacart.bl1\" -o \"gigacart.bl2\" -omod \"gigacart\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj gigacart -lci gigacart.lct -log gigacart.imp -err automake.err -tti gigacart.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci gigacart.lct -blifopt gigacart.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" gigacart.bl2 -sweep -mergefb -err automake.err -o gigacart.bl3 @gigacart.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci gigacart.lct -dev lc4k -diofft gigacart.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" gigacart.bl3 -family AMDMACH -idev van -o gigacart.bl4 -oxrf gigacart.xrf -err automake.err @gigacart.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci gigacart.lct -dev lc4k -prefit gigacart.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp gigacart.bl4 -out gigacart.bl5 -err automake.err -log gigacart.log -mod gigacart @gigacart.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open gigacart.rs1 w} rspFile] {
	puts stderr "Cannot create response file gigacart.rs1: $rspFile"
} else {
	puts $rspFile "-i gigacart.bl5 -lci gigacart.lct -d m4s_64_64 -lco gigacart.lco -html_rpt -fti gigacart.fti -fmt PLA -tto gigacart.tt4 -nojed -eqn gigacart.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open gigacart.rs2 w} rspFile] {
	puts stderr "Cannot create response file gigacart.rs2: $rspFile"
} else {
	puts $rspFile "-i gigacart.bl5 -lci gigacart.lct -d m4s_64_64 -lco gigacart.lco -html_rpt -fti gigacart.fti -fmt PLA -tto gigacart.tt4 -eqn gigacart.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@gigacart.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete gigacart.rs1
file delete gigacart.rs2
if [runCmd "\"$cpld_bin/tda\" -i gigacart.bl5 -o gigacart.tda -lci gigacart.lct -dev m4s_64_64 -family lc4k -mod gigacart -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj gigacart -if gigacart.jed -j2s -log gigacart.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 07/03/18 23:16:46 ###########


########## Tcl recorder starts at 07/03/18 23:17:12 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vhd2jhd\" design.vhd -o design.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 07/03/18 23:17:12 ###########


########## Tcl recorder starts at 07/03/18 23:17:16 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open gigacart.cmd w} rspFile] {
	puts stderr "Cannot create response file gigacart.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: gigacart.sty
PROJECT: gigacart
WORKING_PATH: \"$proj_dir\"
MODULE: gigacart
VHDL_FILE_LIST: design.vhd
OUTPUT_FILE_NAME: gigacart
SUFFIX_NAME: edi
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DEFAULT_ENUM_ENCODING: default
ARRANGE_VHDL_FILES: true
synthesis_onoff_pragma: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -e gigacart -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete gigacart.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf gigacart.edi -out gigacart.bl0 -err automake.err -log gigacart.log -prj gigacart -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" gigacart.bl0 -collapse none -reduce none -keepwires  -err automake.err -family"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"gigacart.bl1\" -o \"gigacart.bl2\" -omod \"gigacart\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj gigacart -lci gigacart.lct -log gigacart.imp -err automake.err -tti gigacart.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci gigacart.lct -blifopt gigacart.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" gigacart.bl2 -sweep -mergefb -err automake.err -o gigacart.bl3 @gigacart.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci gigacart.lct -dev lc4k -diofft gigacart.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" gigacart.bl3 -family AMDMACH -idev van -o gigacart.bl4 -oxrf gigacart.xrf -err automake.err @gigacart.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci gigacart.lct -dev lc4k -prefit gigacart.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp gigacart.bl4 -out gigacart.bl5 -err automake.err -log gigacart.log -mod gigacart @gigacart.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open gigacart.rs1 w} rspFile] {
	puts stderr "Cannot create response file gigacart.rs1: $rspFile"
} else {
	puts $rspFile "-i gigacart.bl5 -lci gigacart.lct -d m4s_64_64 -lco gigacart.lco -html_rpt -fti gigacart.fti -fmt PLA -tto gigacart.tt4 -nojed -eqn gigacart.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open gigacart.rs2 w} rspFile] {
	puts stderr "Cannot create response file gigacart.rs2: $rspFile"
} else {
	puts $rspFile "-i gigacart.bl5 -lci gigacart.lct -d m4s_64_64 -lco gigacart.lco -html_rpt -fti gigacart.fti -fmt PLA -tto gigacart.tt4 -eqn gigacart.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@gigacart.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete gigacart.rs1
file delete gigacart.rs2
if [runCmd "\"$cpld_bin/tda\" -i gigacart.bl5 -o gigacart.tda -lci gigacart.lct -dev m4s_64_64 -family lc4k -mod gigacart -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj gigacart -if gigacart.jed -j2s -log gigacart.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 07/03/18 23:17:16 ###########


########## Tcl recorder starts at 07/03/18 23:21:58 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vhd2jhd\" design.vhd -o design.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 07/03/18 23:21:58 ###########


########## Tcl recorder starts at 07/03/18 23:22:05 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open gigacart.cmd w} rspFile] {
	puts stderr "Cannot create response file gigacart.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: gigacart.sty
PROJECT: gigacart
WORKING_PATH: \"$proj_dir\"
MODULE: gigacart
VHDL_FILE_LIST: design.vhd
OUTPUT_FILE_NAME: gigacart
SUFFIX_NAME: edi
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DEFAULT_ENUM_ENCODING: default
ARRANGE_VHDL_FILES: true
synthesis_onoff_pragma: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -e gigacart -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete gigacart.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf gigacart.edi -out gigacart.bl0 -err automake.err -log gigacart.log -prj gigacart -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" gigacart.bl0 -collapse none -reduce none -keepwires  -err automake.err -family"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"gigacart.bl1\" -o \"gigacart.bl2\" -omod \"gigacart\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj gigacart -lci gigacart.lct -log gigacart.imp -err automake.err -tti gigacart.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci gigacart.lct -blifopt gigacart.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" gigacart.bl2 -sweep -mergefb -err automake.err -o gigacart.bl3 @gigacart.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci gigacart.lct -dev lc4k -diofft gigacart.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" gigacart.bl3 -family AMDMACH -idev van -o gigacart.bl4 -oxrf gigacart.xrf -err automake.err @gigacart.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci gigacart.lct -dev lc4k -prefit gigacart.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp gigacart.bl4 -out gigacart.bl5 -err automake.err -log gigacart.log -mod gigacart @gigacart.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open gigacart.rs1 w} rspFile] {
	puts stderr "Cannot create response file gigacart.rs1: $rspFile"
} else {
	puts $rspFile "-i gigacart.bl5 -lci gigacart.lct -d m4s_64_64 -lco gigacart.lco -html_rpt -fti gigacart.fti -fmt PLA -tto gigacart.tt4 -nojed -eqn gigacart.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open gigacart.rs2 w} rspFile] {
	puts stderr "Cannot create response file gigacart.rs2: $rspFile"
} else {
	puts $rspFile "-i gigacart.bl5 -lci gigacart.lct -d m4s_64_64 -lco gigacart.lco -html_rpt -fti gigacart.fti -fmt PLA -tto gigacart.tt4 -eqn gigacart.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@gigacart.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete gigacart.rs1
file delete gigacart.rs2
if [runCmd "\"$cpld_bin/tda\" -i gigacart.bl5 -o gigacart.tda -lci gigacart.lct -dev m4s_64_64 -family lc4k -mod gigacart -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj gigacart -if gigacart.jed -j2s -log gigacart.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 07/03/18 23:22:05 ###########


########## Tcl recorder starts at 07/03/18 23:22:37 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vhd2jhd\" design.vhd -o design.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 07/03/18 23:22:37 ###########


########## Tcl recorder starts at 07/03/18 23:22:40 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open gigacart.cmd w} rspFile] {
	puts stderr "Cannot create response file gigacart.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: gigacart.sty
PROJECT: gigacart
WORKING_PATH: \"$proj_dir\"
MODULE: gigacart
VHDL_FILE_LIST: design.vhd
OUTPUT_FILE_NAME: gigacart
SUFFIX_NAME: edi
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DEFAULT_ENUM_ENCODING: default
ARRANGE_VHDL_FILES: true
synthesis_onoff_pragma: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -e gigacart -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete gigacart.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf gigacart.edi -out gigacart.bl0 -err automake.err -log gigacart.log -prj gigacart -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" gigacart.bl0 -collapse none -reduce none -keepwires  -err automake.err -family"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"gigacart.bl1\" -o \"gigacart.bl2\" -omod \"gigacart\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj gigacart -lci gigacart.lct -log gigacart.imp -err automake.err -tti gigacart.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci gigacart.lct -blifopt gigacart.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" gigacart.bl2 -sweep -mergefb -err automake.err -o gigacart.bl3 @gigacart.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci gigacart.lct -dev lc4k -diofft gigacart.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" gigacart.bl3 -family AMDMACH -idev van -o gigacart.bl4 -oxrf gigacart.xrf -err automake.err @gigacart.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci gigacart.lct -dev lc4k -prefit gigacart.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp gigacart.bl4 -out gigacart.bl5 -err automake.err -log gigacart.log -mod gigacart @gigacart.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open gigacart.rs1 w} rspFile] {
	puts stderr "Cannot create response file gigacart.rs1: $rspFile"
} else {
	puts $rspFile "-i gigacart.bl5 -lci gigacart.lct -d m4s_64_64 -lco gigacart.lco -html_rpt -fti gigacart.fti -fmt PLA -tto gigacart.tt4 -nojed -eqn gigacart.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open gigacart.rs2 w} rspFile] {
	puts stderr "Cannot create response file gigacart.rs2: $rspFile"
} else {
	puts $rspFile "-i gigacart.bl5 -lci gigacart.lct -d m4s_64_64 -lco gigacart.lco -html_rpt -fti gigacart.fti -fmt PLA -tto gigacart.tt4 -eqn gigacart.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@gigacart.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete gigacart.rs1
file delete gigacart.rs2
if [runCmd "\"$cpld_bin/tda\" -i gigacart.bl5 -o gigacart.tda -lci gigacart.lct -dev m4s_64_64 -family lc4k -mod gigacart -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj gigacart -if gigacart.jed -j2s -log gigacart.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 07/03/18 23:22:40 ###########


########## Tcl recorder starts at 07/03/18 23:23:20 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vhd2jhd\" design.vhd -o design.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 07/03/18 23:23:20 ###########


########## Tcl recorder starts at 07/03/18 23:23:24 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open gigacart.cmd w} rspFile] {
	puts stderr "Cannot create response file gigacart.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: gigacart.sty
PROJECT: gigacart
WORKING_PATH: \"$proj_dir\"
MODULE: gigacart
VHDL_FILE_LIST: design.vhd
OUTPUT_FILE_NAME: gigacart
SUFFIX_NAME: edi
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DEFAULT_ENUM_ENCODING: default
ARRANGE_VHDL_FILES: true
synthesis_onoff_pragma: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -e gigacart -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete gigacart.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf gigacart.edi -out gigacart.bl0 -err automake.err -log gigacart.log -prj gigacart -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" gigacart.bl0 -collapse none -reduce none -keepwires  -err automake.err -family"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"gigacart.bl1\" -o \"gigacart.bl2\" -omod \"gigacart\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj gigacart -lci gigacart.lct -log gigacart.imp -err automake.err -tti gigacart.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci gigacart.lct -blifopt gigacart.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" gigacart.bl2 -sweep -mergefb -err automake.err -o gigacart.bl3 @gigacart.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci gigacart.lct -dev lc4k -diofft gigacart.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" gigacart.bl3 -family AMDMACH -idev van -o gigacart.bl4 -oxrf gigacart.xrf -err automake.err @gigacart.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci gigacart.lct -dev lc4k -prefit gigacart.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp gigacart.bl4 -out gigacart.bl5 -err automake.err -log gigacart.log -mod gigacart @gigacart.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open gigacart.rs1 w} rspFile] {
	puts stderr "Cannot create response file gigacart.rs1: $rspFile"
} else {
	puts $rspFile "-i gigacart.bl5 -lci gigacart.lct -d m4s_64_64 -lco gigacart.lco -html_rpt -fti gigacart.fti -fmt PLA -tto gigacart.tt4 -nojed -eqn gigacart.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open gigacart.rs2 w} rspFile] {
	puts stderr "Cannot create response file gigacart.rs2: $rspFile"
} else {
	puts $rspFile "-i gigacart.bl5 -lci gigacart.lct -d m4s_64_64 -lco gigacart.lco -html_rpt -fti gigacart.fti -fmt PLA -tto gigacart.tt4 -eqn gigacart.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@gigacart.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete gigacart.rs1
file delete gigacart.rs2
if [runCmd "\"$cpld_bin/tda\" -i gigacart.bl5 -o gigacart.tda -lci gigacart.lct -dev m4s_64_64 -family lc4k -mod gigacart -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj gigacart -if gigacart.jed -j2s -log gigacart.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 07/03/18 23:23:24 ###########


########## Tcl recorder starts at 07/03/18 23:25:05 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vhd2jhd\" design.vhd -o design.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 07/03/18 23:25:05 ###########


########## Tcl recorder starts at 07/03/18 23:25:09 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open gigacart.cmd w} rspFile] {
	puts stderr "Cannot create response file gigacart.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: gigacart.sty
PROJECT: gigacart
WORKING_PATH: \"$proj_dir\"
MODULE: gigacart
VHDL_FILE_LIST: design.vhd
OUTPUT_FILE_NAME: gigacart
SUFFIX_NAME: edi
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DEFAULT_ENUM_ENCODING: default
ARRANGE_VHDL_FILES: true
synthesis_onoff_pragma: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -e gigacart -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete gigacart.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf gigacart.edi -out gigacart.bl0 -err automake.err -log gigacart.log -prj gigacart -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" gigacart.bl0 -collapse none -reduce none -keepwires  -err automake.err -family"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"gigacart.bl1\" -o \"gigacart.bl2\" -omod \"gigacart\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj gigacart -lci gigacart.lct -log gigacart.imp -err automake.err -tti gigacart.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci gigacart.lct -blifopt gigacart.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" gigacart.bl2 -sweep -mergefb -err automake.err -o gigacart.bl3 @gigacart.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci gigacart.lct -dev lc4k -diofft gigacart.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" gigacart.bl3 -family AMDMACH -idev van -o gigacart.bl4 -oxrf gigacart.xrf -err automake.err @gigacart.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci gigacart.lct -dev lc4k -prefit gigacart.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp gigacart.bl4 -out gigacart.bl5 -err automake.err -log gigacart.log -mod gigacart @gigacart.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open gigacart.rs1 w} rspFile] {
	puts stderr "Cannot create response file gigacart.rs1: $rspFile"
} else {
	puts $rspFile "-i gigacart.bl5 -lci gigacart.lct -d m4s_64_64 -lco gigacart.lco -html_rpt -fti gigacart.fti -fmt PLA -tto gigacart.tt4 -nojed -eqn gigacart.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open gigacart.rs2 w} rspFile] {
	puts stderr "Cannot create response file gigacart.rs2: $rspFile"
} else {
	puts $rspFile "-i gigacart.bl5 -lci gigacart.lct -d m4s_64_64 -lco gigacart.lco -html_rpt -fti gigacart.fti -fmt PLA -tto gigacart.tt4 -eqn gigacart.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@gigacart.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete gigacart.rs1
file delete gigacart.rs2
if [runCmd "\"$cpld_bin/tda\" -i gigacart.bl5 -o gigacart.tda -lci gigacart.lct -dev m4s_64_64 -family lc4k -mod gigacart -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj gigacart -if gigacart.jed -j2s -log gigacart.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 07/03/18 23:25:09 ###########


########## Tcl recorder starts at 07/03/18 23:27:29 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vhd2jhd\" design.vhd -o design.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 07/03/18 23:27:29 ###########


########## Tcl recorder starts at 07/03/18 23:27:33 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open gigacart.cmd w} rspFile] {
	puts stderr "Cannot create response file gigacart.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: gigacart.sty
PROJECT: gigacart
WORKING_PATH: \"$proj_dir\"
MODULE: gigacart
VHDL_FILE_LIST: design.vhd
OUTPUT_FILE_NAME: gigacart
SUFFIX_NAME: edi
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DEFAULT_ENUM_ENCODING: default
ARRANGE_VHDL_FILES: true
synthesis_onoff_pragma: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -e gigacart -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete gigacart.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf gigacart.edi -out gigacart.bl0 -err automake.err -log gigacart.log -prj gigacart -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" gigacart.bl0 -collapse none -reduce none -keepwires  -err automake.err -family"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"gigacart.bl1\" -o \"gigacart.bl2\" -omod \"gigacart\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj gigacart -lci gigacart.lct -log gigacart.imp -err automake.err -tti gigacart.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci gigacart.lct -blifopt gigacart.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" gigacart.bl2 -sweep -mergefb -err automake.err -o gigacart.bl3 @gigacart.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci gigacart.lct -dev lc4k -diofft gigacart.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" gigacart.bl3 -family AMDMACH -idev van -o gigacart.bl4 -oxrf gigacart.xrf -err automake.err @gigacart.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci gigacart.lct -dev lc4k -prefit gigacart.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp gigacart.bl4 -out gigacart.bl5 -err automake.err -log gigacart.log -mod gigacart @gigacart.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open gigacart.rs1 w} rspFile] {
	puts stderr "Cannot create response file gigacart.rs1: $rspFile"
} else {
	puts $rspFile "-i gigacart.bl5 -lci gigacart.lct -d m4s_64_64 -lco gigacart.lco -html_rpt -fti gigacart.fti -fmt PLA -tto gigacart.tt4 -nojed -eqn gigacart.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open gigacart.rs2 w} rspFile] {
	puts stderr "Cannot create response file gigacart.rs2: $rspFile"
} else {
	puts $rspFile "-i gigacart.bl5 -lci gigacart.lct -d m4s_64_64 -lco gigacart.lco -html_rpt -fti gigacart.fti -fmt PLA -tto gigacart.tt4 -eqn gigacart.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@gigacart.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete gigacart.rs1
file delete gigacart.rs2
if [runCmd "\"$cpld_bin/tda\" -i gigacart.bl5 -o gigacart.tda -lci gigacart.lct -dev m4s_64_64 -family lc4k -mod gigacart -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj gigacart -if gigacart.jed -j2s -log gigacart.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 07/03/18 23:27:33 ###########

