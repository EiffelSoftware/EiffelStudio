
Windows Eiffel eXtension Library - Readme

-------------------------------------
WEX, Version 1.00, 23th of July, 1998.
-------------------------------------

For copyright notice, please see forum.txt


What is WEX?
------------

WEX, the Windows Eiffel eXtension library, is as its name says an extension to WEL, 
the Windows Eiffel Library, that comes with the Windows version of ISE Eiffel. It is
free for everybody to use as defined in the file "forum.txt".


What do I need to run WEX?
--------------------------

You will need a copy of ISE Eiffel for Windows 95/98/NT and WEL. And Visual C++. It
should not be hard to get it running with any other C compiler, all you need to do is
change the ACE-files, but I never tried.


How do I install WEX?
---------------------

WEX consists of 2 major directories: "examples" and "library". Please add them to the 
directory where ISE Eiffel is installed. You will also need to define the enviroment
variable wex_vc_lib. It should point directly to the directory where the file "winmm.lib"
resides. This is typically "c:\program files\devstudio\vc\lib". 

Under Windows 95 or 98 you might add a line to the file autoexec.bat:

set wex_vc_lib = c:\program files\devstudio\vc\lib


Any Questions?
--------------

For any questions, comments or if you would like to contibute to WEX please mail to 
either:

Robin van Ommeren (robin.van.ommeren@wxs.nl) or 
Andreas Leitner (andreas.leitner@teleweb.at)

