indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Globalization.CultureInfo"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	CULTURE_INFO

inherit
	SYSTEM_OBJECT
		redefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end
	ICLONEABLE
	IFORMAT_PROVIDER

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

	frozen make (name: SYSTEM_STRING) is
		external
			"IL creator signature (System.String) use System.Globalization.CultureInfo"
		end

	frozen make_1 (name: SYSTEM_STRING; use_user_override: BOOLEAN) is
		external
			"IL creator signature (System.String, System.Boolean) use System.Globalization.CultureInfo"
		end

feature -- Access

	frozen get_invariant_culture: CULTURE_INFO is
		external
			"IL static signature (): System.Globalization.CultureInfo use System.Globalization.CultureInfo"
		alias
			"get_InvariantCulture"
		end

	frozen get_installed_uiculture: CULTURE_INFO is
		external
			"IL static signature (): System.Globalization.CultureInfo use System.Globalization.CultureInfo"
		alias
			"get_InstalledUICulture"
		end

	get_display_name: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Globalization.CultureInfo"
		alias
			"get_DisplayName"
		end

	get_three_letter_isolanguage_name: SYSTEM_STRING is
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

	frozen get_current_culture: CULTURE_INFO is
		external
			"IL static signature (): System.Globalization.CultureInfo use System.Globalization.CultureInfo"
		alias
			"get_CurrentCulture"
		end

	get_date_time_format: DATE_TIME_FORMAT_INFO is
		external
			"IL signature (): System.Globalization.DateTimeFormatInfo use System.Globalization.CultureInfo"
		alias
			"get_DateTimeFormat"
		end

	get_calendar: CALENDAR is
		external
			"IL signature (): System.Globalization.Calendar use System.Globalization.CultureInfo"
		alias
			"get_Calendar"
		end

	get_english_name: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Globalization.CultureInfo"
		alias
			"get_EnglishName"
		end

	get_two_letter_isolanguage_name: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Globalization.CultureInfo"
		alias
			"get_TwoLetterISOLanguageName"
		end

	get_name: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Globalization.CultureInfo"
		alias
			"get_Name"
		end

	get_three_letter_windows_language_name: SYSTEM_STRING is
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

	get_optional_calendars: NATIVE_ARRAY [CALENDAR] is
		external
			"IL signature (): System.Globalization.Calendar[] use System.Globalization.CultureInfo"
		alias
			"get_OptionalCalendars"
		end

	get_native_name: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Globalization.CultureInfo"
		alias
			"get_NativeName"
		end

	get_parent: CULTURE_INFO is
		external
			"IL signature (): System.Globalization.CultureInfo use System.Globalization.CultureInfo"
		alias
			"get_Parent"
		end

	get_compare_info: COMPARE_INFO is
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

	get_text_info: TEXT_INFO is
		external
			"IL signature (): System.Globalization.TextInfo use System.Globalization.CultureInfo"
		alias
			"get_TextInfo"
		end

	frozen get_is_read_only: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Globalization.CultureInfo"
		alias
			"get_IsReadOnly"
		end

	get_number_format: NUMBER_FORMAT_INFO is
		external
			"IL signature (): System.Globalization.NumberFormatInfo use System.Globalization.CultureInfo"
		alias
			"get_NumberFormat"
		end

	frozen get_current_uiculture: CULTURE_INFO is
		external
			"IL static signature (): System.Globalization.CultureInfo use System.Globalization.CultureInfo"
		alias
			"get_CurrentUICulture"
		end

feature -- Element Change

	set_number_format (value: NUMBER_FORMAT_INFO) is
		external
			"IL signature (System.Globalization.NumberFormatInfo): System.Void use System.Globalization.CultureInfo"
		alias
			"set_NumberFormat"
		end

	set_date_time_format (value: DATE_TIME_FORMAT_INFO) is
		external
			"IL signature (System.Globalization.DateTimeFormatInfo): System.Void use System.Globalization.CultureInfo"
		alias
			"set_DateTimeFormat"
		end

feature -- Basic Operations

	frozen create_specific_culture (name: SYSTEM_STRING): CULTURE_INFO is
		external
			"IL static signature (System.String): System.Globalization.CultureInfo use System.Globalization.CultureInfo"
		alias
			"CreateSpecificCulture"
		end

	get_format (format_type: TYPE): SYSTEM_OBJECT is
		external
			"IL signature (System.Type): System.Object use System.Globalization.CultureInfo"
		alias
			"GetFormat"
		end

	clone_: SYSTEM_OBJECT is
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

	frozen read_only (ci: CULTURE_INFO): CULTURE_INFO is
		external
			"IL static signature (System.Globalization.CultureInfo): System.Globalization.CultureInfo use System.Globalization.CultureInfo"
		alias
			"ReadOnly"
		end

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Globalization.CultureInfo"
		alias
			"ToString"
		end

	equals (value: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Globalization.CultureInfo"
		alias
			"Equals"
		end

	frozen get_cultures (types: CULTURE_TYPES): NATIVE_ARRAY [CULTURE_INFO] is
		external
			"IL static signature (System.Globalization.CultureTypes): System.Globalization.CultureInfo[] use System.Globalization.CultureInfo"
		alias
			"GetCultures"
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

end -- class CULTURE_INFO
