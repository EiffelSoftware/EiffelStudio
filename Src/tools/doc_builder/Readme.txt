Documentation Tool Release Notes (version 1.0)
----------------------------------------------

-----------
COMPILATION
-----------


.NET Compilation
----------------

Requirements:

	- Precompiled .NET Vision2
	- Gobo 3.1 library


1) Run `setup.bat'
2) Extract the contents of the file gobo_win.tgz found in CVS at Src/free_add_ons/gobo to your EIFFEL_SRC/library directory
3) Compile 'docbuilder.ace'


Classic Mode Compilation
------------------------

1) Extract the contents of the file gobo_win.tgz found in CVS at Src/free_add_ons/gobo to your EIFFEL_SRC/library directory
2) Compile 'docbuilder_classic.ace'


------------------------------------
DIFFERENCES BETWEEN CLASSIC AND .NET
------------------------------------

- No schema support in classic mode.  Will assume all files are correct to schema
  for any generation
  
- No browser XML or HTML view in classic mode.  Only edit mode works currently.


------------
KNOWN ISSUES
------------

- When generating HTML in browser images are not shown for root-relative paths, i.e, '/project_root/my_image.png'
- When clicking a hyperlink in browser does not work			
- After pretty printing the XML in the editor 'code_block' tags don't format correctly in the HTML view(?!)
- Font changes when file error dialog pops up	


