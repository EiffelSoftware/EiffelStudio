<?xml version="1.0" encoding="ISO-8859-1"?>
<system xmlns="http://www.eiffel.com/developers/xml/configuration-1-21-0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://www.eiffel.com/developers/xml/configuration-1-21-0 http://www.eiffel.com/developers/xml/configuration-1-21-0.xsd" name="precomp_dotnet_base" uuid="FBDC60E2-A9D3-4724-A03F-BB9C72D2733C" library_target="base">
	<target name="base">
		<description>Base library</description>
		<root all_classes="true"/>
		<option warning="error">
		</option>
		<setting name="dotnet_naming_convention" value="true"/>
		<setting name="executable_name" value="EiffelSoftware.Library.Base"/>
		<setting name="msil_generation" value="true"/>
		<setting name="msil_generation_type" value="dll"/>
		<setting name="msil_clr_version" value="${MSIL_CLR_VERSION}"/>
		<capability>
			<concurrency support="none"/>
			<void_safety support="none"/>
		</capability>
		<library name="base" location="$ISE_LIBRARY\library\base\base.ecf"/>
	</target>
</system>
