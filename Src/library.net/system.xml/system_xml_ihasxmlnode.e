indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Xml.IHasXmlNode"

deferred external class
	SYSTEM_XML_IHASXMLNODE

inherit
	ANY
		undefine
			finalize,
			get_hash_code,
			is_equal,
			to_string
		end

feature -- Basic Operations

	get_node: SYSTEM_XML_XMLNODE is
		external
			"IL deferred signature (): System.Xml.XmlNode use System.Xml.IHasXmlNode"
		alias
			"GetNode"
		end

end -- class SYSTEM_XML_IHASXMLNODE
