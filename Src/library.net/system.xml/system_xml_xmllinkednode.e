indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Xml.XmlLinkedNode"

deferred external class
	SYSTEM_XML_XMLLINKEDNODE

inherit
	SYSTEM_XML_XMLNODE
		redefine
			get_next_sibling,
			get_previous_sibling
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

feature -- Access

	get_next_sibling: SYSTEM_XML_XMLNODE is
		external
			"IL signature (): System.Xml.XmlNode use System.Xml.XmlLinkedNode"
		alias
			"get_NextSibling"
		end

	get_previous_sibling: SYSTEM_XML_XMLNODE is
		external
			"IL signature (): System.Xml.XmlNode use System.Xml.XmlLinkedNode"
		alias
			"get_PreviousSibling"
		end

end -- class SYSTEM_XML_XMLLINKEDNODE
