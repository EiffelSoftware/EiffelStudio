indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Windows.Forms.InputLanguageChangedEventArgs"

external class
	SYSTEM_WINDOWS_FORMS_INPUTLANGUAGECHANGEDEVENTARGS

inherit
	SYSTEM_EVENTARGS

create
	make_inputlanguagechangedeventargs_1,
	make_inputlanguagechangedeventargs

feature {NONE} -- Initialization

	frozen make_inputlanguagechangedeventargs_1 (input_language: SYSTEM_WINDOWS_FORMS_INPUTLANGUAGE; char_set: INTEGER_8) is
		external
			"IL creator signature (System.Windows.Forms.InputLanguage, System.Byte) use System.Windows.Forms.InputLanguageChangedEventArgs"
		end

	frozen make_inputlanguagechangedeventargs (culture: SYSTEM_GLOBALIZATION_CULTUREINFO; char_set: INTEGER_8) is
		external
			"IL creator signature (System.Globalization.CultureInfo, System.Byte) use System.Windows.Forms.InputLanguageChangedEventArgs"
		end

feature -- Access

	frozen get_char_set: INTEGER_8 is
		external
			"IL signature (): System.Byte use System.Windows.Forms.InputLanguageChangedEventArgs"
		alias
			"get_CharSet"
		end

	frozen get_input_language: SYSTEM_WINDOWS_FORMS_INPUTLANGUAGE is
		external
			"IL signature (): System.Windows.Forms.InputLanguage use System.Windows.Forms.InputLanguageChangedEventArgs"
		alias
			"get_InputLanguage"
		end

	frozen get_culture: SYSTEM_GLOBALIZATION_CULTUREINFO is
		external
			"IL signature (): System.Globalization.CultureInfo use System.Windows.Forms.InputLanguageChangedEventArgs"
		alias
			"get_Culture"
		end

end -- class SYSTEM_WINDOWS_FORMS_INPUTLANGUAGECHANGEDEVENTARGS
