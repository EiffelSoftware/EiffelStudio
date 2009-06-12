if [ -x "$XEBRA_DEV" ]; then
	:
else
 	echo "XEBRA_DEV is not defined. Please define before running script.";
 	exit;
fi;

if [ -x "$EIFFEL_SRC" ]; then
	:
else
 	echo "EIFFEL_SRC is not defined. Please define before running script.";
 	exit;
fi;

if [ -x "$ISE_EIFFEL" ]; then
	:
else
 	echo "ISE_EIFFEL is not defined. Please define before running script.";
 	exit;
fi;


if [ -x "$ISE_LIBRARY" ]; then
	:
else
 	echo "ISE_LIBRARYis not defined. Please define before running script.";
 	exit;
fi;

if [ -x "$APACHE2" ]; then
	:
else
 	echo "APACHE2 is not defined. Please define before running script.";
 	exit;
fi;



if [ ! $# = 3 ]; then
	echo "Wrong number of arguments. Usage: $0 <name> <port> <install_path>";
	exit;
fi;

cd $3;

# Create folders
echo "Creating folderss..."
mkdir $1;
cd $1;
mkdir $APACHE2/htdocs/$1


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
		<library name="base" location="$ISE_LIBRARY\library\base\base.ecf"/>
		<library name="gobo_kernel" location="$ISE_LIBRARY\library\gobo\gobo_kernel.ecf"/>
		<library name="settable_types" location="$EIFFEL_SRC\framework\settable_types\settable_types.ecf"/>
		<library name="xebra_http" location="$XEBRA_DEV\eiffel_projects\library\xebra_http\xebra_http-voidunsafe.ecf"/>
		<library name="xebra_ini" location="$XEBRA_DEV\eiffel_projects\library\xebra_ini\xebra_ini-voidunsafe.ecf"/>
		<library name="xebra_web_application" location="$XEBRA_DEV\eiffel_projects\library\xebra_web_application\xebra_web_application-voidunsafe.ecf" readonly="false"/>
		<cluster name="xebrawebapp" location=".\" recursive="true">
			<file_rule>
				<exclude>/EIFGENs$</exclude>
				<exclude>/.svn$</exclude>
				<exclude>/CVS$</exclude>
			</file_rule>
		</cluster>
	</target>
</system>
' > $1.ecf;

# Create ini file
echo "Creating website config file..." 
echo "name=$1
port=$2
host=localhost
is_interactive=false" > config.ini;

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








	
