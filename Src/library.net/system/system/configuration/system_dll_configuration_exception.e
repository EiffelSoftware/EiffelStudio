indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Configuration.ConfigurationException"
	assembly: "System", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	SYSTEM_DLL_CONFIGURATION_EXCEPTION

inherit
	SYSTEM_EXCEPTION
		redefine
			get_object_data,
			get_message
		end
	ISERIALIZABLE

create
	make_system_dll_configuration_exception_1,
	make_system_dll_configuration_exception,
	make_system_dll_configuration_exception_3,
	make_system_dll_configuration_exception_2,
	make_system_dll_configuration_exception_5,
	make_system_dll_configuration_exception_4,
	make_system_dll_configuration_exception_6

feature {NONE} -- Initialization

	frozen make_system_dll_configuration_exception_1 (message: SYSTEM_STRING) is
		external
			"IL creator signature (System.String) use System.Configuration.ConfigurationException"
		end

	frozen make_system_dll_configuration_exception is
		external
			"IL creator use System.Configuration.ConfigurationException"
		end

	frozen make_system_dll_configuration_exception_3 (message: SYSTEM_STRING; node: SYSTEM_XML_XML_NODE) is
		external
			"IL creator signature (System.String, System.Xml.XmlNode) use System.Configuration.ConfigurationException"
		end

	frozen make_system_dll_configuration_exception_2 (message: SYSTEM_STRING; inner: EXCEPTION) is
		external
			"IL creator signature (System.String, System.Exception) use System.Configuration.ConfigurationException"
		end

	frozen make_system_dll_configuration_exception_5 (message: SYSTEM_STRING; filename: SYSTEM_STRING; line: INTEGER) is
		external
			"IL creator signature (System.String, System.String, System.Int32) use System.Configuration.ConfigurationException"
		end

	frozen make_system_dll_configuration_exception_4 (message: SYSTEM_STRING; inner: EXCEPTION; node: SYSTEM_XML_XML_NODE) is
		external
			"IL creator signature (System.String, System.Exception, System.Xml.XmlNode) use System.Configuration.ConfigurationException"
		end

	frozen make_system_dll_configuration_exception_6 (message: SYSTEM_STRING; inner: EXCEPTION; filename: SYSTEM_STRING; line: INTEGER) is
		external
			"IL creator signature (System.String, System.Exception, System.String, System.Int32) use System.Configuration.ConfigurationException"
		end

feature -- Access

	frozen get_bare_message: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Configuration.ConfigurationException"
		alias
			"get_BareMessage"
		end

	frozen get_line: INTEGER is
		external
			"IL signature (): System.Int32 use System.Configuration.ConfigurationException"
		alias
			"get_Line"
		end

	frozen get_filename: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Configuration.ConfigurationException"
		alias
			"get_Filename"
		end

	get_message: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Configuration.ConfigurationException"
		alias
			"get_Message"
		end

feature -- Basic Operations

	frozen get_xml_node_line_number (node: SYSTEM_XML_XML_NODE): INTEGER is
		external
			"IL static signature (System.Xml.XmlNode): System.Int32 use System.Configuration.ConfigurationException"
		alias
			"GetXmlNodeLineNumber"
		end

	get_object_data (info: SERIALIZATION_INFO; context: STREAMING_CONTEXT) is
		external
			"IL signature (System.Runtime.Serialization.SerializationInfo, System.Runtime.Serialization.StreamingContext): System.Void use System.Configuration.ConfigurationException"
		alias
			"GetObjectData"
		end

	frozen get_xml_node_filename (node: SYSTEM_XML_XML_NODE): SYSTEM_STRING is
		external
			"IL static signature (System.Xml.XmlNode): System.String use System.Configuration.ConfigurationException"
		alias
			"GetXmlNodeFilename"
		end

end -- class SYSTEM_DLL_CONFIGURATION_EXCEPTION
