indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Xml.XmlDocumentType"

external class
	SYSTEM_XML_XMLDOCUMENTTYPE

inherit
	SYSTEM_XML_XPATH_IXPATHNAVIGABLE
	SYSTEM_ICLONEABLE
		rename
			clone as system_icloneable_clone
		end
	SYSTEM_COLLECTIONS_IENUMERABLE
		rename
			get_enumerator as system_collections_ienumerable_get_enumerator
		end
	SYSTEM_XML_XMLLINKEDNODE
		redefine
			get_is_read_only
		end

create {NONE}

feature -- Access

	get_name: STRING is
		external
			"IL signature (): System.String use System.Xml.XmlDocumentType"
		alias
			"get_Name"
		end

	get_local_name: STRING is
		external
			"IL signature (): System.String use System.Xml.XmlDocumentType"
		alias
			"get_LocalName"
		end

	frozen get_public_id: STRING is
		external
			"IL signature (): System.String use System.Xml.XmlDocumentType"
		alias
			"get_PublicId"
		end

	frozen get_internal_subset: STRING is
		external
			"IL signature (): System.String use System.Xml.XmlDocumentType"
		alias
			"get_InternalSubset"
		end

	get_is_read_only: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Xml.XmlDocumentType"
		alias
			"get_IsReadOnly"
		end

	frozen get_notations: SYSTEM_XML_XMLNAMEDNODEMAP is
		external
			"IL signature (): System.Xml.XmlNamedNodeMap use System.Xml.XmlDocumentType"
		alias
			"get_Notations"
		end

	get_node_type: SYSTEM_XML_XMLNODETYPE is
		external
			"IL signature (): System.Xml.XmlNodeType use System.Xml.XmlDocumentType"
		alias
			"get_NodeType"
		end

	frozen get_system_id: STRING is
		external
			"IL signature (): System.String use System.Xml.XmlDocumentType"
		alias
			"get_SystemId"
		end

	frozen get_entities: SYSTEM_XML_XMLNAMEDNODEMAP is
		external
			"IL signature (): System.Xml.XmlNamedNodeMap use System.Xml.XmlDocumentType"
		alias
			"get_Entities"
		end

feature -- Basic Operations

	write_content_to (w: SYSTEM_XML_XMLWRITER) is
		external
			"IL signature (System.Xml.XmlWriter): System.Void use System.Xml.XmlDocumentType"
		alias
			"WriteContentTo"
		end

	clone_node (deep: BOOLEAN): SYSTEM_XML_XMLNODE is
		external
			"IL signature (System.Boolean): System.Xml.XmlNode use System.Xml.XmlDocumentType"
		alias
			"CloneNode"
		end

	write_to (w: SYSTEM_XML_XMLWRITER) is
		external
			"IL signature (System.Xml.XmlWriter): System.Void use System.Xml.XmlDocumentType"
		alias
			"WriteTo"
		end

end -- class SYSTEM_XML_XMLDOCUMENTTYPE
