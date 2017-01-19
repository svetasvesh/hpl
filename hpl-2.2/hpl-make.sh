
set -x

. /opt/intel/bin/compilervars.sh intel64
. /opt/intel/impi/2017.1.132/bin64/mpivars.sh intel64


# Берем конфигурацию из скрипта setup/make_generic и изменям пути
# к заголовочным файлам (MPINC).
sed -e 's%@SHELL@%/bin/sh%' \
    -e 's%@CD@%cd%' \
    -e 's%@CP@%cp%' \
    -e 's%@LN_S@%ln -s%' \
    -e 's%@MKDIR@%mkdir%' \
    -e 's%@RM@%/bin/rm -f%' \
    -e 's%@TOUCH@%touch%' \
    -e 's%@ARCH@%Unix%' \
    -e 's%@CC@%mpicc%' \
    -e 's%@CCNOOPT@%%' \
    -e 's%@CCFLAGS@%-I$(MKLROOT)/include%' \
    -e 's%@LINKER@%mpif77%' \
    -e 's%@LINKFLAGS@%-L$(MKLROOT)/lib/intel64 -lmkl_intel_lp64 -lmkl_core -lmkl_sequential -lpthread -lm%' \
    -e 's%@ARCHIVER@%ar%' \
    -e 's%@ARFLAGS@%r%' \
    -e 's%@RANLIB@%echo%' \
    -e 's%@MPDIR@%%' \
    -e 's%@MPINC@%%' \
    -e 's%@MPLIB@%%' \
    -e 's%@F2CDEFS@%-DAdd_ -DF77_INTEGER=int -DStringSunStyle%' \
    -e 's%@LADIR@%%' \
    -e 's%@LAINC@%%' \
    -e 's%@LALIB@%%' \
    setup/Make.UNKNOWN.in > Make.Unix

ln -sfn `pwd` ~/hpl

#make -j9 arch=Unix clean

# Компилируем LINPACK.
make -j9 arch=Unix




