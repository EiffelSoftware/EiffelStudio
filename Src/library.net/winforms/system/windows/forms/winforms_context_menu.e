indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Windows.Forms.ContextMenu"
	assembly: "System.Windows.Forms", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	WINFORMS_CONTEXT_MENU

inherit
	WINFORMS_MENU
	SYSTEM_DLL_ICOMPONENT
	IDISPOSABLE

create
	make_winforms_context_menu_1,
	make_winforms_context_menu

feature {NONE} -- Initialization

	frozen make_winforms_context_menu_1 (menu_items: NATIVE_ARRAY [WINFORMS_MENU_ITEM]) is
		external
			"IL creator signature (System.Windows.Forms.MenuItem[]) use System.Windows.Forms.ContextMenu"
		end

	frozen make_winforms_context_menu is
		external
			"IL creator use System.Windows.Forms.ContextMenu"
		end

feature -- Access

	get_right_to_left: WINFORMS_RIGHT_TO_LEFT is
		external
			"IL signature (): System.Windows.Forms.RightToLeft use System.Windows.Forms.ContextMenu"
		alias
			"get_RightToLeft"
		end

	frozen get_source_control: WINFORMS_CONTROL is
		external
			"IL signature (): System.Windows.Forms.Control use System.Windows.Forms.ContextMenu"
		alias
			"get_SourceControl"
		end

feature -- Element Change

	frozen add_popup (value: EVENT_HANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.ContextMenu"
		alias
			"add_Popup"
		end

	set_right_to_left (value: WINFORMS_RIGHT_TO_LEFT) is
		external
			"IL signature (System.Windows.Forms.RightToLeft): System.Void use System.Windows.Forms.ContextMenu"
		alias
			"set_RightToLeft"
		end

	frozen remove_popup (value: EVENT_HANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.ContextMenu"
		alias
			"remove_Popup"
		end

feature -- Basic Operations

	frozen show (control: WINFORMS_CONTROL; pos: DRAWING_POINT) is
		external
			"IL signature (System.Windows.Forms.Control, System.Drawing.Point): System.Void use System.Windows.Forms.ContextMenu"
		alias
			"Show"
		end

feature {NONE} -- Implementation

	on_popup (e: EVENT_ARGS) is
		external
			"IL signature (System.EventArgs): System.Void use System.Windows.Forms.ContextMenu"
		alias
			"OnPopup"
		end

end -- class WINFORMS_CONTEXT_MENU
