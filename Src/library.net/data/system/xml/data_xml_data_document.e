indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Xml.XmlDataDocument"
	assembly: "System.Data", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	DATA_XML_DATA_DOCUMENT

inherit
	SYSTEM_XML_XML_DOCUMENT
		redefine
			load_xml_reader,
			load_text_reader,
			load,
			load_string,
			create_element_string_string_string,
			get_element_by_id,
			create_navigator_xml_node,
			create_entity_reference,
			clone_node
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
	make_data_xml_data_document,
	make_data_xml_data_document_1

feature {NONE} -- Initialization

	frozen make_data_xml_data_document is
		external
			"IL creator use System.Xml.XmlDataDocument"
		end

	frozen make_data_xml_data_document_1 (dataset: DATA_DATA_SET) is
		external
			"IL creator signature (System.Data.DataSet) use System.Xml.XmlDataDocument"
		end

feature -- Access

	frozen get_data_set: DATA_DATA_SET is
		external
			"IL signature (): System.Data.DataSet use System.Xml.XmlDataDocument"
		alias
			"get_DataSet"
		end

feature -- Basic Operations

	load_text_reader (txt_reader: TEXT_READER) is
		external
			"IL signature (System.IO.TextReader): System.Void use System.Xml.XmlDataDocument"
		alias
			"Load"
		end

	frozen get_element_from_row (r: DATA_DATA_ROW): SYSTEM_XML_XML_ELEMENT is
		external
			"IL signature (System.Data.DataRow): System.Xml.XmlElement use System.Xml.XmlDataDocument"
		alias
			"GetElementFromRow"
		end

	get_element_by_id (elem_id: SYSTEM_STRING): SYSTEM_XML_XML_ELEMENT is
		external
			"IL signature (System.String): System.Xml.XmlElement use System.Xml.XmlDataDocument"
		alias
			"GetElementById"
		end

	create_element_string_string_string (prefix_: SYSTEM_STRING; local_name: SYSTEM_STRING; namespace_uri: SYSTEM_STRING): SYSTEM_XML_XML_ELEMENT is
		external
			"IL signature (System.String, System.String, System.String): System.Xml.XmlElement use System.Xml.XmlDataDocument"
		alias
			"CreateElement"
		end

	clone_node (deep: BOOLEAN): SYSTEM_XML_XML_NODE is
		external
			"IL signature (System.Boolean): System.Xml.XmlNode use System.Xml.XmlDataDocument"
		alias
			"CloneNode"
		end

	create_entity_reference (name: SYSTEM_STRING): SYSTEM_XML_XML_ENTITY_REFERENCE is
		external
			"IL signature (System.String): System.Xml.XmlEntityReference use System.Xml.XmlDataDocument"
		alias
			"CreateEntityReference"
		end

	load_string (filename: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Xml.XmlDataDocument"
		alias
			"Load"
		end

	frozen get_row_from_element (e: SYSTEM_XML_XML_ELEMENT): DATA_DATA_ROW is
		external
			"IL signature (System.Xml.XmlElement): System.Data.DataRow use System.Xml.XmlDataDocument"
		alias
			"GetRowFromElement"
		end

	load_xml_reader (reader: SYSTEM_XML_XML_READER) is
		external
			"IL signature (System.Xml.XmlReader): System.Void use System.Xml.XmlDataDocument"
		alias
			"Load"
		end

	load (in_stream: SYSTEM_STREAM) is
		external
			"IL signature (System.IO.Stream): System.Void use System.Xml.XmlDataDocument"
		alias
			"Load"
		end

feature {NONE} -- Implementation

	create_navigator_xml_node (node: SYSTEM_XML_XML_NODE): SYSTEM_XML_XPATH_NAVIGATOR is
		external
			"IL signature (System.Xml.XmlNode): System.Xml.XPath.XPathNavigator use System.Xml.XmlDataDocument"
		alias
			"CreateNavigator"
		end

end -- class DATA_XML_DATA_DOCUMENT
