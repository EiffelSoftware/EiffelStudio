indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Globalization.DateTimeStyles"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"
	enum_type: "INTEGER"

frozen expanded external class
	DATE_TIME_STYLES

inherit
	ENUM
	ICOMPARABLE
	IFORMATTABLE

feature -- Access

	frozen allow_trailing_white: DATE_TIME_STYLES is
		external
			"IL enum signature :System.Globalization.DateTimeStyles use System.Globalization.DateTimeStyles"
		alias
			"2"
		end

	frozen adjust_to_universal: DATE_TIME_STYLES is
		external
			"IL enum signature :System.Globalization.DateTimeStyles use System.Globalization.DateTimeStyles"
		alias
			"16"
		end

	frozen allow_inner_white: DATE_TIME_STYLES is
		external
			"IL enum signature :System.Globalization.DateTimeStyles use System.Globalization.DateTimeStyles"
		alias
			"4"
		end

	frozen none: DATE_TIME_STYLES is
		external
			"IL enum signature :System.Globalization.DateTimeStyles use System.Globalization.DateTimeStyles"
		alias
			"0"
		end

	frozen allow_white_spaces: DATE_TIME_STYLES is
		external
			"IL enum signature :System.Globalization.DateTimeStyles use System.Globalization.DateTimeStyles"
		alias
			"7"
		end

	frozen allow_leading_white: DATE_TIME_STYLES is
		external
			"IL enum signature :System.Globalization.DateTimeStyles use System.Globalization.DateTimeStyles"
		alias
			"1"
		end

	frozen no_current_date_default: DATE_TIME_STYLES is
		external
			"IL enum signature :System.Globalization.DateTimeStyles use System.Globalization.DateTimeStyles"
		alias
			"8"
		end

feature -- Basic Operations

	infix "|" (infix_arg: like Current): like Current is
		do
			--Built-in
		end

end -- class DATE_TIME_STYLES
