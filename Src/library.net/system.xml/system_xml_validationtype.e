indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Xml.ValidationType"
	enum_type: "INTEGER"

frozen expanded external class
	SYSTEM_XML_VALIDATIONTYPE

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

	frozen xdr: SYSTEM_XML_VALIDATIONTYPE is
		external
			"IL enum signature :System.Xml.ValidationType use System.Xml.ValidationType"
		alias
			"3"
		end

	frozen dtd: SYSTEM_XML_VALIDATIONTYPE is
		external
			"IL enum signature :System.Xml.ValidationType use System.Xml.ValidationType"
		alias
			"2"
		end

	frozen none: SYSTEM_XML_VALIDATIONTYPE is
		external
			"IL enum signature :System.Xml.ValidationType use System.Xml.ValidationType"
		alias
			"0"
		end

	frozen schema: SYSTEM_XML_VALIDATIONTYPE is
		external
			"IL enum signature :System.Xml.ValidationType use System.Xml.ValidationType"
		alias
			"4"
		end

	frozen auto: SYSTEM_XML_VALIDATIONTYPE is
		external
			"IL enum signature :System.Xml.ValidationType use System.Xml.ValidationType"
		alias
			"1"
		end

end -- class SYSTEM_XML_VALIDATIONTYPE
