indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Xml.Schema.XmlSchemaDatatype"
	assembly: "System.Xml", "1.0.3300.0", "neutral", "b77a5c561934e089"

deferred external class
	SYSTEM_XML_XML_SCHEMA_DATATYPE

inherit
	SYSTEM_OBJECT

feature -- Access

	get_tokenized_type: SYSTEM_XML_XML_TOKENIZED_TYPE is
		external
			"IL deferred signature (): System.Xml.XmlTokenizedType use System.Xml.Schema.XmlSchemaDatatype"
		alias
			"get_TokenizedType"
		end

	get_value_type: TYPE is
		external
			"IL deferred signature (): System.Type use System.Xml.Schema.XmlSchemaDatatype"
		alias
			"get_ValueType"
		end

feature -- Basic Operations

	parse_value (s: SYSTEM_STRING; name_table: SYSTEM_XML_XML_NAME_TABLE; nsmgr: SYSTEM_XML_XML_NAMESPACE_MANAGER): SYSTEM_OBJECT is
		external
			"IL deferred signature (System.String, System.Xml.XmlNameTable, System.Xml.XmlNamespaceManager): System.Object use System.Xml.Schema.XmlSchemaDatatype"
		alias
			"ParseValue"
		end

end -- class SYSTEM_XML_XML_SCHEMA_DATATYPE
