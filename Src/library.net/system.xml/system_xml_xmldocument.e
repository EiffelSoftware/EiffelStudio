indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Xml.XmlDocument"

external class
	SYSTEM_XML_XMLDOCUMENT

inherit
	SYSTEM_XML_XMLNODE
		redefine
			get_base_uri,
			set_inner_xml,
			get_inner_xml,
			get_is_read_only,
			get_owner_document
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
	make_xmldocument,
	make_xmldocument_1

feature {NONE} -- Initialization

	frozen make_xmldocument is
		external
			"IL creator use System.Xml.XmlDocument"
		end

	frozen make_xmldocument_1 (nt: SYSTEM_XML_XMLNAMETABLE) is
		external
			"IL creator signature (System.Xml.XmlNameTable) use System.Xml.XmlDocument"
		end

feature -- Access

	frozen get_implementation: SYSTEM_XML_XMLIMPLEMENTATION is
		external
			"IL signature (): System.Xml.XmlImplementation use System.Xml.XmlDocument"
		alias
			"get_Implementation"
		end

	get_name: STRING is
		external
			"IL signature (): System.String use System.Xml.XmlDocument"
		alias
			"get_Name"
		end

	frozen get_document_element: SYSTEM_XML_XMLELEMENT is
		external
			"IL signature (): System.Xml.XmlElement use System.Xml.XmlDocument"
		alias
			"get_DocumentElement"
		end

	get_local_name: STRING is
		external
			"IL signature (): System.String use System.Xml.XmlDocument"
		alias
			"get_LocalName"
		end

	get_base_uri: STRING is
		external
			"IL signature (): System.String use System.Xml.XmlDocument"
		alias
			"get_BaseURI"
		end

	get_document_type: SYSTEM_XML_XMLDOCUMENTTYPE is
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

	get_node_type: SYSTEM_XML_XMLNODETYPE is
		external
			"IL signature (): System.Xml.XmlNodeType use System.Xml.XmlDocument"
		alias
			"get_NodeType"
		end

	get_inner_xml: STRING is
		external
			"IL signature (): System.String use System.Xml.XmlDocument"
		alias
			"get_InnerXml"
		end

	get_owner_document: SYSTEM_XML_XMLDOCUMENT is
		external
			"IL signature (): System.Xml.XmlDocument use System.Xml.XmlDocument"
		alias
			"get_OwnerDocument"
		end

	frozen get_name_table: SYSTEM_XML_XMLNAMETABLE is
		external
			"IL signature (): System.Xml.XmlNameTable use System.Xml.XmlDocument"
		alias
			"get_NameTable"
		end

feature -- Element Change

	frozen add_node_removed (value: SYSTEM_XML_XMLNODECHANGEDEVENTHANDLER) is
		external
			"IL signature (System.Xml.XmlNodeChangedEventHandler): System.Void use System.Xml.XmlDocument"
		alias
			"add_NodeRemoved"
		end

	frozen add_node_inserted (value: SYSTEM_XML_XMLNODECHANGEDEVENTHANDLER) is
		external
			"IL signature (System.Xml.XmlNodeChangedEventHandler): System.Void use System.Xml.XmlDocument"
		alias
			"add_NodeInserted"
		end

	frozen add_node_inserting (value: SYSTEM_XML_XMLNODECHANGEDEVENTHANDLER) is
		external
			"IL signature (System.Xml.XmlNodeChangedEventHandler): System.Void use System.Xml.XmlDocument"
		alias
			"add_NodeInserting"
		end

	frozen add_node_changing (value: SYSTEM_XML_XMLNODECHANGEDEVENTHANDLER) is
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

	set_inner_xml (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Xml.XmlDocument"
		alias
			"set_InnerXml"
		end

	frozen remove_node_inserted (value: SYSTEM_XML_XMLNODECHANGEDEVENTHANDLER) is
		external
			"IL signature (System.Xml.XmlNodeChangedEventHandler): System.Void use System.Xml.XmlDocument"
		alias
			"remove_NodeInserted"
		end

	set_xml_resolver (value: SYSTEM_XML_XMLRESOLVER) is
		external
			"IL signature (System.Xml.XmlResolver): System.Void use System.Xml.XmlDocument"
		alias
			"set_XmlResolver"
		end

	frozen remove_node_removed (value: SYSTEM_XML_XMLNODECHANGEDEVENTHANDLER) is
		external
			"IL signature (System.Xml.XmlNodeChangedEventHandler): System.Void use System.Xml.XmlDocument"
		alias
			"remove_NodeRemoved"
		end

	frozen remove_node_changing (value: SYSTEM_XML_XMLNODECHANGEDEVENTHANDLER) is
		external
			"IL signature (System.Xml.XmlNodeChangedEventHandler): System.Void use System.Xml.XmlDocument"
		alias
			"remove_NodeChanging"
		end

	frozen add_node_changed (value: SYSTEM_XML_XMLNODECHANGEDEVENTHANDLER) is
		external
			"IL signature (System.Xml.XmlNodeChangedEventHandler): System.Void use System.Xml.XmlDocument"
		alias
			"add_NodeChanged"
		end

	frozen remove_node_removing (value: SYSTEM_XML_XMLNODECHANGEDEVENTHANDLER) is
		external
			"IL signature (System.Xml.XmlNodeChangedEventHandler): System.Void use System.Xml.XmlDocument"
		alias
			"remove_NodeRemoving"
		end

	frozen remove_node_changed (value: SYSTEM_XML_XMLNODECHANGEDEVENTHANDLER) is
		external
			"IL signature (System.Xml.XmlNodeChangedEventHandler): System.Void use System.Xml.XmlDocument"
		alias
			"remove_NodeChanged"
		end

	frozen remove_node_inserting (value: SYSTEM_XML_XMLNODECHANGEDEVENTHANDLER) is
		external
			"IL signature (System.Xml.XmlNodeChangedEventHandler): System.Void use System.Xml.XmlDocument"
		alias
			"remove_NodeInserting"
		end

	frozen add_node_removing (value: SYSTEM_XML_XMLNODECHANGEDEVENTHANDLER) is
		external
			"IL signature (System.Xml.XmlNodeChangedEventHandler): System.Void use System.Xml.XmlDocument"
		alias
			"add_NodeRemoving"
		end

feature -- Basic Operations

	load (in_stream: SYSTEM_IO_STREAM) is
		external
			"IL signature (System.IO.Stream): System.Void use System.Xml.XmlDocument"
		alias
			"Load"
		end

	create_node (node_type_string: STRING; name: STRING; namespace_uri: STRING): SYSTEM_XML_XMLNODE is
		external
			"IL signature (System.String, System.String, System.String): System.Xml.XmlNode use System.Xml.XmlDocument"
		alias
			"CreateNode"
		end

	frozen create_element (name: STRING): SYSTEM_XML_XMLELEMENT is
		external
			"IL signature (System.String): System.Xml.XmlElement use System.Xml.XmlDocument"
		alias
			"CreateElement"
		end

	save_xml_writer (writer: SYSTEM_XML_XMLWRITER) is
		external
			"IL signature (System.Xml.XmlWriter): System.Void use System.Xml.XmlDocument"
		alias
			"Save"
		end

	create_xml_declaration (version: STRING; encoding: STRING; standalone: STRING): SYSTEM_XML_XMLDECLARATION is
		external
			"IL signature (System.String, System.String, System.String): System.Xml.XmlDeclaration use System.Xml.XmlDocument"
		alias
			"CreateXmlDeclaration"
		end

	create_document_type (name: STRING; public_id: STRING; system_id: STRING; internal_subset: STRING): SYSTEM_XML_XMLDOCUMENTTYPE is
		external
			"IL signature (System.String, System.String, System.String, System.String): System.Xml.XmlDocumentType use System.Xml.XmlDocument"
		alias
			"CreateDocumentType"
		end

	load_text_reader (txt_reader: SYSTEM_IO_TEXTREADER) is
		external
			"IL signature (System.IO.TextReader): System.Void use System.Xml.XmlDocument"
		alias
			"Load"
		end

	create_entity_reference (name: STRING): SYSTEM_XML_XMLENTITYREFERENCE is
		external
			"IL signature (System.String): System.Xml.XmlEntityReference use System.Xml.XmlDocument"
		alias
			"CreateEntityReference"
		end

	load_xml_reader (reader: SYSTEM_XML_XMLREADER) is
		external
			"IL signature (System.Xml.XmlReader): System.Void use System.Xml.XmlDocument"
		alias
			"Load"
		end

	create_processing_instruction (target: STRING; data: STRING): SYSTEM_XML_XMLPROCESSINGINSTRUCTION is
		external
			"IL signature (System.String, System.String): System.Xml.XmlProcessingInstruction use System.Xml.XmlDocument"
		alias
			"CreateProcessingInstruction"
		end

	load_xml (xml: STRING) is
		external
			"IL signature (System.String): System.Void use System.Xml.XmlDocument"
		alias
			"LoadXml"
		end

	clone_node (deep: BOOLEAN): SYSTEM_XML_XMLNODE is
		external
			"IL signature (System.Boolean): System.Xml.XmlNode use System.Xml.XmlDocument"
		alias
			"CloneNode"
		end

	save (out_stream: SYSTEM_IO_STREAM) is
		external
			"IL signature (System.IO.Stream): System.Void use System.Xml.XmlDocument"
		alias
			"Save"
		end

	create_node_xml_node_type_string_string_string (type: SYSTEM_XML_XMLNODETYPE; prefix_: STRING; name: STRING; namespace_uri: STRING): SYSTEM_XML_XMLNODE is
		external
			"IL signature (System.Xml.XmlNodeType, System.String, System.String, System.String): System.Xml.XmlNode use System.Xml.XmlDocument"
		alias
			"CreateNode"
		end

	read_node (reader: SYSTEM_XML_XMLREADER): SYSTEM_XML_XMLNODE is
		external
			"IL signature (System.Xml.XmlReader): System.Xml.XmlNode use System.Xml.XmlDocument"
		alias
			"ReadNode"
		end

	frozen create_attribute_string_string (qualified_name: STRING; namespace_uri: STRING): SYSTEM_XML_XMLATTRIBUTE is
		external
			"IL signature (System.String, System.String): System.Xml.XmlAttribute use System.Xml.XmlDocument"
		alias
			"CreateAttribute"
		end

	create_document_fragment: SYSTEM_XML_XMLDOCUMENTFRAGMENT is
		external
			"IL signature (): System.Xml.XmlDocumentFragment use System.Xml.XmlDocument"
		alias
			"CreateDocumentFragment"
		end

	create_whitespace (text: STRING): SYSTEM_XML_XMLWHITESPACE is
		external
			"IL signature (System.String): System.Xml.XmlWhitespace use System.Xml.XmlDocument"
		alias
			"CreateWhitespace"
		end

	write_content_to (w: SYSTEM_XML_XMLWRITER) is
		external
			"IL signature (System.Xml.XmlWriter): System.Void use System.Xml.XmlDocument"
		alias
			"WriteContentTo"
		end

	frozen create_element_string_string (qualified_name: STRING; namespace_uri: STRING): SYSTEM_XML_XMLELEMENT is
		external
			"IL signature (System.String, System.String): System.Xml.XmlElement use System.Xml.XmlDocument"
		alias
			"CreateElement"
		end

	create_significant_whitespace (text: STRING): SYSTEM_XML_XMLSIGNIFICANTWHITESPACE is
		external
			"IL signature (System.String): System.Xml.XmlSignificantWhitespace use System.Xml.XmlDocument"
		alias
			"CreateSignificantWhitespace"
		end

	create_comment (data: STRING): SYSTEM_XML_XMLCOMMENT is
		external
			"IL signature (System.String): System.Xml.XmlComment use System.Xml.XmlDocument"
		alias
			"CreateComment"
		end

	import_node (node: SYSTEM_XML_XMLNODE; deep: BOOLEAN): SYSTEM_XML_XMLNODE is
		external
			"IL signature (System.Xml.XmlNode, System.Boolean): System.Xml.XmlNode use System.Xml.XmlDocument"
		alias
			"ImportNode"
		end

	get_element_by_id (element_id: STRING): SYSTEM_XML_XMLELEMENT is
		external
			"IL signature (System.String): System.Xml.XmlElement use System.Xml.XmlDocument"
		alias
			"GetElementById"
		end

	get_elements_by_tag_name (name: STRING): SYSTEM_XML_XMLNODELIST is
		external
			"IL signature (System.String): System.Xml.XmlNodeList use System.Xml.XmlDocument"
		alias
			"GetElementsByTagName"
		end

	save_string (filename: STRING) is
		external
			"IL signature (System.String): System.Void use System.Xml.XmlDocument"
		alias
			"Save"
		end

	write_to (w: SYSTEM_XML_XMLWRITER) is
		external
			"IL signature (System.Xml.XmlWriter): System.Void use System.Xml.XmlDocument"
		alias
			"WriteTo"
		end

	create_cdata_section (data: STRING): SYSTEM_XML_XMLCDATASECTION is
		external
			"IL signature (System.String): System.Xml.XmlCDataSection use System.Xml.XmlDocument"
		alias
			"CreateCDataSection"
		end

	frozen create_attribute (name: STRING): SYSTEM_XML_XMLATTRIBUTE is
		external
			"IL signature (System.String): System.Xml.XmlAttribute use System.Xml.XmlDocument"
		alias
			"CreateAttribute"
		end

	create_node_xml_node_type_string_string (type: SYSTEM_XML_XMLNODETYPE; name: STRING; namespace_uri: STRING): SYSTEM_XML_XMLNODE is
		external
			"IL signature (System.Xml.XmlNodeType, System.String, System.String): System.Xml.XmlNode use System.Xml.XmlDocument"
		alias
			"CreateNode"
		end

	load_string (filename: STRING) is
		external
			"IL signature (System.String): System.Void use System.Xml.XmlDocument"
		alias
			"Load"
		end

	create_element_string_string_string (prefix_: STRING; local_name: STRING; namespace_uri: STRING): SYSTEM_XML_XMLELEMENT is
		external
			"IL signature (System.String, System.String, System.String): System.Xml.XmlElement use System.Xml.XmlDocument"
		alias
			"CreateElement"
		end

	create_text_node (text: STRING): SYSTEM_XML_XMLTEXT is
		external
			"IL signature (System.String): System.Xml.XmlText use System.Xml.XmlDocument"
		alias
			"CreateTextNode"
		end

	get_elements_by_tag_name_string_string (local_name: STRING; namespace_uri: STRING): SYSTEM_XML_XMLNODELIST is
		external
			"IL signature (System.String, System.String): System.Xml.XmlNodeList use System.Xml.XmlDocument"
		alias
			"GetElementsByTagName"
		end

	create_attribute_string_string_string (prefix_: STRING; local_name: STRING; namespace_uri: STRING): SYSTEM_XML_XMLATTRIBUTE is
		external
			"IL signature (System.String, System.String, System.String): System.Xml.XmlAttribute use System.Xml.XmlDocument"
		alias
			"CreateAttribute"
		end

	save_text_writer (writer: SYSTEM_IO_TEXTWRITER) is
		external
			"IL signature (System.IO.TextWriter): System.Void use System.Xml.XmlDocument"
		alias
			"Save"
		end

feature {NONE} -- Implementation

	create_default_attribute (prefix_: STRING; local_name: STRING; namespace_uri: STRING): SYSTEM_XML_XMLATTRIBUTE is
		external
			"IL signature (System.String, System.String, System.String): System.Xml.XmlAttribute use System.Xml.XmlDocument"
		alias
			"CreateDefaultAttribute"
		end

	create_navigator_xml_node (node: SYSTEM_XML_XMLNODE): SYSTEM_XML_XPATH_XPATHNAVIGATOR is
		external
			"IL signature (System.Xml.XmlNode): System.Xml.XPath.XPathNavigator use System.Xml.XmlDocument"
		alias
			"CreateNavigator"
		end

end -- class SYSTEM_XML_XMLDOCUMENT
