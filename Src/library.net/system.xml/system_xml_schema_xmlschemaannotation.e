indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Xml.Schema.XmlSchemaAnnotation"

external class
	SYSTEM_XML_SCHEMA_XMLSCHEMAANNOTATION

inherit
	SYSTEM_XML_SCHEMA_XMLSCHEMAOBJECT

create
	make_xmlschemaannotation

feature {NONE} -- Initialization

	frozen make_xmlschemaannotation is
		external
			"IL creator use System.Xml.Schema.XmlSchemaAnnotation"
		end

feature -- Access

	frozen get_items: SYSTEM_XML_SCHEMA_XMLSCHEMAOBJECTCOLLECTION is
		external
			"IL signature (): System.Xml.Schema.XmlSchemaObjectCollection use System.Xml.Schema.XmlSchemaAnnotation"
		alias
			"get_Items"
		end

end -- class SYSTEM_XML_SCHEMA_XMLSCHEMAANNOTATION
