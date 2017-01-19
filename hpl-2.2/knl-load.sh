#!/bin/sh

#PBS -N SPSU-hpl

#PBS -l nodes=1:ppn=64

. /home/opt/intel/bin/compilervars.sh intel64
. /opt/intel/impi/2017.1.132/bin64/mpivars.sh intel64

cd $PBS_O_WORKDIR

mpirun -machinefile $PBS_NODEFILE bin/Unix/xhpl
