indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Windows.Forms.ProgressBar"
	assembly: "System.Windows.Forms", "1.0.3300.0", "neutral", "b77a5c561934e089"

frozen external class
	WINFORMS_PROGRESS_BAR

inherit
	WINFORMS_CONTROL
		redefine
			on_handle_created,
			create_handle,
			set_text,
			get_text,
			set_right_to_left,
			get_right_to_left,
			set_fore_color,
			get_fore_color,
			set_font,
			get_font,
			get_default_size,
			get_default_ime_mode,
			get_create_params,
			set_background_image,
			get_background_image,
			set_back_color,
			get_back_color,
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
	make_winforms_progress_bar

feature {NONE} -- Initialization

	frozen make_winforms_progress_bar is
		external
			"IL creator use System.Windows.Forms.ProgressBar"
		end

feature -- Access

	frozen get_tab_stop_boolean: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.ProgressBar"
		alias
			"get_TabStop"
		end

	get_back_color: DRAWING_COLOR is
		external
			"IL signature (): System.Drawing.Color use System.Windows.Forms.ProgressBar"
		alias
			"get_BackColor"
		end

	get_font: DRAWING_FONT is
		external
			"IL signature (): System.Drawing.Font use System.Windows.Forms.ProgressBar"
		alias
			"get_Font"
		end

	get_allow_drop: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.ProgressBar"
		alias
			"get_AllowDrop"
		end

	frozen get_causes_validation_boolean: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.ProgressBar"
		alias
			"get_CausesValidation"
		end

	frozen get_maximum: INTEGER is
		external
			"IL signature (): System.Int32 use System.Windows.Forms.ProgressBar"
		alias
			"get_Maximum"
		end

	frozen get_value: INTEGER is
		external
			"IL signature (): System.Int32 use System.Windows.Forms.ProgressBar"
		alias
			"get_Value"
		end

	get_text: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Windows.Forms.ProgressBar"
		alias
			"get_Text"
		end

	frozen get_ime_mode_ime_mode: WINFORMS_IME_MODE is
		external
			"IL signature (): System.Windows.Forms.ImeMode use System.Windows.Forms.ProgressBar"
		alias
			"get_ImeMode"
		end

	frozen get_step: INTEGER is
		external
			"IL signature (): System.Int32 use System.Windows.Forms.ProgressBar"
		alias
			"get_Step"
		end

	get_fore_color: DRAWING_COLOR is
		external
			"IL signature (): System.Drawing.Color use System.Windows.Forms.ProgressBar"
		alias
			"get_ForeColor"
		end

	get_right_to_left: WINFORMS_RIGHT_TO_LEFT is
		external
			"IL signature (): System.Windows.Forms.RightToLeft use System.Windows.Forms.ProgressBar"
		alias
			"get_RightToLeft"
		end

	get_background_image: DRAWING_IMAGE is
		external
			"IL signature (): System.Drawing.Image use System.Windows.Forms.ProgressBar"
		alias
			"get_BackgroundImage"
		end

	frozen get_minimum: INTEGER is
		external
			"IL signature (): System.Int32 use System.Windows.Forms.ProgressBar"
		alias
			"get_Minimum"
		end

feature -- Element Change

	frozen add_double_click_event_handler (value: EVENT_HANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.ProgressBar"
		alias
			"add_DoubleClick"
		end

	frozen remove_enter_event_handler (value: EVENT_HANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.ProgressBar"
		alias
			"remove_Enter"
		end

	frozen add_leave_event_handler (value: EVENT_HANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.ProgressBar"
		alias
			"add_Leave"
		end

	frozen remove_double_click_event_handler (value: EVENT_HANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.ProgressBar"
		alias
			"remove_DoubleClick"
		end

	set_back_color (value: DRAWING_COLOR) is
		external
			"IL signature (System.Drawing.Color): System.Void use System.Windows.Forms.ProgressBar"
		alias
			"set_BackColor"
		end

	frozen add_paint_paint_event_handler (value: WINFORMS_PAINT_EVENT_HANDLER) is
		external
			"IL signature (System.Windows.Forms.PaintEventHandler): System.Void use System.Windows.Forms.ProgressBar"
		alias
			"add_Paint"
		end

	frozen remove_paint_paint_event_handler (value: WINFORMS_PAINT_EVENT_HANDLER) is
		external
			"IL signature (System.Windows.Forms.PaintEventHandler): System.Void use System.Windows.Forms.ProgressBar"
		alias
			"remove_Paint"
		end

	set_right_to_left (value: WINFORMS_RIGHT_TO_LEFT) is
		external
			"IL signature (System.Windows.Forms.RightToLeft): System.Void use System.Windows.Forms.ProgressBar"
		alias
			"set_RightToLeft"
		end

	set_font (value: DRAWING_FONT) is
		external
			"IL signature (System.Drawing.Font): System.Void use System.Windows.Forms.ProgressBar"
		alias
			"set_Font"
		end

	frozen set_tab_stop_boolean (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Windows.Forms.ProgressBar"
		alias
			"set_TabStop"
		end

	frozen add_key_press_key_press_event_handler (value: WINFORMS_KEY_PRESS_EVENT_HANDLER) is
		external
			"IL signature (System.Windows.Forms.KeyPressEventHandler): System.Void use System.Windows.Forms.ProgressBar"
		alias
			"add_KeyPress"
		end

	set_allow_drop (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Windows.Forms.ProgressBar"
		alias
			"set_AllowDrop"
		end

	frozen remove_leave_event_handler (value: EVENT_HANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.ProgressBar"
		alias
			"remove_Leave"
		end

	set_fore_color (value: DRAWING_COLOR) is
		external
			"IL signature (System.Drawing.Color): System.Void use System.Windows.Forms.ProgressBar"
		alias
			"set_ForeColor"
		end

	frozen set_step (value: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.Windows.Forms.ProgressBar"
		alias
			"set_Step"
		end

	frozen set_causes_validation_boolean (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Windows.Forms.ProgressBar"
		alias
			"set_CausesValidation"
		end

	frozen remove_key_down_key_event_handler (value: WINFORMS_KEY_EVENT_HANDLER) is
		external
			"IL signature (System.Windows.Forms.KeyEventHandler): System.Void use System.Windows.Forms.ProgressBar"
		alias
			"remove_KeyDown"
		end

	frozen set_maximum (value: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.Windows.Forms.ProgressBar"
		alias
			"set_Maximum"
		end

	frozen add_key_down_key_event_handler (value: WINFORMS_KEY_EVENT_HANDLER) is
		external
			"IL signature (System.Windows.Forms.KeyEventHandler): System.Void use System.Windows.Forms.ProgressBar"
		alias
			"add_KeyDown"
		end

	frozen remove_key_press_key_press_event_handler (value: WINFORMS_KEY_PRESS_EVENT_HANDLER) is
		external
			"IL signature (System.Windows.Forms.KeyPressEventHandler): System.Void use System.Windows.Forms.ProgressBar"
		alias
			"remove_KeyPress"
		end

	set_text (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Windows.Forms.ProgressBar"
		alias
			"set_Text"
		end

	frozen add_key_up_key_event_handler (value: WINFORMS_KEY_EVENT_HANDLER) is
		external
			"IL signature (System.Windows.Forms.KeyEventHandler): System.Void use System.Windows.Forms.ProgressBar"
		alias
			"add_KeyUp"
		end

	frozen remove_key_up_key_event_handler (value: WINFORMS_KEY_EVENT_HANDLER) is
		external
			"IL signature (System.Windows.Forms.KeyEventHandler): System.Void use System.Windows.Forms.ProgressBar"
		alias
			"remove_KeyUp"
		end

	frozen set_ime_mode_ime_mode (value: WINFORMS_IME_MODE) is
		external
			"IL signature (System.Windows.Forms.ImeMode): System.Void use System.Windows.Forms.ProgressBar"
		alias
			"set_ImeMode"
		end

	frozen set_minimum (value: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.Windows.Forms.ProgressBar"
		alias
			"set_Minimum"
		end

	frozen add_enter_event_handler (value: EVENT_HANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.ProgressBar"
		alias
			"add_Enter"
		end

	frozen set_value (value: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.Windows.Forms.ProgressBar"
		alias
			"set_Value"
		end

	set_background_image (value: DRAWING_IMAGE) is
		external
			"IL signature (System.Drawing.Image): System.Void use System.Windows.Forms.ProgressBar"
		alias
			"set_BackgroundImage"
		end

feature -- Basic Operations

	frozen perform_step is
		external
			"IL signature (): System.Void use System.Windows.Forms.ProgressBar"
		alias
			"PerformStep"
		end

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Windows.Forms.ProgressBar"
		alias
			"ToString"
		end

	frozen increment (value: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.Windows.Forms.ProgressBar"
		alias
			"Increment"
		end

feature {NONE} -- Implementation

	create_handle is
		external
			"IL signature (): System.Void use System.Windows.Forms.ProgressBar"
		alias
			"CreateHandle"
		end

	get_default_ime_mode: WINFORMS_IME_MODE is
		external
			"IL signature (): System.Windows.Forms.ImeMode use System.Windows.Forms.ProgressBar"
		alias
			"get_DefaultImeMode"
		end

	get_default_size: DRAWING_SIZE is
		external
			"IL signature (): System.Drawing.Size use System.Windows.Forms.ProgressBar"
		alias
			"get_DefaultSize"
		end

	on_handle_created (e: EVENT_ARGS) is
		external
			"IL signature (System.EventArgs): System.Void use System.Windows.Forms.ProgressBar"
		alias
			"OnHandleCreated"
		end

	get_create_params: WINFORMS_CREATE_PARAMS is
		external
			"IL signature (): System.Windows.Forms.CreateParams use System.Windows.Forms.ProgressBar"
		alias
			"get_CreateParams"
		end

end -- class WINFORMS_PROGRESS_BAR
