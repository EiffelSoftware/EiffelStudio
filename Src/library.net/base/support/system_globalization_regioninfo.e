indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Globalization.RegionInfo"

external class
	SYSTEM_GLOBALIZATION_REGIONINFO

inherit
	ANY
		redefine
			get_hash_code,
			is_equal,
			to_string
		end

create
	make,
	make_1

feature {NONE} -- Initialization

	frozen make (name: STRING) is
		external
			"IL creator signature (System.String) use System.Globalization.RegionInfo"
		end

	frozen make_1 (culture: INTEGER) is
		external
			"IL creator signature (System.Int32) use System.Globalization.RegionInfo"
		end

feature -- Access

	get_three_letter_isoregion_name: STRING is
		external
			"IL signature (): System.String use System.Globalization.RegionInfo"
		alias
			"get_ThreeLetterISORegionName"
		end

	get_name: STRING is
		external
			"IL signature (): System.String use System.Globalization.RegionInfo"
		alias
			"get_Name"
		end

	get_currency_symbol: STRING is
		external
			"IL signature (): System.String use System.Globalization.RegionInfo"
		alias
			"get_CurrencySymbol"
		end

	get_is_metric: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Globalization.RegionInfo"
		alias
			"get_IsMetric"
		end

	get_isocurrency_symbol: STRING is
		external
			"IL signature (): System.String use System.Globalization.RegionInfo"
		alias
			"get_ISOCurrencySymbol"
		end

	get_three_letter_windows_region_name: STRING is
		external
			"IL signature (): System.String use System.Globalization.RegionInfo"
		alias
			"get_ThreeLetterWindowsRegionName"
		end

	frozen get_current_region: SYSTEM_GLOBALIZATION_REGIONINFO is
		external
			"IL static signature (): System.Globalization.RegionInfo use System.Globalization.RegionInfo"
		alias
			"get_CurrentRegion"
		end

	get_two_letter_isoregion_name: STRING is
		external
			"IL signature (): System.String use System.Globalization.RegionInfo"
		alias
			"get_TwoLetterISORegionName"
		end

	get_english_name: STRING is
		external
			"IL signature (): System.String use System.Globalization.RegionInfo"
		alias
			"get_EnglishName"
		end

	get_display_name: STRING is
		external
			"IL signature (): System.String use System.Globalization.RegionInfo"
		alias
			"get_DisplayName"
		end

feature -- Basic Operations

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.Globalization.RegionInfo"
		alias
			"GetHashCode"
		end

	is_equal (value: ANY): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Globalization.RegionInfo"
		alias
			"Equals"
		end

	to_string: STRING is
		external
			"IL signature (): System.String use System.Globalization.RegionInfo"
		alias
			"ToString"
		end

end -- class SYSTEM_GLOBALIZATION_REGIONINFO
