indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Xml.XmlDataDocument"

external class
	SYSTEM_XML_XMLDATADOCUMENT

inherit
	SYSTEM_XML_XMLDOCUMENT
		redefine
			load_xml_reader,
			create_element_string_string_string,
			get_element_by_id,
			create_navigator_xml_node,
			create_entity_reference,
			write_to,
			clone_node
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
	make_xmldatadocument_1,
	make_xmldatadocument

feature {NONE} -- Initialization

	frozen make_xmldatadocument_1 (dataset: SYSTEM_DATA_DATASET) is
		external
			"IL creator signature (System.Data.DataSet) use System.Xml.XmlDataDocument"
		end

	frozen make_xmldatadocument is
		external
			"IL creator use System.Xml.XmlDataDocument"
		end

feature -- Access

	frozen get_data_set: SYSTEM_DATA_DATASET is
		external
			"IL signature (): System.Data.DataSet use System.Xml.XmlDataDocument"
		alias
			"get_DataSet"
		end

feature -- Basic Operations

	write_to (writer: SYSTEM_XML_XMLWRITER) is
		external
			"IL signature (System.Xml.XmlWriter): System.Void use System.Xml.XmlDataDocument"
		alias
			"WriteTo"
		end

	frozen get_element_from_row (r: SYSTEM_DATA_DATAROW): SYSTEM_XML_XMLELEMENT is
		external
			"IL signature (System.Data.DataRow): System.Xml.XmlElement use System.Xml.XmlDataDocument"
		alias
			"GetElementFromRow"
		end

	create_element_string_string_string (prefix_: STRING; local_name: STRING; namespace_uri: STRING): SYSTEM_XML_XMLELEMENT is
		external
			"IL signature (System.String, System.String, System.String): System.Xml.XmlElement use System.Xml.XmlDataDocument"
		alias
			"CreateElement"
		end

	get_element_by_id (elem_id: STRING): SYSTEM_XML_XMLELEMENT is
		external
			"IL signature (System.String): System.Xml.XmlElement use System.Xml.XmlDataDocument"
		alias
			"GetElementById"
		end

	frozen get_row_from_element (e: SYSTEM_XML_XMLELEMENT): SYSTEM_DATA_DATAROW is
		external
			"IL signature (System.Xml.XmlElement): System.Data.DataRow use System.Xml.XmlDataDocument"
		alias
			"GetRowFromElement"
		end

	clone_node (deep: BOOLEAN): SYSTEM_XML_XMLNODE is
		external
			"IL signature (System.Boolean): System.Xml.XmlNode use System.Xml.XmlDataDocument"
		alias
			"CloneNode"
		end

	create_entity_reference (name: STRING): SYSTEM_XML_XMLENTITYREFERENCE is
		external
			"IL signature (System.String): System.Xml.XmlEntityReference use System.Xml.XmlDataDocument"
		alias
			"CreateEntityReference"
		end

	load_xml_reader (reader: SYSTEM_XML_XMLREADER) is
		external
			"IL signature (System.Xml.XmlReader): System.Void use System.Xml.XmlDataDocument"
		alias
			"Load"
		end

feature {NONE} -- Implementation

	create_navigator_xml_node (node: SYSTEM_XML_XMLNODE): SYSTEM_XML_XPATH_XPATHNAVIGATOR is
		external
			"IL signature (System.Xml.XmlNode): System.Xml.XPath.XPathNavigator use System.Xml.XmlDataDocument"
		alias
			"CreateNavigator"
		end

end -- class SYSTEM_XML_XMLDATADOCUMENT
