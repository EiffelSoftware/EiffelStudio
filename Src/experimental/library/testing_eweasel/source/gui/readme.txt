Graphical front end for Eweasel Readme
--------------------------------------

This front end for the eweasel command-line test execution suite is fairly simple.  To
run eweasel in graphical mode compile the ace file at $EWEASEL/compilation/eweasel.windows.gui.ace
(where $EWEASEL refers to the eweasel installation directory on your machine).

Once running use the 'Configuration' notebook page to set the required eweasel configuration
options before attempting to run any tests.  You can save the current configuration for quicker
retrieval next time.  If the configuration is correct you can load a test catalog file and the run
the tests and output will appear in the text box below.

.NET
----
To compile and run the tests for .NET make sure you have a 'dotnet' directory in 
$ISE_EIFFEL/studio/spec and select the dotnet option in the configuration part of the interface.  