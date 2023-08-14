<?xml version="1.0" encoding="ISO-8859-1"?>
<system xmlns="http://www.eiffel.com/developers/xml/configuration-1-21-0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://www.eiffel.com/developers/xml/configuration-1-21-0 http://www.eiffel.com/developers/xml/configuration-1-21-0.xsd" name="precomp_dotnet_vision2" uuid="79D06C9D-B4A2-451D-9EAA-D02D9166936D" library_target="vision2">
	<target name="vision2">
		<description>Vision2 library</description>
		<root all_classes="true"/>
		<option warning="error">
		</option>
		<setting name="dotnet_naming_convention" value="true"/>
		<setting name="executable_name" value="EiffelSoftware.Library.Vision2"/>
		<setting name="msil_generation" value="true"/>
		<setting name="msil_generation_type" value="dll"/>
		<setting name="msil_use_optimized_precompile" value="true"/>
		<setting name="msil_clr_version" value="${MSIL_CLR_VERSION}"/>
		<capability>
			<concurrency support="none"/>
			<void_safety support="none"/>
		</capability>
		<precompile name="precompile" location="$ISE_PRECOMP\wel.ecf"/>
		<library name="base" location="$ISE_LIBRARY\library\base\base.ecf"/>
		<library name="vision2" location="$ISE_LIBRARY\library\vision2\vision2.ecf"/>
		<library name="wel" location="$ISE_LIBRARY\library\wel\wel.ecf"/>
	</target>
</system>
