indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Windows.Forms.TrackBar"
	assembly: "System.Windows.Forms", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	WINFORMS_TRACK_BAR

inherit
	WINFORMS_CONTROL
		redefine
			wnd_proc,
			set_bounds_core,
			on_handle_created,
			on_back_color_changed,
			is_input_key,
			create_handle,
			set_text,
			get_text,
			set_fore_color,
			get_fore_color,
			set_font,
			get_font,
			get_default_size,
			get_default_ime_mode,
			get_create_params,
			set_background_image,
			get_background_image,
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
	SYSTEM_DLL_ISUPPORT_INITIALIZE

create
	make_winforms_track_bar

feature {NONE} -- Initialization

	frozen make_winforms_track_bar is
		external
			"IL creator use System.Windows.Forms.TrackBar"
		end

feature -- Access

	frozen get_auto_size: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.TrackBar"
		alias
			"get_AutoSize"
		end

	get_background_image: DRAWING_IMAGE is
		external
			"IL signature (): System.Drawing.Image use System.Windows.Forms.TrackBar"
		alias
			"get_BackgroundImage"
		end

	get_font: DRAWING_FONT is
		external
			"IL signature (): System.Drawing.Font use System.Windows.Forms.TrackBar"
		alias
			"get_Font"
		end

	frozen get_small_change: INTEGER is
		external
			"IL signature (): System.Int32 use System.Windows.Forms.TrackBar"
		alias
			"get_SmallChange"
		end

	frozen get_orientation: WINFORMS_ORIENTATION is
		external
			"IL signature (): System.Windows.Forms.Orientation use System.Windows.Forms.TrackBar"
		alias
			"get_Orientation"
		end

	frozen get_value: INTEGER is
		external
			"IL signature (): System.Int32 use System.Windows.Forms.TrackBar"
		alias
			"get_Value"
		end

	get_text: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Windows.Forms.TrackBar"
		alias
			"get_Text"
		end

	frozen get_ime_mode_ime_mode: WINFORMS_IME_MODE is
		external
			"IL signature (): System.Windows.Forms.ImeMode use System.Windows.Forms.TrackBar"
		alias
			"get_ImeMode"
		end

	frozen get_tick_style: WINFORMS_TICK_STYLE is
		external
			"IL signature (): System.Windows.Forms.TickStyle use System.Windows.Forms.TrackBar"
		alias
			"get_TickStyle"
		end

	get_fore_color: DRAWING_COLOR is
		external
			"IL signature (): System.Drawing.Color use System.Windows.Forms.TrackBar"
		alias
			"get_ForeColor"
		end

	frozen get_tick_frequency: INTEGER is
		external
			"IL signature (): System.Int32 use System.Windows.Forms.TrackBar"
		alias
			"get_TickFrequency"
		end

	frozen get_maximum: INTEGER is
		external
			"IL signature (): System.Int32 use System.Windows.Forms.TrackBar"
		alias
			"get_Maximum"
		end

	frozen get_minimum: INTEGER is
		external
			"IL signature (): System.Int32 use System.Windows.Forms.TrackBar"
		alias
			"get_Minimum"
		end

	frozen get_large_change: INTEGER is
		external
			"IL signature (): System.Int32 use System.Windows.Forms.TrackBar"
		alias
			"get_LargeChange"
		end

feature -- Element Change

	frozen remove_double_click_event_handler (value: EVENT_HANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.TrackBar"
		alias
			"remove_DoubleClick"
		end

	frozen set_large_change (value: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.Windows.Forms.TrackBar"
		alias
			"set_LargeChange"
		end

	frozen add_click_event_handler (value: EVENT_HANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.TrackBar"
		alias
			"add_Click"
		end

	frozen set_value (value: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.Windows.Forms.TrackBar"
		alias
			"set_Value"
		end

	frozen remove_paint_paint_event_handler (value: WINFORMS_PAINT_EVENT_HANDLER) is
		external
			"IL signature (System.Windows.Forms.PaintEventHandler): System.Void use System.Windows.Forms.TrackBar"
		alias
			"remove_Paint"
		end

	set_font (value: DRAWING_FONT) is
		external
			"IL signature (System.Drawing.Font): System.Void use System.Windows.Forms.TrackBar"
		alias
			"set_Font"
		end

	frozen remove_click_event_handler (value: EVENT_HANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.TrackBar"
		alias
			"remove_Click"
		end

	frozen remove_scroll (value: EVENT_HANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.TrackBar"
		alias
			"remove_Scroll"
		end

	frozen set_orientation (value: WINFORMS_ORIENTATION) is
		external
			"IL signature (System.Windows.Forms.Orientation): System.Void use System.Windows.Forms.TrackBar"
		alias
			"set_Orientation"
		end

	frozen set_tick_style (value: WINFORMS_TICK_STYLE) is
		external
			"IL signature (System.Windows.Forms.TickStyle): System.Void use System.Windows.Forms.TrackBar"
		alias
			"set_TickStyle"
		end

	set_text (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Windows.Forms.TrackBar"
		alias
			"set_Text"
		end

	set_fore_color (value: DRAWING_COLOR) is
		external
			"IL signature (System.Drawing.Color): System.Void use System.Windows.Forms.TrackBar"
		alias
			"set_ForeColor"
		end

	frozen set_tick_frequency (value: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.Windows.Forms.TrackBar"
		alias
			"set_TickFrequency"
		end

	frozen set_small_change (value: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.Windows.Forms.TrackBar"
		alias
			"set_SmallChange"
		end

	frozen set_maximum (value: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.Windows.Forms.TrackBar"
		alias
			"set_Maximum"
		end

	frozen add_paint_paint_event_handler (value: WINFORMS_PAINT_EVENT_HANDLER) is
		external
			"IL signature (System.Windows.Forms.PaintEventHandler): System.Void use System.Windows.Forms.TrackBar"
		alias
			"add_Paint"
		end

	frozen set_auto_size (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Windows.Forms.TrackBar"
		alias
			"set_AutoSize"
		end

	frozen add_value_changed (value: EVENT_HANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.TrackBar"
		alias
			"add_ValueChanged"
		end

	frozen set_ime_mode_ime_mode (value: WINFORMS_IME_MODE) is
		external
			"IL signature (System.Windows.Forms.ImeMode): System.Void use System.Windows.Forms.TrackBar"
		alias
			"set_ImeMode"
		end

	frozen set_minimum (value: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.Windows.Forms.TrackBar"
		alias
			"set_Minimum"
		end

	frozen remove_value_changed (value: EVENT_HANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.TrackBar"
		alias
			"remove_ValueChanged"
		end

	frozen add_double_click_event_handler (value: EVENT_HANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.TrackBar"
		alias
			"add_DoubleClick"
		end

	frozen add_scroll (value: EVENT_HANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.TrackBar"
		alias
			"add_Scroll"
		end

	set_background_image (value: DRAWING_IMAGE) is
		external
			"IL signature (System.Drawing.Image): System.Void use System.Windows.Forms.TrackBar"
		alias
			"set_BackgroundImage"
		end

feature -- Basic Operations

	frozen end_init is
		external
			"IL signature (): System.Void use System.Windows.Forms.TrackBar"
		alias
			"EndInit"
		end

	frozen set_range (min_value: INTEGER; max_value: INTEGER) is
		external
			"IL signature (System.Int32, System.Int32): System.Void use System.Windows.Forms.TrackBar"
		alias
			"SetRange"
		end

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Windows.Forms.TrackBar"
		alias
			"ToString"
		end

	frozen begin_init is
		external
			"IL signature (): System.Void use System.Windows.Forms.TrackBar"
		alias
			"BeginInit"
		end

feature {NONE} -- Implementation

	get_default_size: DRAWING_SIZE is
		external
			"IL signature (): System.Drawing.Size use System.Windows.Forms.TrackBar"
		alias
			"get_DefaultSize"
		end

	get_create_params: WINFORMS_CREATE_PARAMS is
		external
			"IL signature (): System.Windows.Forms.CreateParams use System.Windows.Forms.TrackBar"
		alias
			"get_CreateParams"
		end

	create_handle is
		external
			"IL signature (): System.Void use System.Windows.Forms.TrackBar"
		alias
			"CreateHandle"
		end

	on_value_changed (e: EVENT_ARGS) is
		external
			"IL signature (System.EventArgs): System.Void use System.Windows.Forms.TrackBar"
		alias
			"OnValueChanged"
		end

	set_bounds_core (x: INTEGER; y: INTEGER; width: INTEGER; height: INTEGER; specified: WINFORMS_BOUNDS_SPECIFIED) is
		external
			"IL signature (System.Int32, System.Int32, System.Int32, System.Int32, System.Windows.Forms.BoundsSpecified): System.Void use System.Windows.Forms.TrackBar"
		alias
			"SetBoundsCore"
		end

	get_default_ime_mode: WINFORMS_IME_MODE is
		external
			"IL signature (): System.Windows.Forms.ImeMode use System.Windows.Forms.TrackBar"
		alias
			"get_DefaultImeMode"
		end

	on_scroll (e: EVENT_ARGS) is
		external
			"IL signature (System.EventArgs): System.Void use System.Windows.Forms.TrackBar"
		alias
			"OnScroll"
		end

	on_back_color_changed (e: EVENT_ARGS) is
		external
			"IL signature (System.EventArgs): System.Void use System.Windows.Forms.TrackBar"
		alias
			"OnBackColorChanged"
		end

	on_handle_created (e: EVENT_ARGS) is
		external
			"IL signature (System.EventArgs): System.Void use System.Windows.Forms.TrackBar"
		alias
			"OnHandleCreated"
		end

	wnd_proc (m: WINFORMS_MESSAGE) is
		external
			"IL signature (System.Windows.Forms.Message&): System.Void use System.Windows.Forms.TrackBar"
		alias
			"WndProc"
		end

	is_input_key (key_data: WINFORMS_KEYS): BOOLEAN is
		external
			"IL signature (System.Windows.Forms.Keys): System.Boolean use System.Windows.Forms.TrackBar"
		alias
			"IsInputKey"
		end

end -- class WINFORMS_TRACK_BAR
