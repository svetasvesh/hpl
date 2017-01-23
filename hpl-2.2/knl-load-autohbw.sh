#!/bin/sh

#PBS -N SPSU-hpl

#PBS -l nodes=1:ppn=64

. /opt/intel/bin/compilervars.sh intel64
. /opt/intel/impi/2017.1.132/bin64/mpivars.sh intel64

cd $PBS_O_WORKDIR

export LD_PRELOAD=$HOME/autohbw/lib/libautohbw.so
export AUTO_HBW_LOG=1
export AUTO_HBW_SIZE=4M
export KMP_AFFINITY=verbose,scatter
time mpirun -machinefile $PBS_NODEFILE bin/Unix/xhpl