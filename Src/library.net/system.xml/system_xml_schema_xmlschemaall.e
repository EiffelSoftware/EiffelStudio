indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Xml.Schema.XmlSchemaAll"

external class
	SYSTEM_XML_SCHEMA_XMLSCHEMAALL

inherit
	SYSTEM_XML_SCHEMA_XMLSCHEMAGROUPBASE

create
	make_xmlschemaall

feature {NONE} -- Initialization

	frozen make_xmlschemaall is
		external
			"IL creator use System.Xml.Schema.XmlSchemaAll"
		end

feature -- Access

	get_items: SYSTEM_XML_SCHEMA_XMLSCHEMAOBJECTCOLLECTION is
		external
			"IL signature (): System.Xml.Schema.XmlSchemaObjectCollection use System.Xml.Schema.XmlSchemaAll"
		alias
			"get_Items"
		end

end -- class SYSTEM_XML_SCHEMA_XMLSCHEMAALL
