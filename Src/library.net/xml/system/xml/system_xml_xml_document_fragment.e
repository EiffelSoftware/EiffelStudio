indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Xml.XmlDocumentFragment"
	assembly: "System.Xml", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	SYSTEM_XML_XML_DOCUMENT_FRAGMENT

inherit
	SYSTEM_XML_XML_NODE
		redefine
			set_inner_xml,
			get_inner_xml,
			get_owner_document,
			get_parent_node
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

create {NONE}

feature -- Access

	get_local_name: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Xml.XmlDocumentFragment"
		alias
			"get_LocalName"
		end

	get_inner_xml: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Xml.XmlDocumentFragment"
		alias
			"get_InnerXml"
		end

	get_owner_document: SYSTEM_XML_XML_DOCUMENT is
		external
			"IL signature (): System.Xml.XmlDocument use System.Xml.XmlDocumentFragment"
		alias
			"get_OwnerDocument"
		end

	get_node_type: SYSTEM_XML_XML_NODE_TYPE is
		external
			"IL signature (): System.Xml.XmlNodeType use System.Xml.XmlDocumentFragment"
		alias
			"get_NodeType"
		end

	get_name: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Xml.XmlDocumentFragment"
		alias
			"get_Name"
		end

	get_parent_node: SYSTEM_XML_XML_NODE is
		external
			"IL signature (): System.Xml.XmlNode use System.Xml.XmlDocumentFragment"
		alias
			"get_ParentNode"
		end

feature -- Element Change

	set_inner_xml (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Xml.XmlDocumentFragment"
		alias
			"set_InnerXml"
		end

feature -- Basic Operations

	write_content_to (w: SYSTEM_XML_XML_WRITER) is
		external
			"IL signature (System.Xml.XmlWriter): System.Void use System.Xml.XmlDocumentFragment"
		alias
			"WriteContentTo"
		end

	clone_node (deep: BOOLEAN): SYSTEM_XML_XML_NODE is
		external
			"IL signature (System.Boolean): System.Xml.XmlNode use System.Xml.XmlDocumentFragment"
		alias
			"CloneNode"
		end

	write_to (w: SYSTEM_XML_XML_WRITER) is
		external
			"IL signature (System.Xml.XmlWriter): System.Void use System.Xml.XmlDocumentFragment"
		alias
			"WriteTo"
		end

end -- class SYSTEM_XML_XML_DOCUMENT_FRAGMENT
