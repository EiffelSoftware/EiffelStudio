indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Xml.Schema.XmlSchemaExternal"

deferred external class
	SYSTEM_XML_SCHEMA_XMLSCHEMAEXTERNAL

inherit
	SYSTEM_XML_SCHEMA_XMLSCHEMAANNOTATED

feature -- Access

	frozen get_schema_location: STRING is
		external
			"IL signature (): System.String use System.Xml.Schema.XmlSchemaExternal"
		alias
			"get_SchemaLocation"
		end

	frozen get_schema: SYSTEM_XML_SCHEMA_XMLSCHEMA is
		external
			"IL signature (): System.Xml.Schema.XmlSchema use System.Xml.Schema.XmlSchemaExternal"
		alias
			"get_Schema"
		end

feature -- Element Change

	frozen set_schema (value: SYSTEM_XML_SCHEMA_XMLSCHEMA) is
		external
			"IL signature (System.Xml.Schema.XmlSchema): System.Void use System.Xml.Schema.XmlSchemaExternal"
		alias
			"set_Schema"
		end

	frozen set_schema_location (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Xml.Schema.XmlSchemaExternal"
		alias
			"set_SchemaLocation"
		end

end -- class SYSTEM_XML_SCHEMA_XMLSCHEMAEXTERNAL
