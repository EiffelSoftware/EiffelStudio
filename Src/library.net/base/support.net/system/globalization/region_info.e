indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Globalization.RegionInfo"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	REGION_INFO

inherit
	SYSTEM_OBJECT
		redefine
			get_hash_code,
			equals,
			to_string
		end

create
	make,
	make_1

feature {NONE} -- Initialization

	frozen make (name: SYSTEM_STRING) is
		external
			"IL creator signature (System.String) use System.Globalization.RegionInfo"
		end

	frozen make_1 (culture: INTEGER) is
		external
			"IL creator signature (System.Int32) use System.Globalization.RegionInfo"
		end

feature -- Access

	get_three_letter_isoregion_name: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Globalization.RegionInfo"
		alias
			"get_ThreeLetterISORegionName"
		end

	get_name: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Globalization.RegionInfo"
		alias
			"get_Name"
		end

	get_currency_symbol: SYSTEM_STRING is
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

	get_isocurrency_symbol: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Globalization.RegionInfo"
		alias
			"get_ISOCurrencySymbol"
		end

	get_three_letter_windows_region_name: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Globalization.RegionInfo"
		alias
			"get_ThreeLetterWindowsRegionName"
		end

	frozen get_current_region: REGION_INFO is
		external
			"IL static signature (): System.Globalization.RegionInfo use System.Globalization.RegionInfo"
		alias
			"get_CurrentRegion"
		end

	get_two_letter_isoregion_name: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Globalization.RegionInfo"
		alias
			"get_TwoLetterISORegionName"
		end

	get_english_name: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Globalization.RegionInfo"
		alias
			"get_EnglishName"
		end

	get_display_name: SYSTEM_STRING is
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

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Globalization.RegionInfo"
		alias
			"ToString"
		end

	equals (value: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Globalization.RegionInfo"
		alias
			"Equals"
		end

end -- class REGION_INFO
