indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Xml.XmlNodeList"
	assembly: "System.Xml", "1.0.3300.0", "neutral", "b77a5c561934e089"

deferred external class
	SYSTEM_XML_XML_NODE_LIST

inherit
	SYSTEM_OBJECT
		redefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end
	IENUMERABLE

feature -- Access

	get_count: INTEGER is
		external
			"IL deferred signature (): System.Int32 use System.Xml.XmlNodeList"
		alias
			"get_Count"
		end

	get_item_of (i: INTEGER): SYSTEM_XML_XML_NODE is
		external
			"IL signature (System.Int32): System.Xml.XmlNode use System.Xml.XmlNodeList"
		alias
			"get_ItemOf"
		end

feature -- Basic Operations

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.Xml.XmlNodeList"
		alias
			"GetHashCode"
		end

	item (index: INTEGER): SYSTEM_XML_XML_NODE is
		external
			"IL deferred signature (System.Int32): System.Xml.XmlNode use System.Xml.XmlNodeList"
		alias
			"Item"
		end

	get_enumerator: IENUMERATOR is
		external
			"IL deferred signature (): System.Collections.IEnumerator use System.Xml.XmlNodeList"
		alias
			"GetEnumerator"
		end

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Xml.XmlNodeList"
		alias
			"ToString"
		end

	equals (obj: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Xml.XmlNodeList"
		alias
			"Equals"
		end

feature {NONE} -- Implementation

	finalize is
		external
			"IL signature (): System.Void use System.Xml.XmlNodeList"
		alias
			"Finalize"
		end

end -- class SYSTEM_XML_XML_NODE_LIST
