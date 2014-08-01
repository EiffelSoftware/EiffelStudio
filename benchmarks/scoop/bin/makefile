!IFNDEF OUTPUT
OUTPUT=scoop_benchmark.csv
!ENDIF

EC="$(ISE_EIFFEL)/studio/spec/$(ISE_PLATFORM)/bin/ec"
MAKE=$(MAKE) -nologo
TOP=..

ELAPSED_TIME_DIR=$(TOP)/../tool/elapsed_time
ELAPSED_TIME=$(ELAPSED_TIME_DIR)/EIFGENs/elapsed_time/F_code/elapsed_time.exe
MEASURE="$(ELAPSED_TIME)" -nologo -skip_first 1 -f c

#.SILENT:

all:
	"echo" Available targets:
	"echo".
	"echo"	^ ^ ^ benchmark - run benchmarks and record measurements to '$(OUTPUT)'
	"echo"	^ ^ ^ build^ ^ ^ ^ ^ - compile benchmarks
	"echo"	^ ^ ^ clean^ ^ ^ ^ ^ - remove all generated files, including benchmark executables

benchmark::
	echo Name,Count,Minimum (ms),Maximum (ms),Average (ms),Standard deviation (ms),Command,Directory,Skip first count,Skip maximum count> "$(OUTPUT)"

benchmark build clean::
	$(MAKE) ACTION=$* chain
	$(MAKE) ACTION=$* chameneos
	$(MAKE) ACTION=$* outer
	$(MAKE) ACTION=$* product
	$(MAKE) ACTION=$* randmat
	$(MAKE) ACTION=$* thresh
	$(MAKE) ACTION=$* winnow
	
chain:
	$(MAKE) action.$(ACTION) TARGET=$* ARGUMENT="-i $(TOP)\scoop_$*\main.in -bench" "REPEAT=-c 72"

chameneos:
	$(MAKE) action.$(ACTION) TARGET=$* ARGUMENT="1000000" "REPEAT=-c 6"

outer:
	$(MAKE) action.$(ACTION) TARGET=$* ARGUMENT="-i $(TOP)\scoop_$*\mainbig.in -bench" "REPEAT=-c 18"

product:
	$(MAKE) action.$(ACTION) TARGET=$* ARGUMENT="-i $(TOP)\scoop_$*\mainbig.in -bench" "REPEAT=-c 7"

randmat:
	$(MAKE) action.$(ACTION) TARGET=$* ARGUMENT="-i $(TOP)\scoop_$*\mainbig2.in -bench" "REPEAT=-c 8"

thresh:
	$(MAKE) action.$(ACTION) TARGET=$* ARGUMENT="-i $(TOP)\scoop_$*\mainbig.in -bench" "REPEAT=-c 117"

winnow:
	$(MAKE) action.$(ACTION) TARGET=$* ARGUMENT="-i $(TOP)\scoop_$*\mainbig.in -bench" "REPEAT=-c 87"

action.benchmark: $(ELAPSED_TIME) action.build
	$(MEASURE) -w "$(TOP)\scoop_$(TARGET)" -n $(TARGET) $(REPEAT) "$(TOP)\scoop_$(TARGET)\EIFGENs\main\F_code\main.exe $(ARGUMENT)" >> "$(OUTPUT)"

action.build: $(TOP)\scoop_$(TARGET)\EIFGENs\main\F_code\main.exe

action.clean:
	-rd /s /q "$(TOP)\scoop_$(TARGET)\EIFGENs"
	-del $(TOP)\scoop_$(TARGET)\main.rc

$(TOP)\scoop_$(TARGET)\EIFGENs\main\F_code\main.exe:
	$(EC) -finalize -clean -c_compile -config $(TOP)\scoop_$(TARGET)\main.ecf -project_path $(TOP)\scoop_$(TARGET) -target main

"$(ELAPSED_TIME)": "$(ELAPSED_TIME_DIR)/elapsed_time.e" "$(ELAPSED_TIME_DIR)/elapsed_time.ecf"
	$(EC) -finalize -clean -config "$(ELAPSED_TIME_DIR)/elapsed_time.ecf" -project_path "$(ELAPSED_TIME_DIR)" -c_compile
