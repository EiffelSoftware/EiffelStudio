indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Xml.XmlDocumentFragment"

external class
	SYSTEM_XML_XMLDOCUMENTFRAGMENT

inherit
	SYSTEM_XML_XMLNODE
		redefine
			set_inner_xml,
			get_inner_xml,
			get_owner_document,
			get_parent_node
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

create {NONE}

feature -- Access

	get_local_name: STRING is
		external
			"IL signature (): System.String use System.Xml.XmlDocumentFragment"
		alias
			"get_LocalName"
		end

	get_inner_xml: STRING is
		external
			"IL signature (): System.String use System.Xml.XmlDocumentFragment"
		alias
			"get_InnerXml"
		end

	get_owner_document: SYSTEM_XML_XMLDOCUMENT is
		external
			"IL signature (): System.Xml.XmlDocument use System.Xml.XmlDocumentFragment"
		alias
			"get_OwnerDocument"
		end

	get_node_type: SYSTEM_XML_XMLNODETYPE is
		external
			"IL signature (): System.Xml.XmlNodeType use System.Xml.XmlDocumentFragment"
		alias
			"get_NodeType"
		end

	get_name: STRING is
		external
			"IL signature (): System.String use System.Xml.XmlDocumentFragment"
		alias
			"get_Name"
		end

	get_parent_node: SYSTEM_XML_XMLNODE is
		external
			"IL signature (): System.Xml.XmlNode use System.Xml.XmlDocumentFragment"
		alias
			"get_ParentNode"
		end

feature -- Element Change

	set_inner_xml (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Xml.XmlDocumentFragment"
		alias
			"set_InnerXml"
		end

feature -- Basic Operations

	write_content_to (w: SYSTEM_XML_XMLWRITER) is
		external
			"IL signature (System.Xml.XmlWriter): System.Void use System.Xml.XmlDocumentFragment"
		alias
			"WriteContentTo"
		end

	clone_node (deep: BOOLEAN): SYSTEM_XML_XMLNODE is
		external
			"IL signature (System.Boolean): System.Xml.XmlNode use System.Xml.XmlDocumentFragment"
		alias
			"CloneNode"
		end

	write_to (w: SYSTEM_XML_XMLWRITER) is
		external
			"IL signature (System.Xml.XmlWriter): System.Void use System.Xml.XmlDocumentFragment"
		alias
			"WriteTo"
		end

end -- class SYSTEM_XML_XMLDOCUMENTFRAGMENT
