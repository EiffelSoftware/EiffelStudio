indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Windows.Forms.MainMenu"

external class
	SYSTEM_WINDOWS_FORMS_MAINMENU

inherit
	SYSTEM_COMPONENTMODEL_ICOMPONENT
	SYSTEM_WINDOWS_FORMS_MENU
		redefine
			create_menu_handle,
			dispose_boolean,
			to_string
		end
	SYSTEM_IDISPOSABLE

create
	make_mainmenu,
	make_mainmenu_1

feature {NONE} -- Initialization

	frozen make_mainmenu is
		external
			"IL creator use System.Windows.Forms.MainMenu"
		end

	frozen make_mainmenu_1 (items: ARRAY [SYSTEM_WINDOWS_FORMS_MENUITEM]) is
		external
			"IL creator signature (System.Windows.Forms.MenuItem[]) use System.Windows.Forms.MainMenu"
		end

feature -- Access

	get_right_to_left: SYSTEM_WINDOWS_FORMS_RIGHTTOLEFT is
		external
			"IL signature (): System.Windows.Forms.RightToLeft use System.Windows.Forms.MainMenu"
		alias
			"get_RightToLeft"
		end

feature -- Element Change

	set_right_to_left (value: SYSTEM_WINDOWS_FORMS_RIGHTTOLEFT) is
		external
			"IL signature (System.Windows.Forms.RightToLeft): System.Void use System.Windows.Forms.MainMenu"
		alias
			"set_RightToLeft"
		end

feature -- Basic Operations

	frozen get_form: SYSTEM_WINDOWS_FORMS_FORM is
		external
			"IL signature (): System.Windows.Forms.Form use System.Windows.Forms.MainMenu"
		alias
			"GetForm"
		end

	clone_menu_main_menu: SYSTEM_WINDOWS_FORMS_MAINMENU is
		external
			"IL signature (): System.Windows.Forms.MainMenu use System.Windows.Forms.MainMenu"
		alias
			"CloneMenu"
		end

	to_string: STRING is
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

end -- class SYSTEM_WINDOWS_FORMS_MAINMENU
