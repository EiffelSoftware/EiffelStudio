indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Xml.XPath.XPathNodeIterator"
	assembly: "System.Xml", "1.0.3300.0", "neutral", "b77a5c561934e089"

deferred external class
	SYSTEM_XML_XPATH_NODE_ITERATOR

inherit
	SYSTEM_OBJECT
		redefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end
	ICLONEABLE
		rename
			clone_ as system_icloneable_clone
		end

feature -- Access

	get_count: INTEGER is
		external
			"IL signature (): System.Int32 use System.Xml.XPath.XPathNodeIterator"
		alias
			"get_Count"
		end

	get_current: SYSTEM_XML_XPATH_NAVIGATOR is
		external
			"IL deferred signature (): System.Xml.XPath.XPathNavigator use System.Xml.XPath.XPathNodeIterator"
		alias
			"get_Current"
		end

	get_current_position: INTEGER is
		external
			"IL deferred signature (): System.Int32 use System.Xml.XPath.XPathNodeIterator"
		alias
			"get_CurrentPosition"
		end

feature -- Basic Operations

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.Xml.XPath.XPathNodeIterator"
		alias
			"GetHashCode"
		end

	move_next: BOOLEAN is
		external
			"IL deferred signature (): System.Boolean use System.Xml.XPath.XPathNodeIterator"
		alias
			"MoveNext"
		end

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Xml.XPath.XPathNodeIterator"
		alias
			"ToString"
		end

	clone_: SYSTEM_XML_XPATH_NODE_ITERATOR is
		external
			"IL deferred signature (): System.Xml.XPath.XPathNodeIterator use System.Xml.XPath.XPathNodeIterator"
		alias
			"Clone"
		end

	equals (obj: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Xml.XPath.XPathNodeIterator"
		alias
			"Equals"
		end

feature {NONE} -- Implementation

	finalize is
		external
			"IL signature (): System.Void use System.Xml.XPath.XPathNodeIterator"
		alias
			"Finalize"
		end

	frozen system_icloneable_clone: SYSTEM_OBJECT is
		external
			"IL signature (): System.Object use System.Xml.XPath.XPathNodeIterator"
		alias
			"System.ICloneable.Clone"
		end

end -- class SYSTEM_XML_XPATH_NODE_ITERATOR
