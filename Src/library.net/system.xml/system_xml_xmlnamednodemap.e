indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Xml.XmlNamedNodeMap"

external class
	SYSTEM_XML_XMLNAMEDNODEMAP

inherit
	ANY
		redefine
			finalize,
			get_hash_code,
			is_equal,
			to_string
		end
	SYSTEM_COLLECTIONS_IENUMERABLE

create {NONE}

feature -- Access

	get_count: INTEGER is
		external
			"IL signature (): System.Int32 use System.Xml.XmlNamedNodeMap"
		alias
			"get_Count"
		end

feature -- Basic Operations

	set_named_item (node: SYSTEM_XML_XMLNODE): SYSTEM_XML_XMLNODE is
		external
			"IL signature (System.Xml.XmlNode): System.Xml.XmlNode use System.Xml.XmlNamedNodeMap"
		alias
			"SetNamedItem"
		end

	item (index: INTEGER): SYSTEM_XML_XMLNODE is
		external
			"IL signature (System.Int32): System.Xml.XmlNode use System.Xml.XmlNamedNodeMap"
		alias
			"Item"
		end

	get_enumerator: SYSTEM_COLLECTIONS_IENUMERATOR is
		external
			"IL signature (): System.Collections.IEnumerator use System.Xml.XmlNamedNodeMap"
		alias
			"GetEnumerator"
		end

	get_named_item_string_string (local_name: STRING; namespace_uri: STRING): SYSTEM_XML_XMLNODE is
		external
			"IL signature (System.String, System.String): System.Xml.XmlNode use System.Xml.XmlNamedNodeMap"
		alias
			"GetNamedItem"
		end

	get_named_item (name: STRING): SYSTEM_XML_XMLNODE is
		external
			"IL signature (System.String): System.Xml.XmlNode use System.Xml.XmlNamedNodeMap"
		alias
			"GetNamedItem"
		end

	to_string: STRING is
		external
			"IL signature (): System.String use System.Xml.XmlNamedNodeMap"
		alias
			"ToString"
		end

	is_equal (obj: ANY): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Xml.XmlNamedNodeMap"
		alias
			"Equals"
		end

	remove_named_item (name: STRING): SYSTEM_XML_XMLNODE is
		external
			"IL signature (System.String): System.Xml.XmlNode use System.Xml.XmlNamedNodeMap"
		alias
			"RemoveNamedItem"
		end

	remove_named_item_string_string (local_name: STRING; namespace_uri: STRING): SYSTEM_XML_XMLNODE is
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

end -- class SYSTEM_XML_XMLNAMEDNODEMAP
