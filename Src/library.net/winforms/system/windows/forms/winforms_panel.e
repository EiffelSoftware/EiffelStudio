indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Windows.Forms.Panel"
	assembly: "System.Windows.Forms", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	WINFORMS_PANEL

inherit
	WINFORMS_SCROLLABLE_CONTROL
		redefine
			on_resize,
			set_text,
			get_text,
			get_default_size,
			get_create_params,
			to_string
		end
	SYSTEM_DLL_ICOMPONENT
	IDISPOSABLE
	SYSTEM_DLL_ISYNCHRONIZE_INVOKE
		rename
			invoke as invoke_delegate_array_object,
			begin_invoke as begin_invoke_delegate_array_object
		end
	WINFORMS_IWIN32_WINDOW

create
	make_winforms_panel

feature {NONE} -- Initialization

	frozen make_winforms_panel is
		external
			"IL creator use System.Windows.Forms.Panel"
		end

feature -- Access

	frozen get_tab_stop_boolean: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.Panel"
		alias
			"get_TabStop"
		end

	get_text: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Windows.Forms.Panel"
		alias
			"get_Text"
		end

	frozen get_border_style: WINFORMS_BORDER_STYLE is
		external
			"IL signature (): System.Windows.Forms.BorderStyle use System.Windows.Forms.Panel"
		alias
			"get_BorderStyle"
		end

feature -- Element Change

	frozen set_border_style (value: WINFORMS_BORDER_STYLE) is
		external
			"IL signature (System.Windows.Forms.BorderStyle): System.Void use System.Windows.Forms.Panel"
		alias
			"set_BorderStyle"
		end

	set_text (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Windows.Forms.Panel"
		alias
			"set_Text"
		end

	frozen set_tab_stop_boolean (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Windows.Forms.Panel"
		alias
			"set_TabStop"
		end

	frozen remove_key_down_key_event_handler (value: WINFORMS_KEY_EVENT_HANDLER) is
		external
			"IL signature (System.Windows.Forms.KeyEventHandler): System.Void use System.Windows.Forms.Panel"
		alias
			"remove_KeyDown"
		end

	frozen add_key_press_key_press_event_handler (value: WINFORMS_KEY_PRESS_EVENT_HANDLER) is
		external
			"IL signature (System.Windows.Forms.KeyPressEventHandler): System.Void use System.Windows.Forms.Panel"
		alias
			"add_KeyPress"
		end

	frozen remove_key_up_key_event_handler (value: WINFORMS_KEY_EVENT_HANDLER) is
		external
			"IL signature (System.Windows.Forms.KeyEventHandler): System.Void use System.Windows.Forms.Panel"
		alias
			"remove_KeyUp"
		end

	frozen remove_key_press_key_press_event_handler (value: WINFORMS_KEY_PRESS_EVENT_HANDLER) is
		external
			"IL signature (System.Windows.Forms.KeyPressEventHandler): System.Void use System.Windows.Forms.Panel"
		alias
			"remove_KeyPress"
		end

	frozen add_key_down_key_event_handler (value: WINFORMS_KEY_EVENT_HANDLER) is
		external
			"IL signature (System.Windows.Forms.KeyEventHandler): System.Void use System.Windows.Forms.Panel"
		alias
			"add_KeyDown"
		end

	frozen add_key_up_key_event_handler (value: WINFORMS_KEY_EVENT_HANDLER) is
		external
			"IL signature (System.Windows.Forms.KeyEventHandler): System.Void use System.Windows.Forms.Panel"
		alias
			"add_KeyUp"
		end

feature -- Basic Operations

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Windows.Forms.Panel"
		alias
			"ToString"
		end

feature {NONE} -- Implementation

	on_resize (eventargs: EVENT_ARGS) is
		external
			"IL signature (System.EventArgs): System.Void use System.Windows.Forms.Panel"
		alias
			"OnResize"
		end

	get_default_size: DRAWING_SIZE is
		external
			"IL signature (): System.Drawing.Size use System.Windows.Forms.Panel"
		alias
			"get_DefaultSize"
		end

	get_create_params: WINFORMS_CREATE_PARAMS is
		external
			"IL signature (): System.Windows.Forms.CreateParams use System.Windows.Forms.Panel"
		alias
			"get_CreateParams"
		end

end -- class WINFORMS_PANEL
