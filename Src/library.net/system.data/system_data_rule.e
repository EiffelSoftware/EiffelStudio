indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Data.Rule"
	enum_type: "INTEGER"

frozen expanded external class
	SYSTEM_DATA_RULE

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

	frozen set_default: SYSTEM_DATA_RULE is
		external
			"IL enum signature :System.Data.Rule use System.Data.Rule"
		alias
			"3"
		end

	frozen none: SYSTEM_DATA_RULE is
		external
			"IL enum signature :System.Data.Rule use System.Data.Rule"
		alias
			"0"
		end

	frozen set_null: SYSTEM_DATA_RULE is
		external
			"IL enum signature :System.Data.Rule use System.Data.Rule"
		alias
			"2"
		end

	frozen cascade: SYSTEM_DATA_RULE is
		external
			"IL enum signature :System.Data.Rule use System.Data.Rule"
		alias
			"1"
		end

end -- class SYSTEM_DATA_RULE
