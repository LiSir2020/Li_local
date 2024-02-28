# 
# Synthesis run script generated by Vivado
# 

set TIME_start [clock seconds] 
proc create_report { reportName command } {
  set status "."
  append status $reportName ".fail"
  if { [file exists $status] } {
    eval file delete [glob $status]
  }
  send_msg_id runtcl-4 info "Executing : $command"
  set retval [eval catch { $command } msg]
  if { $retval != 0 } {
    set fp [open $status w]
    close $fp
    send_msg_id runtcl-5 warning "$msg"
  }
}
set_param synth.incrementalSynthesisCache C:/Users/Fakers/AppData/Roaming/Xilinx/Vivado/.Xil/Vivado-30980-Li-Jun-Computer/incrSyn
set_param xicom.use_bs_reader 1
set_msg_config -id {Synth 8-256} -limit 10000
set_msg_config -id {Synth 8-638} -limit 10000
set_msg_config  -id {VRFC 10-3091}  -string {{WARNING: [VRFC 10-3091] actual bit length 1 differs from formal bit length 32 for port 'Instr' [E:/vivado-works/some_cycle_MIPS/some_cycle_MIPS.srcs/sources_1/new/mips.sv:25]}}  -suppress 
create_project -in_memory -part xc7a100tcsg324-1

set_param project.singleFileAddWarning.threshold 0
set_param project.compositeFile.enableAutoGeneration 0
set_param synth.vivado.isSynthRun true
set_property webtalk.parent_dir E:/vivado-works/some_cycle_MIPS/some_cycle_MIPS.cache/wt [current_project]
set_property parent.project_path E:/vivado-works/some_cycle_MIPS/some_cycle_MIPS.xpr [current_project]
set_property default_lib xil_defaultlib [current_project]
set_property target_language Verilog [current_project]
set_property ip_output_repo e:/vivado-works/some_cycle_MIPS/some_cycle_MIPS.cache/ip [current_project]
set_property ip_cache_permissions {read write} [current_project]
read_mem {
  E:/vivado-works/some_cycle_MIPS/some_cycle_MIPS.srcs/sources_1/imports/Desktop/fuc_second.dat
  E:/vivado-works/some_cycle_MIPS/some_cycle_MIPS.srcs/sources_1/imports/Desktop/fuc_third.dat
  E:/vivado-works/some_cycle_MIPS/some_cycle_MIPS.srcs/sources_1/imports/Desktop/fuc_teio.dat
}
read_verilog -library xil_defaultlib -sv {
  E:/vivado-works/some_cycle_MIPS/some_cycle_MIPS.srcs/sources_1/new/DataMemoryDecoder.sv
  E:/vivado-works/some_cycle_MIPS/some_cycle_MIPS.srcs/sources_1/new/Hex7Seg.sv
  E:/vivado-works/some_cycle_MIPS/some_cycle_MIPS.srcs/sources_1/new/IDmem.sv
  E:/vivado-works/some_cycle_MIPS/some_cycle_MIPS.srcs/sources_1/new/IO.sv
  E:/vivado-works/some_cycle_MIPS/some_cycle_MIPS.srcs/sources_1/new/alu.sv
  E:/vivado-works/some_cycle_MIPS/some_cycle_MIPS.srcs/sources_1/new/aludec.sv
  E:/vivado-works/some_cycle_MIPS/some_cycle_MIPS.srcs/sources_1/new/controller.sv
  E:/vivado-works/some_cycle_MIPS/some_cycle_MIPS.srcs/sources_1/new/datapath.sv
  E:/vivado-works/some_cycle_MIPS/some_cycle_MIPS.srcs/sources_1/new/flopenr.sv
  E:/vivado-works/some_cycle_MIPS/some_cycle_MIPS.srcs/sources_1/new/maindec.sv
  E:/vivado-works/some_cycle_MIPS/some_cycle_MIPS.srcs/sources_1/new/mips.sv
  E:/vivado-works/some_cycle_MIPS/some_cycle_MIPS.srcs/sources_1/new/mux2_MemToReg_32.sv
  E:/vivado-works/some_cycle_MIPS/some_cycle_MIPS.srcs/sources_1/new/mux2_RegDst.sv
  E:/vivado-works/some_cycle_MIPS/some_cycle_MIPS.srcs/sources_1/new/mux3_PCsrc_32.sv
  E:/vivado-works/some_cycle_MIPS/some_cycle_MIPS.srcs/sources_1/new/mux4_ALUsrb_32.sv
  E:/vivado-works/some_cycle_MIPS/some_cycle_MIPS.srcs/sources_1/new/reg_AB.sv
  E:/vivado-works/some_cycle_MIPS/some_cycle_MIPS.srcs/sources_1/new/reg_Instr.sv
  E:/vivado-works/some_cycle_MIPS/some_cycle_MIPS.srcs/sources_1/new/reg_alu.sv
  E:/vivado-works/some_cycle_MIPS/some_cycle_MIPS.srcs/sources_1/new/reg_data.sv
  E:/vivado-works/some_cycle_MIPS/some_cycle_MIPS.srcs/sources_1/new/regfile.sv
  E:/vivado-works/some_cycle_MIPS/some_cycle_MIPS.srcs/sources_1/new/signext.sv
  E:/vivado-works/some_cycle_MIPS/some_cycle_MIPS.srcs/sources_1/new/sl2.sv
  E:/vivado-works/some_cycle_MIPS/some_cycle_MIPS.srcs/sources_1/new/x7seg.sv
  E:/vivado-works/some_cycle_MIPS/some_cycle_MIPS.srcs/sources_1/new/ze_expend.sv
  E:/vivado-works/some_cycle_MIPS/some_cycle_MIPS.srcs/sources_1/new/Top.sv
}
# Mark all dcp files as not used in implementation to prevent them from being
# stitched into the results of this synthesis run. Any black boxes in the
# design are intentionally left as such for best results. Dcp files will be
# stitched into the design at a later time, either when this synthesis run is
# opened, or when it is stitched into a dependent implementation run.
foreach dcp [get_files -quiet -all -filter file_type=="Design\ Checkpoint"] {
  set_property used_in_implementation false $dcp
}
read_xdc E:/vivado-works/some_cycle_MIPS/some_cycle_MIPS.srcs/constrs_1/new/con_som_mips.xdc
set_property used_in_implementation false [get_files E:/vivado-works/some_cycle_MIPS/some_cycle_MIPS.srcs/constrs_1/new/con_som_mips.xdc]

set_param ips.enableIPCacheLiteLoad 1
close [open __synthesis_is_running__ w]

synth_design -top Top -part xc7a100tcsg324-1


# disable binary constraint mode for synth run checkpoints
set_param constraints.enableBinaryConstraints false
write_checkpoint -force -noxdef Top.dcp
create_report "synth_1_synth_report_utilization_0" "report_utilization -file Top_utilization_synth.rpt -pb Top_utilization_synth.pb"
file delete __synthesis_is_running__
close [open __synthesis_is_complete__ w]
