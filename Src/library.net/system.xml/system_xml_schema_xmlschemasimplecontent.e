indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Xml.Schema.XmlSchemaSimpleContent"

external class
	SYSTEM_XML_SCHEMA_XMLSCHEMASIMPLECONTENT

inherit
	SYSTEM_XML_SCHEMA_XMLSCHEMACONTENTMODEL

create
	make_xmlschemasimplecontent

feature {NONE} -- Initialization

	frozen make_xmlschemasimplecontent is
		external
			"IL creator use System.Xml.Schema.XmlSchemaSimpleContent"
		end

feature -- Access

	get_content: SYSTEM_XML_SCHEMA_XMLSCHEMACONTENT is
		external
			"IL signature (): System.Xml.Schema.XmlSchemaContent use System.Xml.Schema.XmlSchemaSimpleContent"
		alias
			"get_Content"
		end

feature -- Element Change

	set_content (value: SYSTEM_XML_SCHEMA_XMLSCHEMACONTENT) is
		external
			"IL signature (System.Xml.Schema.XmlSchemaContent): System.Void use System.Xml.Schema.XmlSchemaSimpleContent"
		alias
			"set_Content"
		end

end -- class SYSTEM_XML_SCHEMA_XMLSCHEMASIMPLECONTENT
