indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Windows.Forms.MainMenu"
	assembly: "System.Windows.Forms", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	WINFORMS_MAIN_MENU

inherit
	WINFORMS_MENU
		redefine
			create_menu_handle,
			dispose_boolean,
			to_string
		end
	SYSTEM_DLL_ICOMPONENT
	IDISPOSABLE

create
	make_winforms_main_menu_1,
	make_winforms_main_menu

feature {NONE} -- Initialization

	frozen make_winforms_main_menu_1 (items: NATIVE_ARRAY [WINFORMS_MENU_ITEM]) is
		external
			"IL creator signature (System.Windows.Forms.MenuItem[]) use System.Windows.Forms.MainMenu"
		end

	frozen make_winforms_main_menu is
		external
			"IL creator use System.Windows.Forms.MainMenu"
		end

feature -- Access

	get_right_to_left: WINFORMS_RIGHT_TO_LEFT is
		external
			"IL signature (): System.Windows.Forms.RightToLeft use System.Windows.Forms.MainMenu"
		alias
			"get_RightToLeft"
		end

feature -- Element Change

	set_right_to_left (value: WINFORMS_RIGHT_TO_LEFT) is
		external
			"IL signature (System.Windows.Forms.RightToLeft): System.Void use System.Windows.Forms.MainMenu"
		alias
			"set_RightToLeft"
		end

feature -- Basic Operations

	frozen get_form: WINFORMS_FORM is
		external
			"IL signature (): System.Windows.Forms.Form use System.Windows.Forms.MainMenu"
		alias
			"GetForm"
		end

	clone_menu_main_menu: WINFORMS_MAIN_MENU is
		external
			"IL signature (): System.Windows.Forms.MainMenu use System.Windows.Forms.MainMenu"
		alias
			"CloneMenu"
		end

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Windows.Forms.MainMenu"
		alias
			"ToString"
		end

feature {NONE} -- Implementation

	dispose_boolean (disposing: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Windows.Forms.MainMenu"
		alias
			"Dispose"
		end

	create_menu_handle: POINTER is
		external
			"IL signature (): System.IntPtr use System.Windows.Forms.MainMenu"
		alias
			"CreateMenuHandle"
		end

end -- class WINFORMS_MAIN_MENU
