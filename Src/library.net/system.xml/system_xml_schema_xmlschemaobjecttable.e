indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Xml.Schema.XmlSchemaObjectTable"

external class
	SYSTEM_XML_SCHEMA_XMLSCHEMAOBJECTTABLE

create {NONE}

feature -- Access

	frozen get_item (name: SYSTEM_XML_XMLQUALIFIEDNAME): SYSTEM_XML_SCHEMA_XMLSCHEMAOBJECT is
		external
			"IL signature (System.Xml.XmlQualifiedName): System.Xml.Schema.XmlSchemaObject use System.Xml.Schema.XmlSchemaObjectTable"
		alias
			"get_Item"
		end

	frozen get_names: SYSTEM_COLLECTIONS_ICOLLECTION is
		external
			"IL signature (): System.Collections.ICollection use System.Xml.Schema.XmlSchemaObjectTable"
		alias
			"get_Names"
		end

	frozen get_count: INTEGER is
		external
			"IL signature (): System.Int32 use System.Xml.Schema.XmlSchemaObjectTable"
		alias
			"get_Count"
		end

	frozen get_values: SYSTEM_COLLECTIONS_ICOLLECTION is
		external
			"IL signature (): System.Collections.ICollection use System.Xml.Schema.XmlSchemaObjectTable"
		alias
			"get_Values"
		end

feature -- Basic Operations

	frozen get_enumerator: SYSTEM_COLLECTIONS_IDICTIONARYENUMERATOR is
		external
			"IL signature (): System.Collections.IDictionaryEnumerator use System.Xml.Schema.XmlSchemaObjectTable"
		alias
			"GetEnumerator"
		end

	frozen contains (name: SYSTEM_XML_XMLQUALIFIEDNAME): BOOLEAN is
		external
			"IL signature (System.Xml.XmlQualifiedName): System.Boolean use System.Xml.Schema.XmlSchemaObjectTable"
		alias
			"Contains"
		end

end -- class SYSTEM_XML_SCHEMA_XMLSCHEMAOBJECTTABLE
