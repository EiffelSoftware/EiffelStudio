indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Xml.Schema.XmlSchemaDatatype"

deferred external class
	SYSTEM_XML_SCHEMA_XMLSCHEMADATATYPE

feature -- Access

	get_tokenized_type: SYSTEM_XML_XMLTOKENIZEDTYPE is
		external
			"IL deferred signature (): System.Xml.XmlTokenizedType use System.Xml.Schema.XmlSchemaDatatype"
		alias
			"get_TokenizedType"
		end

	get_value_type: SYSTEM_TYPE is
		external
			"IL deferred signature (): System.Type use System.Xml.Schema.XmlSchemaDatatype"
		alias
			"get_ValueType"
		end

feature -- Basic Operations

	parse_value (s: STRING; name_table: SYSTEM_XML_XMLNAMETABLE; nsmgr: SYSTEM_XML_XMLNAMESPACEMANAGER): ANY is
		external
			"IL deferred signature (System.String, System.Xml.XmlNameTable, System.Xml.XmlNamespaceManager): System.Object use System.Xml.Schema.XmlSchemaDatatype"
		alias
			"ParseValue"
		end

end -- class SYSTEM_XML_SCHEMA_XMLSCHEMADATATYPE
