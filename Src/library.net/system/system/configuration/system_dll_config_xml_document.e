indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Configuration.ConfigXmlDocument"
	assembly: "System", "1.0.3300.0", "neutral", "b77a5c561934e089"

frozen external class
	SYSTEM_DLL_CONFIG_XML_DOCUMENT

inherit
	SYSTEM_XML_XML_DOCUMENT
		redefine
			load_string,
			create_element_string_string_string,
			create_attribute_string_string_string,
			create_whitespace,
			create_significant_whitespace,
			create_text_node,
			create_comment,
			create_cdata_section
		end
	ICLONEABLE
		rename
			clone_ as system_icloneable_clone
		end
	IENUMERABLE
		rename
			get_enumerator as system_collections_ienumerable_get_enumerator
		end
	SYSTEM_XML_IXPATH_NAVIGABLE

create
	make_system_dll_config_xml_document

feature {NONE} -- Initialization

	frozen make_system_dll_config_xml_document is
		external
			"IL creator use System.Configuration.ConfigXmlDocument"
		end

feature -- Access

	frozen get_line_number: INTEGER is
		external
			"IL signature (): System.Int32 use System.Configuration.ConfigXmlDocument"
		alias
			"get_LineNumber"
		end

	frozen get_filename: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Configuration.ConfigXmlDocument"
		alias
			"get_Filename"
		end

feature -- Basic Operations

	create_comment (data: SYSTEM_STRING): SYSTEM_XML_XML_COMMENT is
		external
			"IL signature (System.String): System.Xml.XmlComment use System.Configuration.ConfigXmlDocument"
		alias
			"CreateComment"
		end

	create_cdata_section (data: SYSTEM_STRING): SYSTEM_XML_XML_CDATA_SECTION is
		external
			"IL signature (System.String): System.Xml.XmlCDataSection use System.Configuration.ConfigXmlDocument"
		alias
			"CreateCDataSection"
		end

	create_element_string_string_string (prefix_: SYSTEM_STRING; local_name: SYSTEM_STRING; namespace_uri: SYSTEM_STRING): SYSTEM_XML_XML_ELEMENT is
		external
			"IL signature (System.String, System.String, System.String): System.Xml.XmlElement use System.Configuration.ConfigXmlDocument"
		alias
			"CreateElement"
		end

	create_whitespace (data: SYSTEM_STRING): SYSTEM_XML_XML_WHITESPACE is
		external
			"IL signature (System.String): System.Xml.XmlWhitespace use System.Configuration.ConfigXmlDocument"
		alias
			"CreateWhitespace"
		end

	create_significant_whitespace (data: SYSTEM_STRING): SYSTEM_XML_XML_SIGNIFICANT_WHITESPACE is
		external
			"IL signature (System.String): System.Xml.XmlSignificantWhitespace use System.Configuration.ConfigXmlDocument"
		alias
			"CreateSignificantWhitespace"
		end

	frozen load_single_element (filename: SYSTEM_STRING; source_reader: SYSTEM_XML_XML_TEXT_READER) is
		external
			"IL signature (System.String, System.Xml.XmlTextReader): System.Void use System.Configuration.ConfigXmlDocument"
		alias
			"LoadSingleElement"
		end

	create_text_node (text: SYSTEM_STRING): SYSTEM_XML_XML_TEXT is
		external
			"IL signature (System.String): System.Xml.XmlText use System.Configuration.ConfigXmlDocument"
		alias
			"CreateTextNode"
		end

	load_string (filename: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Configuration.ConfigXmlDocument"
		alias
			"Load"
		end

	create_attribute_string_string_string (prefix_: SYSTEM_STRING; local_name: SYSTEM_STRING; namespace_uri: SYSTEM_STRING): SYSTEM_XML_XML_ATTRIBUTE is
		external
			"IL signature (System.String, System.String, System.String): System.Xml.XmlAttribute use System.Configuration.ConfigXmlDocument"
		alias
			"CreateAttribute"
		end

end -- class SYSTEM_DLL_CONFIG_XML_DOCUMENT
