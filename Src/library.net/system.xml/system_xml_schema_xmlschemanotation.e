indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Xml.Schema.XmlSchemaNotation"

external class
	SYSTEM_XML_SCHEMA_XMLSCHEMANOTATION

inherit
	SYSTEM_XML_SCHEMA_XMLSCHEMAANNOTATED

create
	make_xmlschemanotation

feature {NONE} -- Initialization

	frozen make_xmlschemanotation is
		external
			"IL creator use System.Xml.Schema.XmlSchemaNotation"
		end

feature -- Access

	frozen get_public: STRING is
		external
			"IL signature (): System.String use System.Xml.Schema.XmlSchemaNotation"
		alias
			"get_Public"
		end

	frozen get_system: STRING is
		external
			"IL signature (): System.String use System.Xml.Schema.XmlSchemaNotation"
		alias
			"get_System"
		end

	frozen get_name: STRING is
		external
			"IL signature (): System.String use System.Xml.Schema.XmlSchemaNotation"
		alias
			"get_Name"
		end

feature -- Element Change

	frozen set_name (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Xml.Schema.XmlSchemaNotation"
		alias
			"set_Name"
		end

	frozen set_system (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Xml.Schema.XmlSchemaNotation"
		alias
			"set_System"
		end

	frozen set_public (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Xml.Schema.XmlSchemaNotation"
		alias
			"set_Public"
		end

end -- class SYSTEM_XML_SCHEMA_XMLSCHEMANOTATION
