indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Xml.Schema.XmlSchemaDocumentation"

external class
	SYSTEM_XML_SCHEMA_XMLSCHEMADOCUMENTATION

inherit
	SYSTEM_XML_SCHEMA_XMLSCHEMAOBJECT

create
	make_xmlschemadocumentation

feature {NONE} -- Initialization

	frozen make_xmlschemadocumentation is
		external
			"IL creator use System.Xml.Schema.XmlSchemaDocumentation"
		end

feature -- Access

	frozen get_markup: ARRAY [SYSTEM_XML_XMLNODE] is
		external
			"IL signature (): System.Xml.XmlNode[] use System.Xml.Schema.XmlSchemaDocumentation"
		alias
			"get_Markup"
		end

	frozen get_source: STRING is
		external
			"IL signature (): System.String use System.Xml.Schema.XmlSchemaDocumentation"
		alias
			"get_Source"
		end

	frozen get_language: STRING is
		external
			"IL signature (): System.String use System.Xml.Schema.XmlSchemaDocumentation"
		alias
			"get_Language"
		end

feature -- Element Change

	frozen set_source (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Xml.Schema.XmlSchemaDocumentation"
		alias
			"set_Source"
		end

	frozen set_language (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Xml.Schema.XmlSchemaDocumentation"
		alias
			"set_Language"
		end

	frozen set_markup (value: ARRAY [SYSTEM_XML_XMLNODE]) is
		external
			"IL signature (System.Xml.XmlNode[]): System.Void use System.Xml.Schema.XmlSchemaDocumentation"
		alias
			"set_Markup"
		end

end -- class SYSTEM_XML_SCHEMA_XMLSCHEMADOCUMENTATION
