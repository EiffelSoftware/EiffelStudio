indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Xml.Schema.XmlSchemaObjectTable"
	assembly: "System.Xml", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	SYSTEM_XML_XML_SCHEMA_OBJECT_TABLE

inherit
	SYSTEM_OBJECT

create {NONE}

feature -- Access

	frozen get_item (name: SYSTEM_XML_XML_QUALIFIED_NAME): SYSTEM_XML_XML_SCHEMA_OBJECT is
		external
			"IL signature (System.Xml.XmlQualifiedName): System.Xml.Schema.XmlSchemaObject use System.Xml.Schema.XmlSchemaObjectTable"
		alias
			"get_Item"
		end

	frozen get_names: ICOLLECTION is
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

	frozen get_values: ICOLLECTION is
		external
			"IL signature (): System.Collections.ICollection use System.Xml.Schema.XmlSchemaObjectTable"
		alias
			"get_Values"
		end

feature -- Basic Operations

	frozen get_enumerator: IDICTIONARY_ENUMERATOR is
		external
			"IL signature (): System.Collections.IDictionaryEnumerator use System.Xml.Schema.XmlSchemaObjectTable"
		alias
			"GetEnumerator"
		end

	frozen contains (name: SYSTEM_XML_XML_QUALIFIED_NAME): BOOLEAN is
		external
			"IL signature (System.Xml.XmlQualifiedName): System.Boolean use System.Xml.Schema.XmlSchemaObjectTable"
		alias
			"Contains"
		end

end -- class SYSTEM_XML_XML_SCHEMA_OBJECT_TABLE
