indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Globalization.CultureTypes"
	enum_type: "INTEGER"

frozen expanded external class
	SYSTEM_GLOBALIZATION_CULTURETYPES

inherit
	ENUM
	SYSTEM_ICOMPARABLE
	SYSTEM_IFORMATTABLE

feature -- Access

	frozen all_cultures: SYSTEM_GLOBALIZATION_CULTURETYPES is
		external
			"IL enum signature :System.Globalization.CultureTypes use System.Globalization.CultureTypes"
		alias
			"7"
		end

	frozen specific_cultures: SYSTEM_GLOBALIZATION_CULTURETYPES is
		external
			"IL enum signature :System.Globalization.CultureTypes use System.Globalization.CultureTypes"
		alias
			"2"
		end

	frozen neutral_cultures: SYSTEM_GLOBALIZATION_CULTURETYPES is
		external
			"IL enum signature :System.Globalization.CultureTypes use System.Globalization.CultureTypes"
		alias
			"1"
		end

	frozen installed_win32_cultures: SYSTEM_GLOBALIZATION_CULTURETYPES is
		external
			"IL enum signature :System.Globalization.CultureTypes use System.Globalization.CultureTypes"
		alias
			"4"
		end

feature -- Basic Operations

	infix "|" (o: like Current): like Current is
		do
			--Built-in
		end

end -- class SYSTEM_GLOBALIZATION_CULTURETYPES
