indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Windows.Forms.ContextMenu"

external class
	SYSTEM_WINDOWS_FORMS_CONTEXTMENU

inherit
	SYSTEM_COMPONENTMODEL_ICOMPONENT
	SYSTEM_WINDOWS_FORMS_MENU
	SYSTEM_IDISPOSABLE

create
	make_contextmenu,
	make_contextmenu_1

feature {NONE} -- Initialization

	frozen make_contextmenu is
		external
			"IL creator use System.Windows.Forms.ContextMenu"
		end

	frozen make_contextmenu_1 (menu_items: ARRAY [SYSTEM_WINDOWS_FORMS_MENUITEM]) is
		external
			"IL creator signature (System.Windows.Forms.MenuItem[]) use System.Windows.Forms.ContextMenu"
		end

feature -- Access

	get_right_to_left: SYSTEM_WINDOWS_FORMS_RIGHTTOLEFT is
		external
			"IL signature (): System.Windows.Forms.RightToLeft use System.Windows.Forms.ContextMenu"
		alias
			"get_RightToLeft"
		end

	frozen get_source_control: SYSTEM_WINDOWS_FORMS_CONTROL is
		external
			"IL signature (): System.Windows.Forms.Control use System.Windows.Forms.ContextMenu"
		alias
			"get_SourceControl"
		end

feature -- Element Change

	frozen add_popup (value: SYSTEM_EVENTHANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.ContextMenu"
		alias
			"add_Popup"
		end

	set_right_to_left (value: SYSTEM_WINDOWS_FORMS_RIGHTTOLEFT) is
		external
			"IL signature (System.Windows.Forms.RightToLeft): System.Void use System.Windows.Forms.ContextMenu"
		alias
			"set_RightToLeft"
		end

	frozen remove_popup (value: SYSTEM_EVENTHANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.ContextMenu"
		alias
			"remove_Popup"
		end

feature -- Basic Operations

	frozen show (control: SYSTEM_WINDOWS_FORMS_CONTROL; pos: SYSTEM_DRAWING_POINT) is
		external
			"IL signature (System.Windows.Forms.Control, System.Drawing.Point): System.Void use System.Windows.Forms.ContextMenu"
		alias
			"Show"
		end

feature {NONE} -- Implementation

	on_popup (e: SYSTEM_EVENTARGS) is
		external
			"IL signature (System.EventArgs): System.Void use System.Windows.Forms.ContextMenu"
		alias
			"OnPopup"
		end

end -- class SYSTEM_WINDOWS_FORMS_CONTEXTMENU
