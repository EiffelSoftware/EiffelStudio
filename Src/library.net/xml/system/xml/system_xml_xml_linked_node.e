indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Xml.XmlLinkedNode"
	assembly: "System.Xml", "1.0.3300.0", "neutral", "b77a5c561934e089"

deferred external class
	SYSTEM_XML_XML_LINKED_NODE

inherit
	SYSTEM_XML_XML_NODE
		redefine
			get_next_sibling,
			get_previous_sibling
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

feature -- Access

	get_next_sibling: SYSTEM_XML_XML_NODE is
		external
			"IL signature (): System.Xml.XmlNode use System.Xml.XmlLinkedNode"
		alias
			"get_NextSibling"
		end

	get_previous_sibling: SYSTEM_XML_XML_NODE is
		external
			"IL signature (): System.Xml.XmlNode use System.Xml.XmlLinkedNode"
		alias
			"get_PreviousSibling"
		end

end -- class SYSTEM_XML_XML_LINKED_NODE
