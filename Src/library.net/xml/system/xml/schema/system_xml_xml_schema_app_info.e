indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Xml.Schema.XmlSchemaAppInfo"
	assembly: "System.Xml", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	SYSTEM_XML_XML_SCHEMA_APP_INFO

inherit
	SYSTEM_XML_XML_SCHEMA_OBJECT

create
	make_system_xml_xml_schema_app_info

feature {NONE} -- Initialization

	frozen make_system_xml_xml_schema_app_info is
		external
			"IL creator use System.Xml.Schema.XmlSchemaAppInfo"
		end

feature -- Access

	frozen get_markup: NATIVE_ARRAY [SYSTEM_XML_XML_NODE] is
		external
			"IL signature (): System.Xml.XmlNode[] use System.Xml.Schema.XmlSchemaAppInfo"
		alias
			"get_Markup"
		end

	frozen get_source: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Xml.Schema.XmlSchemaAppInfo"
		alias
			"get_Source"
		end

feature -- Element Change

	frozen set_source (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Xml.Schema.XmlSchemaAppInfo"
		alias
			"set_Source"
		end

	frozen set_markup (value: NATIVE_ARRAY [SYSTEM_XML_XML_NODE]) is
		external
			"IL signature (System.Xml.XmlNode[]): System.Void use System.Xml.Schema.XmlSchemaAppInfo"
		alias
			"set_Markup"
		end

end -- class SYSTEM_XML_XML_SCHEMA_APP_INFO
