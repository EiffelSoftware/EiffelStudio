#
# This is the configuration file for MICROSOFT'S VISUAL C++
#
gcc-=''
include_path='$compiler_path\i586-cygwin32\include'
lib_path='$compiler_path\ar'
make='$ms_compiler_path\bin\nmake'
#
del='rm -f'
output_cmd='-o'
input_cmd=''
resource_compiler='windres'
#
obj='o'
lib='a'
#
#-- Standard runtime
#-------------------
ccflags='-mno-cygwin -DCYGWIN'
mtccflags='-mno-cygwin -DCYGWIN -DEIF_THREADS'
output_libraries='standard mtstandard'
#
#
link_line='$compiler_path\bin\ld -r -o $@ $(OBJECTS)'
link_wline='$compiler_path\bin\ld -r -o $@ $(WOBJECTS)'
link_eline='$compiler_path\bin\ld -r -o $@ $(EOBJECTS)'
link_mtline='$compiler_path\bin\ld -r -o $@ $(MT_OBJECTS)'
link_mtwline='$compiler_path\bin\ld -r -o $@ $(MT_WOBJECTS)'
#
optimize='-O2'
debug=''
#optimize=''
#debug='-g'
dllflags=''
#
cc='gcc'
link32='$compiler_path\bin\ld'
compiler_path='d:\apps\cygwin'
ms_compiler_path='d:\apps\MSVC\VC98'
all_dependency='*.o: eif_config.h eif_portable.h eif_globals.h eif_eiffel.h eif_macros.h'
#
