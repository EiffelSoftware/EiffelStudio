indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Xml.Schema.XmlSchemaObject"

deferred external class
	SYSTEM_XML_SCHEMA_XMLSCHEMAOBJECT

feature -- Access

	frozen get_source_uri: STRING is
		external
			"IL signature (): System.String use System.Xml.Schema.XmlSchemaObject"
		alias
			"get_SourceUri"
		end

	frozen get_line_number: INTEGER is
		external
			"IL signature (): System.Int32 use System.Xml.Schema.XmlSchemaObject"
		alias
			"get_LineNumber"
		end

	frozen get_line_position: INTEGER is
		external
			"IL signature (): System.Int32 use System.Xml.Schema.XmlSchemaObject"
		alias
			"get_LinePosition"
		end

feature -- Element Change

	frozen set_line_position (value: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.Xml.Schema.XmlSchemaObject"
		alias
			"set_LinePosition"
		end

	frozen set_source_uri (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Xml.Schema.XmlSchemaObject"
		alias
			"set_SourceUri"
		end

	frozen set_line_number (value: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.Xml.Schema.XmlSchemaObject"
		alias
			"set_LineNumber"
		end

end -- class SYSTEM_XML_SCHEMA_XMLSCHEMAOBJECT
