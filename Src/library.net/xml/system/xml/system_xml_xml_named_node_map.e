indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Xml.XmlNamedNodeMap"
	assembly: "System.Xml", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	SYSTEM_XML_XML_NAMED_NODE_MAP

inherit
	SYSTEM_OBJECT
		redefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end
	IENUMERABLE

create {NONE}

feature -- Access

	get_count: INTEGER is
		external
			"IL signature (): System.Int32 use System.Xml.XmlNamedNodeMap"
		alias
			"get_Count"
		end

feature -- Basic Operations

	set_named_item (node: SYSTEM_XML_XML_NODE): SYSTEM_XML_XML_NODE is
		external
			"IL signature (System.Xml.XmlNode): System.Xml.XmlNode use System.Xml.XmlNamedNodeMap"
		alias
			"SetNamedItem"
		end

	item (index: INTEGER): SYSTEM_XML_XML_NODE is
		external
			"IL signature (System.Int32): System.Xml.XmlNode use System.Xml.XmlNamedNodeMap"
		alias
			"Item"
		end

	get_enumerator: IENUMERATOR is
		external
			"IL signature (): System.Collections.IEnumerator use System.Xml.XmlNamedNodeMap"
		alias
			"GetEnumerator"
		end

	get_named_item_string_string (local_name: SYSTEM_STRING; namespace_uri: SYSTEM_STRING): SYSTEM_XML_XML_NODE is
		external
			"IL signature (System.String, System.String): System.Xml.XmlNode use System.Xml.XmlNamedNodeMap"
		alias
			"GetNamedItem"
		end

	get_named_item (name: SYSTEM_STRING): SYSTEM_XML_XML_NODE is
		external
			"IL signature (System.String): System.Xml.XmlNode use System.Xml.XmlNamedNodeMap"
		alias
			"GetNamedItem"
		end

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Xml.XmlNamedNodeMap"
		alias
			"ToString"
		end

	equals (obj: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Xml.XmlNamedNodeMap"
		alias
			"Equals"
		end

	remove_named_item (name: SYSTEM_STRING): SYSTEM_XML_XML_NODE is
		external
			"IL signature (System.String): System.Xml.XmlNode use System.Xml.XmlNamedNodeMap"
		alias
			"RemoveNamedItem"
		end

	remove_named_item_string_string (local_name: SYSTEM_STRING; namespace_uri: SYSTEM_STRING): SYSTEM_XML_XML_NODE is
		external
			"IL signature (System.String, System.String): System.Xml.XmlNode use System.Xml.XmlNamedNodeMap"
		alias
			"RemoveNamedItem"
		end

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.Xml.XmlNamedNodeMap"
		alias
			"GetHashCode"
		end

feature {NONE} -- Implementation

	finalize is
		external
			"IL signature (): System.Void use System.Xml.XmlNamedNodeMap"
		alias
			"Finalize"
		end

end -- class SYSTEM_XML_XML_NAMED_NODE_MAP
