indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Windows.Forms.NotifyIcon"
	assembly: "System.Windows.Forms", "1.0.3300.0", "neutral", "b77a5c561934e089"

frozen external class
	WINFORMS_NOTIFY_ICON

inherit
	SYSTEM_DLL_COMPONENT
		redefine
			dispose_boolean
		end
	SYSTEM_DLL_ICOMPONENT
	IDISPOSABLE

create
	make_winforms_notify_icon_1,
	make_winforms_notify_icon

feature {NONE} -- Initialization

	frozen make_winforms_notify_icon_1 (container: SYSTEM_DLL_ICONTAINER) is
		external
			"IL creator signature (System.ComponentModel.IContainer) use System.Windows.Forms.NotifyIcon"
		end

	frozen make_winforms_notify_icon is
		external
			"IL creator use System.Windows.Forms.NotifyIcon"
		end

feature -- Access

	frozen get_context_menu: WINFORMS_CONTEXT_MENU is
		external
			"IL signature (): System.Windows.Forms.ContextMenu use System.Windows.Forms.NotifyIcon"
		alias
			"get_ContextMenu"
		end

	frozen get_text: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Windows.Forms.NotifyIcon"
		alias
			"get_Text"
		end

	frozen get_icon: DRAWING_ICON is
		external
			"IL signature (): System.Drawing.Icon use System.Windows.Forms.NotifyIcon"
		alias
			"get_Icon"
		end

	frozen get_visible: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.NotifyIcon"
		alias
			"get_Visible"
		end

feature -- Element Change

	frozen set_context_menu (value: WINFORMS_CONTEXT_MENU) is
		external
			"IL signature (System.Windows.Forms.ContextMenu): System.Void use System.Windows.Forms.NotifyIcon"
		alias
			"set_ContextMenu"
		end

	frozen set_visible (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Windows.Forms.NotifyIcon"
		alias
			"set_Visible"
		end

	frozen set_icon (value: DRAWING_ICON) is
		external
			"IL signature (System.Drawing.Icon): System.Void use System.Windows.Forms.NotifyIcon"
		alias
			"set_Icon"
		end

	frozen remove_double_click (value: EVENT_HANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.NotifyIcon"
		alias
			"remove_DoubleClick"
		end

	frozen add_mouse_down (value: WINFORMS_MOUSE_EVENT_HANDLER) is
		external
			"IL signature (System.Windows.Forms.MouseEventHandler): System.Void use System.Windows.Forms.NotifyIcon"
		alias
			"add_MouseDown"
		end

	frozen set_text (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Windows.Forms.NotifyIcon"
		alias
			"set_Text"
		end

	frozen add_mouse_up (value: WINFORMS_MOUSE_EVENT_HANDLER) is
		external
			"IL signature (System.Windows.Forms.MouseEventHandler): System.Void use System.Windows.Forms.NotifyIcon"
		alias
			"add_MouseUp"
		end

	frozen remove_click (value: EVENT_HANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.NotifyIcon"
		alias
			"remove_Click"
		end

	frozen remove_mouse_move (value: WINFORMS_MOUSE_EVENT_HANDLER) is
		external
			"IL signature (System.Windows.Forms.MouseEventHandler): System.Void use System.Windows.Forms.NotifyIcon"
		alias
			"remove_MouseMove"
		end

	frozen remove_mouse_up (value: WINFORMS_MOUSE_EVENT_HANDLER) is
		external
			"IL signature (System.Windows.Forms.MouseEventHandler): System.Void use System.Windows.Forms.NotifyIcon"
		alias
			"remove_MouseUp"
		end

	frozen add_click (value: EVENT_HANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.NotifyIcon"
		alias
			"add_Click"
		end

	frozen remove_mouse_down (value: WINFORMS_MOUSE_EVENT_HANDLER) is
		external
			"IL signature (System.Windows.Forms.MouseEventHandler): System.Void use System.Windows.Forms.NotifyIcon"
		alias
			"remove_MouseDown"
		end

	frozen add_mouse_move (value: WINFORMS_MOUSE_EVENT_HANDLER) is
		external
			"IL signature (System.Windows.Forms.MouseEventHandler): System.Void use System.Windows.Forms.NotifyIcon"
		alias
			"add_MouseMove"
		end

	frozen add_double_click (value: EVENT_HANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.NotifyIcon"
		alias
			"add_DoubleClick"
		end

feature {NONE} -- Implementation

	dispose_boolean (disposing: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Windows.Forms.NotifyIcon"
		alias
			"Dispose"
		end

end -- class WINFORMS_NOTIFY_ICON
