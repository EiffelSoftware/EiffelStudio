indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Windows.Forms.Help"

external class
	SYSTEM_WINDOWS_FORMS_HELP

create {NONE}

feature -- Basic Operations

	frozen show_help_control_string_help_navigator (parent: SYSTEM_WINDOWS_FORMS_CONTROL; url: STRING; navigator: SYSTEM_WINDOWS_FORMS_HELPNAVIGATOR) is
		external
			"IL static signature (System.Windows.Forms.Control, System.String, System.Windows.Forms.HelpNavigator): System.Void use System.Windows.Forms.Help"
		alias
			"ShowHelp"
		end

	frozen show_help (parent: SYSTEM_WINDOWS_FORMS_CONTROL; url: STRING) is
		external
			"IL static signature (System.Windows.Forms.Control, System.String): System.Void use System.Windows.Forms.Help"
		alias
			"ShowHelp"
		end

	frozen show_help_control_string_string (parent: SYSTEM_WINDOWS_FORMS_CONTROL; url: STRING; keyword: STRING) is
		external
			"IL static signature (System.Windows.Forms.Control, System.String, System.String): System.Void use System.Windows.Forms.Help"
		alias
			"ShowHelp"
		end

	frozen show_help_index (parent: SYSTEM_WINDOWS_FORMS_CONTROL; url: STRING) is
		external
			"IL static signature (System.Windows.Forms.Control, System.String): System.Void use System.Windows.Forms.Help"
		alias
			"ShowHelpIndex"
		end

	frozen show_help_control_string_help_navigator_object (parent: SYSTEM_WINDOWS_FORMS_CONTROL; url: STRING; command: SYSTEM_WINDOWS_FORMS_HELPNAVIGATOR; param: ANY) is
		external
			"IL static signature (System.Windows.Forms.Control, System.String, System.Windows.Forms.HelpNavigator, System.Object): System.Void use System.Windows.Forms.Help"
		alias
			"ShowHelp"
		end

	frozen show_popup (parent: SYSTEM_WINDOWS_FORMS_CONTROL; caption: STRING; location: SYSTEM_DRAWING_POINT) is
		external
			"IL static signature (System.Windows.Forms.Control, System.String, System.Drawing.Point): System.Void use System.Windows.Forms.Help"
		alias
			"ShowPopup"
		end

end -- class SYSTEM_WINDOWS_FORMS_HELP
