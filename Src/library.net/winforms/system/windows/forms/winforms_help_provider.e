indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Windows.Forms.HelpProvider"
	assembly: "System.Windows.Forms", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	WINFORMS_HELP_PROVIDER

inherit
	SYSTEM_DLL_COMPONENT
		redefine
			to_string
		end
	SYSTEM_DLL_ICOMPONENT
	IDISPOSABLE
	SYSTEM_DLL_IEXTENDER_PROVIDER

create
	make_winforms_help_provider

feature {NONE} -- Initialization

	frozen make_winforms_help_provider is
		external
			"IL creator use System.Windows.Forms.HelpProvider"
		end

feature -- Access

	get_help_namespace: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Windows.Forms.HelpProvider"
		alias
			"get_HelpNamespace"
		end

feature -- Element Change

	set_help_namespace (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Windows.Forms.HelpProvider"
		alias
			"set_HelpNamespace"
		end

feature -- Basic Operations

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Windows.Forms.HelpProvider"
		alias
			"ToString"
		end

	get_help_keyword (ctl: WINFORMS_CONTROL): SYSTEM_STRING is
		external
			"IL signature (System.Windows.Forms.Control): System.String use System.Windows.Forms.HelpProvider"
		alias
			"GetHelpKeyword"
		end

	get_show_help (ctl: WINFORMS_CONTROL): BOOLEAN is
		external
			"IL signature (System.Windows.Forms.Control): System.Boolean use System.Windows.Forms.HelpProvider"
		alias
			"GetShowHelp"
		end

	get_help_string (ctl: WINFORMS_CONTROL): SYSTEM_STRING is
		external
			"IL signature (System.Windows.Forms.Control): System.String use System.Windows.Forms.HelpProvider"
		alias
			"GetHelpString"
		end

	set_show_help (ctl: WINFORMS_CONTROL; value: BOOLEAN) is
		external
			"IL signature (System.Windows.Forms.Control, System.Boolean): System.Void use System.Windows.Forms.HelpProvider"
		alias
			"SetShowHelp"
		end

	set_help_keyword (ctl: WINFORMS_CONTROL; keyword: SYSTEM_STRING) is
		external
			"IL signature (System.Windows.Forms.Control, System.String): System.Void use System.Windows.Forms.HelpProvider"
		alias
			"SetHelpKeyword"
		end

	set_help_navigator (ctl: WINFORMS_CONTROL; navigator: WINFORMS_HELP_NAVIGATOR) is
		external
			"IL signature (System.Windows.Forms.Control, System.Windows.Forms.HelpNavigator): System.Void use System.Windows.Forms.HelpProvider"
		alias
			"SetHelpNavigator"
		end

	get_help_navigator (ctl: WINFORMS_CONTROL): WINFORMS_HELP_NAVIGATOR is
		external
			"IL signature (System.Windows.Forms.Control): System.Windows.Forms.HelpNavigator use System.Windows.Forms.HelpProvider"
		alias
			"GetHelpNavigator"
		end

	reset_show_help (ctl: WINFORMS_CONTROL) is
		external
			"IL signature (System.Windows.Forms.Control): System.Void use System.Windows.Forms.HelpProvider"
		alias
			"ResetShowHelp"
		end

	set_help_string (ctl: WINFORMS_CONTROL; help_string: SYSTEM_STRING) is
		external
			"IL signature (System.Windows.Forms.Control, System.String): System.Void use System.Windows.Forms.HelpProvider"
		alias
			"SetHelpString"
		end

	can_extend (target: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Windows.Forms.HelpProvider"
		alias
			"CanExtend"
		end

end -- class WINFORMS_HELP_PROVIDER
