indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Xml.XmlDocument"
	assembly: "System.Xml", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	SYSTEM_XML_XML_DOCUMENT

inherit
	SYSTEM_XML_XML_NODE
		redefine
			get_base_uri,
			set_inner_xml,
			get_inner_xml,
			get_is_read_only,
			get_owner_document
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
	make_system_xml_xml_document,
	make_system_xml_xml_document_1

feature {NONE} -- Initialization

	frozen make_system_xml_xml_document is
		external
			"IL creator use System.Xml.XmlDocument"
		end

	frozen make_system_xml_xml_document_1 (nt: SYSTEM_XML_XML_NAME_TABLE) is
		external
			"IL creator signature (System.Xml.XmlNameTable) use System.Xml.XmlDocument"
		end

feature -- Access

	frozen get_implementation: SYSTEM_XML_XML_IMPLEMENTATION is
		external
			"IL signature (): System.Xml.XmlImplementation use System.Xml.XmlDocument"
		alias
			"get_Implementation"
		end

	get_name: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Xml.XmlDocument"
		alias
			"get_Name"
		end

	frozen get_document_element: SYSTEM_XML_XML_ELEMENT is
		external
			"IL signature (): System.Xml.XmlElement use System.Xml.XmlDocument"
		alias
			"get_DocumentElement"
		end

	get_local_name: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Xml.XmlDocument"
		alias
			"get_LocalName"
		end

	get_base_uri: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Xml.XmlDocument"
		alias
			"get_BaseURI"
		end

	get_document_type: SYSTEM_XML_XML_DOCUMENT_TYPE is
		external
			"IL signature (): System.Xml.XmlDocumentType use System.Xml.XmlDocument"
		alias
			"get_DocumentType"
		end

	get_is_read_only: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Xml.XmlDocument"
		alias
			"get_IsReadOnly"
		end

	frozen get_preserve_whitespace: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Xml.XmlDocument"
		alias
			"get_PreserveWhitespace"
		end

	get_node_type: SYSTEM_XML_XML_NODE_TYPE is
		external
			"IL signature (): System.Xml.XmlNodeType use System.Xml.XmlDocument"
		alias
			"get_NodeType"
		end

	get_inner_xml: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Xml.XmlDocument"
		alias
			"get_InnerXml"
		end

	get_owner_document: SYSTEM_XML_XML_DOCUMENT is
		external
			"IL signature (): System.Xml.XmlDocument use System.Xml.XmlDocument"
		alias
			"get_OwnerDocument"
		end

	frozen get_name_table: SYSTEM_XML_XML_NAME_TABLE is
		external
			"IL signature (): System.Xml.XmlNameTable use System.Xml.XmlDocument"
		alias
			"get_NameTable"
		end

feature -- Element Change

	frozen add_node_removed (value: SYSTEM_XML_XML_NODE_CHANGED_EVENT_HANDLER) is
		external
			"IL signature (System.Xml.XmlNodeChangedEventHandler): System.Void use System.Xml.XmlDocument"
		alias
			"add_NodeRemoved"
		end

	frozen add_node_inserted (value: SYSTEM_XML_XML_NODE_CHANGED_EVENT_HANDLER) is
		external
			"IL signature (System.Xml.XmlNodeChangedEventHandler): System.Void use System.Xml.XmlDocument"
		alias
			"add_NodeInserted"
		end

	frozen add_node_inserting (value: SYSTEM_XML_XML_NODE_CHANGED_EVENT_HANDLER) is
		external
			"IL signature (System.Xml.XmlNodeChangedEventHandler): System.Void use System.Xml.XmlDocument"
		alias
			"add_NodeInserting"
		end

	frozen add_node_changing (value: SYSTEM_XML_XML_NODE_CHANGED_EVENT_HANDLER) is
		external
			"IL signature (System.Xml.XmlNodeChangedEventHandler): System.Void use System.Xml.XmlDocument"
		alias
			"add_NodeChanging"
		end

	frozen set_preserve_whitespace (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Xml.XmlDocument"
		alias
			"set_PreserveWhitespace"
		end

	set_inner_xml (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Xml.XmlDocument"
		alias
			"set_InnerXml"
		end

	frozen remove_node_inserted (value: SYSTEM_XML_XML_NODE_CHANGED_EVENT_HANDLER) is
		external
			"IL signature (System.Xml.XmlNodeChangedEventHandler): System.Void use System.Xml.XmlDocument"
		alias
			"remove_NodeInserted"
		end

	set_xml_resolver (value: SYSTEM_XML_XML_RESOLVER) is
		external
			"IL signature (System.Xml.XmlResolver): System.Void use System.Xml.XmlDocument"
		alias
			"set_XmlResolver"
		end

	frozen remove_node_removed (value: SYSTEM_XML_XML_NODE_CHANGED_EVENT_HANDLER) is
		external
			"IL signature (System.Xml.XmlNodeChangedEventHandler): System.Void use System.Xml.XmlDocument"
		alias
			"remove_NodeRemoved"
		end

	frozen remove_node_changing (value: SYSTEM_XML_XML_NODE_CHANGED_EVENT_HANDLER) is
		external
			"IL signature (System.Xml.XmlNodeChangedEventHandler): System.Void use System.Xml.XmlDocument"
		alias
			"remove_NodeChanging"
		end

	frozen add_node_changed (value: SYSTEM_XML_XML_NODE_CHANGED_EVENT_HANDLER) is
		external
			"IL signature (System.Xml.XmlNodeChangedEventHandler): System.Void use System.Xml.XmlDocument"
		alias
			"add_NodeChanged"
		end

	frozen remove_node_removing (value: SYSTEM_XML_XML_NODE_CHANGED_EVENT_HANDLER) is
		external
			"IL signature (System.Xml.XmlNodeChangedEventHandler): System.Void use System.Xml.XmlDocument"
		alias
			"remove_NodeRemoving"
		end

	frozen remove_node_changed (value: SYSTEM_XML_XML_NODE_CHANGED_EVENT_HANDLER) is
		external
			"IL signature (System.Xml.XmlNodeChangedEventHandler): System.Void use System.Xml.XmlDocument"
		alias
			"remove_NodeChanged"
		end

	frozen remove_node_inserting (value: SYSTEM_XML_XML_NODE_CHANGED_EVENT_HANDLER) is
		external
			"IL signature (System.Xml.XmlNodeChangedEventHandler): System.Void use System.Xml.XmlDocument"
		alias
			"remove_NodeInserting"
		end

	frozen add_node_removing (value: SYSTEM_XML_XML_NODE_CHANGED_EVENT_HANDLER) is
		external
			"IL signature (System.Xml.XmlNodeChangedEventHandler): System.Void use System.Xml.XmlDocument"
		alias
			"add_NodeRemoving"
		end

feature -- Basic Operations

	load (in_stream: SYSTEM_STREAM) is
		external
			"IL signature (System.IO.Stream): System.Void use System.Xml.XmlDocument"
		alias
			"Load"
		end

	create_node (node_type_string: SYSTEM_STRING; name: SYSTEM_STRING; namespace_uri: SYSTEM_STRING): SYSTEM_XML_XML_NODE is
		external
			"IL signature (System.String, System.String, System.String): System.Xml.XmlNode use System.Xml.XmlDocument"
		alias
			"CreateNode"
		end

	frozen create_element (name: SYSTEM_STRING): SYSTEM_XML_XML_ELEMENT is
		external
			"IL signature (System.String): System.Xml.XmlElement use System.Xml.XmlDocument"
		alias
			"CreateElement"
		end

	save_xml_writer (w: SYSTEM_XML_XML_WRITER) is
		external
			"IL signature (System.Xml.XmlWriter): System.Void use System.Xml.XmlDocument"
		alias
			"Save"
		end

	create_xml_declaration (version: SYSTEM_STRING; encoding: SYSTEM_STRING; standalone: SYSTEM_STRING): SYSTEM_XML_XML_DECLARATION is
		external
			"IL signature (System.String, System.String, System.String): System.Xml.XmlDeclaration use System.Xml.XmlDocument"
		alias
			"CreateXmlDeclaration"
		end

	create_document_type (name: SYSTEM_STRING; public_id: SYSTEM_STRING; system_id: SYSTEM_STRING; internal_subset: SYSTEM_STRING): SYSTEM_XML_XML_DOCUMENT_TYPE is
		external
			"IL signature (System.String, System.String, System.String, System.String): System.Xml.XmlDocumentType use System.Xml.XmlDocument"
		alias
			"CreateDocumentType"
		end

	load_text_reader (txt_reader: TEXT_READER) is
		external
			"IL signature (System.IO.TextReader): System.Void use System.Xml.XmlDocument"
		alias
			"Load"
		end

	create_entity_reference (name: SYSTEM_STRING): SYSTEM_XML_XML_ENTITY_REFERENCE is
		external
			"IL signature (System.String): System.Xml.XmlEntityReference use System.Xml.XmlDocument"
		alias
			"CreateEntityReference"
		end

	load_xml_reader (reader: SYSTEM_XML_XML_READER) is
		external
			"IL signature (System.Xml.XmlReader): System.Void use System.Xml.XmlDocument"
		alias
			"Load"
		end

	create_processing_instruction (target: SYSTEM_STRING; data: SYSTEM_STRING): SYSTEM_XML_XML_PROCESSING_INSTRUCTION is
		external
			"IL signature (System.String, System.String): System.Xml.XmlProcessingInstruction use System.Xml.XmlDocument"
		alias
			"CreateProcessingInstruction"
		end

	load_xml (xml: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Xml.XmlDocument"
		alias
			"LoadXml"
		end

	clone_node (deep: BOOLEAN): SYSTEM_XML_XML_NODE is
		external
			"IL signature (System.Boolean): System.Xml.XmlNode use System.Xml.XmlDocument"
		alias
			"CloneNode"
		end

	save (out_stream: SYSTEM_STREAM) is
		external
			"IL signature (System.IO.Stream): System.Void use System.Xml.XmlDocument"
		alias
			"Save"
		end

	create_node_xml_node_type_string_string_string (type: SYSTEM_XML_XML_NODE_TYPE; prefix_: SYSTEM_STRING; name: SYSTEM_STRING; namespace_uri: SYSTEM_STRING): SYSTEM_XML_XML_NODE is
		external
			"IL signature (System.Xml.XmlNodeType, System.String, System.String, System.String): System.Xml.XmlNode use System.Xml.XmlDocument"
		alias
			"CreateNode"
		end

	read_node (reader: SYSTEM_XML_XML_READER): SYSTEM_XML_XML_NODE is
		external
			"IL signature (System.Xml.XmlReader): System.Xml.XmlNode use System.Xml.XmlDocument"
		alias
			"ReadNode"
		end

	frozen create_attribute_string_string (qualified_name: SYSTEM_STRING; namespace_uri: SYSTEM_STRING): SYSTEM_XML_XML_ATTRIBUTE is
		external
			"IL signature (System.String, System.String): System.Xml.XmlAttribute use System.Xml.XmlDocument"
		alias
			"CreateAttribute"
		end

	create_document_fragment: SYSTEM_XML_XML_DOCUMENT_FRAGMENT is
		external
			"IL signature (): System.Xml.XmlDocumentFragment use System.Xml.XmlDocument"
		alias
			"CreateDocumentFragment"
		end

	create_whitespace (text: SYSTEM_STRING): SYSTEM_XML_XML_WHITESPACE is
		external
			"IL signature (System.String): System.Xml.XmlWhitespace use System.Xml.XmlDocument"
		alias
			"CreateWhitespace"
		end

	write_content_to (xw: SYSTEM_XML_XML_WRITER) is
		external
			"IL signature (System.Xml.XmlWriter): System.Void use System.Xml.XmlDocument"
		alias
			"WriteContentTo"
		end

	frozen create_element_string_string (qualified_name: SYSTEM_STRING; namespace_uri: SYSTEM_STRING): SYSTEM_XML_XML_ELEMENT is
		external
			"IL signature (System.String, System.String): System.Xml.XmlElement use System.Xml.XmlDocument"
		alias
			"CreateElement"
		end

	create_significant_whitespace (text: SYSTEM_STRING): SYSTEM_XML_XML_SIGNIFICANT_WHITESPACE is
		external
			"IL signature (System.String): System.Xml.XmlSignificantWhitespace use System.Xml.XmlDocument"
		alias
			"CreateSignificantWhitespace"
		end

	create_comment (data: SYSTEM_STRING): SYSTEM_XML_XML_COMMENT is
		external
			"IL signature (System.String): System.Xml.XmlComment use System.Xml.XmlDocument"
		alias
			"CreateComment"
		end

	import_node (node: SYSTEM_XML_XML_NODE; deep: BOOLEAN): SYSTEM_XML_XML_NODE is
		external
			"IL signature (System.Xml.XmlNode, System.Boolean): System.Xml.XmlNode use System.Xml.XmlDocument"
		alias
			"ImportNode"
		end

	get_element_by_id (element_id: SYSTEM_STRING): SYSTEM_XML_XML_ELEMENT is
		external
			"IL signature (System.String): System.Xml.XmlElement use System.Xml.XmlDocument"
		alias
			"GetElementById"
		end

	get_elements_by_tag_name (name: SYSTEM_STRING): SYSTEM_XML_XML_NODE_LIST is
		external
			"IL signature (System.String): System.Xml.XmlNodeList use System.Xml.XmlDocument"
		alias
			"GetElementsByTagName"
		end

	save_string (filename: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Xml.XmlDocument"
		alias
			"Save"
		end

	write_to (w: SYSTEM_XML_XML_WRITER) is
		external
			"IL signature (System.Xml.XmlWriter): System.Void use System.Xml.XmlDocument"
		alias
			"WriteTo"
		end

	create_cdata_section (data: SYSTEM_STRING): SYSTEM_XML_XML_CDATA_SECTION is
		external
			"IL signature (System.String): System.Xml.XmlCDataSection use System.Xml.XmlDocument"
		alias
			"CreateCDataSection"
		end

	frozen create_attribute (name: SYSTEM_STRING): SYSTEM_XML_XML_ATTRIBUTE is
		external
			"IL signature (System.String): System.Xml.XmlAttribute use System.Xml.XmlDocument"
		alias
			"CreateAttribute"
		end

	create_node_xml_node_type_string_string (type: SYSTEM_XML_XML_NODE_TYPE; name: SYSTEM_STRING; namespace_uri: SYSTEM_STRING): SYSTEM_XML_XML_NODE is
		external
			"IL signature (System.Xml.XmlNodeType, System.String, System.String): System.Xml.XmlNode use System.Xml.XmlDocument"
		alias
			"CreateNode"
		end

	load_string (filename: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Xml.XmlDocument"
		alias
			"Load"
		end

	create_element_string_string_string (prefix_: SYSTEM_STRING; local_name: SYSTEM_STRING; namespace_uri: SYSTEM_STRING): SYSTEM_XML_XML_ELEMENT is
		external
			"IL signature (System.String, System.String, System.String): System.Xml.XmlElement use System.Xml.XmlDocument"
		alias
			"CreateElement"
		end

	create_text_node (text: SYSTEM_STRING): SYSTEM_XML_XML_TEXT is
		external
			"IL signature (System.String): System.Xml.XmlText use System.Xml.XmlDocument"
		alias
			"CreateTextNode"
		end

	get_elements_by_tag_name_string_string (local_name: SYSTEM_STRING; namespace_uri: SYSTEM_STRING): SYSTEM_XML_XML_NODE_LIST is
		external
			"IL signature (System.String, System.String): System.Xml.XmlNodeList use System.Xml.XmlDocument"
		alias
			"GetElementsByTagName"
		end

	create_attribute_string_string_string (prefix_: SYSTEM_STRING; local_name: SYSTEM_STRING; namespace_uri: SYSTEM_STRING): SYSTEM_XML_XML_ATTRIBUTE is
		external
			"IL signature (System.String, System.String, System.String): System.Xml.XmlAttribute use System.Xml.XmlDocument"
		alias
			"CreateAttribute"
		end

	save_text_writer (writer: TEXT_WRITER) is
		external
			"IL signature (System.IO.TextWriter): System.Void use System.Xml.XmlDocument"
		alias
			"Save"
		end

feature {NONE} -- Implementation

	create_default_attribute (prefix_: SYSTEM_STRING; local_name: SYSTEM_STRING; namespace_uri: SYSTEM_STRING): SYSTEM_XML_XML_ATTRIBUTE is
		external
			"IL signature (System.String, System.String, System.String): System.Xml.XmlAttribute use System.Xml.XmlDocument"
		alias
			"CreateDefaultAttribute"
		end

	create_navigator_xml_node (node: SYSTEM_XML_XML_NODE): SYSTEM_XML_XPATH_NAVIGATOR is
		external
			"IL signature (System.Xml.XmlNode): System.Xml.XPath.XPathNavigator use System.Xml.XmlDocument"
		alias
			"CreateNavigator"
		end

end -- class SYSTEM_XML_XML_DOCUMENT
