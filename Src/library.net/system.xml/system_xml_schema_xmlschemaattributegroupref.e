indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Xml.Schema.XmlSchemaAttributeGroupRef"

external class
	SYSTEM_XML_SCHEMA_XMLSCHEMAATTRIBUTEGROUPREF

inherit
	SYSTEM_XML_SCHEMA_XMLSCHEMAANNOTATED

create
	make_xmlschemaattributegroupref

feature {NONE} -- Initialization

	frozen make_xmlschemaattributegroupref is
		external
			"IL creator use System.Xml.Schema.XmlSchemaAttributeGroupRef"
		end

feature -- Access

	frozen get_ref_name: SYSTEM_XML_XMLQUALIFIEDNAME is
		external
			"IL signature (): System.Xml.XmlQualifiedName use System.Xml.Schema.XmlSchemaAttributeGroupRef"
		alias
			"get_RefName"
		end

feature -- Element Change

	frozen set_ref_name (value: SYSTEM_XML_XMLQUALIFIEDNAME) is
		external
			"IL signature (System.Xml.XmlQualifiedName): System.Void use System.Xml.Schema.XmlSchemaAttributeGroupRef"
		alias
			"set_RefName"
		end

end -- class SYSTEM_XML_SCHEMA_XMLSCHEMAATTRIBUTEGROUPREF
