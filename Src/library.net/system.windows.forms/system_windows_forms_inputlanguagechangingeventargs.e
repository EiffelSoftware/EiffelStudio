indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Windows.Forms.InputLanguageChangingEventArgs"

external class
	SYSTEM_WINDOWS_FORMS_INPUTLANGUAGECHANGINGEVENTARGS

inherit
	SYSTEM_COMPONENTMODEL_CANCELEVENTARGS

create
	make_inputlanguagechangingeventargs,
	make_inputlanguagechangingeventargs_1

feature {NONE} -- Initialization

	frozen make_inputlanguagechangingeventargs (culture: SYSTEM_GLOBALIZATION_CULTUREINFO; sys_char_set: BOOLEAN) is
		external
			"IL creator signature (System.Globalization.CultureInfo, System.Boolean) use System.Windows.Forms.InputLanguageChangingEventArgs"
		end

	frozen make_inputlanguagechangingeventargs_1 (input_language: SYSTEM_WINDOWS_FORMS_INPUTLANGUAGE; sys_char_set: BOOLEAN) is
		external
			"IL creator signature (System.Windows.Forms.InputLanguage, System.Boolean) use System.Windows.Forms.InputLanguageChangingEventArgs"
		end

feature -- Access

	frozen get_input_language: SYSTEM_WINDOWS_FORMS_INPUTLANGUAGE is
		external
			"IL signature (): System.Windows.Forms.InputLanguage use System.Windows.Forms.InputLanguageChangingEventArgs"
		alias
			"get_InputLanguage"
		end

	frozen get_sys_char_set: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.InputLanguageChangingEventArgs"
		alias
			"get_SysCharSet"
		end

	frozen get_culture: SYSTEM_GLOBALIZATION_CULTUREINFO is
		external
			"IL signature (): System.Globalization.CultureInfo use System.Windows.Forms.InputLanguageChangingEventArgs"
		alias
			"get_Culture"
		end

end -- class SYSTEM_WINDOWS_FORMS_INPUTLANGUAGECHANGINGEVENTARGS
