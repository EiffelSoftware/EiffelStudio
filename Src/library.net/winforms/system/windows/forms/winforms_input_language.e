indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Windows.Forms.InputLanguage"
	assembly: "System.Windows.Forms", "1.0.3300.0", "neutral", "b77a5c561934e089"

frozen external class
	WINFORMS_INPUT_LANGUAGE

inherit
	SYSTEM_OBJECT
		redefine
			get_hash_code,
			equals
		end

create {NONE}

feature -- Access

	frozen get_layout_name: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Windows.Forms.InputLanguage"
		alias
			"get_LayoutName"
		end

	frozen get_installed_input_languages: WINFORMS_INPUT_LANGUAGE_COLLECTION is
		external
			"IL static signature (): System.Windows.Forms.InputLanguageCollection use System.Windows.Forms.InputLanguage"
		alias
			"get_InstalledInputLanguages"
		end

	frozen get_current_input_language: WINFORMS_INPUT_LANGUAGE is
		external
			"IL static signature (): System.Windows.Forms.InputLanguage use System.Windows.Forms.InputLanguage"
		alias
			"get_CurrentInputLanguage"
		end

	frozen get_default_input_language: WINFORMS_INPUT_LANGUAGE is
		external
			"IL static signature (): System.Windows.Forms.InputLanguage use System.Windows.Forms.InputLanguage"
		alias
			"get_DefaultInputLanguage"
		end

	frozen get_handle: POINTER is
		external
			"IL signature (): System.IntPtr use System.Windows.Forms.InputLanguage"
		alias
			"get_Handle"
		end

	frozen get_culture: CULTURE_INFO is
		external
			"IL signature (): System.Globalization.CultureInfo use System.Windows.Forms.InputLanguage"
		alias
			"get_Culture"
		end

feature -- Element Change

	frozen set_current_input_language (value: WINFORMS_INPUT_LANGUAGE) is
		external
			"IL static signature (System.Windows.Forms.InputLanguage): System.Void use System.Windows.Forms.InputLanguage"
		alias
			"set_CurrentInputLanguage"
		end

feature -- Basic Operations

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.Windows.Forms.InputLanguage"
		alias
			"GetHashCode"
		end

	frozen from_culture (culture: CULTURE_INFO): WINFORMS_INPUT_LANGUAGE is
		external
			"IL static signature (System.Globalization.CultureInfo): System.Windows.Forms.InputLanguage use System.Windows.Forms.InputLanguage"
		alias
			"FromCulture"
		end

	equals (value: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Windows.Forms.InputLanguage"
		alias
			"Equals"
		end

end -- class WINFORMS_INPUT_LANGUAGE
