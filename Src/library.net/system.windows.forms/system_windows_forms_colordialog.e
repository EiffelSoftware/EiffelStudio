indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Windows.Forms.ColorDialog"

external class
	SYSTEM_WINDOWS_FORMS_COLORDIALOG

inherit
	SYSTEM_COMPONENTMODEL_ICOMPONENT
	SYSTEM_IDISPOSABLE
	SYSTEM_WINDOWS_FORMS_COMMONDIALOG
		redefine
			to_string
		end

create
	make_colordialog

feature {NONE} -- Initialization

	frozen make_colordialog is
		external
			"IL creator use System.Windows.Forms.ColorDialog"
		end

feature -- Access

	get_allow_full_open: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.ColorDialog"
		alias
			"get_AllowFullOpen"
		end

	get_show_help: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.ColorDialog"
		alias
			"get_ShowHelp"
		end

	frozen get_custom_colors: ARRAY [INTEGER] is
		external
			"IL signature (): System.Int32[] use System.Windows.Forms.ColorDialog"
		alias
			"get_CustomColors"
		end

	get_solid_color_only: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.ColorDialog"
		alias
			"get_SolidColorOnly"
		end

	get_any_color: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.ColorDialog"
		alias
			"get_AnyColor"
		end

	frozen get_color: SYSTEM_DRAWING_COLOR is
		external
			"IL signature (): System.Drawing.Color use System.Windows.Forms.ColorDialog"
		alias
			"get_Color"
		end

	get_full_open: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.ColorDialog"
		alias
			"get_FullOpen"
		end

feature -- Element Change

	set_full_open (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Windows.Forms.ColorDialog"
		alias
			"set_FullOpen"
		end

	set_solid_color_only (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Windows.Forms.ColorDialog"
		alias
			"set_SolidColorOnly"
		end

	set_show_help (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Windows.Forms.ColorDialog"
		alias
			"set_ShowHelp"
		end

	frozen set_color (value: SYSTEM_DRAWING_COLOR) is
		external
			"IL signature (System.Drawing.Color): System.Void use System.Windows.Forms.ColorDialog"
		alias
			"set_Color"
		end

	set_allow_full_open (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Windows.Forms.ColorDialog"
		alias
			"set_AllowFullOpen"
		end

	frozen set_custom_colors (value: ARRAY [INTEGER]) is
		external
			"IL signature (System.Int32[]): System.Void use System.Windows.Forms.ColorDialog"
		alias
			"set_CustomColors"
		end

	set_any_color (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Windows.Forms.ColorDialog"
		alias
			"set_AnyColor"
		end

feature -- Basic Operations

	reset is
		external
			"IL signature (): System.Void use System.Windows.Forms.ColorDialog"
		alias
			"Reset"
		end

	to_string: STRING is
		external
			"IL signature (): System.String use System.Windows.Forms.ColorDialog"
		alias
			"ToString"
		end

feature {NONE} -- Implementation

	run_dialog (hwnd_owner: POINTER): BOOLEAN is
		external
			"IL signature (System.IntPtr): System.Boolean use System.Windows.Forms.ColorDialog"
		alias
			"RunDialog"
		end

	get_instance: POINTER is
		external
			"IL signature (): System.IntPtr use System.Windows.Forms.ColorDialog"
		alias
			"get_Instance"
		end

	get_options: INTEGER is
		external
			"IL signature (): System.Int32 use System.Windows.Forms.ColorDialog"
		alias
			"get_Options"
		end

end -- class SYSTEM_WINDOWS_FORMS_COLORDIALOG
