indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Xml.XmlNodeChangedAction"
	enum_type: "INTEGER"

frozen expanded external class
	SYSTEM_XML_XMLNODECHANGEDACTION

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

	frozen change: SYSTEM_XML_XMLNODECHANGEDACTION is
		external
			"IL enum signature :System.Xml.XmlNodeChangedAction use System.Xml.XmlNodeChangedAction"
		alias
			"2"
		end

	frozen remove: SYSTEM_XML_XMLNODECHANGEDACTION is
		external
			"IL enum signature :System.Xml.XmlNodeChangedAction use System.Xml.XmlNodeChangedAction"
		alias
			"1"
		end

	frozen insert: SYSTEM_XML_XMLNODECHANGEDACTION is
		external
			"IL enum signature :System.Xml.XmlNodeChangedAction use System.Xml.XmlNodeChangedAction"
		alias
			"0"
		end

end -- class SYSTEM_XML_XMLNODECHANGEDACTION
