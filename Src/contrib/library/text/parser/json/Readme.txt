Readme file for eJSON
=====================

team: "Javier Velilla,Jocelyn Fiat, Paul Cohen"
date: "$Date$"
revision: "$Revision$"

1. Introduction
---------------

eJSON stands for Eiffel JSON library and is a small Eiffel library for dealing
with the JSON format. The objective of the library is to provide two basic
features Eiffel2JSON and JSON2Eiffel.

2. Legal stuff
--------------

eJSON is copyrighted by the author Javier Velilla and others. It is licensed
under the MIT License. See the file license.txt in the same directory as this
readme file.

3. Versioning scheme
--------------------

eJSON version numbers has the form:

   «major number».«minor number».«patch level»

eJSON will retain the major number 0 as long as it has beta status. A change in
major number indicates that a release is not backward compatible. A change in
minor number indicates that a release is backward compatible (within that major
number) but that new useful features may have been added. A change in patch
level simply indicates that the release contains bug fixes for the previous
release. Note that as long as eJSON is in beta status (0.Y.Z) backward 
compatibility is not guranteed for changes in minor numbers!

4. Documentation
---------------

Currently the only documentation on eJSON is available at:

  https://github.com/eiffelhub/json/wiki/User-guide

5. Requirements and installation
--------------------------------

EJSON requires that you have:

1. Gobo 3.9 installed or later
2. One of the following compiler combinations installed:
   * ISE Eiffel 6.5 or later.
   * gec [try to test]
   * tecomp [try to test]

eJSON probably works fine with other versions of the above compilers.
There are no known platform dependencies (Windows, Linux).

To install eJSON simply extract the ejson-X.Y.Z.zip file to some appropriate
place on your hard disk. There are no requirements on environment variables or
registry variables.

To verify that everything works you should compile the example programs and/or
the test program.

6. Contents of eJSON
--------------------

All directory names below are relative to the root directory of your ejson
installation. 

Directory   Description
---------   -----------
doc         Contains the eJSON.pdf documentation file.
examples    Contains the two example programs.
ejson       Contains the actual eJSON library classes.
test        Contains a test program for eJSON.

7. Contacting the Team
----------------------

Contact the team: 

 Javier Velilla «javier.hector@gmail.com»
 Paul Cohen «paco@seibostudios.se»
 Jocelyn Fiat «jfiat@eiffel.com»

8. Releases
-----------

For more information on what was changed in each release look in the file
history.txt.

Version Date            Description
------- ----            -----------
0.3.0   2011-07-06      JSON Factory Converters
0.2.0   2010-02-07      Adapted to EiffelStudio 6.4 or later, supports void-safety
0.1.0   2010-02-07      First release, Adapted to SmartEiffel 1.2r7 and EiffelStudio 6.2 or previous