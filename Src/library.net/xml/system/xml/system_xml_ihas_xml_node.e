indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Xml.IHasXmlNode"
	assembly: "System.Xml", "1.0.3300.0", "neutral", "b77a5c561934e089"

deferred external class
	SYSTEM_XML_IHAS_XML_NODE

inherit
	SYSTEM_OBJECT
		undefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end

feature -- Basic Operations

	get_node: SYSTEM_XML_XML_NODE is
		external
			"IL deferred signature (): System.Xml.XmlNode use System.Xml.IHasXmlNode"
		alias
			"GetNode"
		end

end -- class SYSTEM_XML_IHAS_XML_NODE
