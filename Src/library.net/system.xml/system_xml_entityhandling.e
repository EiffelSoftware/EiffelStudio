indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Xml.EntityHandling"
	enum_type: "INTEGER"

frozen expanded external class
	SYSTEM_XML_ENTITYHANDLING

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

	frozen expand_char_entities: SYSTEM_XML_ENTITYHANDLING is
		external
			"IL enum signature :System.Xml.EntityHandling use System.Xml.EntityHandling"
		alias
			"2"
		end

	frozen expand_entities: SYSTEM_XML_ENTITYHANDLING is
		external
			"IL enum signature :System.Xml.EntityHandling use System.Xml.EntityHandling"
		alias
			"1"
		end

end -- class SYSTEM_XML_ENTITYHANDLING
