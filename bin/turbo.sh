#!/usr/bin/env bash
if [[ "$1" == "off" ]]; then
  echo 1 | sudo tee /sys/devices/system/cpu/intel_pstate/no_turbo
else
  echo 0 | sudo tee /sys/devices/system/cpu/intel_pstate/no_turbo
fi
