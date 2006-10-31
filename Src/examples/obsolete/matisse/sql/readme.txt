                =============
                SQL Example
                =============




Contents of the directory
 - data
	- presidents.txt
 - Ace.ace 
 - presidency.odl
 - example_sql.e
 - books.dat
 - mt_container_type.e
 - person.e
 - presidency.e
 - string_token.e
 - sql_interface.rtf

How to run the example Eiffel programs
--------------------------------------

Before running the example, you  need to install the MATISSE 4.x.


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
(A-4) In the console window, go to the examples\matisse\sql
      directory
(A-5) From the console window, load the database schema into the 
      newly created database using the utility mt_odl.
    	> mt_odl -h <hostname> -db <databasename> example.odl
(A-6) Start the EiffelBench and select the examples\matisse\sql
      directory as a project directory.
(A-7) In the EiffelBench Project Tool, click on the System hole and 
      select the Ace.ace file. You need the EiffelTime library from 
      ISE. If it is installed in the different directory from the one 
      specified in the Ace.ace file, edit and change it. You need to 
      specify the C library file for MATISSE. It is specified as 
	  ³$MTS_ROOT\lib\matisse.lib². MTS_ROOT is a registry key 
	  you have to set within Eiffel keys.
(A-8) Compile the project. Click on the Melt button in the EiffelBench 
      window.
(A-9) After the compilation, run the system with two arguments, the 
       host name and database name of your database.
(A-10) The sample application ask questions about american presidents... 



