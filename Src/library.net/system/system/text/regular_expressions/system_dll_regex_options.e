indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Text.RegularExpressions.RegexOptions"
	assembly: "System", "1.0.3300.0", "neutral", "b77a5c561934e089"
	enum_type: "INTEGER"

frozen expanded external class
	SYSTEM_DLL_REGEX_OPTIONS

inherit
	ENUM
	ICOMPARABLE
	IFORMATTABLE

feature -- Access

	frozen multiline: SYSTEM_DLL_REGEX_OPTIONS is
		external
			"IL enum signature :System.Text.RegularExpressions.RegexOptions use System.Text.RegularExpressions.RegexOptions"
		alias
			"2"
		end

	frozen compiled: SYSTEM_DLL_REGEX_OPTIONS is
		external
			"IL enum signature :System.Text.RegularExpressions.RegexOptions use System.Text.RegularExpressions.RegexOptions"
		alias
			"8"
		end

	frozen ignore_pattern_whitespace: SYSTEM_DLL_REGEX_OPTIONS is
		external
			"IL enum signature :System.Text.RegularExpressions.RegexOptions use System.Text.RegularExpressions.RegexOptions"
		alias
			"32"
		end

	frozen right_to_left: SYSTEM_DLL_REGEX_OPTIONS is
		external
			"IL enum signature :System.Text.RegularExpressions.RegexOptions use System.Text.RegularExpressions.RegexOptions"
		alias
			"64"
		end

	frozen singleline: SYSTEM_DLL_REGEX_OPTIONS is
		external
			"IL enum signature :System.Text.RegularExpressions.RegexOptions use System.Text.RegularExpressions.RegexOptions"
		alias
			"16"
		end

	frozen ecmascript: SYSTEM_DLL_REGEX_OPTIONS is
		external
			"IL enum signature :System.Text.RegularExpressions.RegexOptions use System.Text.RegularExpressions.RegexOptions"
		alias
			"256"
		end

	frozen ignore_case: SYSTEM_DLL_REGEX_OPTIONS is
		external
			"IL enum signature :System.Text.RegularExpressions.RegexOptions use System.Text.RegularExpressions.RegexOptions"
		alias
			"1"
		end

	frozen none: SYSTEM_DLL_REGEX_OPTIONS is
		external
			"IL enum signature :System.Text.RegularExpressions.RegexOptions use System.Text.RegularExpressions.RegexOptions"
		alias
			"0"
		end

	frozen explicit_capture: SYSTEM_DLL_REGEX_OPTIONS is
		external
			"IL enum signature :System.Text.RegularExpressions.RegexOptions use System.Text.RegularExpressions.RegexOptions"
		alias
			"4"
		end

feature -- Basic Operations

	infix "|" (infix_arg: like Current): like Current is
		do
			--Built-in
		end

end -- class SYSTEM_DLL_REGEX_OPTIONS
