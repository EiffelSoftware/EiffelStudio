indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Xml.Schema.XmlSchemaKeyref"

external class
	SYSTEM_XML_SCHEMA_XMLSCHEMAKEYREF

inherit
	SYSTEM_XML_SCHEMA_XMLSCHEMAIDENTITYCONSTRAINT

create
	make_xmlschemakeyref

feature {NONE} -- Initialization

	frozen make_xmlschemakeyref is
		external
			"IL creator use System.Xml.Schema.XmlSchemaKeyref"
		end

feature -- Access

	frozen get_refer: SYSTEM_XML_XMLQUALIFIEDNAME is
		external
			"IL signature (): System.Xml.XmlQualifiedName use System.Xml.Schema.XmlSchemaKeyref"
		alias
			"get_Refer"
		end

feature -- Element Change

	frozen set_refer (value: SYSTEM_XML_XMLQUALIFIEDNAME) is
		external
			"IL signature (System.Xml.XmlQualifiedName): System.Void use System.Xml.Schema.XmlSchemaKeyref"
		alias
			"set_Refer"
		end

end -- class SYSTEM_XML_SCHEMA_XMLSCHEMAKEYREF
