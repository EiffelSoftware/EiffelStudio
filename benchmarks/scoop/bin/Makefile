DEFAULT_OUTPUT=scoop_benchmark.csv

ifndef OUTPUT
OUTPUT=$(DEFAULT_OUTPUT)
endif

ifndef EWEASEL_OUTPUT
EWEASEL_OUTPUT=$(CWD)/../output
endif

ifndef PROCESSORS
PROCESSORS=0
endif


ECHO_S=echo "
ECHO_E="

DO_MAKE=$(MAKE)

EXE=
RM=rm -f
RD=rm -rf
DIRSEP=/

.SILENT:

all:
	$(ECHO_S)Available targets:$(ECHO_E)
	$(ECHO_S)$(ECHO_E)
	$(ECHO_S)	   benchmark - run benchmarks (multiple runs) and record measurements to '$(OUTPUT)'$(ECHO_E)
	$(ECHO_S)	   benchmark_1 - run benchmarks (single run) and record measurements to '$(OUTPUT)'$(ECHO_E)
	$(ECHO_S)	   build     - compile benchmarks$(ECHO_E)
	$(ECHO_S)	   clean     - remove all generated files, including benchmark executables$(ECHO_E)
	$(ECHO_S)$(ECHO_E)
	$(ECHO_S)Available settings:$(ECHO_E)
	$(ECHO_S)$(ECHO_E)
	$(ECHO_S)	   PROCESSORS=count - maximum number of processors that can be used (default: '0', i.e. all available)$(ECHO_E)
	$(ECHO_S)	   OUTPUT=file_name - output file name for benchmarks (default: '$(DEFAULT_OUTPUT)')$(ECHO_E)
	$(ECHO_S)	   EWEASEL_OUTPUT=dir_name - directory for benchmarks (default: '$(DEFAULT_EWEASEL_OUTPUT)')$(ECHO_E)

action.echo:
	echo "$(MESSAGE)"> "$(OUTPUT)"

include makefile.common
