                =============
                Hello Example
                =============


This application manages a set of books as well as authors and 
publishers. It shows how to create, retrieve and remove persistent 
objects. And also it contains many sample programs which are 
used in the document "A mechanism for storing and retrieving 
objects between MATISSE and Eiffel"

It illustrates the following features:
  - Database connection management
  - Transaction management
  - Version Access management
  - Instance creation
  - Entry point
  - Index
  - Extent of class
  - Accessing attribute values and relationship successors


Contents of the directory
 - Ace.ace
 - example.odl
 - example_app.e
 - books.dat


How to run the example Eiffel programs
--------------------------------------

Before running the example, you  need to install the MATISSE 4.x.
In this document, the installation directory of the MAITSSE-Eiffel 
Binding is called BINDING_HOME. Note that this variable indicates 
neither environment variable nor registry key.

(A) If you're running Windows

(A-1) Be sure that your environment variable path includes the 
      'bin' directory of the MATISSE 4.x installation, typically 
      c:\matisse\bin.
(A-2) Create and initialize a new MATISSE database using mts_dba tool. 
      From the Windows Start menu, start mts_dba from the MATISSE 
      Start Menu Program.
           To create and initialize a new database, in the mts_dba tool,
           (1) select 'Create...' from the Database menu, (2) complete 
           the configuration file (specify NAME and SILO at least) (3) 
           then click on the 'Initialize' from the Database menu. For 
           the details, please see the document 'MATISSE DBA Guide'
(A-3) From the Windows Start menu or from the Control Panel, open a 
      console (MS-DOS-style) window.
(A-4) In the console window, go to the BINDING_HOME\example_hello
      directory
(A-5) From the console window, load the database schema into the 
      newly created database using the utility mt_odl.
    	> mt_odl -h <hostname> -db <databasename> example.odl
(A-6) From the console window, generate the Eiffel persistent 
      classes using the utility mt_odl.
	    > mt_odl -eiffel example.odl
(A-7) Start the EiffelBench and select the BINDING_HOME\example_hello
      directory as a project directory.
(A-8) In the EiffelBench Project Tool, click on the System hole and 
      select the Ace.ace file. You need the EiffelTime library from 
      ISE. If it is installed in the different directory from the one 
      specified in the Ace.ace file, edit and change it. You need to 
      specify the C library file for MATISSE. By default, it is 
      specified as ³C:\matisse\lib\matisse.lib². If the file is 
      installed in the different directory, edit and change it.
(A-9) Compile the project. Click on the Melt button in the EiffelBench 
      window.
(A-10) After the compilation, run the system with two arguments, the 
       host name and database name of your database.
(A-11) The sample application reads a text file as sample data and 
       creates some objects in the database. Then it executes several 
       queries on those objects. You may edit the procedure ³make² of 
       the class EXAMPLE_APP and execute the queries one by one.




How to generate Eiffel source code with mt_odl
----------------------------------------------

You can write your schema in an ODL file, named schema.odl for 
instance. To know more about how to write an ODL file, please 
refer to MATISSE ODL Programming Guide.
In order to generate Eiffel source code, call up the utility 
mt_odl with the option eiffel.
	> mt_odl -eiffel schema.odl
This utility generates Eiffel persistent class files in the 
directory where the utility is executed.
