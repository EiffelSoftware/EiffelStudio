include_path: ""

eiffel4: "$(EIFFEL4)"

platform: "w32sc"

cc: "sc"

optimize: "-o"

ccflags: "-mn -g"

large: ""

ldflags: "-SUBSYSTEM:WINDOWS"

libs: ""

mkdep: ""

mv: "copy"

ranlib: "echo"

rm: "del"

make: "smake"

dpflags: ""

continuation: "\"

appl_make: "$appl.exe: $appl.lnk%N%
%%Tlink @$appl.lnk%N%
%#%N%
%..\..\$appl.rc:%N%
%%Tif not exist ..\..\$appl.rc copy $(EIFFEL4)\bench\spec\w32bcc\es3sh\eiffel.rc ..\..\$appl.rc%N%
%#%N%
%$appl.rc: ..\..\$appl.rc $(EIFFEL4)\bench\spec\w32bcc\es3sh\except.rc%N%
%%Tcopy ..\..\$appl.rc+$(EIFFEL4)\bench\spec\w32bcc\es3sh\except.rc $appl.rc%N%
%#%N%
%$appl.res: $appl.rc working.ico appl.ico Makefile $appl.ico%N%
%%Tif exist ..\..\*.ico xcopy ..\..\*.ico .%N%
%%Tif exist ..\..\*.cur xcopy ..\..\*.cur .%N%
%%Tif exist ..\..\*.bmp xcopy ..\..\*.bmp .%N%
%%Tif exist ..\..\*.h xcopy ..\..\*.h .%N%
%%Trcc $appl.rc -32%N%
%#%N%
%working.ico:%N%
%%Tif exist ..\..\working.ico copy ..\..\working.ico .%N%
%%Tif not exist working.ico copy $(EIFFEL4)\bench\spec\w32bcc\es3sh\working.ico .%N%
%#%N%
%..\..\$appl.ico:%N%
%%Tcopy $(EIFFEL4)\bench\spec\w32bcc\es3sh\appl.ico ..\..\$appl.ico%N%
%#%N%
%$appl.ico: ..\..\$appl.ico%N%
%%Tcopy ..\..\$appl.ico .%N%
%#%N%
%appl.ico:%N%
%%Tif exist ..\..\appl.ico copy ..\..\appl.ico .%N%
%%Tif not exist appl.ico copy $(EIFFEL4)\bench\spec\w32bcc\es3sh\appl.ico .%N%
%#%N%
%%Tdel $@%N%
%%T&echo $** + >> $@%N%
%#%N%
%$appl.lnk: $(OBJECTS) $(EOBJECTS) $(EXTERNALS) e1\emain.obj Makefile $appl.res%N%
%%T$(RM) $@%N%
%%Techo e1\emain.obj >> $@%N%
%%Techo $appl.exe >> $@%N%
%%Techo $appl.map >> $@%N%
%%Techo $library + >> $@%N%
%%Tfor %%i in ($(OBJECTS)) do echo %%i + >> $@%N%
%%Tfor %%i in ($(EOBJECTS) $(EXTERNALS)) do echo %%i + >> $@%N%
%%Techo ADVAPI32.lib GDI32.LIB COMDLG32.lib WSOCK32.LIB >> $@%N%
%%Techo $(LDFLAGS) >> $@%N%
%%Techo $appl.res >> $@%N%
%#"

-- %%Techo $precompilelib\precomp.lib >> $@%N%
precompile: "driver.exe: driver.lnk driver.rc appl.ico working.ico%N%
%%T$(RM) driver.exe%N%
%%Tlink @driver.lnk%N%
%%T$(RM) *.err%N%
%%T$(RM) driver.lnk%N%
%%T$(RM) driver.res%N%
%%T$(RM) driver.map%N%
%%T$(RM) *.ico%N%
%%T$(RM) *.rc%N%
%%T$(RM) Makefile%N%
%%T$(RM) TRANSLAT%N%
%%T$(RM) Makefile.SH%N%
%%T$(RM) *.bak%N%
%%Tcopy Melted.eif preobj.obj%N%
%%Tcopy $(EIFFEL4)\bench\spec\w32bcc\es3sh\version.eif .%N%
%%Tfor %%i in ($(SUBDIRS)) do del %%i /s /q%N%
%%Tfor %%i in ($(SUBDIRS)) do rd %%i%N%
%#%N%
%appl.ico:%N%
%%Tif exist ..\..\console.ico copy ..\..\appl.ico .%N%
%%Tif not exist console.ico copy  $(EIFFEL4)\bench\spec\w32bcc\es3sh\appl.ico%N%
%#%N%
%working.ico:%N%
%%Tif exist ..\..\working.ico copy ..\..\working.ico .%N%
%%Tif not exist working.ico copy $(EIFFEL4)\bench\spec\w32bcc\es3sh\working.ico .%N%
%#%N%
%driver.rc: $(EIFFEL4)\bench\spec\w32bcc\es3sh\eiffel.rc%N%
%%Tcopy $(EIFFEL4)\bench\spec\w32bcc\es3sh\eiffel.rc+$(EIFFEL4)\bench\spec\w32bcc\es3sh\except.rc driver.rc%N%
%%Tcopy $(EIFFEL4)\bench\spec\w32bcc\es3sh\appl.ico .%N%
%#%N%
%driver.res: driver.rc appl.ico working.ico%N%
%%Trcc driver.rc -32%N%
%#%N%
%$precompilelib\precomp.lib: $(OBJECTS) $(EXTERNALS)%N%
%%T$(RM) $@%N%
%%Tlib /c /p:64 $@ +$** %N%
%#%N%
%driver.lnk: e1\emain.obj $precompilelib\precomp.lib driver.res eobject.lib%N%
%%Techo e1\emain.obj >> $@%N%
%%Techo driver.exe + >> $@%N%
%%Techo driver.map + >> $@%N%
%%Techo $library + >> $@%N%
%%Techo $precompilelib\precomp.lib + >> $@ %N%
%%Tfor %%i in ($(EOBJECTS)) do echo %%i + >> $@%N%
%%Techo $precompilelib\precomp.lib + >> $@ %N%
%%Techo ADVAPI32.lib GDI32.LIB COMDLG32.lib WSOCK32.LIB >> $@%N%
%%Techo $(LDFLAGS) >> $@%N%
%%Techo driver.res >> $@"

cecil_make: "cecil.lib: $(OBJECTS) $(EXTERNALS) $(EOBJECTS)%N%
%%T$(RM) $@%N%
%%Tlib /c /p:64 $@ +$**"

completed: "%Techo done > completd.eif"

all: "all:: "

intermediate_file_ext: "lib"

make_intermediate: "%Tdel $@%N%
%%Tlib /c /p:64 $@ +$obj;"

-- options below are for es3sh internal use
-- mind the spaces!

no_subs: "!NO!SUBS!"

-- platform change directory command
cd: "cd"

-- text for remove command
rm_text: "RM ="

-- text for make command
make_text: "MAKE"

-- text for C-compiler command
cc_text: "$(CC) $(CFLAGS)"

cobj_text: ".c.obj:"

xobj_text: ".x.obj:"

obj_text: ".obj "

eobj_text: "$(EOBJ"

objects__text: "$(OBJECTS)"

-- text for precompilation
precompile_text: "precompile $appl"

appl_text: "appl_make $appl"

cecil_text: "cecil_make $appl"

-- platform 'parent' directory
updir: ".."

emain_text: "emain"

emain_obj_text: "emain.obj"

objects_text: "OBJECTS = "

eobjects_text: "EOBJECTS = "

obj_file_ext: "obj"

executable_file_ext: ".exe"

driver_text: "driver"

driver_filename: "driver.exe"

externals_text: "EXTERNALS"

externals_continuation_text: "EXTERNALS =  \"
