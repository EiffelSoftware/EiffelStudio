DEFAULT_OUTPUT=scoop_benchmark.csv
!IFNDEF OUTPUT
OUTPUT=$(DEFAULT_OUTPUT)
!ENDIF

!IFDEF QS
!IF "$(QS)" != "-qs"
!ERROR Invalid value of the variable QS that is allowed to be either empty or equal to "-qs": "$(QS)"
!ENDIF
!ENDIF

DO_MAKE=$(MAKE) -nologo

EXE=.exe
RM=del
RD=rmdir /S/Q

.SILENT:

all:
	"echo" Available targets:
	"echo".
	"echo"	^ ^ ^ benchmark - run benchmarks and record measurements to '$(OUTPUT)'
	"echo"	^ ^ ^ build^ ^ ^ ^ ^ - compile benchmarks
	"echo"	^ ^ ^ clean^ ^ ^ ^ ^ - remove all generated files, including benchmark executables
	"echo".
	"echo" Available settings:
	"echo".
	"echo"	^ ^ ^ QS=-qs - use new SCOOP run-time instead of the old one
	"echo"	^ ^ ^ OUTPUT=file_name - output file name for benchmarks (default: '$(DEFAULT_OUTPUT)')

action.echo:
	echo $(MESSAGE)> "$(OUTPUT)"

!INCLUDE makefile.common
