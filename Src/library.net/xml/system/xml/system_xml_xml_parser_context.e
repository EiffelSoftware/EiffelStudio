indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Xml.XmlParserContext"
	assembly: "System.Xml", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	SYSTEM_XML_XML_PARSER_CONTEXT

inherit
	SYSTEM_OBJECT

create
	make_3,
	make_2,
	make,
	make_1

feature {NONE} -- Initialization

	frozen make_3 (nt: SYSTEM_XML_XML_NAME_TABLE; ns_mgr: SYSTEM_XML_XML_NAMESPACE_MANAGER; doc_type_name: SYSTEM_STRING; pub_id: SYSTEM_STRING; sys_id: SYSTEM_STRING; internal_subset: SYSTEM_STRING; base_uri: SYSTEM_STRING; xml_lang: SYSTEM_STRING; xml_space: SYSTEM_XML_XML_SPACE; enc: ENCODING) is
		external
			"IL creator signature (System.Xml.XmlNameTable, System.Xml.XmlNamespaceManager, System.String, System.String, System.String, System.String, System.String, System.String, System.Xml.XmlSpace, System.Text.Encoding) use System.Xml.XmlParserContext"
		end

	frozen make_2 (nt: SYSTEM_XML_XML_NAME_TABLE; ns_mgr: SYSTEM_XML_XML_NAMESPACE_MANAGER; doc_type_name: SYSTEM_STRING; pub_id: SYSTEM_STRING; sys_id: SYSTEM_STRING; internal_subset: SYSTEM_STRING; base_uri: SYSTEM_STRING; xml_lang: SYSTEM_STRING; xml_space: SYSTEM_XML_XML_SPACE) is
		external
			"IL creator signature (System.Xml.XmlNameTable, System.Xml.XmlNamespaceManager, System.String, System.String, System.String, System.String, System.String, System.String, System.Xml.XmlSpace) use System.Xml.XmlParserContext"
		end

	frozen make (nt: SYSTEM_XML_XML_NAME_TABLE; ns_mgr: SYSTEM_XML_XML_NAMESPACE_MANAGER; xml_lang: SYSTEM_STRING; xml_space: SYSTEM_XML_XML_SPACE) is
		external
			"IL creator signature (System.Xml.XmlNameTable, System.Xml.XmlNamespaceManager, System.String, System.Xml.XmlSpace) use System.Xml.XmlParserContext"
		end

	frozen make_1 (nt: SYSTEM_XML_XML_NAME_TABLE; ns_mgr: SYSTEM_XML_XML_NAMESPACE_MANAGER; xml_lang: SYSTEM_STRING; xml_space: SYSTEM_XML_XML_SPACE; enc: ENCODING) is
		external
			"IL creator signature (System.Xml.XmlNameTable, System.Xml.XmlNamespaceManager, System.String, System.Xml.XmlSpace, System.Text.Encoding) use System.Xml.XmlParserContext"
		end

feature -- Access

	frozen get_xml_lang: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Xml.XmlParserContext"
		alias
			"get_XmlLang"
		end

	frozen get_encoding: ENCODING is
		external
			"IL signature (): System.Text.Encoding use System.Xml.XmlParserContext"
		alias
			"get_Encoding"
		end

	frozen get_xml_space: SYSTEM_XML_XML_SPACE is
		external
			"IL signature (): System.Xml.XmlSpace use System.Xml.XmlParserContext"
		alias
			"get_XmlSpace"
		end

	frozen get_base_uri: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Xml.XmlParserContext"
		alias
			"get_BaseURI"
		end

	frozen get_public_id: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Xml.XmlParserContext"
		alias
			"get_PublicId"
		end

	frozen get_internal_subset: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Xml.XmlParserContext"
		alias
			"get_InternalSubset"
		end

	frozen get_doc_type_name: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Xml.XmlParserContext"
		alias
			"get_DocTypeName"
		end

	frozen get_namespace_manager: SYSTEM_XML_XML_NAMESPACE_MANAGER is
		external
			"IL signature (): System.Xml.XmlNamespaceManager use System.Xml.XmlParserContext"
		alias
			"get_NamespaceManager"
		end

	frozen get_system_id: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Xml.XmlParserContext"
		alias
			"get_SystemId"
		end

	frozen get_name_table: SYSTEM_XML_XML_NAME_TABLE is
		external
			"IL signature (): System.Xml.XmlNameTable use System.Xml.XmlParserContext"
		alias
			"get_NameTable"
		end

feature -- Element Change

	frozen set_doc_type_name (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Xml.XmlParserContext"
		alias
			"set_DocTypeName"
		end

	frozen set_encoding (value: ENCODING) is
		external
			"IL signature (System.Text.Encoding): System.Void use System.Xml.XmlParserContext"
		alias
			"set_Encoding"
		end

	frozen set_base_uri (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Xml.XmlParserContext"
		alias
			"set_BaseURI"
		end

	frozen set_system_id (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Xml.XmlParserContext"
		alias
			"set_SystemId"
		end

	frozen set_internal_subset (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Xml.XmlParserContext"
		alias
			"set_InternalSubset"
		end

	frozen set_namespace_manager (value: SYSTEM_XML_XML_NAMESPACE_MANAGER) is
		external
			"IL signature (System.Xml.XmlNamespaceManager): System.Void use System.Xml.XmlParserContext"
		alias
			"set_NamespaceManager"
		end

	frozen set_xml_lang (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Xml.XmlParserContext"
		alias
			"set_XmlLang"
		end

	frozen set_public_id (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Xml.XmlParserContext"
		alias
			"set_PublicId"
		end

	frozen set_xml_space (value: SYSTEM_XML_XML_SPACE) is
		external
			"IL signature (System.Xml.XmlSpace): System.Void use System.Xml.XmlParserContext"
		alias
			"set_XmlSpace"
		end

	frozen set_name_table (value: SYSTEM_XML_XML_NAME_TABLE) is
		external
			"IL signature (System.Xml.XmlNameTable): System.Void use System.Xml.XmlParserContext"
		alias
			"set_NameTable"
		end

end -- class SYSTEM_XML_XML_PARSER_CONTEXT
