IVERILOG ?= iverilog
VVP ?= vvp
SIM = sim/alu_sim
SRC = rtl/alu_32bit.v tb/tb_alu_32bit.v

.PHONY: test clean
test:
	$(IVERILOG) -g2005 -Wall -o $(SIM) $(SRC)
	$(VVP) $(SIM)

clean:
	rm -f $(SIM) sim/alu.vcd
