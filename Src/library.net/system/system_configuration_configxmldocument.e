indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Configuration.ConfigXmlDocument"

frozen external class
	SYSTEM_CONFIGURATION_CONFIGXMLDOCUMENT

inherit
	SYSTEM_XML_XMLDOCUMENT
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
	SYSTEM_XML_XPATH_IXPATHNAVIGABLE
	SYSTEM_ICLONEABLE
		rename
			clone as system_icloneable_clone
		end
	SYSTEM_COLLECTIONS_IENUMERABLE
		rename
			get_enumerator as system_collections_ienumerable_get_enumerator
		end

create
	make_configxmldocument

feature {NONE} -- Initialization

	frozen make_configxmldocument is
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

	frozen get_filename: STRING is
		external
			"IL signature (): System.String use System.Configuration.ConfigXmlDocument"
		alias
			"get_Filename"
		end

feature -- Basic Operations

	create_comment (data: STRING): SYSTEM_XML_XMLCOMMENT is
		external
			"IL signature (System.String): System.Xml.XmlComment use System.Configuration.ConfigXmlDocument"
		alias
			"CreateComment"
		end

	create_cdata_section (data: STRING): SYSTEM_XML_XMLCDATASECTION is
		external
			"IL signature (System.String): System.Xml.XmlCDataSection use System.Configuration.ConfigXmlDocument"
		alias
			"CreateCDataSection"
		end

	create_element_string_string_string (prefix_: STRING; local_name: STRING; namespace_uri: STRING): SYSTEM_XML_XMLELEMENT is
		external
			"IL signature (System.String, System.String, System.String): System.Xml.XmlElement use System.Configuration.ConfigXmlDocument"
		alias
			"CreateElement"
		end

	create_whitespace (data: STRING): SYSTEM_XML_XMLWHITESPACE is
		external
			"IL signature (System.String): System.Xml.XmlWhitespace use System.Configuration.ConfigXmlDocument"
		alias
			"CreateWhitespace"
		end

	create_significant_whitespace (data: STRING): SYSTEM_XML_XMLSIGNIFICANTWHITESPACE is
		external
			"IL signature (System.String): System.Xml.XmlSignificantWhitespace use System.Configuration.ConfigXmlDocument"
		alias
			"CreateSignificantWhitespace"
		end

	frozen load_single_element (filename: STRING; source_reader: SYSTEM_XML_XMLTEXTREADER) is
		external
			"IL signature (System.String, System.Xml.XmlTextReader): System.Void use System.Configuration.ConfigXmlDocument"
		alias
			"LoadSingleElement"
		end

	create_text_node (text: STRING): SYSTEM_XML_XMLTEXT is
		external
			"IL signature (System.String): System.Xml.XmlText use System.Configuration.ConfigXmlDocument"
		alias
			"CreateTextNode"
		end

	load_string (filename: STRING) is
		external
			"IL signature (System.String): System.Void use System.Configuration.ConfigXmlDocument"
		alias
			"Load"
		end

	create_attribute_string_string_string (prefix_: STRING; local_name: STRING; namespace_uri: STRING): SYSTEM_XML_XMLATTRIBUTE is
		external
			"IL signature (System.String, System.String, System.String): System.Xml.XmlAttribute use System.Configuration.ConfigXmlDocument"
		alias
			"CreateAttribute"
		end

end -- class SYSTEM_CONFIGURATION_CONFIGXMLDOCUMENT
