indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Xml.XmlNodeList"

deferred external class
	SYSTEM_XML_XMLNODELIST

inherit
	ANY
		redefine
			finalize,
			get_hash_code,
			is_equal,
			to_string
		end
	SYSTEM_COLLECTIONS_IENUMERABLE

feature -- Access

	get_count: INTEGER is
		external
			"IL deferred signature (): System.Int32 use System.Xml.XmlNodeList"
		alias
			"get_Count"
		end

	get_item_of (i: INTEGER): SYSTEM_XML_XMLNODE is
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

	item (index: INTEGER): SYSTEM_XML_XMLNODE is
		external
			"IL deferred signature (System.Int32): System.Xml.XmlNode use System.Xml.XmlNodeList"
		alias
			"Item"
		end

	get_enumerator: SYSTEM_COLLECTIONS_IENUMERATOR is
		external
			"IL deferred signature (): System.Collections.IEnumerator use System.Xml.XmlNodeList"
		alias
			"GetEnumerator"
		end

	to_string: STRING is
		external
			"IL signature (): System.String use System.Xml.XmlNodeList"
		alias
			"ToString"
		end

	is_equal (obj: ANY): BOOLEAN is
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

end -- class SYSTEM_XML_XMLNODELIST
