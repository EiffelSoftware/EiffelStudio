Readme file for ECLOP
=====================

author: "Paul Cohen"
date: "$Date$"
revision: "$Revision$"

1. Introduction
---------------

ECLOP stands for Eiffel Command Line Parser and is a small library for parsing
command line options. The current release (0.1.1) should still be considered a
beta release but should despite that still be useful for writing command line
based programs and it is reasonably stable. Your mileage may vary. ;-)  

ECLOP was originally developed in a commercial project at Enea Systems AB,
Stockholm, Sweden, but has been released to the Eiffel community thanks to
understanding executives! I would like to thank Johan Pettersson and Peter
Johansson at Enea Systems for allowing me to release ECLOP under an open source
license and as a personal submission to the 2003 Eiffel Class Struggle! 


2. Legal stuff
--------------

ECLOP is copyrighted by the author Paul Cohen. It is licensed under the Eiffel 
Forum License v2. See the file license.txt in the same directory as this readme 
file.


3. Versioning scheme
--------------------

ECLOP version numbers has the form:

   <major number>.<minor number>.<patch level>

ECLOP will retain the major number 0 as long as it has beta status. A change in
major number indicates that a release is not backward compatible. A change in
minor number indicates that a release is backward compatible (within that major
number) but that new useful features may have been added. A change in patch
level simply indicates that the release contains bug fixes for the previous
release.  


4. Documentation
---------------

The file "eclop.pdf" is the main documentation available on ECLOP. This readme
file contains general information and the files todo.txt and history.txt in the
same directory as this readme file contains some additional information.


5. Requirements and installation
--------------------------------

ECLOP has been developed with ISE Eiffel (5.1, 5.2 and 5.4) and MSVC++ 6.0 on
Windows NT and 2000 machines. It should be easy to adapt to SmartEiffel and
Visual Eiffel and it is indeed the authors intention to do so. It should work on
Linux as is. It should also work without modifications with later versions of
ISE Eiffel. 

To install ECLOP simply extract the eclop-0.1.1.zip file to some appropriate
place on your hard disk. There are no requirements on environment variables or
registry variables. See the section "Contents of ECLOP" below for a description
of what is in the different directories of ECLOP. 

To verify that everything works you should compile the example programs and/or
the test program.


6. Contents of ECLOP
--------------------

All directory names below are relative to the root directory of your eclop
installation. 

Directory   Description
---------   -----------
doc	    Contains the eclop.pdf documentation file.
examples    Contains the two example programs mention in the eclop.pdf file.
eclop	    Contains the actual ECLOP library classes.
test	    Contains a test program for ECLOP.


7. Contacting the author
------------------------

Contact the author Paul Cohen at paco@enea.se.


8. Releases
-----------

For more information on what was changed in each release look in the file
history.txt.

Version Date	        Description
------- ----            -----------
0.1.1   2004-03-07	Patch release.
0.1.0   2003-10-31      First release. Submitted to the 2003 Eiffel Class
                        Struggle. 

			