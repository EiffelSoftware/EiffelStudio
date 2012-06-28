This directory contains the source code of 
the Gobo Eiffel XSLT 2.0 command-line processor (gexslt). 
The code of gexslt is mainly based on the Gobo Eiffel
Xpath and XSLT libraries, which in turn use the Gobo XML Library, 
and other Gobo libraries.

To compile this program:

1. Use your favorite Eiffel compiler to compile the Eiffel system using
   the provided Ace, Xace or ECF file (e.g. <compiler>.ecf). Alternatively
   you can use 'geant' to launch the compilation:
   
       geant compile_<compiler>
       
   where <compiler> is either 'ise' or 'ge'.

2. Run gexslt using:

       gexslt

   This will give you the usage message.

The full documentation for gexslt can be found at "$GOBO/doc/gexslt".

--
Copyright (c) 2004-2008, Colin Adams and others
