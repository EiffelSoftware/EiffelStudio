#
# This is the configuration file for MICROSOFT'S VISUAL C++
#
gcc-=''
include_path='$compiler_path\i586-cygwin32\include'
lib_path='$compiler_path\ar'
make='$compiler_path\bin\make'
link32='$compiler_path\bin\ld'
#
obj='o'
lib='o'
#
#-- no MT no debug
#--------
ccflags='-mno-cygwin'
dllflags=''
link_line='$compiler_path\bin\ld -r -o $@ $(OBJECTS)'
link_wline='$compiler_path\bin\ld -r -o $@ $(WOBJECTS)'
link_eline='$compiler_path\bin\ld -r -o $@ $(EOBJECTS)'
#
optimize='-O2'
#optimize=''
output_cmd='-o'
input_cmd=''
cc='gcc'
resource_compiler='windres'
extra_object_files=''
compiler_path='d:\apps\Cygnus\B20\H-i586-cygwin32'
all_dependency='*.o: eif_config.h eif_portable.h eif_globals.h eif_eiffel.h eif_macros.h'
#
