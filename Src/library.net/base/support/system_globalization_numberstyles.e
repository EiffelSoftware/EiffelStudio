indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Globalization.NumberStyles"
	enum_type: "INTEGER"

frozen expanded external class
	SYSTEM_GLOBALIZATION_NUMBERSTYLES

inherit
	ENUM
	SYSTEM_ICOMPARABLE
	SYSTEM_IFORMATTABLE

feature -- Access

	frozen currency: SYSTEM_GLOBALIZATION_NUMBERSTYLES is
		external
			"IL enum signature :System.Globalization.NumberStyles use System.Globalization.NumberStyles"
		alias
			"383"
		end

	frozen none: SYSTEM_GLOBALIZATION_NUMBERSTYLES is
		external
			"IL enum signature :System.Globalization.NumberStyles use System.Globalization.NumberStyles"
		alias
			"0"
		end

	frozen allow_hex_specifier: SYSTEM_GLOBALIZATION_NUMBERSTYLES is
		external
			"IL enum signature :System.Globalization.NumberStyles use System.Globalization.NumberStyles"
		alias
			"512"
		end

	frozen allow_trailing_sign: SYSTEM_GLOBALIZATION_NUMBERSTYLES is
		external
			"IL enum signature :System.Globalization.NumberStyles use System.Globalization.NumberStyles"
		alias
			"8"
		end

	frozen allow_leading_white: SYSTEM_GLOBALIZATION_NUMBERSTYLES is
		external
			"IL enum signature :System.Globalization.NumberStyles use System.Globalization.NumberStyles"
		alias
			"1"
		end

	frozen allow_parentheses: SYSTEM_GLOBALIZATION_NUMBERSTYLES is
		external
			"IL enum signature :System.Globalization.NumberStyles use System.Globalization.NumberStyles"
		alias
			"16"
		end

	frozen allow_trailing_white: SYSTEM_GLOBALIZATION_NUMBERSTYLES is
		external
			"IL enum signature :System.Globalization.NumberStyles use System.Globalization.NumberStyles"
		alias
			"2"
		end

	frozen allow_thousands: SYSTEM_GLOBALIZATION_NUMBERSTYLES is
		external
			"IL enum signature :System.Globalization.NumberStyles use System.Globalization.NumberStyles"
		alias
			"64"
		end

	frozen hex_number: SYSTEM_GLOBALIZATION_NUMBERSTYLES is
		external
			"IL enum signature :System.Globalization.NumberStyles use System.Globalization.NumberStyles"
		alias
			"515"
		end

	frozen float: SYSTEM_GLOBALIZATION_NUMBERSTYLES is
		external
			"IL enum signature :System.Globalization.NumberStyles use System.Globalization.NumberStyles"
		alias
			"167"
		end

	frozen integer: SYSTEM_GLOBALIZATION_NUMBERSTYLES is
		external
			"IL enum signature :System.Globalization.NumberStyles use System.Globalization.NumberStyles"
		alias
			"7"
		end

	frozen allow_currency_symbol: SYSTEM_GLOBALIZATION_NUMBERSTYLES is
		external
			"IL enum signature :System.Globalization.NumberStyles use System.Globalization.NumberStyles"
		alias
			"256"
		end

	frozen allow_decimal_point: SYSTEM_GLOBALIZATION_NUMBERSTYLES is
		external
			"IL enum signature :System.Globalization.NumberStyles use System.Globalization.NumberStyles"
		alias
			"32"
		end

	frozen number: SYSTEM_GLOBALIZATION_NUMBERSTYLES is
		external
			"IL enum signature :System.Globalization.NumberStyles use System.Globalization.NumberStyles"
		alias
			"111"
		end

	frozen any: SYSTEM_GLOBALIZATION_NUMBERSTYLES is
		external
			"IL enum signature :System.Globalization.NumberStyles use System.Globalization.NumberStyles"
		alias
			"511"
		end

	frozen allow_exponent: SYSTEM_GLOBALIZATION_NUMBERSTYLES is
		external
			"IL enum signature :System.Globalization.NumberStyles use System.Globalization.NumberStyles"
		alias
			"128"
		end

	frozen allow_leading_sign: SYSTEM_GLOBALIZATION_NUMBERSTYLES is
		external
			"IL enum signature :System.Globalization.NumberStyles use System.Globalization.NumberStyles"
		alias
			"4"
		end

feature -- Basic Operations

	infix "|" (o: like Current): like Current is
		do
			--Built-in
		end

end -- class SYSTEM_GLOBALIZATION_NUMBERSTYLES
