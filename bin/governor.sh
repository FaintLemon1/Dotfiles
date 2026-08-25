#!/usr/bin/env bash
if [[ "$1" == "performance" ]]; then
  sudo cpupower frequency-set -g performance
else
  sudo cpupower frequency-set -g powersave
fi
