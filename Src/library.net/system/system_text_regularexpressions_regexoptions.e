indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Text.RegularExpressions.RegexOptions"
	enum_type: "INTEGER"

frozen expanded external class
	SYSTEM_TEXT_REGULAREXPRESSIONS_REGEXOPTIONS

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

	frozen multiline: SYSTEM_TEXT_REGULAREXPRESSIONS_REGEXOPTIONS is
		external
			"IL enum signature :System.Text.RegularExpressions.RegexOptions use System.Text.RegularExpressions.RegexOptions"
		alias
			"2"
		end

	frozen compiled: SYSTEM_TEXT_REGULAREXPRESSIONS_REGEXOPTIONS is
		external
			"IL enum signature :System.Text.RegularExpressions.RegexOptions use System.Text.RegularExpressions.RegexOptions"
		alias
			"8"
		end

	frozen ignore_pattern_whitespace: SYSTEM_TEXT_REGULAREXPRESSIONS_REGEXOPTIONS is
		external
			"IL enum signature :System.Text.RegularExpressions.RegexOptions use System.Text.RegularExpressions.RegexOptions"
		alias
			"32"
		end

	frozen right_to_left: SYSTEM_TEXT_REGULAREXPRESSIONS_REGEXOPTIONS is
		external
			"IL enum signature :System.Text.RegularExpressions.RegexOptions use System.Text.RegularExpressions.RegexOptions"
		alias
			"64"
		end

	frozen singleline: SYSTEM_TEXT_REGULAREXPRESSIONS_REGEXOPTIONS is
		external
			"IL enum signature :System.Text.RegularExpressions.RegexOptions use System.Text.RegularExpressions.RegexOptions"
		alias
			"16"
		end

	frozen ecmascript: SYSTEM_TEXT_REGULAREXPRESSIONS_REGEXOPTIONS is
		external
			"IL enum signature :System.Text.RegularExpressions.RegexOptions use System.Text.RegularExpressions.RegexOptions"
		alias
			"256"
		end

	frozen ignore_case: SYSTEM_TEXT_REGULAREXPRESSIONS_REGEXOPTIONS is
		external
			"IL enum signature :System.Text.RegularExpressions.RegexOptions use System.Text.RegularExpressions.RegexOptions"
		alias
			"1"
		end

	frozen none: SYSTEM_TEXT_REGULAREXPRESSIONS_REGEXOPTIONS is
		external
			"IL enum signature :System.Text.RegularExpressions.RegexOptions use System.Text.RegularExpressions.RegexOptions"
		alias
			"0"
		end

	frozen explicit_capture: SYSTEM_TEXT_REGULAREXPRESSIONS_REGEXOPTIONS is
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

end -- class SYSTEM_TEXT_REGULAREXPRESSIONS_REGEXOPTIONS
