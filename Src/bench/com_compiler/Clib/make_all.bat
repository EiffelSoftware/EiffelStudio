cl -Ox -c registration_utility.c
lib registration_utility.obj
del registration_utility.obj
copy /y registration_utility.lib msc
del registration_utility.lib
call make_msc.bat