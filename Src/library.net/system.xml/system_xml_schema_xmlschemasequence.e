indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Xml.Schema.XmlSchemaSequence"

external class
	SYSTEM_XML_SCHEMA_XMLSCHEMASEQUENCE

inherit
	SYSTEM_XML_SCHEMA_XMLSCHEMAGROUPBASE

create
	make_xmlschemasequence

feature {NONE} -- Initialization

	frozen make_xmlschemasequence is
		external
			"IL creator use System.Xml.Schema.XmlSchemaSequence"
		end

feature -- Access

	get_items: SYSTEM_XML_SCHEMA_XMLSCHEMAOBJECTCOLLECTION is
		external
			"IL signature (): System.Xml.Schema.XmlSchemaObjectCollection use System.Xml.Schema.XmlSchemaSequence"
		alias
			"get_Items"
		end

end -- class SYSTEM_XML_SCHEMA_XMLSCHEMASEQUENCE
