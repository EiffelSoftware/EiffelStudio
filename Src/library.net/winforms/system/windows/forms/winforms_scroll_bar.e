indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Windows.Forms.ScrollBar"
	assembly: "System.Windows.Forms", "1.0.3300.0", "neutral", "b77a5c561934e089"

deferred external class
	WINFORMS_SCROLL_BAR

inherit
	WINFORMS_CONTROL
		redefine
			wnd_proc,
			on_handle_created,
			on_enabled_changed,
			set_text,
			get_text,
			set_fore_color,
			get_fore_color,
			set_font,
			get_font,
			get_default_ime_mode,
			get_create_params,
			set_background_image,
			get_background_image,
			set_back_color,
			get_back_color,
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

feature -- Access

	frozen get_tab_stop_boolean: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.ScrollBar"
		alias
			"get_TabStop"
		end

	get_back_color: DRAWING_COLOR is
		external
			"IL signature (): System.Drawing.Color use System.Windows.Forms.ScrollBar"
		alias
			"get_BackColor"
		end

	get_font: DRAWING_FONT is
		external
			"IL signature (): System.Drawing.Font use System.Windows.Forms.ScrollBar"
		alias
			"get_Font"
		end

	frozen get_small_change: INTEGER is
		external
			"IL signature (): System.Int32 use System.Windows.Forms.ScrollBar"
		alias
			"get_SmallChange"
		end

	frozen get_maximum: INTEGER is
		external
			"IL signature (): System.Int32 use System.Windows.Forms.ScrollBar"
		alias
			"get_Maximum"
		end

	get_text: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Windows.Forms.ScrollBar"
		alias
			"get_Text"
		end

	frozen get_ime_mode_ime_mode: WINFORMS_IME_MODE is
		external
			"IL signature (): System.Windows.Forms.ImeMode use System.Windows.Forms.ScrollBar"
		alias
			"get_ImeMode"
		end

	frozen get_value: INTEGER is
		external
			"IL signature (): System.Int32 use System.Windows.Forms.ScrollBar"
		alias
			"get_Value"
		end

	get_fore_color: DRAWING_COLOR is
		external
			"IL signature (): System.Drawing.Color use System.Windows.Forms.ScrollBar"
		alias
			"get_ForeColor"
		end

	get_background_image: DRAWING_IMAGE is
		external
			"IL signature (): System.Drawing.Image use System.Windows.Forms.ScrollBar"
		alias
			"get_BackgroundImage"
		end

	frozen get_minimum: INTEGER is
		external
			"IL signature (): System.Int32 use System.Windows.Forms.ScrollBar"
		alias
			"get_Minimum"
		end

	frozen get_large_change: INTEGER is
		external
			"IL signature (): System.Int32 use System.Windows.Forms.ScrollBar"
		alias
			"get_LargeChange"
		end

feature -- Element Change

	frozen remove_double_click_event_handler (value: EVENT_HANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.ScrollBar"
		alias
			"remove_DoubleClick"
		end

	frozen set_large_change (value: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.Windows.Forms.ScrollBar"
		alias
			"set_LargeChange"
		end

	frozen add_click_event_handler (value: EVENT_HANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.ScrollBar"
		alias
			"add_Click"
		end

	frozen set_value (value: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.Windows.Forms.ScrollBar"
		alias
			"set_Value"
		end

	set_back_color (value: DRAWING_COLOR) is
		external
			"IL signature (System.Drawing.Color): System.Void use System.Windows.Forms.ScrollBar"
		alias
			"set_BackColor"
		end

	frozen remove_paint_paint_event_handler (value: WINFORMS_PAINT_EVENT_HANDLER) is
		external
			"IL signature (System.Windows.Forms.PaintEventHandler): System.Void use System.Windows.Forms.ScrollBar"
		alias
			"remove_Paint"
		end

	set_font (value: DRAWING_FONT) is
		external
			"IL signature (System.Drawing.Font): System.Void use System.Windows.Forms.ScrollBar"
		alias
			"set_Font"
		end

	frozen remove_click_event_handler (value: EVENT_HANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.ScrollBar"
		alias
			"remove_Click"
		end

	frozen set_tab_stop_boolean (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Windows.Forms.ScrollBar"
		alias
			"set_TabStop"
		end

	frozen remove_scroll (value: WINFORMS_SCROLL_EVENT_HANDLER) is
		external
			"IL signature (System.Windows.Forms.ScrollEventHandler): System.Void use System.Windows.Forms.ScrollBar"
		alias
			"remove_Scroll"
		end

	frozen add_scroll (value: WINFORMS_SCROLL_EVENT_HANDLER) is
		external
			"IL signature (System.Windows.Forms.ScrollEventHandler): System.Void use System.Windows.Forms.ScrollBar"
		alias
			"add_Scroll"
		end

	frozen add_value_changed (value: EVENT_HANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.ScrollBar"
		alias
			"add_ValueChanged"
		end

	frozen remove_mouse_up_mouse_event_handler (value: WINFORMS_MOUSE_EVENT_HANDLER) is
		external
			"IL signature (System.Windows.Forms.MouseEventHandler): System.Void use System.Windows.Forms.ScrollBar"
		alias
			"remove_MouseUp"
		end

	set_fore_color (value: DRAWING_COLOR) is
		external
			"IL signature (System.Drawing.Color): System.Void use System.Windows.Forms.ScrollBar"
		alias
			"set_ForeColor"
		end

	frozen add_paint_paint_event_handler (value: WINFORMS_PAINT_EVENT_HANDLER) is
		external
			"IL signature (System.Windows.Forms.PaintEventHandler): System.Void use System.Windows.Forms.ScrollBar"
		alias
			"add_Paint"
		end

	frozen set_small_change (value: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.Windows.Forms.ScrollBar"
		alias
			"set_SmallChange"
		end

	frozen set_maximum (value: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.Windows.Forms.ScrollBar"
		alias
			"set_Maximum"
		end

	frozen remove_mouse_down_mouse_event_handler (value: WINFORMS_MOUSE_EVENT_HANDLER) is
		external
			"IL signature (System.Windows.Forms.MouseEventHandler): System.Void use System.Windows.Forms.ScrollBar"
		alias
			"remove_MouseDown"
		end

	frozen add_mouse_move_mouse_event_handler (value: WINFORMS_MOUSE_EVENT_HANDLER) is
		external
			"IL signature (System.Windows.Forms.MouseEventHandler): System.Void use System.Windows.Forms.ScrollBar"
		alias
			"add_MouseMove"
		end

	set_text (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Windows.Forms.ScrollBar"
		alias
			"set_Text"
		end

	frozen remove_mouse_move_mouse_event_handler (value: WINFORMS_MOUSE_EVENT_HANDLER) is
		external
			"IL signature (System.Windows.Forms.MouseEventHandler): System.Void use System.Windows.Forms.ScrollBar"
		alias
			"remove_MouseMove"
		end

	frozen add_mouse_up_mouse_event_handler (value: WINFORMS_MOUSE_EVENT_HANDLER) is
		external
			"IL signature (System.Windows.Forms.MouseEventHandler): System.Void use System.Windows.Forms.ScrollBar"
		alias
			"add_MouseUp"
		end

	frozen add_mouse_down_mouse_event_handler (value: WINFORMS_MOUSE_EVENT_HANDLER) is
		external
			"IL signature (System.Windows.Forms.MouseEventHandler): System.Void use System.Windows.Forms.ScrollBar"
		alias
			"add_MouseDown"
		end

	frozen set_ime_mode_ime_mode (value: WINFORMS_IME_MODE) is
		external
			"IL signature (System.Windows.Forms.ImeMode): System.Void use System.Windows.Forms.ScrollBar"
		alias
			"set_ImeMode"
		end

	frozen set_minimum (value: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.Windows.Forms.ScrollBar"
		alias
			"set_Minimum"
		end

	frozen add_double_click_event_handler (value: EVENT_HANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.ScrollBar"
		alias
			"add_DoubleClick"
		end

	frozen remove_value_changed (value: EVENT_HANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.ScrollBar"
		alias
			"remove_ValueChanged"
		end

	set_background_image (value: DRAWING_IMAGE) is
		external
			"IL signature (System.Drawing.Image): System.Void use System.Windows.Forms.ScrollBar"
		alias
			"set_BackgroundImage"
		end

feature -- Basic Operations

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Windows.Forms.ScrollBar"
		alias
			"ToString"
		end

feature {NONE} -- Implementation

	get_create_params: WINFORMS_CREATE_PARAMS is
		external
			"IL signature (): System.Windows.Forms.CreateParams use System.Windows.Forms.ScrollBar"
		alias
			"get_CreateParams"
		end

	frozen update_scroll_info is
		external
			"IL signature (): System.Void use System.Windows.Forms.ScrollBar"
		alias
			"UpdateScrollInfo"
		end

	on_value_changed (e: EVENT_ARGS) is
		external
			"IL signature (System.EventArgs): System.Void use System.Windows.Forms.ScrollBar"
		alias
			"OnValueChanged"
		end

	get_default_ime_mode: WINFORMS_IME_MODE is
		external
			"IL signature (): System.Windows.Forms.ImeMode use System.Windows.Forms.ScrollBar"
		alias
			"get_DefaultImeMode"
		end

	on_scroll (se: WINFORMS_SCROLL_EVENT_ARGS) is
		external
			"IL signature (System.Windows.Forms.ScrollEventArgs): System.Void use System.Windows.Forms.ScrollBar"
		alias
			"OnScroll"
		end

	on_handle_created (e: EVENT_ARGS) is
		external
			"IL signature (System.EventArgs): System.Void use System.Windows.Forms.ScrollBar"
		alias
			"OnHandleCreated"
		end

	wnd_proc (m: WINFORMS_MESSAGE) is
		external
			"IL signature (System.Windows.Forms.Message&): System.Void use System.Windows.Forms.ScrollBar"
		alias
			"WndProc"
		end

	on_enabled_changed (e: EVENT_ARGS) is
		external
			"IL signature (System.EventArgs): System.Void use System.Windows.Forms.ScrollBar"
		alias
			"OnEnabledChanged"
		end

end -- class WINFORMS_SCROLL_BAR
