indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Xml.Schema.XmlSchemaAppInfo"

external class
	SYSTEM_XML_SCHEMA_XMLSCHEMAAPPINFO

inherit
	SYSTEM_XML_SCHEMA_XMLSCHEMAOBJECT

create
	make_xmlschemaappinfo

feature {NONE} -- Initialization

	frozen make_xmlschemaappinfo is
		external
			"IL creator use System.Xml.Schema.XmlSchemaAppInfo"
		end

feature -- Access

	frozen get_markup: ARRAY [SYSTEM_XML_XMLNODE] is
		external
			"IL signature (): System.Xml.XmlNode[] use System.Xml.Schema.XmlSchemaAppInfo"
		alias
			"get_Markup"
		end

	frozen get_source: STRING is
		external
			"IL signature (): System.String use System.Xml.Schema.XmlSchemaAppInfo"
		alias
			"get_Source"
		end

feature -- Element Change

	frozen set_source (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Xml.Schema.XmlSchemaAppInfo"
		alias
			"set_Source"
		end

	frozen set_markup (value: ARRAY [SYSTEM_XML_XMLNODE]) is
		external
			"IL signature (System.Xml.XmlNode[]): System.Void use System.Xml.Schema.XmlSchemaAppInfo"
		alias
			"set_Markup"
		end

end -- class SYSTEM_XML_SCHEMA_XMLSCHEMAAPPINFO
