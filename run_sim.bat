@echo off
cd /d "%~dp0"
if not exist sim mkdir sim
iverilog -g2005 -Wall -o sim\alu_sim rtl\alu_32bit.v tb\tb_alu_32bit.v
if errorlevel 1 exit /b 1
vvp sim\alu_sim
