indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Xml.Schema.XmlSchemaSimpleTypeList"

external class
	SYSTEM_XML_SCHEMA_XMLSCHEMASIMPLETYPELIST

inherit
	SYSTEM_XML_SCHEMA_XMLSCHEMASIMPLETYPECONTENT

create
	make_xmlschemasimpletypelist

feature {NONE} -- Initialization

	frozen make_xmlschemasimpletypelist is
		external
			"IL creator use System.Xml.Schema.XmlSchemaSimpleTypeList"
		end

feature -- Access

	frozen get_item_type_name: SYSTEM_XML_XMLQUALIFIEDNAME is
		external
			"IL signature (): System.Xml.XmlQualifiedName use System.Xml.Schema.XmlSchemaSimpleTypeList"
		alias
			"get_ItemTypeName"
		end

	frozen get_item_type: SYSTEM_XML_SCHEMA_XMLSCHEMASIMPLETYPE is
		external
			"IL signature (): System.Xml.Schema.XmlSchemaSimpleType use System.Xml.Schema.XmlSchemaSimpleTypeList"
		alias
			"get_ItemType"
		end

feature -- Element Change

	frozen set_item_type_name (value: SYSTEM_XML_XMLQUALIFIEDNAME) is
		external
			"IL signature (System.Xml.XmlQualifiedName): System.Void use System.Xml.Schema.XmlSchemaSimpleTypeList"
		alias
			"set_ItemTypeName"
		end

	frozen set_item_type (value: SYSTEM_XML_SCHEMA_XMLSCHEMASIMPLETYPE) is
		external
			"IL signature (System.Xml.Schema.XmlSchemaSimpleType): System.Void use System.Xml.Schema.XmlSchemaSimpleTypeList"
		alias
			"set_ItemType"
		end

end -- class SYSTEM_XML_SCHEMA_XMLSCHEMASIMPLETYPELIST
