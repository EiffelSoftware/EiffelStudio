indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Xml.Schema.XmlSchemaSimpleTypeUnion"

external class
	SYSTEM_XML_SCHEMA_XMLSCHEMASIMPLETYPEUNION

inherit
	SYSTEM_XML_SCHEMA_XMLSCHEMASIMPLETYPECONTENT

create
	make_xmlschemasimpletypeunion

feature {NONE} -- Initialization

	frozen make_xmlschemasimpletypeunion is
		external
			"IL creator use System.Xml.Schema.XmlSchemaSimpleTypeUnion"
		end

feature -- Access

	frozen get_base_types: SYSTEM_XML_SCHEMA_XMLSCHEMAOBJECTCOLLECTION is
		external
			"IL signature (): System.Xml.Schema.XmlSchemaObjectCollection use System.Xml.Schema.XmlSchemaSimpleTypeUnion"
		alias
			"get_BaseTypes"
		end

	frozen get_member_types_source: STRING is
		external
			"IL signature (): System.String use System.Xml.Schema.XmlSchemaSimpleTypeUnion"
		alias
			"get_MemberTypesSource"
		end

feature -- Element Change

	frozen set_member_types_source (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Xml.Schema.XmlSchemaSimpleTypeUnion"
		alias
			"set_MemberTypesSource"
		end

end -- class SYSTEM_XML_SCHEMA_XMLSCHEMASIMPLETYPEUNION
