indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Xml.Schema.XmlSchemaXPath"
	assembly: "System.Xml", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	SYSTEM_XML_XML_SCHEMA_XPATH

inherit
	SYSTEM_XML_XML_SCHEMA_ANNOTATED

create
	make_system_xml_xml_schema_xpath

feature {NONE} -- Initialization

	frozen make_system_xml_xml_schema_xpath is
		external
			"IL creator use System.Xml.Schema.XmlSchemaXPath"
		end

feature -- Access

	frozen get_xpath: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Xml.Schema.XmlSchemaXPath"
		alias
			"get_XPath"
		end

feature -- Element Change

	frozen set_xpath (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Xml.Schema.XmlSchemaXPath"
		alias
			"set_XPath"
		end

end -- class SYSTEM_XML_XML_SCHEMA_XPATH
