DEFAULT_OUTPUT=scoop_benchmark.csv
!IFNDEF OUTPUT
OUTPUT=$(DEFAULT_OUTPUT)
!ENDIF

!IFDEF QS
!IF "$(QS)" != "-qs"
!ERROR Invalid value of the variable QS that is allowed to be either empty or equal to "-qs": "$(QS)"
!ENDIF
!ENDIF

EC="$(ISE_EIFFEL)/studio/spec/$(ISE_PLATFORM)/bin/ec"
MAKE=$(MAKE) -nologo
TOP=..

ELAPSED_TIME_DIR=$(TOP)/../tool/elapsed_time
ELAPSED_TIME=$(ELAPSED_TIME_DIR)/EIFGENs/elapsed_time/F_code/elapsed_time.exe
MEASURE="$(ELAPSED_TIME)" -nologo -skip_first 1 -f c

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

benchmark::
	echo Name,Count,Minimum (ms),Maximum (ms),Average (ms),Standard deviation (ms),Command,Directory,Skip first count,Skip maximum count> "$(OUTPUT)"

benchmark build clean::
	$(MAKE) ACTION=$* chain
	$(MAKE) ACTION=$* chameneos
	$(MAKE) ACTION=$* condition
	$(MAKE) ACTION=$* mutex
	$(MAKE) ACTION=$* outer
	$(MAKE) ACTION=$* prodcons
	$(MAKE) ACTION=$* product
	$(MAKE) ACTION=$* randmat
	$(MAKE) ACTION=$* threadring
	$(MAKE) ACTION=$* thresh
	$(MAKE) ACTION=$* winnow
	
chain:
	$(MAKE) action.$(ACTION) TARGET=$* ARGUMENT="-i $(TOP)\scoop_$*\main.in -bench" "REPEAT=-c 72"

chameneos:
	$(MAKE) action.$(ACTION) TARGET=$* ARGUMENT="1000000" "REPEAT=-c 6"

condition:
	$(MAKE) action.$(ACTION) TARGET=$* ARGUMENT="100000 32" "REPEAT=-c 1"

mutex:
	$(MAKE) action.$(ACTION) TARGET=$* ARGUMENT="1000000 64" "REPEAT=-c 9"

outer:
	$(MAKE) action.$(ACTION) TARGET=$* ARGUMENT="-i $(TOP)\scoop_$*\mainbig.in -bench" "REPEAT=-c 18"

prodcons:
	$(MAKE) action.$(ACTION) TARGET=$* ARGUMENT="40000 32" "REPEAT=-c 16"

product:
	$(MAKE) action.$(ACTION) TARGET=$* ARGUMENT="-i $(TOP)\scoop_$*\mainbig.in -bench" "REPEAT=-c 7"

randmat:
	$(MAKE) action.$(ACTION) TARGET=$* ARGUMENT="-i $(TOP)\scoop_$*\mainbig2.in -bench" "REPEAT=-c 8"

threadring:
	$(MAKE) action.$(ACTION) TARGET=$* ARGUMENT="3000000 64" "REPEAT=-c 14"

thresh:
	$(MAKE) action.$(ACTION) TARGET=$* ARGUMENT="-i $(TOP)\scoop_$*\mainbig.in -bench" "REPEAT=-c 117"

winnow:
	$(MAKE) action.$(ACTION) TARGET=$* ARGUMENT="-i $(TOP)\scoop_$*\mainbig.in -bench" "REPEAT=-c 87"

action.benchmark: $(ELAPSED_TIME) action.build
	$(MEASURE) -w "$(TOP)\scoop_$(TARGET)" -n $(TARGET) $(REPEAT) "$(TOP)\scoop_$(TARGET)\EIFGENs\main$(QS)\F_code\main.exe $(ARGUMENT)" >> "$(OUTPUT)"

action.build: $(TOP)\scoop_$(TARGET)\EIFGENs\main$(QS)\F_code\main.exe

action.clean:
	-rd /s /q "$(TOP)\scoop_$(TARGET)\EIFGENs"
	-del $(TOP)\scoop_$(TARGET)\main.rc

$(TOP)\scoop_$(TARGET)\EIFGENs\main$(QS)\F_code\main.exe:
	$(EC) -finalize -clean -c_compile -config $(TOP)\scoop_$(TARGET)\main.ecf -project_path $(TOP)\scoop_$(TARGET) -target main$(QS)

"$(ELAPSED_TIME)": "$(ELAPSED_TIME_DIR)/elapsed_time.e" "$(ELAPSED_TIME_DIR)/elapsed_time.ecf"
	$(EC) -finalize -clean -config "$(ELAPSED_TIME_DIR)/elapsed_time.ecf" -project_path "$(ELAPSED_TIME_DIR)" -c_compile
