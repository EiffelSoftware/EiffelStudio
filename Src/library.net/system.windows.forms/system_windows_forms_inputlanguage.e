indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Windows.Forms.InputLanguage"

frozen external class
	SYSTEM_WINDOWS_FORMS_INPUTLANGUAGE

inherit
	ANY
		rename
			is_equal as equals_object
		redefine
			get_hash_code,
			equals_object
		end

create {NONE}

feature -- Access

	frozen get_layout_name: STRING is
		external
			"IL signature (): System.String use System.Windows.Forms.InputLanguage"
		alias
			"get_LayoutName"
		end

	frozen get_installed_input_languages: SYSTEM_WINDOWS_FORMS_INPUTLANGUAGECOLLECTION is
		external
			"IL static signature (): System.Windows.Forms.InputLanguageCollection use System.Windows.Forms.InputLanguage"
		alias
			"get_InstalledInputLanguages"
		end

	frozen get_current_input_language: SYSTEM_WINDOWS_FORMS_INPUTLANGUAGE is
		external
			"IL static signature (): System.Windows.Forms.InputLanguage use System.Windows.Forms.InputLanguage"
		alias
			"get_CurrentInputLanguage"
		end

	frozen get_default_input_language: SYSTEM_WINDOWS_FORMS_INPUTLANGUAGE is
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

	frozen get_culture: SYSTEM_GLOBALIZATION_CULTUREINFO is
		external
			"IL signature (): System.Globalization.CultureInfo use System.Windows.Forms.InputLanguage"
		alias
			"get_Culture"
		end

feature -- Element Change

	frozen set_current_input_language (value: SYSTEM_WINDOWS_FORMS_INPUTLANGUAGE) is
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

	equals_object (value: ANY): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Windows.Forms.InputLanguage"
		alias
			"Equals"
		end

	frozen from_culture (culture: SYSTEM_GLOBALIZATION_CULTUREINFO): SYSTEM_WINDOWS_FORMS_INPUTLANGUAGE is
		external
			"IL static signature (System.Globalization.CultureInfo): System.Windows.Forms.InputLanguage use System.Windows.Forms.InputLanguage"
		alias
			"FromCulture"
		end

end -- class SYSTEM_WINDOWS_FORMS_INPUTLANGUAGE
