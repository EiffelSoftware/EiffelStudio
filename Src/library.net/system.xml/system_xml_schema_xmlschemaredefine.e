indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Xml.Schema.XmlSchemaRedefine"

external class
	SYSTEM_XML_SCHEMA_XMLSCHEMAREDEFINE

inherit
	SYSTEM_XML_SCHEMA_XMLSCHEMAEXTERNAL

create
	make_xmlschemaredefine

feature {NONE} -- Initialization

	frozen make_xmlschemaredefine is
		external
			"IL creator use System.Xml.Schema.XmlSchemaRedefine"
		end

feature -- Access

	frozen get_attribute_groups: SYSTEM_XML_SCHEMA_XMLSCHEMAOBJECTTABLE is
		external
			"IL signature (): System.Xml.Schema.XmlSchemaObjectTable use System.Xml.Schema.XmlSchemaRedefine"
		alias
			"get_AttributeGroups"
		end

	frozen get_items: SYSTEM_XML_SCHEMA_XMLSCHEMAOBJECTCOLLECTION is
		external
			"IL signature (): System.Xml.Schema.XmlSchemaObjectCollection use System.Xml.Schema.XmlSchemaRedefine"
		alias
			"get_Items"
		end

	frozen get_schema_types: SYSTEM_XML_SCHEMA_XMLSCHEMAOBJECTTABLE is
		external
			"IL signature (): System.Xml.Schema.XmlSchemaObjectTable use System.Xml.Schema.XmlSchemaRedefine"
		alias
			"get_SchemaTypes"
		end

	frozen get_groups: SYSTEM_XML_SCHEMA_XMLSCHEMAOBJECTTABLE is
		external
			"IL signature (): System.Xml.Schema.XmlSchemaObjectTable use System.Xml.Schema.XmlSchemaRedefine"
		alias
			"get_Groups"
		end

end -- class SYSTEM_XML_SCHEMA_XMLSCHEMAREDEFINE
