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

- HTML generation incomplete.  HTML should be generated, but not necessarily in a nice, pretty
  format.  Working on it.
  
- TOC automatic node moving and alphabetical sorting not implemented yet.

- No documentation yet.

- XSLT support removed.

