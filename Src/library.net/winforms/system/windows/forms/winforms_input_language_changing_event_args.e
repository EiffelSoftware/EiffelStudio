indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Windows.Forms.InputLanguageChangingEventArgs"
	assembly: "System.Windows.Forms", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	WINFORMS_INPUT_LANGUAGE_CHANGING_EVENT_ARGS

inherit
	SYSTEM_DLL_CANCEL_EVENT_ARGS

create
	make_winforms_input_language_changing_event_args_1,
	make_winforms_input_language_changing_event_args

feature {NONE} -- Initialization

	frozen make_winforms_input_language_changing_event_args_1 (input_language: WINFORMS_INPUT_LANGUAGE; sys_char_set: BOOLEAN) is
		external
			"IL creator signature (System.Windows.Forms.InputLanguage, System.Boolean) use System.Windows.Forms.InputLanguageChangingEventArgs"
		end

	frozen make_winforms_input_language_changing_event_args (culture: CULTURE_INFO; sys_char_set: BOOLEAN) is
		external
			"IL creator signature (System.Globalization.CultureInfo, System.Boolean) use System.Windows.Forms.InputLanguageChangingEventArgs"
		end

feature -- Access

	frozen get_input_language: WINFORMS_INPUT_LANGUAGE is
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

	frozen get_culture: CULTURE_INFO is
		external
			"IL signature (): System.Globalization.CultureInfo use System.Windows.Forms.InputLanguageChangingEventArgs"
		alias
			"get_Culture"
		end

end -- class WINFORMS_INPUT_LANGUAGE_CHANGING_EVENT_ARGS
