indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Xml.Schema.XmlSchemaComplexContent"

external class
	SYSTEM_XML_SCHEMA_XMLSCHEMACOMPLEXCONTENT

inherit
	SYSTEM_XML_SCHEMA_XMLSCHEMACONTENTMODEL

create
	make_xmlschemacomplexcontent

feature {NONE} -- Initialization

	frozen make_xmlschemacomplexcontent is
		external
			"IL creator use System.Xml.Schema.XmlSchemaComplexContent"
		end

feature -- Access

	frozen get_is_mixed: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Xml.Schema.XmlSchemaComplexContent"
		alias
			"get_IsMixed"
		end

	get_content: SYSTEM_XML_SCHEMA_XMLSCHEMACONTENT is
		external
			"IL signature (): System.Xml.Schema.XmlSchemaContent use System.Xml.Schema.XmlSchemaComplexContent"
		alias
			"get_Content"
		end

feature -- Element Change

	set_content (value: SYSTEM_XML_SCHEMA_XMLSCHEMACONTENT) is
		external
			"IL signature (System.Xml.Schema.XmlSchemaContent): System.Void use System.Xml.Schema.XmlSchemaComplexContent"
		alias
			"set_Content"
		end

	frozen set_is_mixed (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Xml.Schema.XmlSchemaComplexContent"
		alias
			"set_IsMixed"
		end

end -- class SYSTEM_XML_SCHEMA_XMLSCHEMACOMPLEXCONTENT
