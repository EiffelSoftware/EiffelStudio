indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Windows.Forms.UserControl"
	assembly: "System.Windows.Forms", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	WINFORMS_USER_CONTROL

inherit
	WINFORMS_CONTAINER_CONTROL
		redefine
			wnd_proc,
			on_mouse_down,
			on_create_control,
			set_text,
			get_text,
			get_default_size
		end
	SYSTEM_DLL_ICOMPONENT
	IDISPOSABLE
	SYSTEM_DLL_ISYNCHRONIZE_INVOKE
		rename
			invoke as invoke_delegate_array_object,
			begin_invoke as begin_invoke_delegate_array_object
		end
	WINFORMS_IWIN32_WINDOW
	WINFORMS_ICONTAINER_CONTROL
		rename
			activate_control as system_windows_forms_icontainer_control_activate_control
		end

create
	make_winforms_user_control

feature {NONE} -- Initialization

	frozen make_winforms_user_control is
		external
			"IL creator use System.Windows.Forms.UserControl"
		end

feature -- Access

	get_text: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Windows.Forms.UserControl"
		alias
			"get_Text"
		end

feature -- Element Change

	set_text (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Windows.Forms.UserControl"
		alias
			"set_Text"
		end

	frozen remove_load (value: EVENT_HANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.UserControl"
		alias
			"remove_Load"
		end

	frozen add_load (value: EVENT_HANDLER) is
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

	get_default_size: DRAWING_SIZE is
		external
			"IL signature (): System.Drawing.Size use System.Windows.Forms.UserControl"
		alias
			"get_DefaultSize"
		end

	wnd_proc (m: WINFORMS_MESSAGE) is
		external
			"IL signature (System.Windows.Forms.Message&): System.Void use System.Windows.Forms.UserControl"
		alias
			"WndProc"
		end

	on_mouse_down (e: WINFORMS_MOUSE_EVENT_ARGS) is
		external
			"IL signature (System.Windows.Forms.MouseEventArgs): System.Void use System.Windows.Forms.UserControl"
		alias
			"OnMouseDown"
		end

	on_load (e: EVENT_ARGS) is
		external
			"IL signature (System.EventArgs): System.Void use System.Windows.Forms.UserControl"
		alias
			"OnLoad"
		end

end -- class WINFORMS_USER_CONTROL
