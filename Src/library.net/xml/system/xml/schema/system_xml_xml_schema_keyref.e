indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Xml.Schema.XmlSchemaKeyref"
	assembly: "System.Xml", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	SYSTEM_XML_XML_SCHEMA_KEYREF

inherit
	SYSTEM_XML_XML_SCHEMA_IDENTITY_CONSTRAINT

create
	make_system_xml_xml_schema_keyref

feature {NONE} -- Initialization

	frozen make_system_xml_xml_schema_keyref is
		external
			"IL creator use System.Xml.Schema.XmlSchemaKeyref"
		end

feature -- Access

	frozen get_refer: SYSTEM_XML_XML_QUALIFIED_NAME is
		external
			"IL signature (): System.Xml.XmlQualifiedName use System.Xml.Schema.XmlSchemaKeyref"
		alias
			"get_Refer"
		end

feature -- Element Change

	frozen set_refer (value: SYSTEM_XML_XML_QUALIFIED_NAME) is
		external
			"IL signature (System.Xml.XmlQualifiedName): System.Void use System.Xml.Schema.XmlSchemaKeyref"
		alias
			"set_Refer"
		end

end -- class SYSTEM_XML_XML_SCHEMA_KEYREF
