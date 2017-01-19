
set -x
wget http://icl.cs.utk.edu/projectsfiles/hpcc/download/hpcc-1.4.3.tar.gz

# Установить зависимости.
#yum install openmpi-devel openblas-devel

# Скачать архив с исходным кодом и распаковать его.
#wget http://www.netlib.org/benchmark/hpl/hpl-2.1.tar.gz
tar xzvf hpcc-1.4.3.tar.gz

# Переименовать каталог, чтобы избежать ошибок при сборке.
#mv hpl-2.1/ hpl
cd hpcc-1.4.3/hpl

# Берем конфигурацию из скрипта setup/make_generic и изменям пути
# к заголовочным файлам (MPINC).
sed -e 's%@SHELL@%/bin/sh%' \
    -e 's%@CD@%cd%' \
    -e 's%@CP@%cp%' \
    -e 's%@LN_S@%ln -s%' \
    -e 's%@MKDIR@%mkdir%' \
    -e 's%@RM@%/bin/rm -f%' \
    -e 's%@TOUCH@%touch%' \
    -e 's%@ARCH@%UNKNOWN%' \
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

# Добавляем пути к исполняемым файлам OpenMPI.
#export PATH=$PATH:/usr/lib64/openmpi/bin

. /opt/intel/bin/compilervars.sh intel64
. /opt/intel/impi/2017.1.132/bin64/mpivars.sh intel64

cd ..
# Компилируем LINPACK.
make -j9 arch=Unix


