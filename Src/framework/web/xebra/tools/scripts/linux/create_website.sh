
# install.sh
echo "under construction!";
exit;

if [ ! -d "$XEBRA_DEV" ]; then
 	echo "XEBRA_DEV is not defined or is not a directory. Please define before running script."
 	exit
fi

if [ ! $# = 3 ]; then
	echo "Wrong number of arguments. Usage: $0 <name> <port> <install_path>";
	exit;
fi;

cd $3;
# Create folders
echo "Creating folderss..."
mkdir $1;
cd $1;



# Create ecf project file
echo "Creating ecf project file..."
echo '<?xml version="1.0" encoding="ISO-8859-1"?>
<system xmlns="http://www.eiffel.com/developers/xml/configuration-1-5-0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://www.eiffel.com/developers/xml/configuration-1-5-0 http://www.eiffel.com/developers/xml/configuration-1-5-0.xsd" name="'$1'">
	<target name="'$1'">
		<root class="G_'$1'_APPLICATION" feature="make"/>
		<option full_class_checking="true">
			<assertions precondition="true" postcondition="true" check="true" invariant="true" loop="true" supplier_precondition="true"/>
		</option>
			<setting name="console_application" value="true"/>
		<setting name="multithreaded" value="true"/>
		<precompile name="precompile" location="$XEBRA_LIBRARY\xebra_precompile\xebra_precompile.ecf"/>
		<library name="base" location="$ISE_LIBRARY\library\base\base-safe.ecf"/>
		<library name="time" location="$ISE_LIBRARY\library\time\time-safe.ecf"/>
		<library name="xebra_http" location="$XEBRA_LIBRARY\xebra_http\xebra_http.ecf"/>
		<library name="xebra_web_application" location="$XEBRA_LIBRARY\xebra_web_application\xebra_web_application.ecf"/>
		<cluster name="'$1'" location=".\" recursive="true">
			<file_rule>
				<exclude>/EIFGENs$</exclude>
				<exclude>/.svn$</exclude>
				<exclude>/CVS$</exclude>
			</file_rule>
		</cluster>
	</target>
</system>
' > $1.ecf;

# Create config file
echo "Creating website config file..." 
echo '{
	"ecf": "$3/$1.ecf",
	"name": "$1",
	"port": "$2",
	"server_host": "localhost",
	"taglibs": 
	[
		{ 
			"name": "xebra_taglibrary_base",
			"ecf":  "xebra_taglibrary_base.ecf",
			"path": "$XEBRA_LIBRARY/xebra_taglibrary_base"
		}
	]	
}
' > config.wapp;

# Create xeb files and controller
echo "Creating xeb files and controller..."
echo '<html>
<page:controller class="MAIN_CONTROLLER"/>
<body>
'$1' works!
</body>
</html>' > index.xeb
echo 'note
	description: "[
		Provides features for the servlets
	]"
	legal: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	MAIN_CONTROLLER

inherit
	XWA_CONTROLLER redefine	make end

create
	make

feature {NONE} -- Initialization	

	make
			-- Initializes 'Current'
		do
			Precursor
		end
end' > main_controller.e
echo "All done."








	
