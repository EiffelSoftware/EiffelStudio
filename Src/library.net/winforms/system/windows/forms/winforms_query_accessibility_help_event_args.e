indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Windows.Forms.QueryAccessibilityHelpEventArgs"
	assembly: "System.Windows.Forms", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	WINFORMS_QUERY_ACCESSIBILITY_HELP_EVENT_ARGS

inherit
	EVENT_ARGS

create
	make_winforms_query_accessibility_help_event_args,
	make_winforms_query_accessibility_help_event_args_1

feature {NONE} -- Initialization

	frozen make_winforms_query_accessibility_help_event_args is
		external
			"IL creator use System.Windows.Forms.QueryAccessibilityHelpEventArgs"
		end

	frozen make_winforms_query_accessibility_help_event_args_1 (help_namespace: SYSTEM_STRING; help_string: SYSTEM_STRING; help_keyword: SYSTEM_STRING) is
		external
			"IL creator signature (System.String, System.String, System.String) use System.Windows.Forms.QueryAccessibilityHelpEventArgs"
		end

feature -- Access

	frozen get_help_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Windows.Forms.QueryAccessibilityHelpEventArgs"
		alias
			"get_HelpString"
		end

	frozen get_help_namespace: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Windows.Forms.QueryAccessibilityHelpEventArgs"
		alias
			"get_HelpNamespace"
		end

	frozen get_help_keyword: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Windows.Forms.QueryAccessibilityHelpEventArgs"
		alias
			"get_HelpKeyword"
		end

feature -- Element Change

	frozen set_help_keyword (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Windows.Forms.QueryAccessibilityHelpEventArgs"
		alias
			"set_HelpKeyword"
		end

	frozen set_help_string (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Windows.Forms.QueryAccessibilityHelpEventArgs"
		alias
			"set_HelpString"
		end

	frozen set_help_namespace (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Windows.Forms.QueryAccessibilityHelpEventArgs"
		alias
			"set_HelpNamespace"
		end

end -- class WINFORMS_QUERY_ACCESSIBILITY_HELP_EVENT_ARGS
