indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Xml.Schema.XmlSchemaSimpleTypeRestriction"

external class
	SYSTEM_XML_SCHEMA_XMLSCHEMASIMPLETYPERESTRICTION

inherit
	SYSTEM_XML_SCHEMA_XMLSCHEMASIMPLETYPECONTENT

create
	make_xmlschemasimpletyperestriction

feature {NONE} -- Initialization

	frozen make_xmlschemasimpletyperestriction is
		external
			"IL creator use System.Xml.Schema.XmlSchemaSimpleTypeRestriction"
		end

feature -- Access

	frozen get_base_type: SYSTEM_XML_SCHEMA_XMLSCHEMASIMPLETYPE is
		external
			"IL signature (): System.Xml.Schema.XmlSchemaSimpleType use System.Xml.Schema.XmlSchemaSimpleTypeRestriction"
		alias
			"get_BaseType"
		end

	frozen get_facets: SYSTEM_XML_SCHEMA_XMLSCHEMAOBJECTCOLLECTION is
		external
			"IL signature (): System.Xml.Schema.XmlSchemaObjectCollection use System.Xml.Schema.XmlSchemaSimpleTypeRestriction"
		alias
			"get_Facets"
		end

	frozen get_base_type_name: SYSTEM_XML_XMLQUALIFIEDNAME is
		external
			"IL signature (): System.Xml.XmlQualifiedName use System.Xml.Schema.XmlSchemaSimpleTypeRestriction"
		alias
			"get_BaseTypeName"
		end

feature -- Element Change

	frozen set_base_type (value: SYSTEM_XML_SCHEMA_XMLSCHEMASIMPLETYPE) is
		external
			"IL signature (System.Xml.Schema.XmlSchemaSimpleType): System.Void use System.Xml.Schema.XmlSchemaSimpleTypeRestriction"
		alias
			"set_BaseType"
		end

	frozen set_base_type_name (value: SYSTEM_XML_XMLQUALIFIEDNAME) is
		external
			"IL signature (System.Xml.XmlQualifiedName): System.Void use System.Xml.Schema.XmlSchemaSimpleTypeRestriction"
		alias
			"set_BaseTypeName"
		end

end -- class SYSTEM_XML_SCHEMA_XMLSCHEMASIMPLETYPERESTRICTION
