indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Xml.Schema.XmlSchemaSimpleType"

external class
	SYSTEM_XML_SCHEMA_XMLSCHEMASIMPLETYPE

inherit
	SYSTEM_XML_SCHEMA_XMLSCHEMATYPE

create
	make_xmlschemasimpletype

feature {NONE} -- Initialization

	frozen make_xmlschemasimpletype is
		external
			"IL creator use System.Xml.Schema.XmlSchemaSimpleType"
		end

feature -- Access

	frozen get_content: SYSTEM_XML_SCHEMA_XMLSCHEMASIMPLETYPECONTENT is
		external
			"IL signature (): System.Xml.Schema.XmlSchemaSimpleTypeContent use System.Xml.Schema.XmlSchemaSimpleType"
		alias
			"get_Content"
		end

feature -- Element Change

	frozen set_content (value: SYSTEM_XML_SCHEMA_XMLSCHEMASIMPLETYPECONTENT) is
		external
			"IL signature (System.Xml.Schema.XmlSchemaSimpleTypeContent): System.Void use System.Xml.Schema.XmlSchemaSimpleType"
		alias
			"set_Content"
		end

end -- class SYSTEM_XML_SCHEMA_XMLSCHEMASIMPLETYPE
