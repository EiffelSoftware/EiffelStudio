indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Windows.Forms.ColorDialog"
	assembly: "System.Windows.Forms", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	WINFORMS_COLOR_DIALOG

inherit
	WINFORMS_COMMON_DIALOG
		redefine
			to_string
		end
	SYSTEM_DLL_ICOMPONENT
	IDISPOSABLE

create
	make_winforms_color_dialog

feature {NONE} -- Initialization

	frozen make_winforms_color_dialog is
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

	frozen get_custom_colors: NATIVE_ARRAY [INTEGER] is
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

	frozen get_color: DRAWING_COLOR is
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

	frozen set_color (value: DRAWING_COLOR) is
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

	frozen set_custom_colors (value: NATIVE_ARRAY [INTEGER]) is
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

	to_string: SYSTEM_STRING is
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

end -- class WINFORMS_COLOR_DIALOG
