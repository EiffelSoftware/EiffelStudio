indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Xml.XPath.XmlSortOrder"
	enum_type: "INTEGER"

frozen expanded external class
	SYSTEM_XML_XPATH_XMLSORTORDER

inherit
	ENUM
		rename 
			is_equal as equals_object
		end
	SYSTEM_IFORMATTABLE
		rename
			is_equal as equals_object
		end
	SYSTEM_ICOMPARABLE
		rename
			is_equal as equals_object
		end

feature -- Access

	frozen descending: SYSTEM_XML_XPATH_XMLSORTORDER is
		external
			"IL enum signature :System.Xml.XPath.XmlSortOrder use System.Xml.XPath.XmlSortOrder"
		alias
			"2"
		end

	frozen ascending: SYSTEM_XML_XPATH_XMLSORTORDER is
		external
			"IL enum signature :System.Xml.XPath.XmlSortOrder use System.Xml.XPath.XmlSortOrder"
		alias
			"1"
		end

end -- class SYSTEM_XML_XPATH_XMLSORTORDER
