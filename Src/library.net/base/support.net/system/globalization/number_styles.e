indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Globalization.NumberStyles"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"
	enum_type: "INTEGER"

frozen expanded external class
	NUMBER_STYLES

inherit
	ENUM
	ICOMPARABLE
	IFORMATTABLE

feature -- Access

	frozen currency: NUMBER_STYLES is
		external
			"IL enum signature :System.Globalization.NumberStyles use System.Globalization.NumberStyles"
		alias
			"383"
		end

	frozen none: NUMBER_STYLES is
		external
			"IL enum signature :System.Globalization.NumberStyles use System.Globalization.NumberStyles"
		alias
			"0"
		end

	frozen allow_hex_specifier: NUMBER_STYLES is
		external
			"IL enum signature :System.Globalization.NumberStyles use System.Globalization.NumberStyles"
		alias
			"512"
		end

	frozen allow_trailing_sign: NUMBER_STYLES is
		external
			"IL enum signature :System.Globalization.NumberStyles use System.Globalization.NumberStyles"
		alias
			"8"
		end

	frozen allow_leading_white: NUMBER_STYLES is
		external
			"IL enum signature :System.Globalization.NumberStyles use System.Globalization.NumberStyles"
		alias
			"1"
		end

	frozen allow_parentheses: NUMBER_STYLES is
		external
			"IL enum signature :System.Globalization.NumberStyles use System.Globalization.NumberStyles"
		alias
			"16"
		end

	frozen allow_trailing_white: NUMBER_STYLES is
		external
			"IL enum signature :System.Globalization.NumberStyles use System.Globalization.NumberStyles"
		alias
			"2"
		end

	frozen allow_thousands: NUMBER_STYLES is
		external
			"IL enum signature :System.Globalization.NumberStyles use System.Globalization.NumberStyles"
		alias
			"64"
		end

	frozen hex_number: NUMBER_STYLES is
		external
			"IL enum signature :System.Globalization.NumberStyles use System.Globalization.NumberStyles"
		alias
			"515"
		end

	frozen float: NUMBER_STYLES is
		external
			"IL enum signature :System.Globalization.NumberStyles use System.Globalization.NumberStyles"
		alias
			"167"
		end

	frozen integer: NUMBER_STYLES is
		external
			"IL enum signature :System.Globalization.NumberStyles use System.Globalization.NumberStyles"
		alias
			"7"
		end

	frozen allow_currency_symbol: NUMBER_STYLES is
		external
			"IL enum signature :System.Globalization.NumberStyles use System.Globalization.NumberStyles"
		alias
			"256"
		end

	frozen allow_decimal_point: NUMBER_STYLES is
		external
			"IL enum signature :System.Globalization.NumberStyles use System.Globalization.NumberStyles"
		alias
			"32"
		end

	frozen number: NUMBER_STYLES is
		external
			"IL enum signature :System.Globalization.NumberStyles use System.Globalization.NumberStyles"
		alias
			"111"
		end

	frozen any: NUMBER_STYLES is
		external
			"IL enum signature :System.Globalization.NumberStyles use System.Globalization.NumberStyles"
		alias
			"511"
		end

	frozen allow_exponent: NUMBER_STYLES is
		external
			"IL enum signature :System.Globalization.NumberStyles use System.Globalization.NumberStyles"
		alias
			"128"
		end

	frozen allow_leading_sign: NUMBER_STYLES is
		external
			"IL enum signature :System.Globalization.NumberStyles use System.Globalization.NumberStyles"
		alias
			"4"
		end

feature -- Basic Operations

	infix "|" (infix_arg: like Current): like Current is
		do
			--Built-in
		end

end -- class NUMBER_STYLES
