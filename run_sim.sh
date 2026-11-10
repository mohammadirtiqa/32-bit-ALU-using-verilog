#!/usr/bin/env sh
set -eu
cd "$(dirname "$0")"
mkdir -p sim
iverilog -g2005 -Wall -o sim/alu_sim rtl/alu_32bit.v tb/tb_alu_32bit.v
vvp sim/alu_sim | tee sim/alu_sim.log
