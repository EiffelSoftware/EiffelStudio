indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Globalization.CompareOptions"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"
	enum_type: "INTEGER"

frozen expanded external class
	COMPARE_OPTIONS

inherit
	ENUM
	ICOMPARABLE
	IFORMATTABLE

feature -- Access

	frozen ignore_case: COMPARE_OPTIONS is
		external
			"IL enum signature :System.Globalization.CompareOptions use System.Globalization.CompareOptions"
		alias
			"1"
		end

	frozen ordinal: COMPARE_OPTIONS is
		external
			"IL enum signature :System.Globalization.CompareOptions use System.Globalization.CompareOptions"
		alias
			"1073741824"
		end

	frozen ignore_symbols: COMPARE_OPTIONS is
		external
			"IL enum signature :System.Globalization.CompareOptions use System.Globalization.CompareOptions"
		alias
			"4"
		end

	frozen ignore_non_space: COMPARE_OPTIONS is
		external
			"IL enum signature :System.Globalization.CompareOptions use System.Globalization.CompareOptions"
		alias
			"2"
		end

	frozen ignore_width: COMPARE_OPTIONS is
		external
			"IL enum signature :System.Globalization.CompareOptions use System.Globalization.CompareOptions"
		alias
			"16"
		end

	frozen none: COMPARE_OPTIONS is
		external
			"IL enum signature :System.Globalization.CompareOptions use System.Globalization.CompareOptions"
		alias
			"0"
		end

	frozen ignore_kana_type: COMPARE_OPTIONS is
		external
			"IL enum signature :System.Globalization.CompareOptions use System.Globalization.CompareOptions"
		alias
			"8"
		end

	frozen string_sort: COMPARE_OPTIONS is
		external
			"IL enum signature :System.Globalization.CompareOptions use System.Globalization.CompareOptions"
		alias
			"536870912"
		end

feature -- Basic Operations

	infix "|" (infix_arg: like Current): like Current is
		do
			--Built-in
		end

end -- class COMPARE_OPTIONS
