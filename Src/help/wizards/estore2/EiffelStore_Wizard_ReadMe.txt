							EIFFELSTORE WIZARD (Beta Version)

The EiffelStore Wizard simplifies the job of the object-relational programmer
by providing an automatic mechanism to generate an Eiffel application framework
that encapsulates access to an existing database.

The Wizard analyzes the database for you and produces all the needed interface
classes, as well as the system's Ace file (Eiffel compilation control files). 

OVERVIEW

The EiffelStore Wizard will help you create an Eiffel Project using EiffelStore. 

The steps are straightforward: 

 * You provide the information necessary to connect to your database.
 * The Wizard asks you what tables you wish to use in your project.
 * Using this information, the Wizard will generate an application framework
 	(classes and Ace file) and compile it through EiffelBench. 

You can then adapt and extend the application framework to add your own processing
of the data as needed for your project. 

INSTALLATION AND USE

Once you have downloaded the Wizard:

 * Unzip the file EiffelStore_Wizard.zip. Be sure to use folder names when unzipping. 

 Unzipping creates a subdirectory Store_wizard, 
 	containing three other directories: bmp, exe, resources). 

 * To run the Wizard, execute launch.bat. 

You can also run the exe file in the directory exe, 
with as parameter the path where you have unzipped the wizard; for example: 

store_wizard c:\store_wizard


GENERATION

The Wizard can generate:

 * A set of classes that describes your database and enables to interact with it. These classes can
be added to an existing project to simplify access to your database in this project. See a detailed
description on the associated html page.

 * A simple application framework that shows how to get started with EiffelStore. This application
uses the DATABASE_MANAGER class that stands for a simplified EiffelStore interface.

 * A graphical application framework based on EiffelVision2. This is a ready-to-use simple GUI for
your database, that can be widely extended to develop your own project. This framework uses the
EiffelStore DataView cluster and the set of classes described below.


CURRENT LIMITATIONS

The EiffelStore Wizard is a beta release. Please note the following limitations:

 * You must choose at least one table before doing the generation. 

 * Any table that you select must have at least one Column. 

 *(ODBC) In the generated Ace file, the link to ODBC32.lib appears as: 
 	"$EIFFEL4\library\store\spec\$(COMPILER)\lib\odbc32.lib".
 	To have access to the library, you should either copy it to this destination,
 	or change the Ace file line to refer to the library's location. 

 * The Wizard always regenerates the project from scratch.
 	 Any modifications that you have made in a previous generation will be lost. 

 * After generation, the wizard launches EiffelBench and a compilation.
 	 If a project was already present, the compilation first needs to delete it, 
 	 but will fail if it doesn't have the proper permissions. 

 * If you are using Microsoft's SQL Server, you should check the box Specific Tables/Views;
 	 do not try to generate the System tables as you wouldn't be able to perform requests
 	 on some of these tables. 

 * The Wizard doesn't support tables with a dollar sign $ in their names,
 	 as this is not a valid character in Eiffel identifiers. 

 * The generated classes that describes your database may not compile if your database contains
	table or attribute names that are Eiffel reserved words.

 * (ODBC) The classes that describes your database tables won't give table primary and foreign
	keys but you can easily add this information into the generated classes.
	
