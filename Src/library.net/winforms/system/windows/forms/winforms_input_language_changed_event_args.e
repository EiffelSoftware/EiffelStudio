indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Windows.Forms.InputLanguageChangedEventArgs"
	assembly: "System.Windows.Forms", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	WINFORMS_INPUT_LANGUAGE_CHANGED_EVENT_ARGS

inherit
	EVENT_ARGS

create
	make_winforms_input_language_changed_event_args,
	make_winforms_input_language_changed_event_args_1

feature {NONE} -- Initialization

	frozen make_winforms_input_language_changed_event_args (culture: CULTURE_INFO; char_set: INTEGER_8) is
		external
			"IL creator signature (System.Globalization.CultureInfo, System.Byte) use System.Windows.Forms.InputLanguageChangedEventArgs"
		end

	frozen make_winforms_input_language_changed_event_args_1 (input_language: WINFORMS_INPUT_LANGUAGE; char_set: INTEGER_8) is
		external
			"IL creator signature (System.Windows.Forms.InputLanguage, System.Byte) use System.Windows.Forms.InputLanguageChangedEventArgs"
		end

feature -- Access

	frozen get_char_set: INTEGER_8 is
		external
			"IL signature (): System.Byte use System.Windows.Forms.InputLanguageChangedEventArgs"
		alias
			"get_CharSet"
		end

	frozen get_input_language: WINFORMS_INPUT_LANGUAGE is
		external
			"IL signature (): System.Windows.Forms.InputLanguage use System.Windows.Forms.InputLanguageChangedEventArgs"
		alias
			"get_InputLanguage"
		end

	frozen get_culture: CULTURE_INFO is
		external
			"IL signature (): System.Globalization.CultureInfo use System.Windows.Forms.InputLanguageChangedEventArgs"
		alias
			"get_Culture"
		end

end -- class WINFORMS_INPUT_LANGUAGE_CHANGED_EVENT_ARGS
