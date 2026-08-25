#!/usr/bin/env bash
echo "$1" | sudo tee /sys/firmware/acpi/platform_profile
