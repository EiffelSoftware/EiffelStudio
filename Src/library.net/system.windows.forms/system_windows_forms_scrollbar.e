indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Windows.Forms.ScrollBar"

deferred external class
	SYSTEM_WINDOWS_FORMS_SCROLLBAR

inherit
	SYSTEM_COMPONENTMODEL_ICOMPONENT
	SYSTEM_COMPONENTMODEL_ISYNCHRONIZEINVOKE
		rename
			invoke as invoke_delegate_array_object,
			begin_invoke as begin_invoke_delegate_array_object
		end
	SYSTEM_IDISPOSABLE
	SYSTEM_WINDOWS_FORMS_CONTROL
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
	SYSTEM_WINDOWS_FORMS_IWIN32WINDOW

feature -- Access

	frozen get_tab_stop_boolean: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.ScrollBar"
		alias
			"get_TabStop"
		end

	get_back_color: SYSTEM_DRAWING_COLOR is
		external
			"IL signature (): System.Drawing.Color use System.Windows.Forms.ScrollBar"
		alias
			"get_BackColor"
		end

	get_font: SYSTEM_DRAWING_FONT is
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

	get_text: STRING is
		external
			"IL signature (): System.String use System.Windows.Forms.ScrollBar"
		alias
			"get_Text"
		end

	frozen get_ime_mode_ime_mode: SYSTEM_WINDOWS_FORMS_IMEMODE is
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

	get_fore_color: SYSTEM_DRAWING_COLOR is
		external
			"IL signature (): System.Drawing.Color use System.Windows.Forms.ScrollBar"
		alias
			"get_ForeColor"
		end

	get_background_image: SYSTEM_DRAWING_IMAGE is
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

	frozen add_double_click_event_handler (value: SYSTEM_EVENTHANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.ScrollBar"
		alias
			"add_DoubleClick"
		end

	frozen remove_double_click_event_handler (value: SYSTEM_EVENTHANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.ScrollBar"
		alias
			"remove_DoubleClick"
		end

	set_back_color (value: SYSTEM_DRAWING_COLOR) is
		external
			"IL signature (System.Drawing.Color): System.Void use System.Windows.Forms.ScrollBar"
		alias
			"set_BackColor"
		end

	frozen add_value_changed (value: SYSTEM_EVENTHANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.ScrollBar"
		alias
			"add_ValueChanged"
		end

	set_font (value: SYSTEM_DRAWING_FONT) is
		external
			"IL signature (System.Drawing.Font): System.Void use System.Windows.Forms.ScrollBar"
		alias
			"set_Font"
		end

	frozen remove_mouse_move_mouse_event_handler (value: SYSTEM_WINDOWS_FORMS_MOUSEEVENTHANDLER) is
		external
			"IL signature (System.Windows.Forms.MouseEventHandler): System.Void use System.Windows.Forms.ScrollBar"
		alias
			"remove_MouseMove"
		end

	frozen set_tab_stop_boolean (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Windows.Forms.ScrollBar"
		alias
			"set_TabStop"
		end

	frozen remove_scroll (value: SYSTEM_WINDOWS_FORMS_SCROLLEVENTHANDLER) is
		external
			"IL signature (System.Windows.Forms.ScrollEventHandler): System.Void use System.Windows.Forms.ScrollBar"
		alias
			"remove_Scroll"
		end

	frozen add_scroll (value: SYSTEM_WINDOWS_FORMS_SCROLLEVENTHANDLER) is
		external
			"IL signature (System.Windows.Forms.ScrollEventHandler): System.Void use System.Windows.Forms.ScrollBar"
		alias
			"add_Scroll"
		end

	frozen set_large_change (value: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.Windows.Forms.ScrollBar"
		alias
			"set_LargeChange"
		end

	set_text (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Windows.Forms.ScrollBar"
		alias
			"set_Text"
		end

	frozen remove_mouse_up_mouse_event_handler (value: SYSTEM_WINDOWS_FORMS_MOUSEEVENTHANDLER) is
		external
			"IL signature (System.Windows.Forms.MouseEventHandler): System.Void use System.Windows.Forms.ScrollBar"
		alias
			"remove_MouseUp"
		end

	set_fore_color (value: SYSTEM_DRAWING_COLOR) is
		external
			"IL signature (System.Drawing.Color): System.Void use System.Windows.Forms.ScrollBar"
		alias
			"set_ForeColor"
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

	frozen add_mouse_move_mouse_event_handler (value: SYSTEM_WINDOWS_FORMS_MOUSEEVENTHANDLER) is
		external
			"IL signature (System.Windows.Forms.MouseEventHandler): System.Void use System.Windows.Forms.ScrollBar"
		alias
			"add_MouseMove"
		end

	frozen set_ime_mode_ime_mode (value: SYSTEM_WINDOWS_FORMS_IMEMODE) is
		external
			"IL signature (System.Windows.Forms.ImeMode): System.Void use System.Windows.Forms.ScrollBar"
		alias
			"set_ImeMode"
		end

	frozen add_mouse_up_mouse_event_handler (value: SYSTEM_WINDOWS_FORMS_MOUSEEVENTHANDLER) is
		external
			"IL signature (System.Windows.Forms.MouseEventHandler): System.Void use System.Windows.Forms.ScrollBar"
		alias
			"add_MouseUp"
		end

	frozen add_mouse_down_mouse_event_handler (value: SYSTEM_WINDOWS_FORMS_MOUSEEVENTHANDLER) is
		external
			"IL signature (System.Windows.Forms.MouseEventHandler): System.Void use System.Windows.Forms.ScrollBar"
		alias
			"add_MouseDown"
		end

	frozen remove_mouse_down_mouse_event_handler (value: SYSTEM_WINDOWS_FORMS_MOUSEEVENTHANDLER) is
		external
			"IL signature (System.Windows.Forms.MouseEventHandler): System.Void use System.Windows.Forms.ScrollBar"
		alias
			"remove_MouseDown"
		end

	frozen set_minimum (value: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.Windows.Forms.ScrollBar"
		alias
			"set_Minimum"
		end

	frozen remove_value_changed (value: SYSTEM_EVENTHANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.ScrollBar"
		alias
			"remove_ValueChanged"
		end

	frozen set_value (value: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.Windows.Forms.ScrollBar"
		alias
			"set_Value"
		end

	set_background_image (value: SYSTEM_DRAWING_IMAGE) is
		external
			"IL signature (System.Drawing.Image): System.Void use System.Windows.Forms.ScrollBar"
		alias
			"set_BackgroundImage"
		end

feature -- Basic Operations

	to_string: STRING is
		external
			"IL signature (): System.String use System.Windows.Forms.ScrollBar"
		alias
			"ToString"
		end

feature {NONE} -- Implementation

	get_create_params: SYSTEM_WINDOWS_FORMS_CREATEPARAMS is
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

	on_value_changed (e: SYSTEM_EVENTARGS) is
		external
			"IL signature (System.EventArgs): System.Void use System.Windows.Forms.ScrollBar"
		alias
			"OnValueChanged"
		end

	get_default_ime_mode: SYSTEM_WINDOWS_FORMS_IMEMODE is
		external
			"IL signature (): System.Windows.Forms.ImeMode use System.Windows.Forms.ScrollBar"
		alias
			"get_DefaultImeMode"
		end

	on_scroll (se: SYSTEM_WINDOWS_FORMS_SCROLLEVENTARGS) is
		external
			"IL signature (System.Windows.Forms.ScrollEventArgs): System.Void use System.Windows.Forms.ScrollBar"
		alias
			"OnScroll"
		end

	on_handle_created (e: SYSTEM_EVENTARGS) is
		external
			"IL signature (System.EventArgs): System.Void use System.Windows.Forms.ScrollBar"
		alias
			"OnHandleCreated"
		end

	wnd_proc (m: SYSTEM_WINDOWS_FORMS_MESSAGE) is
		external
			"IL signature (System.Windows.Forms.Message&): System.Void use System.Windows.Forms.ScrollBar"
		alias
			"WndProc"
		end

	on_enabled_changed (e: SYSTEM_EVENTARGS) is
		external
			"IL signature (System.EventArgs): System.Void use System.Windows.Forms.ScrollBar"
		alias
			"OnEnabledChanged"
		end

end -- class SYSTEM_WINDOWS_FORMS_SCROLLBAR
