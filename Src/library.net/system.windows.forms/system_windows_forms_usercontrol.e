indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Windows.Forms.UserControl"

external class
	SYSTEM_WINDOWS_FORMS_USERCONTROL

inherit
	SYSTEM_COMPONENTMODEL_ICOMPONENT
	SYSTEM_WINDOWS_FORMS_ICONTAINERCONTROL
		rename
			activate_control as system_windows_forms_icontainer_control_activate_control
		end
	SYSTEM_COMPONENTMODEL_ISYNCHRONIZEINVOKE
		rename
			invoke as invoke_delegate_array_object,
			begin_invoke as begin_invoke_delegate_array_object
		end
	SYSTEM_IDISPOSABLE
	SYSTEM_WINDOWS_FORMS_IWIN32WINDOW
	SYSTEM_WINDOWS_FORMS_CONTAINERCONTROL
		redefine
			wnd_proc,
			on_mouse_down,
			on_create_control,
			set_text,
			get_text,
			get_default_size
		end

create
	make_usercontrol

feature {NONE} -- Initialization

	frozen make_usercontrol is
		external
			"IL creator use System.Windows.Forms.UserControl"
		end

feature -- Access

	get_text: STRING is
		external
			"IL signature (): System.String use System.Windows.Forms.UserControl"
		alias
			"get_Text"
		end

feature -- Element Change

	set_text (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Windows.Forms.UserControl"
		alias
			"set_Text"
		end

	frozen remove_load (value: SYSTEM_EVENTHANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.UserControl"
		alias
			"remove_Load"
		end

	frozen add_load (value: SYSTEM_EVENTHANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.UserControl"
		alias
			"add_Load"
		end

feature {NONE} -- Implementation

	on_create_control is
		external
			"IL signature (): System.Void use System.Windows.Forms.UserControl"
		alias
			"OnCreateControl"
		end

	get_default_size: SYSTEM_DRAWING_SIZE is
		external
			"IL signature (): System.Drawing.Size use System.Windows.Forms.UserControl"
		alias
			"get_DefaultSize"
		end

	wnd_proc (m: SYSTEM_WINDOWS_FORMS_MESSAGE) is
		external
			"IL signature (System.Windows.Forms.Message&): System.Void use System.Windows.Forms.UserControl"
		alias
			"WndProc"
		end

	on_mouse_down (e: SYSTEM_WINDOWS_FORMS_MOUSEEVENTARGS) is
		external
			"IL signature (System.Windows.Forms.MouseEventArgs): System.Void use System.Windows.Forms.UserControl"
		alias
			"OnMouseDown"
		end

	on_load (e: SYSTEM_EVENTARGS) is
		external
			"IL signature (System.EventArgs): System.Void use System.Windows.Forms.UserControl"
		alias
			"OnLoad"
		end

end -- class SYSTEM_WINDOWS_FORMS_USERCONTROL
