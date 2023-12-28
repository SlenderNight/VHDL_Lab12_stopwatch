#!/bin/sh

# 
# Vivado(TM)
# runme.sh: a Vivado-generated Runs Script for UNIX
# Copyright 1986-2017 Xilinx, Inc. All Rights Reserved.
# 

echo "This script was generated under a different operating system."
echo "Please update the PATH and LD_LIBRARY_PATH variables below, before executing this script"
exit

if [ -z "$PATH" ]; then
  PATH=E:/ProgramFiles/Vivado2017.2/Vivado/2017.2/ids_lite/ISE/bin/nt64;E:/ProgramFiles/Vivado2017.2/Vivado/2017.2/ids_lite/ISE/lib/nt64:E:/ProgramFiles/Vivado2017.2/Vivado/2017.2/bin
else
  PATH=E:/ProgramFiles/Vivado2017.2/Vivado/2017.2/ids_lite/ISE/bin/nt64;E:/ProgramFiles/Vivado2017.2/Vivado/2017.2/ids_lite/ISE/lib/nt64:E:/ProgramFiles/Vivado2017.2/Vivado/2017.2/bin:$PATH
fi
export PATH

if [ -z "$LD_LIBRARY_PATH" ]; then
  LD_LIBRARY_PATH=
else
  LD_LIBRARY_PATH=:$LD_LIBRARY_PATH
fi
export LD_LIBRARY_PATH

HD_PWD='E:/Modelsim_Vivado/lab12_stopwatch/vivado/lab12_stopwatch.runs/impl_1'
cd "$HD_PWD"

HD_LOG=runme.log
/bin/touch $HD_LOG

ISEStep="./ISEWrap.sh"
EAStep()
{
     $ISEStep $HD_LOG "$@" >> $HD_LOG 2>&1
     if [ $? -ne 0 ]
     then
         exit
     fi
}

# pre-commands:
/bin/touch .write_bitstream.begin.rst
EAStep vivado -log stopwatch.vdi -applog -m64 -product Vivado -messageDb vivado.pb -mode batch -source stopwatch.tcl -notrace


