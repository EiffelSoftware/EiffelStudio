indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Windows.Forms.QueryAccessibilityHelpEventArgs"

external class
	SYSTEM_WINDOWS_FORMS_QUERYACCESSIBILITYHELPEVENTARGS

inherit
	SYSTEM_EVENTARGS

create
	make_queryaccessibilityhelpeventargs,
	make_queryaccessibilityhelpeventargs_1

feature {NONE} -- Initialization

	frozen make_queryaccessibilityhelpeventargs is
		external
			"IL creator use System.Windows.Forms.QueryAccessibilityHelpEventArgs"
		end

	frozen make_queryaccessibilityhelpeventargs_1 (help_namespace: STRING; help_string: STRING; help_keyword: STRING) is
		external
			"IL creator signature (System.String, System.String, System.String) use System.Windows.Forms.QueryAccessibilityHelpEventArgs"
		end

feature -- Access

	frozen get_help_string: STRING is
		external
			"IL signature (): System.String use System.Windows.Forms.QueryAccessibilityHelpEventArgs"
		alias
			"get_HelpString"
		end

	frozen get_help_namespace: STRING is
		external
			"IL signature (): System.String use System.Windows.Forms.QueryAccessibilityHelpEventArgs"
		alias
			"get_HelpNamespace"
		end

	frozen get_help_keyword: STRING is
		external
			"IL signature (): System.String use System.Windows.Forms.QueryAccessibilityHelpEventArgs"
		alias
			"get_HelpKeyword"
		end

feature -- Element Change

	frozen set_help_keyword (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Windows.Forms.QueryAccessibilityHelpEventArgs"
		alias
			"set_HelpKeyword"
		end

	frozen set_help_string (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Windows.Forms.QueryAccessibilityHelpEventArgs"
		alias
			"set_HelpString"
		end

	frozen set_help_namespace (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Windows.Forms.QueryAccessibilityHelpEventArgs"
		alias
			"set_HelpNamespace"
		end

end -- class SYSTEM_WINDOWS_FORMS_QUERYACCESSIBILITYHELPEVENTARGS
