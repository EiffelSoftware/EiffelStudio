How to make the WEL C library `wel.lib'?
----------------------------------------

If you have Borland C, run `make_bcc.bat'.
If you have Microsoft C, run `make_msc.bat'.
if you have Watcom C, run `make_wcc.bat'.

The makefiles assume that the C-compiler is in your $PATH environment
variable.

The environment variable EIFFEL3 needs to be set to where ISE Eiffel is
installed for these compilation. (This is usually `c:\eiffel3').

To set the variable, type:

	set eiffel3=c:\eiffel3
