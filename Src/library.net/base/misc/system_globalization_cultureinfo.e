indexing
	Generator: "Eiffel Emitter 2.5b2"
	external_name: "System.Globalization.CultureInfo"

external class
	SYSTEM_GLOBALIZATION_CULTUREINFO

inherit
	ANY
		redefine
			finalize,
			get_hash_code,
			is_equal,
			to_string
		end
	SYSTEM_ICLONEABLE
	SYSTEM_IFORMATPROVIDER

create
	make_3,
	make_2,
	make,
	make_1

feature {NONE} -- Initialization

	frozen make_3 (culture: INTEGER; use_user_override: BOOLEAN) is
		external
			"IL creator signature (System.Int32, System.Boolean) use System.Globalization.CultureInfo"
		end

	frozen make_2 (culture: INTEGER) is
		external
			"IL creator signature (System.Int32) use System.Globalization.CultureInfo"
		end

	frozen make (name: STRING) is
		external
			"IL creator signature (System.String) use System.Globalization.CultureInfo"
		end

	frozen make_1 (name: STRING; use_user_override: BOOLEAN) is
		external
			"IL creator signature (System.String, System.Boolean) use System.Globalization.CultureInfo"
		end

feature -- Access

	frozen get_invariant_culture: SYSTEM_GLOBALIZATION_CULTUREINFO is
		external
			"IL static signature (): System.Globalization.CultureInfo use System.Globalization.CultureInfo"
		alias
			"get_InvariantCulture"
		end

	frozen get_installed_uiculture: SYSTEM_GLOBALIZATION_CULTUREINFO is
		external
			"IL static signature (): System.Globalization.CultureInfo use System.Globalization.CultureInfo"
		alias
			"get_InstalledUICulture"
		end

	get_display_name: STRING is
		external
			"IL signature (): System.String use System.Globalization.CultureInfo"
		alias
			"get_DisplayName"
		end

	get_three_letter_isolanguage_name: STRING is
		external
			"IL signature (): System.String use System.Globalization.CultureInfo"
		alias
			"get_ThreeLetterISOLanguageName"
		end

	frozen get_use_user_override: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Globalization.CultureInfo"
		alias
			"get_UseUserOverride"
		end

	frozen get_current_culture: SYSTEM_GLOBALIZATION_CULTUREINFO is
		external
			"IL static signature (): System.Globalization.CultureInfo use System.Globalization.CultureInfo"
		alias
			"get_CurrentCulture"
		end

	get_date_time_format: SYSTEM_GLOBALIZATION_DATETIMEFORMATINFO is
		external
			"IL signature (): System.Globalization.DateTimeFormatInfo use System.Globalization.CultureInfo"
		alias
			"get_DateTimeFormat"
		end

	get_calendar: SYSTEM_GLOBALIZATION_CALENDAR is
		external
			"IL signature (): System.Globalization.Calendar use System.Globalization.CultureInfo"
		alias
			"get_Calendar"
		end

	get_english_name: STRING is
		external
			"IL signature (): System.String use System.Globalization.CultureInfo"
		alias
			"get_EnglishName"
		end

	get_two_letter_isolanguage_name: STRING is
		external
			"IL signature (): System.String use System.Globalization.CultureInfo"
		alias
			"get_TwoLetterISOLanguageName"
		end

	get_name: STRING is
		external
			"IL signature (): System.String use System.Globalization.CultureInfo"
		alias
			"get_Name"
		end

	get_three_letter_windows_language_name: STRING is
		external
			"IL signature (): System.String use System.Globalization.CultureInfo"
		alias
			"get_ThreeLetterWindowsLanguageName"
		end

	get_lcid: INTEGER is
		external
			"IL signature (): System.Int32 use System.Globalization.CultureInfo"
		alias
			"get_LCID"
		end

	get_optional_calendars: ARRAY [SYSTEM_GLOBALIZATION_CALENDAR] is
		external
			"IL signature (): System.Globalization.Calendar[] use System.Globalization.CultureInfo"
		alias
			"get_OptionalCalendars"
		end

	get_native_name: STRING is
		external
			"IL signature (): System.String use System.Globalization.CultureInfo"
		alias
			"get_NativeName"
		end

	get_parent: SYSTEM_GLOBALIZATION_CULTUREINFO is
		external
			"IL signature (): System.Globalization.CultureInfo use System.Globalization.CultureInfo"
		alias
			"get_Parent"
		end

	get_compare_info: SYSTEM_GLOBALIZATION_COMPAREINFO is
		external
			"IL signature (): System.Globalization.CompareInfo use System.Globalization.CultureInfo"
		alias
			"get_CompareInfo"
		end

	get_is_neutral_culture: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Globalization.CultureInfo"
		alias
			"get_IsNeutralCulture"
		end

	get_text_info: SYSTEM_GLOBALIZATION_TEXTINFO is
		external
			"IL signature (): System.Globalization.TextInfo use System.Globalization.CultureInfo"
		alias
			"get_TextInfo"
		end

	get_is_read_only: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Globalization.CultureInfo"
		alias
			"get_IsReadOnly"
		end

	get_number_format: SYSTEM_GLOBALIZATION_NUMBERFORMATINFO is
		external
			"IL signature (): System.Globalization.NumberFormatInfo use System.Globalization.CultureInfo"
		alias
			"get_NumberFormat"
		end

	frozen get_current_uiculture: SYSTEM_GLOBALIZATION_CULTUREINFO is
		external
			"IL static signature (): System.Globalization.CultureInfo use System.Globalization.CultureInfo"
		alias
			"get_CurrentUICulture"
		end

feature -- Element Change

	set_number_format (value: SYSTEM_GLOBALIZATION_NUMBERFORMATINFO) is
		external
			"IL signature (System.Globalization.NumberFormatInfo): System.Void use System.Globalization.CultureInfo"
		alias
			"set_NumberFormat"
		end

	set_date_time_format (value: SYSTEM_GLOBALIZATION_DATETIMEFORMATINFO) is
		external
			"IL signature (System.Globalization.DateTimeFormatInfo): System.Void use System.Globalization.CultureInfo"
		alias
			"set_DateTimeFormat"
		end

feature -- Basic Operations

	to_string: STRING is
		external
			"IL signature (): System.String use System.Globalization.CultureInfo"
		alias
			"ToString"
		end

	get_format (format_type: SYSTEM_TYPE): ANY is
		external
			"IL signature (System.Type): System.Object use System.Globalization.CultureInfo"
		alias
			"GetFormat"
		end

	frozen get_cultures (types: INTEGER): ARRAY [SYSTEM_GLOBALIZATION_CULTUREINFO] is
			-- Valid values for `types' are:
			-- NeutralCultures = 1
			-- SpecificCultures = 2
			-- InstalledWin32Cultures = 4
			-- AllCultures = 7
		require
			valid_culture_types: types = 1 or types = 2 or types = 4 or types = 7
		external
			"IL static signature (enum System.Globalization.CultureTypes): System.Globalization.CultureInfo[] use System.Globalization.CultureInfo"
		alias
			"GetCultures"
		end

	clone: ANY is
		external
			"IL signature (): System.Object use System.Globalization.CultureInfo"
		alias
			"Clone"
		end

	frozen clear_cached_data is
		external
			"IL signature (): System.Void use System.Globalization.CultureInfo"
		alias
			"ClearCachedData"
		end

	is_equal (value: ANY): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Globalization.CultureInfo"
		alias
			"Equals"
		end

	frozen read_only (ci: SYSTEM_GLOBALIZATION_CULTUREINFO): SYSTEM_GLOBALIZATION_CULTUREINFO is
		external
			"IL static signature (System.Globalization.CultureInfo): System.Globalization.CultureInfo use System.Globalization.CultureInfo"
		alias
			"ReadOnly"
		end

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.Globalization.CultureInfo"
		alias
			"GetHashCode"
		end

feature {NONE} -- Implementation

	finalize is
		external
			"IL signature (): System.Void use System.Globalization.CultureInfo"
		alias
			"Finalize"
		end

end -- class SYSTEM_GLOBALIZATION_CULTUREINFO
