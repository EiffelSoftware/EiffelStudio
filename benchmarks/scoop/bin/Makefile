DEFAULT_OUTPUT=scoop_benchmark.csv
ifndef OUTPUT
OUTPUT=$(DEFAULT_OUTPUT)
endif

ECHO_S=echo "
ECHO_E="

DO_MAKE=$(MAKE)

EXE=
RM=rm -f
RD=rm -rf

.SILENT:

all:
	$(ECHO_S)Available targets:$(ECHO_E)
	$(ECHO_S)$(ECHO_E)
	$(ECHO_S)	   benchmark - run benchmarks and record measurements to '$(OUTPUT)'$(ECHO_E)
	$(ECHO_S)	   build     - compile benchmarks$(ECHO_E)
	$(ECHO_S)	   clean     - remove all generated files, including benchmark executables$(ECHO_E)
	$(ECHO_S)$(ECHO_E)
	$(ECHO_S)Available settings:$(ECHO_E)
	$(ECHO_S)$(ECHO_E)
	$(ECHO_S)	   OUTPUT=file_name - output file name for benchmarks (default: '$(DEFAULT_OUTPUT)')$(ECHO_E)

action.echo:
	echo "$(MESSAGE)"> "$(OUTPUT)"

include makefile.common
