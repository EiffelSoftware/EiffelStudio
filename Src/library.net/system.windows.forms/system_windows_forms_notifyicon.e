indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Windows.Forms.NotifyIcon"

frozen external class
	SYSTEM_WINDOWS_FORMS_NOTIFYICON

inherit
	SYSTEM_COMPONENTMODEL_ICOMPONENT
	SYSTEM_COMPONENTMODEL_COMPONENT
		redefine
			dispose_boolean
		end
	SYSTEM_IDISPOSABLE

create
	make_notifyicon,
	make_notifyicon_1

feature {NONE} -- Initialization

	frozen make_notifyicon is
		external
			"IL creator use System.Windows.Forms.NotifyIcon"
		end

	frozen make_notifyicon_1 (container: SYSTEM_COMPONENTMODEL_ICONTAINER) is
		external
			"IL creator signature (System.ComponentModel.IContainer) use System.Windows.Forms.NotifyIcon"
		end

feature -- Access

	frozen get_context_menu: SYSTEM_WINDOWS_FORMS_CONTEXTMENU is
		external
			"IL signature (): System.Windows.Forms.ContextMenu use System.Windows.Forms.NotifyIcon"
		alias
			"get_ContextMenu"
		end

	frozen get_text: STRING is
		external
			"IL signature (): System.String use System.Windows.Forms.NotifyIcon"
		alias
			"get_Text"
		end

	frozen get_icon: SYSTEM_DRAWING_ICON is
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

	frozen set_context_menu (value: SYSTEM_WINDOWS_FORMS_CONTEXTMENU) is
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

	frozen set_icon (value: SYSTEM_DRAWING_ICON) is
		external
			"IL signature (System.Drawing.Icon): System.Void use System.Windows.Forms.NotifyIcon"
		alias
			"set_Icon"
		end

	frozen remove_double_click (value: SYSTEM_EVENTHANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.NotifyIcon"
		alias
			"remove_DoubleClick"
		end

	frozen add_mouse_down (value: SYSTEM_WINDOWS_FORMS_MOUSEEVENTHANDLER) is
		external
			"IL signature (System.Windows.Forms.MouseEventHandler): System.Void use System.Windows.Forms.NotifyIcon"
		alias
			"add_MouseDown"
		end

	frozen set_text (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Windows.Forms.NotifyIcon"
		alias
			"set_Text"
		end

	frozen add_mouse_up (value: SYSTEM_WINDOWS_FORMS_MOUSEEVENTHANDLER) is
		external
			"IL signature (System.Windows.Forms.MouseEventHandler): System.Void use System.Windows.Forms.NotifyIcon"
		alias
			"add_MouseUp"
		end

	frozen remove_click (value: SYSTEM_EVENTHANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.NotifyIcon"
		alias
			"remove_Click"
		end

	frozen remove_mouse_move (value: SYSTEM_WINDOWS_FORMS_MOUSEEVENTHANDLER) is
		external
			"IL signature (System.Windows.Forms.MouseEventHandler): System.Void use System.Windows.Forms.NotifyIcon"
		alias
			"remove_MouseMove"
		end

	frozen remove_mouse_up (value: SYSTEM_WINDOWS_FORMS_MOUSEEVENTHANDLER) is
		external
			"IL signature (System.Windows.Forms.MouseEventHandler): System.Void use System.Windows.Forms.NotifyIcon"
		alias
			"remove_MouseUp"
		end

	frozen add_click (value: SYSTEM_EVENTHANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.NotifyIcon"
		alias
			"add_Click"
		end

	frozen remove_mouse_down (value: SYSTEM_WINDOWS_FORMS_MOUSEEVENTHANDLER) is
		external
			"IL signature (System.Windows.Forms.MouseEventHandler): System.Void use System.Windows.Forms.NotifyIcon"
		alias
			"remove_MouseDown"
		end

	frozen add_mouse_move (value: SYSTEM_WINDOWS_FORMS_MOUSEEVENTHANDLER) is
		external
			"IL signature (System.Windows.Forms.MouseEventHandler): System.Void use System.Windows.Forms.NotifyIcon"
		alias
			"add_MouseMove"
		end

	frozen add_double_click (value: SYSTEM_EVENTHANDLER) is
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

end -- class SYSTEM_WINDOWS_FORMS_NOTIFYICON
