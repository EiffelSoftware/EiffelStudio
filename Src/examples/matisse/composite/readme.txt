                =====================
                Composite Object Example
                =====================


This example shows how to use Composite Object from the MATISSE-Eiffel
Binding. The application creates document objects which consist of several
chapters. Each document has a list of authors. Each chapter consists of 
several sections which consists of several paragraphs. The relationships 
'chapters', 'sections' and 'paragraphs' are defined as composite relationship 
so that the entire document including its chapters and sections should be 
deleted when you delete a document.
Please refer to the document 'composite_object.rtf' for more details.


How to run the example Eiffel programs
------------------------------------------

Before running the example, you need to install the MATISSE 4.x.
In this document, the installation directory of the MATISSE-Eiffel 
Binding is called BINDING_HOME. Note that this variable indicates 
neither environment variable nor registry key.


(A) If you're running Windows

(A-1) Be sure that your environment variable path includes the 
      'bin' directory of the MATISSE 4.x installation, typically 
      c:\matisse\bin.
(A-2) Create and initialize a new MATISSE database using mts_dba 
      tool. From the Windows Start menu, start mts_dba from the 
      MATISSE Start Menu Program.
          To create and initialize a new database, in the mts_dba 
          tool, (1) select 'Create...' from the Database menu, (2)
          complete the configuration file (specify NAME and SILO at
          least) (3) then click on the 'Initialize' from the 
          Database menu. For the details, please refer to the document 
          'MATISSE DBA Guide'
(A-3) From the Windows Start menu or from the Control Panel, open a 
      console (MS-DOS-style) window.
(A-4) In the console window, go to the BINDING_HOME\example_composite 
      directory
(A-5) From the console window, load the database schema into the newly 
      created database using the utility mt_odl.
       > set MT_CPP="C:\<ms-dev install>\bin\cl.exe -E"
    	> mt_odl -h <hostname> -db <databasename> example_co.odl
     Note you need to define the environment variable MT_CPP.
(A-6) Start the EiffelBench and select the BINDING_HOME\example_composite
      directory as a project directory.
(A-7) In the EiffelBench Project Tool, click on the System hole and 
      select the Ace.ace file. You need the EiffelTime library from ISE. 
      If it is installed in the different directory from the one 
      specified in the Ace.ace file, edit and change it. You need to 
      specify the C library file for MATISSE. By default, it is 
      specified as 'C:\matisse\lib\matisse.lib'. If the C library file 
      is installed in the different directory, edit and change it.
(A-8) Compile the project. Click on the Melt button in the EiffelBench 
      window.
(A-9) After the compilation, run the system with two arguments, the host
      name and database name of your database.
(A-10) The sample application creates some sample objects in the database.
       Then it shows messages of processing the composite objects.
