indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Windows.Forms.ProgressBar"

frozen external class
	SYSTEM_WINDOWS_FORMS_PROGRESSBAR

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
	SYSTEM_WINDOWS_FORMS_IWIN32WINDOW

create
	make_progressbar

feature {NONE} -- Initialization

	frozen make_progressbar is
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

	get_back_color: SYSTEM_DRAWING_COLOR is
		external
			"IL signature (): System.Drawing.Color use System.Windows.Forms.ProgressBar"
		alias
			"get_BackColor"
		end

	get_font: SYSTEM_DRAWING_FONT is
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

	get_text: STRING is
		external
			"IL signature (): System.String use System.Windows.Forms.ProgressBar"
		alias
			"get_Text"
		end

	frozen get_ime_mode_ime_mode: SYSTEM_WINDOWS_FORMS_IMEMODE is
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

	get_fore_color: SYSTEM_DRAWING_COLOR is
		external
			"IL signature (): System.Drawing.Color use System.Windows.Forms.ProgressBar"
		alias
			"get_ForeColor"
		end

	get_right_to_left: SYSTEM_WINDOWS_FORMS_RIGHTTOLEFT is
		external
			"IL signature (): System.Windows.Forms.RightToLeft use System.Windows.Forms.ProgressBar"
		alias
			"get_RightToLeft"
		end

	get_background_image: SYSTEM_DRAWING_IMAGE is
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

	frozen add_double_click_event_handler (value: SYSTEM_EVENTHANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.ProgressBar"
		alias
			"add_DoubleClick"
		end

	frozen remove_enter_event_handler (value: SYSTEM_EVENTHANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.ProgressBar"
		alias
			"remove_Enter"
		end

	frozen add_leave_event_handler (value: SYSTEM_EVENTHANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.ProgressBar"
		alias
			"add_Leave"
		end

	frozen remove_double_click_event_handler (value: SYSTEM_EVENTHANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.ProgressBar"
		alias
			"remove_DoubleClick"
		end

	set_back_color (value: SYSTEM_DRAWING_COLOR) is
		external
			"IL signature (System.Drawing.Color): System.Void use System.Windows.Forms.ProgressBar"
		alias
			"set_BackColor"
		end

	set_right_to_left (value: SYSTEM_WINDOWS_FORMS_RIGHTTOLEFT) is
		external
			"IL signature (System.Windows.Forms.RightToLeft): System.Void use System.Windows.Forms.ProgressBar"
		alias
			"set_RightToLeft"
		end

	set_font (value: SYSTEM_DRAWING_FONT) is
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

	frozen add_key_press_key_press_event_handler (value: SYSTEM_WINDOWS_FORMS_KEYPRESSEVENTHANDLER) is
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

	frozen remove_leave_event_handler (value: SYSTEM_EVENTHANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.ProgressBar"
		alias
			"remove_Leave"
		end

	set_fore_color (value: SYSTEM_DRAWING_COLOR) is
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

	frozen remove_key_down_key_event_handler (value: SYSTEM_WINDOWS_FORMS_KEYEVENTHANDLER) is
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

	frozen add_key_down_key_event_handler (value: SYSTEM_WINDOWS_FORMS_KEYEVENTHANDLER) is
		external
			"IL signature (System.Windows.Forms.KeyEventHandler): System.Void use System.Windows.Forms.ProgressBar"
		alias
			"add_KeyDown"
		end

	frozen remove_key_press_key_press_event_handler (value: SYSTEM_WINDOWS_FORMS_KEYPRESSEVENTHANDLER) is
		external
			"IL signature (System.Windows.Forms.KeyPressEventHandler): System.Void use System.Windows.Forms.ProgressBar"
		alias
			"remove_KeyPress"
		end

	set_text (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Windows.Forms.ProgressBar"
		alias
			"set_Text"
		end

	frozen add_key_up_key_event_handler (value: SYSTEM_WINDOWS_FORMS_KEYEVENTHANDLER) is
		external
			"IL signature (System.Windows.Forms.KeyEventHandler): System.Void use System.Windows.Forms.ProgressBar"
		alias
			"add_KeyUp"
		end

	frozen remove_key_up_key_event_handler (value: SYSTEM_WINDOWS_FORMS_KEYEVENTHANDLER) is
		external
			"IL signature (System.Windows.Forms.KeyEventHandler): System.Void use System.Windows.Forms.ProgressBar"
		alias
			"remove_KeyUp"
		end

	frozen set_ime_mode_ime_mode (value: SYSTEM_WINDOWS_FORMS_IMEMODE) is
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

	frozen add_enter_event_handler (value: SYSTEM_EVENTHANDLER) is
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

	set_background_image (value: SYSTEM_DRAWING_IMAGE) is
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

	to_string: STRING is
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

	get_default_ime_mode: SYSTEM_WINDOWS_FORMS_IMEMODE is
		external
			"IL signature (): System.Windows.Forms.ImeMode use System.Windows.Forms.ProgressBar"
		alias
			"get_DefaultImeMode"
		end

	get_default_size: SYSTEM_DRAWING_SIZE is
		external
			"IL signature (): System.Drawing.Size use System.Windows.Forms.ProgressBar"
		alias
			"get_DefaultSize"
		end

	on_handle_created (e: SYSTEM_EVENTARGS) is
		external
			"IL signature (System.EventArgs): System.Void use System.Windows.Forms.ProgressBar"
		alias
			"OnHandleCreated"
		end

	get_create_params: SYSTEM_WINDOWS_FORMS_CREATEPARAMS is
		external
			"IL signature (): System.Windows.Forms.CreateParams use System.Windows.Forms.ProgressBar"
		alias
			"get_CreateParams"
		end

end -- class SYSTEM_WINDOWS_FORMS_PROGRESSBAR
