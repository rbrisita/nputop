#!/usr/bin/env bash

############################################################
# Read and parse info to create NPU observability.
# Author: Robert Brisita @rbrisita
# License: Apache-2.0
############################################################

source ./simple_curses.sh

version=""
name=""

load_file=""

temp=""

cur_freq=""
governor=""
load=""

async=""
control=""
runtime_active_kids=""
runtime_active_time=""
runtime_enabled=""
runtime_status=""
runtime_suspended_time=""
runtime_usage=""

info() {
  version=$(cat /proc/rknpu/version)
  name=$(cat /sys/class/devfreq/fdab0000.npu/name)
}

load() {
  load_file=$(cat /proc/rknpu/load | awk -F 'NPU load: ' '{print $2}' | awk '{gsub(",", "|", $0); print}')
}

temp() {
  temp=$(sensors | grep -A 3 'npu_thermal-virtual-0' | grep 'temp1' | awk '{print $2}')
}

details() {
  cur_freq=$(cat /sys/class/devfreq/fdab0000.npu/cur_freq)
  governor=$(cat /sys/class/devfreq/fdab0000.npu/governor)
  load=$(cat /sys/class/devfreq/fdab0000.npu/load)
}

power() {
  async=$(cat /sys/class/devfreq/fdab0000.npu/power/async)
  control=$(cat /sys/class/devfreq/fdab0000.npu/power/control)
  runtime_active_kids=$(cat /sys/class/devfreq/fdab0000.npu/power/runtime_active_kids)
  runtime_active_time=$(cat /sys/class/devfreq/fdab0000.npu/power/runtime_active_time)
  runtime_enabled=$(cat /sys/class/devfreq/fdab0000.npu/power/runtime_enabled)
  runtime_status=$(cat /sys/class/devfreq/fdab0000.npu/power/runtime_status)
  runtime_suspended_time=$(cat /sys/class/devfreq/fdab0000.npu/power/runtime_suspended_time)
  runtime_usage=$(cat /sys/class/devfreq/fdab0000.npu/power/runtime_usage)
}

main() {
  # Create gutter
  window "Rockchip RK3588 CPU" "green" "20%"
  endwin

  # Move on the next column
  col_right

  # Create main window
  window "NPU Top" "green" "50%"
    append "$version ($name)"
    addsep
    append "Load"
    append_tabbed "$load_file" 3 "|"
    addsep
    append "Temperature"
    append "$temp"
    addsep
    append "Details"
    append_tabbed "Frequency: $cur_freq" 2 ":"
    append_tabbed "Govenor: $governor" 2 ":"
    append_tabbed "Load: $load" 2 ":"
    addsep
    append "Power"
    append_tabbed "Async: $async" 2 ":"
    append_tabbed "Control: $control" 2 ":"
    append_tabbed "Active Kids: $runtime_active_kids" 2 ":"
    append_tabbed "Active Time: $runtime_active_time" 2 ":"
    append_tabbed "Enabled: $runtime_enabled" 2 ":"
    append_tabbed "Status: $runtime_status" 2 ":"
    append_tabbed "Suspend Time: $runtime_suspended_time" 2 ":"
    append_tabbed "Usage: $runtime_usage" 2 ":"
  endwin

  # Move on the next column
  col_right

  # Create gutter
  window "Made with Bash Simple Curses" "green" "20%"
  endwin
}

update() {
  info
  load
  temp
  details
  power
}

update
main_loop
