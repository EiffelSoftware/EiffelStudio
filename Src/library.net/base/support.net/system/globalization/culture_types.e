indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Globalization.CultureTypes"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"
	enum_type: "INTEGER"

frozen expanded external class
	CULTURE_TYPES

inherit
	ENUM
	ICOMPARABLE
	IFORMATTABLE

feature -- Access

	frozen all_cultures: CULTURE_TYPES is
		external
			"IL enum signature :System.Globalization.CultureTypes use System.Globalization.CultureTypes"
		alias
			"7"
		end

	frozen specific_cultures: CULTURE_TYPES is
		external
			"IL enum signature :System.Globalization.CultureTypes use System.Globalization.CultureTypes"
		alias
			"2"
		end

	frozen neutral_cultures: CULTURE_TYPES is
		external
			"IL enum signature :System.Globalization.CultureTypes use System.Globalization.CultureTypes"
		alias
			"1"
		end

	frozen installed_win32_cultures: CULTURE_TYPES is
		external
			"IL enum signature :System.Globalization.CultureTypes use System.Globalization.CultureTypes"
		alias
			"4"
		end

feature -- Basic Operations

	infix "|" (infix_arg: like Current): like Current is
		do
			--Built-in
		end

end -- class CULTURE_TYPES
