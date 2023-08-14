<?xml version="1.0" encoding="ISO-8859-1"?>
<system xmlns="http://www.eiffel.com/developers/xml/configuration-1-21-0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://www.eiffel.com/developers/xml/configuration-1-21-0 http://www.eiffel.com/developers/xml/configuration-1-21-0.xsd" name="precomp_dotnet_base-mt" uuid="B864C9F3-34D1-4401-A972-039C7920614E" library_target="base-mt">
	<target name="base-mt">
		<description>Base library</description>
		<root all_classes="true"/>
		<option warning="error">
		</option>
		<setting name="dotnet_naming_convention" value="true"/>
		<setting name="executable_name" value="EiffelSoftware.Library.BaseMt"/>
		<setting name="msil_generation" value="true"/>
		<setting name="msil_generation_type" value="dll"/>
		<setting name="msil_clr_version" value="${MSIL_CLR_VERSION}"/>
		<capability>
			<concurrency support="thread" use="thread"/>
			<void_safety support="none"/>
		</capability>
		<library name="base" location="$ISE_LIBRARY\library\base\base.ecf"/>
	</target>
</system>
