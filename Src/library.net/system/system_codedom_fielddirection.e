indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.CodeDom.FieldDirection"
	enum_type: "INTEGER"

frozen expanded external class
	SYSTEM_CODEDOM_FIELDDIRECTION

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

	frozen ref: SYSTEM_CODEDOM_FIELDDIRECTION is
		external
			"IL enum signature :System.CodeDom.FieldDirection use System.CodeDom.FieldDirection"
		alias
			"2"
		end

	frozen out: SYSTEM_CODEDOM_FIELDDIRECTION is
		external
			"IL enum signature :System.CodeDom.FieldDirection use System.CodeDom.FieldDirection"
		alias
			"1"
		end

	frozen in: SYSTEM_CODEDOM_FIELDDIRECTION is
		external
			"IL enum signature :System.CodeDom.FieldDirection use System.CodeDom.FieldDirection"
		alias
			"0"
		end

end -- class SYSTEM_CODEDOM_FIELDDIRECTION
