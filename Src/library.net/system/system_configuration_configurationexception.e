indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Configuration.ConfigurationException"

external class
	SYSTEM_CONFIGURATION_CONFIGURATIONEXCEPTION

inherit
	SYSTEM_SYSTEMEXCEPTION
		redefine
			get_message
		end
	SYSTEM_RUNTIME_SERIALIZATION_ISERIALIZABLE

create
	make_configurationexception_6,
	make_configurationexception_5,
	make_configurationexception_4,
	make_configurationexception_3,
	make_configurationexception_2,
	make_configurationexception_1,
	make_configurationexception

feature {NONE} -- Initialization

	frozen make_configurationexception_6 (message: STRING; inner: SYSTEM_EXCEPTION; filename: STRING; line: INTEGER) is
		external
			"IL creator signature (System.String, System.Exception, System.String, System.Int32) use System.Configuration.ConfigurationException"
		end

	frozen make_configurationexception_5 (message: STRING; filename: STRING; line: INTEGER) is
		external
			"IL creator signature (System.String, System.String, System.Int32) use System.Configuration.ConfigurationException"
		end

	frozen make_configurationexception_4 (message: STRING; inner: SYSTEM_EXCEPTION; node: SYSTEM_XML_XMLNODE) is
		external
			"IL creator signature (System.String, System.Exception, System.Xml.XmlNode) use System.Configuration.ConfigurationException"
		end

	frozen make_configurationexception_3 (message: STRING; node: SYSTEM_XML_XMLNODE) is
		external
			"IL creator signature (System.String, System.Xml.XmlNode) use System.Configuration.ConfigurationException"
		end

	frozen make_configurationexception_2 (message: STRING; inner: SYSTEM_EXCEPTION) is
		external
			"IL creator signature (System.String, System.Exception) use System.Configuration.ConfigurationException"
		end

	frozen make_configurationexception_1 (message: STRING) is
		external
			"IL creator signature (System.String) use System.Configuration.ConfigurationException"
		end

	frozen make_configurationexception is
		external
			"IL creator use System.Configuration.ConfigurationException"
		end

feature -- Access

	frozen get_bare_message: STRING is
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

	frozen get_filename: STRING is
		external
			"IL signature (): System.String use System.Configuration.ConfigurationException"
		alias
			"get_Filename"
		end

	get_message: STRING is
		external
			"IL signature (): System.String use System.Configuration.ConfigurationException"
		alias
			"get_Message"
		end

feature -- Basic Operations

	frozen get_xml_node_line_number (node: SYSTEM_XML_XMLNODE): INTEGER is
		external
			"IL static signature (System.Xml.XmlNode): System.Int32 use System.Configuration.ConfigurationException"
		alias
			"GetXmlNodeLineNumber"
		end

	frozen get_xml_node_filename (node: SYSTEM_XML_XMLNODE): STRING is
		external
			"IL static signature (System.Xml.XmlNode): System.String use System.Configuration.ConfigurationException"
		alias
			"GetXmlNodeFilename"
		end

end -- class SYSTEM_CONFIGURATION_CONFIGURATIONEXCEPTION
