indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Windows.Forms.HelpProvider"

external class
	SYSTEM_WINDOWS_FORMS_HELPPROVIDER

inherit
	SYSTEM_COMPONENTMODEL_ICOMPONENT
	SYSTEM_COMPONENTMODEL_COMPONENT
		redefine
			to_string
		end
	SYSTEM_IDISPOSABLE
	SYSTEM_COMPONENTMODEL_IEXTENDERPROVIDER

create
	make_helpprovider

feature {NONE} -- Initialization

	frozen make_helpprovider is
		external
			"IL creator use System.Windows.Forms.HelpProvider"
		end

feature -- Access

	get_help_namespace: STRING is
		external
			"IL signature (): System.String use System.Windows.Forms.HelpProvider"
		alias
			"get_HelpNamespace"
		end

feature -- Element Change

	set_help_namespace (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Windows.Forms.HelpProvider"
		alias
			"set_HelpNamespace"
		end

feature -- Basic Operations

	to_string: STRING is
		external
			"IL signature (): System.String use System.Windows.Forms.HelpProvider"
		alias
			"ToString"
		end

	get_help_keyword (ctl: SYSTEM_WINDOWS_FORMS_CONTROL): STRING is
		external
			"IL signature (System.Windows.Forms.Control): System.String use System.Windows.Forms.HelpProvider"
		alias
			"GetHelpKeyword"
		end

	get_show_help (ctl: SYSTEM_WINDOWS_FORMS_CONTROL): BOOLEAN is
		external
			"IL signature (System.Windows.Forms.Control): System.Boolean use System.Windows.Forms.HelpProvider"
		alias
			"GetShowHelp"
		end

	get_help_string (ctl: SYSTEM_WINDOWS_FORMS_CONTROL): STRING is
		external
			"IL signature (System.Windows.Forms.Control): System.String use System.Windows.Forms.HelpProvider"
		alias
			"GetHelpString"
		end

	set_show_help (ctl: SYSTEM_WINDOWS_FORMS_CONTROL; value: BOOLEAN) is
		external
			"IL signature (System.Windows.Forms.Control, System.Boolean): System.Void use System.Windows.Forms.HelpProvider"
		alias
			"SetShowHelp"
		end

	set_help_keyword (ctl: SYSTEM_WINDOWS_FORMS_CONTROL; keyword: STRING) is
		external
			"IL signature (System.Windows.Forms.Control, System.String): System.Void use System.Windows.Forms.HelpProvider"
		alias
			"SetHelpKeyword"
		end

	set_help_navigator (ctl: SYSTEM_WINDOWS_FORMS_CONTROL; navigator: SYSTEM_WINDOWS_FORMS_HELPNAVIGATOR) is
		external
			"IL signature (System.Windows.Forms.Control, System.Windows.Forms.HelpNavigator): System.Void use System.Windows.Forms.HelpProvider"
		alias
			"SetHelpNavigator"
		end

	get_help_navigator (ctl: SYSTEM_WINDOWS_FORMS_CONTROL): SYSTEM_WINDOWS_FORMS_HELPNAVIGATOR is
		external
			"IL signature (System.Windows.Forms.Control): System.Windows.Forms.HelpNavigator use System.Windows.Forms.HelpProvider"
		alias
			"GetHelpNavigator"
		end

	reset_show_help (ctl: SYSTEM_WINDOWS_FORMS_CONTROL) is
		external
			"IL signature (System.Windows.Forms.Control): System.Void use System.Windows.Forms.HelpProvider"
		alias
			"ResetShowHelp"
		end

	set_help_string (ctl: SYSTEM_WINDOWS_FORMS_CONTROL; help_string: STRING) is
		external
			"IL signature (System.Windows.Forms.Control, System.String): System.Void use System.Windows.Forms.HelpProvider"
		alias
			"SetHelpString"
		end

	can_extend (target: ANY): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Windows.Forms.HelpProvider"
		alias
			"CanExtend"
		end

end -- class SYSTEM_WINDOWS_FORMS_HELPPROVIDER
