indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Windows.Forms.GroupBox"
	assembly: "System.Windows.Forms", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	WINFORMS_GROUP_BOX

inherit
	WINFORMS_CONTROL
		redefine
			wnd_proc,
			process_mnemonic,
			on_paint,
			on_font_changed,
			set_text,
			get_text,
			get_display_rectangle,
			get_default_size,
			get_create_params,
			set_allow_drop,
			get_allow_drop,
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
	make_winforms_group_box

feature {NONE} -- Initialization

	frozen make_winforms_group_box is
		external
			"IL creator use System.Windows.Forms.GroupBox"
		end

feature -- Access

	frozen get_tab_stop_boolean: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.GroupBox"
		alias
			"get_TabStop"
		end

	get_text: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Windows.Forms.GroupBox"
		alias
			"get_Text"
		end

	get_allow_drop: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.GroupBox"
		alias
			"get_AllowDrop"
		end

	get_display_rectangle: DRAWING_RECTANGLE is
		external
			"IL signature (): System.Drawing.Rectangle use System.Windows.Forms.GroupBox"
		alias
			"get_DisplayRectangle"
		end

	frozen get_flat_style: WINFORMS_FLAT_STYLE is
		external
			"IL signature (): System.Windows.Forms.FlatStyle use System.Windows.Forms.GroupBox"
		alias
			"get_FlatStyle"
		end

feature -- Element Change

	frozen add_double_click_event_handler (value: EVENT_HANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.GroupBox"
		alias
			"add_DoubleClick"
		end

	frozen add_click_event_handler (value: EVENT_HANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.GroupBox"
		alias
			"add_Click"
		end

	frozen remove_double_click_event_handler (value: EVENT_HANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.GroupBox"
		alias
			"remove_DoubleClick"
		end

	frozen add_key_down_key_event_handler (value: WINFORMS_KEY_EVENT_HANDLER) is
		external
			"IL signature (System.Windows.Forms.KeyEventHandler): System.Void use System.Windows.Forms.GroupBox"
		alias
			"add_KeyDown"
		end

	frozen remove_click_event_handler (value: EVENT_HANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.GroupBox"
		alias
			"remove_Click"
		end

	frozen set_tab_stop_boolean (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Windows.Forms.GroupBox"
		alias
			"set_TabStop"
		end

	frozen add_mouse_move_mouse_event_handler (value: WINFORMS_MOUSE_EVENT_HANDLER) is
		external
			"IL signature (System.Windows.Forms.MouseEventHandler): System.Void use System.Windows.Forms.GroupBox"
		alias
			"add_MouseMove"
		end

	frozen add_key_press_key_press_event_handler (value: WINFORMS_KEY_PRESS_EVENT_HANDLER) is
		external
			"IL signature (System.Windows.Forms.KeyPressEventHandler): System.Void use System.Windows.Forms.GroupBox"
		alias
			"add_KeyPress"
		end

	frozen add_mouse_enter_event_handler (value: EVENT_HANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.GroupBox"
		alias
			"add_MouseEnter"
		end

	set_allow_drop (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Windows.Forms.GroupBox"
		alias
			"set_AllowDrop"
		end

	frozen remove_mouse_up_mouse_event_handler (value: WINFORMS_MOUSE_EVENT_HANDLER) is
		external
			"IL signature (System.Windows.Forms.MouseEventHandler): System.Void use System.Windows.Forms.GroupBox"
		alias
			"remove_MouseUp"
		end

	frozen add_mouse_down_mouse_event_handler (value: WINFORMS_MOUSE_EVENT_HANDLER) is
		external
			"IL signature (System.Windows.Forms.MouseEventHandler): System.Void use System.Windows.Forms.GroupBox"
		alias
			"add_MouseDown"
		end

	frozen set_flat_style (value: WINFORMS_FLAT_STYLE) is
		external
			"IL signature (System.Windows.Forms.FlatStyle): System.Void use System.Windows.Forms.GroupBox"
		alias
			"set_FlatStyle"
		end

	frozen remove_mouse_leave_event_handler (value: EVENT_HANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.GroupBox"
		alias
			"remove_MouseLeave"
		end

	frozen remove_key_press_key_press_event_handler (value: WINFORMS_KEY_PRESS_EVENT_HANDLER) is
		external
			"IL signature (System.Windows.Forms.KeyPressEventHandler): System.Void use System.Windows.Forms.GroupBox"
		alias
			"remove_KeyPress"
		end

	set_text (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Windows.Forms.GroupBox"
		alias
			"set_Text"
		end

	frozen remove_mouse_move_mouse_event_handler (value: WINFORMS_MOUSE_EVENT_HANDLER) is
		external
			"IL signature (System.Windows.Forms.MouseEventHandler): System.Void use System.Windows.Forms.GroupBox"
		alias
			"remove_MouseMove"
		end

	frozen add_mouse_up_mouse_event_handler (value: WINFORMS_MOUSE_EVENT_HANDLER) is
		external
			"IL signature (System.Windows.Forms.MouseEventHandler): System.Void use System.Windows.Forms.GroupBox"
		alias
			"add_MouseUp"
		end

	frozen add_key_up_key_event_handler (value: WINFORMS_KEY_EVENT_HANDLER) is
		external
			"IL signature (System.Windows.Forms.KeyEventHandler): System.Void use System.Windows.Forms.GroupBox"
		alias
			"add_KeyUp"
		end

	frozen remove_key_up_key_event_handler (value: WINFORMS_KEY_EVENT_HANDLER) is
		external
			"IL signature (System.Windows.Forms.KeyEventHandler): System.Void use System.Windows.Forms.GroupBox"
		alias
			"remove_KeyUp"
		end

	frozen remove_mouse_down_mouse_event_handler (value: WINFORMS_MOUSE_EVENT_HANDLER) is
		external
			"IL signature (System.Windows.Forms.MouseEventHandler): System.Void use System.Windows.Forms.GroupBox"
		alias
			"remove_MouseDown"
		end

	frozen add_mouse_leave_event_handler (value: EVENT_HANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.GroupBox"
		alias
			"add_MouseLeave"
		end

	frozen remove_mouse_enter_event_handler (value: EVENT_HANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.GroupBox"
		alias
			"remove_MouseEnter"
		end

	frozen remove_key_down_key_event_handler (value: WINFORMS_KEY_EVENT_HANDLER) is
		external
			"IL signature (System.Windows.Forms.KeyEventHandler): System.Void use System.Windows.Forms.GroupBox"
		alias
			"remove_KeyDown"
		end

feature -- Basic Operations

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Windows.Forms.GroupBox"
		alias
			"ToString"
		end

feature {NONE} -- Implementation

	on_paint (e: WINFORMS_PAINT_EVENT_ARGS) is
		external
			"IL signature (System.Windows.Forms.PaintEventArgs): System.Void use System.Windows.Forms.GroupBox"
		alias
			"OnPaint"
		end

	on_font_changed (e: EVENT_ARGS) is
		external
			"IL signature (System.EventArgs): System.Void use System.Windows.Forms.GroupBox"
		alias
			"OnFontChanged"
		end

	process_mnemonic (char_code: CHARACTER): BOOLEAN is
		external
			"IL signature (System.Char): System.Boolean use System.Windows.Forms.GroupBox"
		alias
			"ProcessMnemonic"
		end

	wnd_proc (m: WINFORMS_MESSAGE) is
		external
			"IL signature (System.Windows.Forms.Message&): System.Void use System.Windows.Forms.GroupBox"
		alias
			"WndProc"
		end

	get_default_size: DRAWING_SIZE is
		external
			"IL signature (): System.Drawing.Size use System.Windows.Forms.GroupBox"
		alias
			"get_DefaultSize"
		end

	get_create_params: WINFORMS_CREATE_PARAMS is
		external
			"IL signature (): System.Windows.Forms.CreateParams use System.Windows.Forms.GroupBox"
		alias
			"get_CreateParams"
		end

end -- class WINFORMS_GROUP_BOX
