indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Xml.Schema.XmlSchemaAttributeGroup"

external class
	SYSTEM_XML_SCHEMA_XMLSCHEMAATTRIBUTEGROUP

inherit
	SYSTEM_XML_SCHEMA_XMLSCHEMAANNOTATED

create
	make_xmlschemaattributegroup

feature {NONE} -- Initialization

	frozen make_xmlschemaattributegroup is
		external
			"IL creator use System.Xml.Schema.XmlSchemaAttributeGroup"
		end

feature -- Access

	frozen get_any_attribute: SYSTEM_XML_SCHEMA_XMLSCHEMAANYATTRIBUTE is
		external
			"IL signature (): System.Xml.Schema.XmlSchemaAnyAttribute use System.Xml.Schema.XmlSchemaAttributeGroup"
		alias
			"get_AnyAttribute"
		end

	frozen get_name: STRING is
		external
			"IL signature (): System.String use System.Xml.Schema.XmlSchemaAttributeGroup"
		alias
			"get_Name"
		end

	frozen get_attributes: SYSTEM_XML_SCHEMA_XMLSCHEMAOBJECTCOLLECTION is
		external
			"IL signature (): System.Xml.Schema.XmlSchemaObjectCollection use System.Xml.Schema.XmlSchemaAttributeGroup"
		alias
			"get_Attributes"
		end

feature -- Element Change

	frozen set_name (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Xml.Schema.XmlSchemaAttributeGroup"
		alias
			"set_Name"
		end

	frozen set_any_attribute (value: SYSTEM_XML_SCHEMA_XMLSCHEMAANYATTRIBUTE) is
		external
			"IL signature (System.Xml.Schema.XmlSchemaAnyAttribute): System.Void use System.Xml.Schema.XmlSchemaAttributeGroup"
		alias
			"set_AnyAttribute"
		end

end -- class SYSTEM_XML_SCHEMA_XMLSCHEMAATTRIBUTEGROUP
