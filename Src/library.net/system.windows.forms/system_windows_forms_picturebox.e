indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Windows.Forms.PictureBox"

external class
	SYSTEM_WINDOWS_FORMS_PICTUREBOX

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
			set_bounds_core,
			on_resize,
			on_paint,
			on_parent_changed,
			on_visible_changed,
			on_enabled_changed,
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
			set_allow_drop,
			get_allow_drop,
			dispose_boolean,
			to_string
		end
	SYSTEM_WINDOWS_FORMS_IWIN32WINDOW

create
	make_picturebox

feature {NONE} -- Initialization

	frozen make_picturebox is
		external
			"IL creator use System.Windows.Forms.PictureBox"
		end

feature -- Access

	frozen get_tab_stop_boolean: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.PictureBox"
		alias
			"get_TabStop"
		end

	get_font: SYSTEM_DRAWING_FONT is
		external
			"IL signature (): System.Drawing.Font use System.Windows.Forms.PictureBox"
		alias
			"get_Font"
		end

	get_allow_drop: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.PictureBox"
		alias
			"get_AllowDrop"
		end

	frozen get_causes_validation_boolean: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.PictureBox"
		alias
			"get_CausesValidation"
		end

	get_text: STRING is
		external
			"IL signature (): System.String use System.Windows.Forms.PictureBox"
		alias
			"get_Text"
		end

	frozen get_border_style: SYSTEM_WINDOWS_FORMS_BORDERSTYLE is
		external
			"IL signature (): System.Windows.Forms.BorderStyle use System.Windows.Forms.PictureBox"
		alias
			"get_BorderStyle"
		end

	frozen get_ime_mode_ime_mode: SYSTEM_WINDOWS_FORMS_IMEMODE is
		external
			"IL signature (): System.Windows.Forms.ImeMode use System.Windows.Forms.PictureBox"
		alias
			"get_ImeMode"
		end

	frozen get_tab_index_int32: INTEGER is
		external
			"IL signature (): System.Int32 use System.Windows.Forms.PictureBox"
		alias
			"get_TabIndex"
		end

	get_fore_color: SYSTEM_DRAWING_COLOR is
		external
			"IL signature (): System.Drawing.Color use System.Windows.Forms.PictureBox"
		alias
			"get_ForeColor"
		end

	get_right_to_left: SYSTEM_WINDOWS_FORMS_RIGHTTOLEFT is
		external
			"IL signature (): System.Windows.Forms.RightToLeft use System.Windows.Forms.PictureBox"
		alias
			"get_RightToLeft"
		end

	frozen get_image: SYSTEM_DRAWING_IMAGE is
		external
			"IL signature (): System.Drawing.Image use System.Windows.Forms.PictureBox"
		alias
			"get_Image"
		end

	frozen get_size_mode: SYSTEM_WINDOWS_FORMS_PICTUREBOXSIZEMODE is
		external
			"IL signature (): System.Windows.Forms.PictureBoxSizeMode use System.Windows.Forms.PictureBox"
		alias
			"get_SizeMode"
		end

feature -- Element Change

	set_allow_drop (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Windows.Forms.PictureBox"
		alias
			"set_AllowDrop"
		end

	frozen set_size_mode (value: SYSTEM_WINDOWS_FORMS_PICTUREBOXSIZEMODE) is
		external
			"IL signature (System.Windows.Forms.PictureBoxSizeMode): System.Void use System.Windows.Forms.PictureBox"
		alias
			"set_SizeMode"
		end

	set_right_to_left (value: SYSTEM_WINDOWS_FORMS_RIGHTTOLEFT) is
		external
			"IL signature (System.Windows.Forms.RightToLeft): System.Void use System.Windows.Forms.PictureBox"
		alias
			"set_RightToLeft"
		end

	set_font (value: SYSTEM_DRAWING_FONT) is
		external
			"IL signature (System.Drawing.Font): System.Void use System.Windows.Forms.PictureBox"
		alias
			"set_Font"
		end

	frozen remove_enter_event_handler (value: SYSTEM_EVENTHANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.PictureBox"
		alias
			"remove_Enter"
		end

	frozen set_border_style (value: SYSTEM_WINDOWS_FORMS_BORDERSTYLE) is
		external
			"IL signature (System.Windows.Forms.BorderStyle): System.Void use System.Windows.Forms.PictureBox"
		alias
			"set_BorderStyle"
		end

	frozen set_tab_stop_boolean (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Windows.Forms.PictureBox"
		alias
			"set_TabStop"
		end

	frozen add_key_press_key_press_event_handler (value: SYSTEM_WINDOWS_FORMS_KEYPRESSEVENTHANDLER) is
		external
			"IL signature (System.Windows.Forms.KeyPressEventHandler): System.Void use System.Windows.Forms.PictureBox"
		alias
			"add_KeyPress"
		end

	frozen add_key_down_key_event_handler (value: SYSTEM_WINDOWS_FORMS_KEYEVENTHANDLER) is
		external
			"IL signature (System.Windows.Forms.KeyEventHandler): System.Void use System.Windows.Forms.PictureBox"
		alias
			"add_KeyDown"
		end

	frozen add_enter_event_handler (value: SYSTEM_EVENTHANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.PictureBox"
		alias
			"add_Enter"
		end

	frozen remove_leave_event_handler (value: SYSTEM_EVENTHANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.PictureBox"
		alias
			"remove_Leave"
		end

	set_fore_color (value: SYSTEM_DRAWING_COLOR) is
		external
			"IL signature (System.Drawing.Color): System.Void use System.Windows.Forms.PictureBox"
		alias
			"set_ForeColor"
		end

	frozen add_size_mode_changed (value: SYSTEM_EVENTHANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.PictureBox"
		alias
			"add_SizeModeChanged"
		end

	frozen set_causes_validation_boolean (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Windows.Forms.PictureBox"
		alias
			"set_CausesValidation"
		end

	frozen set_tab_index_int32 (value: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.Windows.Forms.PictureBox"
		alias
			"set_TabIndex"
		end

	frozen set_image (value: SYSTEM_DRAWING_IMAGE) is
		external
			"IL signature (System.Drawing.Image): System.Void use System.Windows.Forms.PictureBox"
		alias
			"set_Image"
		end

	frozen add_leave_event_handler (value: SYSTEM_EVENTHANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.PictureBox"
		alias
			"add_Leave"
		end

	frozen remove_key_press_key_press_event_handler (value: SYSTEM_WINDOWS_FORMS_KEYPRESSEVENTHANDLER) is
		external
			"IL signature (System.Windows.Forms.KeyPressEventHandler): System.Void use System.Windows.Forms.PictureBox"
		alias
			"remove_KeyPress"
		end

	set_text (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Windows.Forms.PictureBox"
		alias
			"set_Text"
		end

	frozen add_key_up_key_event_handler (value: SYSTEM_WINDOWS_FORMS_KEYEVENTHANDLER) is
		external
			"IL signature (System.Windows.Forms.KeyEventHandler): System.Void use System.Windows.Forms.PictureBox"
		alias
			"add_KeyUp"
		end

	frozen remove_key_up_key_event_handler (value: SYSTEM_WINDOWS_FORMS_KEYEVENTHANDLER) is
		external
			"IL signature (System.Windows.Forms.KeyEventHandler): System.Void use System.Windows.Forms.PictureBox"
		alias
			"remove_KeyUp"
		end

	frozen set_ime_mode_ime_mode (value: SYSTEM_WINDOWS_FORMS_IMEMODE) is
		external
			"IL signature (System.Windows.Forms.ImeMode): System.Void use System.Windows.Forms.PictureBox"
		alias
			"set_ImeMode"
		end

	frozen remove_size_mode_changed (value: SYSTEM_EVENTHANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.PictureBox"
		alias
			"remove_SizeModeChanged"
		end

	frozen remove_key_down_key_event_handler (value: SYSTEM_WINDOWS_FORMS_KEYEVENTHANDLER) is
		external
			"IL signature (System.Windows.Forms.KeyEventHandler): System.Void use System.Windows.Forms.PictureBox"
		alias
			"remove_KeyDown"
		end

feature -- Basic Operations

	to_string: STRING is
		external
			"IL signature (): System.String use System.Windows.Forms.PictureBox"
		alias
			"ToString"
		end

feature {NONE} -- Implementation

	get_default_size: SYSTEM_DRAWING_SIZE is
		external
			"IL signature (): System.Drawing.Size use System.Windows.Forms.PictureBox"
		alias
			"get_DefaultSize"
		end

	get_create_params: SYSTEM_WINDOWS_FORMS_CREATEPARAMS is
		external
			"IL signature (): System.Windows.Forms.CreateParams use System.Windows.Forms.PictureBox"
		alias
			"get_CreateParams"
		end

	get_default_ime_mode: SYSTEM_WINDOWS_FORMS_IMEMODE is
		external
			"IL signature (): System.Windows.Forms.ImeMode use System.Windows.Forms.PictureBox"
		alias
			"get_DefaultImeMode"
		end

	on_parent_changed (e: SYSTEM_EVENTARGS) is
		external
			"IL signature (System.EventArgs): System.Void use System.Windows.Forms.PictureBox"
		alias
			"OnParentChanged"
		end

	dispose_boolean (disposing: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Windows.Forms.PictureBox"
		alias
			"Dispose"
		end

	set_bounds_core (x: INTEGER; y: INTEGER; width: INTEGER; height: INTEGER; specified: SYSTEM_WINDOWS_FORMS_BOUNDSSPECIFIED) is
		external
			"IL signature (System.Int32, System.Int32, System.Int32, System.Int32, System.Windows.Forms.BoundsSpecified): System.Void use System.Windows.Forms.PictureBox"
		alias
			"SetBoundsCore"
		end

	on_resize (e: SYSTEM_EVENTARGS) is
		external
			"IL signature (System.EventArgs): System.Void use System.Windows.Forms.PictureBox"
		alias
			"OnResize"
		end

	on_paint (pe: SYSTEM_WINDOWS_FORMS_PAINTEVENTARGS) is
		external
			"IL signature (System.Windows.Forms.PaintEventArgs): System.Void use System.Windows.Forms.PictureBox"
		alias
			"OnPaint"
		end

	on_size_mode_changed (e: SYSTEM_EVENTARGS) is
		external
			"IL signature (System.EventArgs): System.Void use System.Windows.Forms.PictureBox"
		alias
			"OnSizeModeChanged"
		end

	on_visible_changed (e: SYSTEM_EVENTARGS) is
		external
			"IL signature (System.EventArgs): System.Void use System.Windows.Forms.PictureBox"
		alias
			"OnVisibleChanged"
		end

	on_enabled_changed (e: SYSTEM_EVENTARGS) is
		external
			"IL signature (System.EventArgs): System.Void use System.Windows.Forms.PictureBox"
		alias
			"OnEnabledChanged"
		end

end -- class SYSTEM_WINDOWS_FORMS_PICTUREBOX
