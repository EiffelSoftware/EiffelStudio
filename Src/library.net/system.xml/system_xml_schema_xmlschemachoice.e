indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Xml.Schema.XmlSchemaChoice"

external class
	SYSTEM_XML_SCHEMA_XMLSCHEMACHOICE

inherit
	SYSTEM_XML_SCHEMA_XMLSCHEMAGROUPBASE

create
	make_xmlschemachoice

feature {NONE} -- Initialization

	frozen make_xmlschemachoice is
		external
			"IL creator use System.Xml.Schema.XmlSchemaChoice"
		end

feature -- Access

	get_items: SYSTEM_XML_SCHEMA_XMLSCHEMAOBJECTCOLLECTION is
		external
			"IL signature (): System.Xml.Schema.XmlSchemaObjectCollection use System.Xml.Schema.XmlSchemaChoice"
		alias
			"get_Items"
		end

end -- class SYSTEM_XML_SCHEMA_XMLSCHEMACHOICE
