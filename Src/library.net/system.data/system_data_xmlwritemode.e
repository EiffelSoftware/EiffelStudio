indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Data.XmlWriteMode"
	enum_type: "INTEGER"

frozen expanded external class
	SYSTEM_DATA_XMLWRITEMODE

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

	frozen ignore_schema: SYSTEM_DATA_XMLWRITEMODE is
		external
			"IL enum signature :System.Data.XmlWriteMode use System.Data.XmlWriteMode"
		alias
			"1"
		end

	frozen diff_gram: SYSTEM_DATA_XMLWRITEMODE is
		external
			"IL enum signature :System.Data.XmlWriteMode use System.Data.XmlWriteMode"
		alias
			"2"
		end

	frozen write_schema: SYSTEM_DATA_XMLWRITEMODE is
		external
			"IL enum signature :System.Data.XmlWriteMode use System.Data.XmlWriteMode"
		alias
			"0"
		end

end -- class SYSTEM_DATA_XMLWRITEMODE
