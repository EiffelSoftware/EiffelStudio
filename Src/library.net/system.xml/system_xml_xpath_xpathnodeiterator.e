indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Xml.XPath.XPathNodeIterator"

deferred external class
	SYSTEM_XML_XPATH_XPATHNODEITERATOR

inherit
	ANY
		redefine
			finalize,
			get_hash_code,
			is_equal,
			to_string
		end
	SYSTEM_ICLONEABLE
		rename
			clone as system_icloneable_clone
		end

feature -- Access

	get_count: INTEGER is
		external
			"IL signature (): System.Int32 use System.Xml.XPath.XPathNodeIterator"
		alias
			"get_Count"
		end

	get_current: SYSTEM_XML_XPATH_XPATHNAVIGATOR is
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

	clone: SYSTEM_XML_XPATH_XPATHNODEITERATOR is
		external
			"IL deferred signature (): System.Xml.XPath.XPathNodeIterator use System.Xml.XPath.XPathNodeIterator"
		alias
			"Clone"
		end

	move_next: BOOLEAN is
		external
			"IL deferred signature (): System.Boolean use System.Xml.XPath.XPathNodeIterator"
		alias
			"MoveNext"
		end

	to_string: STRING is
		external
			"IL signature (): System.String use System.Xml.XPath.XPathNodeIterator"
		alias
			"ToString"
		end

	is_equal (obj: ANY): BOOLEAN is
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

	frozen system_icloneable_clone: ANY is
		external
			"IL signature (): System.Object use System.Xml.XPath.XPathNodeIterator"
		alias
			"System.ICloneable.Clone"
		end

end -- class SYSTEM_XML_XPATH_XPATHNODEITERATOR
