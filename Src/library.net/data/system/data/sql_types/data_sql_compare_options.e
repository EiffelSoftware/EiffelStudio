indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Data.SqlTypes.SqlCompareOptions"
	assembly: "System.Data", "1.0.3300.0", "neutral", "b77a5c561934e089"
	enum_type: "INTEGER"

frozen expanded external class
	DATA_SQL_COMPARE_OPTIONS

inherit
	ENUM
	ICOMPARABLE
	IFORMATTABLE

feature -- Access

	frozen binary_sort: DATA_SQL_COMPARE_OPTIONS is
		external
			"IL enum signature :System.Data.SqlTypes.SqlCompareOptions use System.Data.SqlTypes.SqlCompareOptions"
		alias
			"32768"
		end

	frozen ignore_non_space: DATA_SQL_COMPARE_OPTIONS is
		external
			"IL enum signature :System.Data.SqlTypes.SqlCompareOptions use System.Data.SqlTypes.SqlCompareOptions"
		alias
			"2"
		end

	frozen ignore_case: DATA_SQL_COMPARE_OPTIONS is
		external
			"IL enum signature :System.Data.SqlTypes.SqlCompareOptions use System.Data.SqlTypes.SqlCompareOptions"
		alias
			"1"
		end

	frozen none: DATA_SQL_COMPARE_OPTIONS is
		external
			"IL enum signature :System.Data.SqlTypes.SqlCompareOptions use System.Data.SqlTypes.SqlCompareOptions"
		alias
			"0"
		end

	frozen ignore_width: DATA_SQL_COMPARE_OPTIONS is
		external
			"IL enum signature :System.Data.SqlTypes.SqlCompareOptions use System.Data.SqlTypes.SqlCompareOptions"
		alias
			"16"
		end

	frozen ignore_kana_type: DATA_SQL_COMPARE_OPTIONS is
		external
			"IL enum signature :System.Data.SqlTypes.SqlCompareOptions use System.Data.SqlTypes.SqlCompareOptions"
		alias
			"8"
		end

feature -- Basic Operations

	infix "|" (infix_arg: like Current): like Current is
		do
			--Built-in
		end

end -- class DATA_SQL_COMPARE_OPTIONS
