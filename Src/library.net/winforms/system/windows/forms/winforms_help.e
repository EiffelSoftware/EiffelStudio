indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Windows.Forms.Help"
	assembly: "System.Windows.Forms", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	WINFORMS_HELP

inherit
	SYSTEM_OBJECT

create {NONE}

feature -- Basic Operations

	frozen show_help_control_string_help_navigator (parent: WINFORMS_CONTROL; url: SYSTEM_STRING; navigator: WINFORMS_HELP_NAVIGATOR) is
		external
			"IL static signature (System.Windows.Forms.Control, System.String, System.Windows.Forms.HelpNavigator): System.Void use System.Windows.Forms.Help"
		alias
			"ShowHelp"
		end

	frozen show_help (parent: WINFORMS_CONTROL; url: SYSTEM_STRING) is
		external
			"IL static signature (System.Windows.Forms.Control, System.String): System.Void use System.Windows.Forms.Help"
		alias
			"ShowHelp"
		end

	frozen show_help_control_string_string (parent: WINFORMS_CONTROL; url: SYSTEM_STRING; keyword: SYSTEM_STRING) is
		external
			"IL static signature (System.Windows.Forms.Control, System.String, System.String): System.Void use System.Windows.Forms.Help"
		alias
			"ShowHelp"
		end

	frozen show_help_index (parent: WINFORMS_CONTROL; url: SYSTEM_STRING) is
		external
			"IL static signature (System.Windows.Forms.Control, System.String): System.Void use System.Windows.Forms.Help"
		alias
			"ShowHelpIndex"
		end

	frozen show_help_control_string_help_navigator_object (parent: WINFORMS_CONTROL; url: SYSTEM_STRING; command: WINFORMS_HELP_NAVIGATOR; param: SYSTEM_OBJECT) is
		external
			"IL static signature (System.Windows.Forms.Control, System.String, System.Windows.Forms.HelpNavigator, System.Object): System.Void use System.Windows.Forms.Help"
		alias
			"ShowHelp"
		end

	frozen show_popup (parent: WINFORMS_CONTROL; caption: SYSTEM_STRING; location: DRAWING_POINT) is
		external
			"IL static signature (System.Windows.Forms.Control, System.String, System.Drawing.Point): System.Void use System.Windows.Forms.Help"
		alias
			"ShowPopup"
		end

end -- class WINFORMS_HELP
