indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Xml.XmlParserContext"

external class
	SYSTEM_XML_XMLPARSERCONTEXT

create
	make,
	make_1

feature {NONE} -- Initialization

	frozen make (nt: SYSTEM_XML_XMLNAMETABLE; ns_mgr: SYSTEM_XML_XMLNAMESPACEMANAGER; xml_lang: STRING; xml_space: SYSTEM_XML_XMLSPACE) is
		external
			"IL creator signature (System.Xml.XmlNameTable, System.Xml.XmlNamespaceManager, System.String, System.Xml.XmlSpace) use System.Xml.XmlParserContext"
		end

	frozen make_1 (nt: SYSTEM_XML_XMLNAMETABLE; ns_mgr: SYSTEM_XML_XMLNAMESPACEMANAGER; doc_type_name: STRING; pub_id: STRING; sys_id: STRING; internal_subset: STRING; base_uri: STRING; xml_lang: STRING; xml_space: SYSTEM_XML_XMLSPACE) is
		external
			"IL creator signature (System.Xml.XmlNameTable, System.Xml.XmlNamespaceManager, System.String, System.String, System.String, System.String, System.String, System.String, System.Xml.XmlSpace) use System.Xml.XmlParserContext"
		end

feature -- Access

	frozen get_xml_lang: STRING is
		external
			"IL signature (): System.String use System.Xml.XmlParserContext"
		alias
			"get_XmlLang"
		end

	frozen get_xml_space: SYSTEM_XML_XMLSPACE is
		external
			"IL signature (): System.Xml.XmlSpace use System.Xml.XmlParserContext"
		alias
			"get_XmlSpace"
		end

	frozen get_base_uri: STRING is
		external
			"IL signature (): System.String use System.Xml.XmlParserContext"
		alias
			"get_BaseURI"
		end

	frozen get_public_id: STRING is
		external
			"IL signature (): System.String use System.Xml.XmlParserContext"
		alias
			"get_PublicId"
		end

	frozen get_internal_subset: STRING is
		external
			"IL signature (): System.String use System.Xml.XmlParserContext"
		alias
			"get_InternalSubset"
		end

	frozen get_doc_type_name: STRING is
		external
			"IL signature (): System.String use System.Xml.XmlParserContext"
		alias
			"get_DocTypeName"
		end

	frozen get_namespace_manager: SYSTEM_XML_XMLNAMESPACEMANAGER is
		external
			"IL signature (): System.Xml.XmlNamespaceManager use System.Xml.XmlParserContext"
		alias
			"get_NamespaceManager"
		end

	frozen get_system_id: STRING is
		external
			"IL signature (): System.String use System.Xml.XmlParserContext"
		alias
			"get_SystemId"
		end

	frozen get_name_table: SYSTEM_XML_XMLNAMETABLE is
		external
			"IL signature (): System.Xml.XmlNameTable use System.Xml.XmlParserContext"
		alias
			"get_NameTable"
		end

feature -- Element Change

	frozen set_doc_type_name (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Xml.XmlParserContext"
		alias
			"set_DocTypeName"
		end

	frozen set_base_uri (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Xml.XmlParserContext"
		alias
			"set_BaseURI"
		end

	frozen set_system_id (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Xml.XmlParserContext"
		alias
			"set_SystemId"
		end

	frozen set_internal_subset (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Xml.XmlParserContext"
		alias
			"set_InternalSubset"
		end

	frozen set_namespace_manager (value: SYSTEM_XML_XMLNAMESPACEMANAGER) is
		external
			"IL signature (System.Xml.XmlNamespaceManager): System.Void use System.Xml.XmlParserContext"
		alias
			"set_NamespaceManager"
		end

	frozen set_xml_lang (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Xml.XmlParserContext"
		alias
			"set_XmlLang"
		end

	frozen set_public_id (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Xml.XmlParserContext"
		alias
			"set_PublicId"
		end

	frozen set_xml_space (value: SYSTEM_XML_XMLSPACE) is
		external
			"IL signature (System.Xml.XmlSpace): System.Void use System.Xml.XmlParserContext"
		alias
			"set_XmlSpace"
		end

	frozen set_name_table (value: SYSTEM_XML_XMLNAMETABLE) is
		external
			"IL signature (System.Xml.XmlNameTable): System.Void use System.Xml.XmlParserContext"
		alias
			"set_NameTable"
		end

end -- class SYSTEM_XML_XMLPARSERCONTEXT
