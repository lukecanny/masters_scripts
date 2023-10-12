# 
# Report generation script generated by Vivado
# 

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
proc start_step { step } {
  set stopFile ".stop.rst"
  if {[file isfile .stop.rst]} {
    puts ""
    puts "*** Halting run - EA reset detected ***"
    puts ""
    puts ""
    return -code error
  }
  set beginFile ".$step.begin.rst"
  set platform "$::tcl_platform(platform)"
  set user "$::tcl_platform(user)"
  set pid [pid]
  set host ""
  if { [string equal $platform unix] } {
    if { [info exist ::env(HOSTNAME)] } {
      set host $::env(HOSTNAME)
    }
  } else {
    if { [info exist ::env(COMPUTERNAME)] } {
      set host $::env(COMPUTERNAME)
    }
  }
  set ch [open $beginFile w]
  puts $ch "<?xml version=\"1.0\"?>"
  puts $ch "<ProcessHandle Version=\"1\" Minor=\"0\">"
  puts $ch "    <Process Command=\".planAhead.\" Owner=\"$user\" Host=\"$host\" Pid=\"$pid\">"
  puts $ch "    </Process>"
  puts $ch "</ProcessHandle>"
  close $ch
}

proc end_step { step } {
  set endFile ".$step.end.rst"
  set ch [open $endFile w]
  close $ch
}

proc step_failed { step } {
  set endFile ".$step.error.rst"
  set ch [open $endFile w]
  close $ch
}


start_step init_design
set ACTIVE_STEP init_design
set rc [catch {
  create_msg_db init_design.pb
  set_param chipscope.maxJobs 1
  create_project -in_memory -part xc7z020clg400-1
  set_property board_part tul.com.tw:pynq-z2:part0:1.0 [current_project]
  set_property design_mode GateLvl [current_fileset]
  set_param project.singleFileAddWarning.threshold 0
  set_property webtalk.parent_dir D:/Vivado/cb4cled-jn-application_cleaned/CB4CLED/vhdl/xilinxprj/CB4CLED_Top.cache/wt [current_project]
  set_property parent.project_path D:/Vivado/cb4cled-jn-application_cleaned/CB4CLED/vhdl/xilinxprj/CB4CLED_Top.xpr [current_project]
  set_property ip_output_repo D:/Vivado/cb4cled-jn-application_cleaned/CB4CLED/vhdl/xilinxprj/CB4CLED_Top.cache/ip [current_project]
  set_property ip_cache_permissions {read write} [current_project]
  add_files -quiet D:/Vivado/cb4cled-jn-application_cleaned/CB4CLED/vhdl/xilinxprj/CB4CLED_Top.runs/synth_2/CB4CLED_Top.dcp
  read_xdc D:/Vivado/cb4cled-jn-application_cleaned/CB4CLED/vhdl/xilinxprj/CB4CLED_Top.srcs/constrs_1/imports/pynq-z2_v1.0.xdc/physical_constr.xdc
  link_design -top CB4CLED_Top -part xc7z020clg400-1
  close_msg_db -file init_design.pb
} RESULT]
if {$rc} {
  step_failed init_design
  return -code error $RESULT
} else {
  end_step init_design
  unset ACTIVE_STEP 
}

start_step opt_design
set ACTIVE_STEP opt_design
set rc [catch {
  create_msg_db opt_design.pb
  opt_design 
  write_checkpoint -force CB4CLED_Top_opt.dcp
  create_report "impl_2_opt_report_drc_0" "report_drc -file CB4CLED_Top_drc_opted.rpt -pb CB4CLED_Top_drc_opted.pb -rpx CB4CLED_Top_drc_opted.rpx"
  close_msg_db -file opt_design.pb
} RESULT]
if {$rc} {
  step_failed opt_design
  return -code error $RESULT
} else {
  end_step opt_design
  unset ACTIVE_STEP 
}

start_step place_design
set ACTIVE_STEP place_design
set rc [catch {
  create_msg_db place_design.pb
  if { [llength [get_debug_cores -quiet] ] > 0 }  { 
    implement_debug_core 
  } 
  place_design 
  write_checkpoint -force CB4CLED_Top_placed.dcp
  create_report "impl_2_place_report_io_0" "report_io -file CB4CLED_Top_io_placed.rpt"
  create_report "impl_2_place_report_utilization_0" "report_utilization -file CB4CLED_Top_utilization_placed.rpt -pb CB4CLED_Top_utilization_placed.pb"
  create_report "impl_2_place_report_control_sets_0" "report_control_sets -verbose -file CB4CLED_Top_control_sets_placed.rpt"
  close_msg_db -file place_design.pb
} RESULT]
if {$rc} {
  step_failed place_design
  return -code error $RESULT
} else {
  end_step place_design
  unset ACTIVE_STEP 
}

start_step route_design
set ACTIVE_STEP route_design
set rc [catch {
  create_msg_db route_design.pb
  route_design 
  write_checkpoint -force CB4CLED_Top_routed.dcp
  create_report "impl_2_route_report_drc_0" "report_drc -file CB4CLED_Top_drc_routed.rpt -pb CB4CLED_Top_drc_routed.pb -rpx CB4CLED_Top_drc_routed.rpx"
  create_report "impl_2_route_report_methodology_0" "report_methodology -file CB4CLED_Top_methodology_drc_routed.rpt -pb CB4CLED_Top_methodology_drc_routed.pb -rpx CB4CLED_Top_methodology_drc_routed.rpx"
  create_report "impl_2_route_report_power_0" "report_power -file CB4CLED_Top_power_routed.rpt -pb CB4CLED_Top_power_summary_routed.pb -rpx CB4CLED_Top_power_routed.rpx"
  create_report "impl_2_route_report_route_status_0" "report_route_status -file CB4CLED_Top_route_status.rpt -pb CB4CLED_Top_route_status.pb"
  create_report "impl_2_route_report_timing_summary_0" "report_timing_summary -max_paths 10 -file CB4CLED_Top_timing_summary_routed.rpt -pb CB4CLED_Top_timing_summary_routed.pb -rpx CB4CLED_Top_timing_summary_routed.rpx -warn_on_violation "
  create_report "impl_2_route_report_incremental_reuse_0" "report_incremental_reuse -file CB4CLED_Top_incremental_reuse_routed.rpt"
  create_report "impl_2_route_report_clock_utilization_0" "report_clock_utilization -file CB4CLED_Top_clock_utilization_routed.rpt"
  create_report "impl_2_route_report_bus_skew_0" "report_bus_skew -warn_on_violation -file CB4CLED_Top_bus_skew_routed.rpt -pb CB4CLED_Top_bus_skew_routed.pb -rpx CB4CLED_Top_bus_skew_routed.rpx"
  close_msg_db -file route_design.pb
} RESULT]
if {$rc} {
  write_checkpoint -force CB4CLED_Top_routed_error.dcp
  step_failed route_design
  return -code error $RESULT
} else {
  end_step route_design
  unset ACTIVE_STEP 
}

