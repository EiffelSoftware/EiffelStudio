indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Globalization.CompareOptions"
	enum_type: "INTEGER"

frozen expanded external class
	SYSTEM_GLOBALIZATION_COMPAREOPTIONS

inherit
	ENUM
	SYSTEM_ICOMPARABLE
	SYSTEM_IFORMATTABLE

feature -- Access

	frozen ignore_case: SYSTEM_GLOBALIZATION_COMPAREOPTIONS is
		external
			"IL enum signature :System.Globalization.CompareOptions use System.Globalization.CompareOptions"
		alias
			"1"
		end

	frozen ordinal: SYSTEM_GLOBALIZATION_COMPAREOPTIONS is
		external
			"IL enum signature :System.Globalization.CompareOptions use System.Globalization.CompareOptions"
		alias
			"1073741824"
		end

	frozen ignore_symbols: SYSTEM_GLOBALIZATION_COMPAREOPTIONS is
		external
			"IL enum signature :System.Globalization.CompareOptions use System.Globalization.CompareOptions"
		alias
			"4"
		end

	frozen ignore_non_space: SYSTEM_GLOBALIZATION_COMPAREOPTIONS is
		external
			"IL enum signature :System.Globalization.CompareOptions use System.Globalization.CompareOptions"
		alias
			"2"
		end

	frozen ignore_width: SYSTEM_GLOBALIZATION_COMPAREOPTIONS is
		external
			"IL enum signature :System.Globalization.CompareOptions use System.Globalization.CompareOptions"
		alias
			"16"
		end

	frozen none: SYSTEM_GLOBALIZATION_COMPAREOPTIONS is
		external
			"IL enum signature :System.Globalization.CompareOptions use System.Globalization.CompareOptions"
		alias
			"0"
		end

	frozen ignore_kana_type: SYSTEM_GLOBALIZATION_COMPAREOPTIONS is
		external
			"IL enum signature :System.Globalization.CompareOptions use System.Globalization.CompareOptions"
		alias
			"8"
		end

	frozen string_sort: SYSTEM_GLOBALIZATION_COMPAREOPTIONS is
		external
			"IL enum signature :System.Globalization.CompareOptions use System.Globalization.CompareOptions"
		alias
			"536870912"
		end

feature -- Basic Operations

	infix "|" (o: like Current): like Current is
		do
			--Built-in
		end

end -- class SYSTEM_GLOBALIZATION_COMPAREOPTIONS
