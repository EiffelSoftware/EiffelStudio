indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Windows.Forms.Label"
	assembly: "System.Windows.Forms", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	WINFORMS_LABEL

inherit
	WINFORMS_CONTROL
		redefine
			wnd_proc,
			set_bounds_core,
			process_mnemonic,
			on_paint,
			on_parent_changed,
			on_visible_changed,
			on_text_changed,
			on_font_changed,
			on_enabled_changed,
			create_accessibility_instance,
			get_default_size,
			get_default_ime_mode,
			get_create_params,
			set_background_image,
			get_background_image,
			dispose_boolean,
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
	make_winforms_label

feature {NONE} -- Initialization

	frozen make_winforms_label is
		external
			"IL creator use System.Windows.Forms.Label"
		end

feature -- Access

	frozen get_flat_style: WINFORMS_FLAT_STYLE is
		external
			"IL signature (): System.Windows.Forms.FlatStyle use System.Windows.Forms.Label"
		alias
			"get_FlatStyle"
		end

	get_background_image: DRAWING_IMAGE is
		external
			"IL signature (): System.Drawing.Image use System.Windows.Forms.Label"
		alias
			"get_BackgroundImage"
		end

	frozen get_tab_stop_boolean: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.Label"
		alias
			"get_TabStop"
		end

	frozen get_image_align: DRAWING_CONTENT_ALIGNMENT is
		external
			"IL signature (): System.Drawing.ContentAlignment use System.Windows.Forms.Label"
		alias
			"get_ImageAlign"
		end

	frozen get_image_list: WINFORMS_IMAGE_LIST is
		external
			"IL signature (): System.Windows.Forms.ImageList use System.Windows.Forms.Label"
		alias
			"get_ImageList"
		end

	get_border_style: WINFORMS_BORDER_STYLE is
		external
			"IL signature (): System.Windows.Forms.BorderStyle use System.Windows.Forms.Label"
		alias
			"get_BorderStyle"
		end

	get_preferred_width: INTEGER is
		external
			"IL signature (): System.Int32 use System.Windows.Forms.Label"
		alias
			"get_PreferredWidth"
		end

	get_text_align: DRAWING_CONTENT_ALIGNMENT is
		external
			"IL signature (): System.Drawing.ContentAlignment use System.Windows.Forms.Label"
		alias
			"get_TextAlign"
		end

	frozen get_ime_mode_ime_mode: WINFORMS_IME_MODE is
		external
			"IL signature (): System.Windows.Forms.ImeMode use System.Windows.Forms.Label"
		alias
			"get_ImeMode"
		end

	frozen get_image_index: INTEGER is
		external
			"IL signature (): System.Int32 use System.Windows.Forms.Label"
		alias
			"get_ImageIndex"
		end

	frozen get_image: DRAWING_IMAGE is
		external
			"IL signature (): System.Drawing.Image use System.Windows.Forms.Label"
		alias
			"get_Image"
		end

	frozen get_use_mnemonic: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.Label"
		alias
			"get_UseMnemonic"
		end

	get_preferred_height: INTEGER is
		external
			"IL signature (): System.Int32 use System.Windows.Forms.Label"
		alias
			"get_PreferredHeight"
		end

	get_auto_size: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.Label"
		alias
			"get_AutoSize"
		end

feature -- Element Change

	frozen set_use_mnemonic (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Windows.Forms.Label"
		alias
			"set_UseMnemonic"
		end

	frozen remove_key_up_key_event_handler (value: WINFORMS_KEY_EVENT_HANDLER) is
		external
			"IL signature (System.Windows.Forms.KeyEventHandler): System.Void use System.Windows.Forms.Label"
		alias
			"remove_KeyUp"
		end

	set_border_style (value: WINFORMS_BORDER_STYLE) is
		external
			"IL signature (System.Windows.Forms.BorderStyle): System.Void use System.Windows.Forms.Label"
		alias
			"set_BorderStyle"
		end

	frozen remove_auto_size_changed (value: EVENT_HANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.Label"
		alias
			"remove_AutoSizeChanged"
		end

	frozen set_image_index (value: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.Windows.Forms.Label"
		alias
			"set_ImageIndex"
		end

	frozen remove_text_align_changed (value: EVENT_HANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.Label"
		alias
			"remove_TextAlignChanged"
		end

	frozen set_tab_stop_boolean (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Windows.Forms.Label"
		alias
			"set_TabStop"
		end

	frozen add_key_press_key_press_event_handler (value: WINFORMS_KEY_PRESS_EVENT_HANDLER) is
		external
			"IL signature (System.Windows.Forms.KeyPressEventHandler): System.Void use System.Windows.Forms.Label"
		alias
			"add_KeyPress"
		end

	frozen add_text_align_changed (value: EVENT_HANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.Label"
		alias
			"add_TextAlignChanged"
		end

	frozen set_image_list (value: WINFORMS_IMAGE_LIST) is
		external
			"IL signature (System.Windows.Forms.ImageList): System.Void use System.Windows.Forms.Label"
		alias
			"set_ImageList"
		end

	frozen remove_key_down_key_event_handler (value: WINFORMS_KEY_EVENT_HANDLER) is
		external
			"IL signature (System.Windows.Forms.KeyEventHandler): System.Void use System.Windows.Forms.Label"
		alias
			"remove_KeyDown"
		end

	frozen set_image_align (value: DRAWING_CONTENT_ALIGNMENT) is
		external
			"IL signature (System.Drawing.ContentAlignment): System.Void use System.Windows.Forms.Label"
		alias
			"set_ImageAlign"
		end

	frozen set_flat_style (value: WINFORMS_FLAT_STYLE) is
		external
			"IL signature (System.Windows.Forms.FlatStyle): System.Void use System.Windows.Forms.Label"
		alias
			"set_FlatStyle"
		end

	frozen set_image (value: DRAWING_IMAGE) is
		external
			"IL signature (System.Drawing.Image): System.Void use System.Windows.Forms.Label"
		alias
			"set_Image"
		end

	frozen add_auto_size_changed (value: EVENT_HANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.Label"
		alias
			"add_AutoSizeChanged"
		end

	frozen remove_key_press_key_press_event_handler (value: WINFORMS_KEY_PRESS_EVENT_HANDLER) is
		external
			"IL signature (System.Windows.Forms.KeyPressEventHandler): System.Void use System.Windows.Forms.Label"
		alias
			"remove_KeyPress"
		end

	set_auto_size (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Windows.Forms.Label"
		alias
			"set_AutoSize"
		end

	frozen add_key_up_key_event_handler (value: WINFORMS_KEY_EVENT_HANDLER) is
		external
			"IL signature (System.Windows.Forms.KeyEventHandler): System.Void use System.Windows.Forms.Label"
		alias
			"add_KeyUp"
		end

	set_text_align (value: DRAWING_CONTENT_ALIGNMENT) is
		external
			"IL signature (System.Drawing.ContentAlignment): System.Void use System.Windows.Forms.Label"
		alias
			"set_TextAlign"
		end

	frozen set_ime_mode_ime_mode (value: WINFORMS_IME_MODE) is
		external
			"IL signature (System.Windows.Forms.ImeMode): System.Void use System.Windows.Forms.Label"
		alias
			"set_ImeMode"
		end

	frozen add_key_down_key_event_handler (value: WINFORMS_KEY_EVENT_HANDLER) is
		external
			"IL signature (System.Windows.Forms.KeyEventHandler): System.Void use System.Windows.Forms.Label"
		alias
			"add_KeyDown"
		end

	set_background_image (value: DRAWING_IMAGE) is
		external
			"IL signature (System.Drawing.Image): System.Void use System.Windows.Forms.Label"
		alias
			"set_BackgroundImage"
		end

feature -- Basic Operations

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Windows.Forms.Label"
		alias
			"ToString"
		end

feature {NONE} -- Implementation

	get_create_params: WINFORMS_CREATE_PARAMS is
		external
			"IL signature (): System.Windows.Forms.CreateParams use System.Windows.Forms.Label"
		alias
			"get_CreateParams"
		end

	set_render_transparent (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Windows.Forms.Label"
		alias
			"set_RenderTransparent"
		end

	on_enabled_changed (e: EVENT_ARGS) is
		external
			"IL signature (System.EventArgs): System.Void use System.Windows.Forms.Label"
		alias
			"OnEnabledChanged"
		end

	wnd_proc (m: WINFORMS_MESSAGE) is
		external
			"IL signature (System.Windows.Forms.Message&): System.Void use System.Windows.Forms.Label"
		alias
			"WndProc"
		end

	frozen draw_image (g: DRAWING_GRAPHICS; image: DRAWING_IMAGE; r: DRAWING_RECTANGLE; align: DRAWING_CONTENT_ALIGNMENT) is
		external
			"IL signature (System.Drawing.Graphics, System.Drawing.Image, System.Drawing.Rectangle, System.Drawing.ContentAlignment): System.Void use System.Windows.Forms.Label"
		alias
			"DrawImage"
		end

	on_parent_changed (e: EVENT_ARGS) is
		external
			"IL signature (System.EventArgs): System.Void use System.Windows.Forms.Label"
		alias
			"OnParentChanged"
		end

	get_render_transparent: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.Label"
		alias
			"get_RenderTransparent"
		end

	process_mnemonic (char_code: CHARACTER): BOOLEAN is
		external
			"IL signature (System.Char): System.Boolean use System.Windows.Forms.Label"
		alias
			"ProcessMnemonic"
		end

	on_paint (e: WINFORMS_PAINT_EVENT_ARGS) is
		external
			"IL signature (System.Windows.Forms.PaintEventArgs): System.Void use System.Windows.Forms.Label"
		alias
			"OnPaint"
		end

	frozen calc_image_render_bounds (image: DRAWING_IMAGE; r: DRAWING_RECTANGLE; align: DRAWING_CONTENT_ALIGNMENT): DRAWING_RECTANGLE is
		external
			"IL signature (System.Drawing.Image, System.Drawing.Rectangle, System.Drawing.ContentAlignment): System.Drawing.Rectangle use System.Windows.Forms.Label"
		alias
			"CalcImageRenderBounds"
		end

	get_default_size: DRAWING_SIZE is
		external
			"IL signature (): System.Drawing.Size use System.Windows.Forms.Label"
		alias
			"get_DefaultSize"
		end

	set_bounds_core (x: INTEGER; y: INTEGER; width: INTEGER; height: INTEGER; specified: WINFORMS_BOUNDS_SPECIFIED) is
		external
			"IL signature (System.Int32, System.Int32, System.Int32, System.Int32, System.Windows.Forms.BoundsSpecified): System.Void use System.Windows.Forms.Label"
		alias
			"SetBoundsCore"
		end

	on_text_changed (e: EVENT_ARGS) is
		external
			"IL signature (System.EventArgs): System.Void use System.Windows.Forms.Label"
		alias
			"OnTextChanged"
		end

	dispose_boolean (disposing: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Windows.Forms.Label"
		alias
			"Dispose"
		end

	on_font_changed (e: EVENT_ARGS) is
		external
			"IL signature (System.EventArgs): System.Void use System.Windows.Forms.Label"
		alias
			"OnFontChanged"
		end

	create_accessibility_instance: WINFORMS_ACCESSIBLE_OBJECT is
		external
			"IL signature (): System.Windows.Forms.AccessibleObject use System.Windows.Forms.Label"
		alias
			"CreateAccessibilityInstance"
		end

	on_text_align_changed (e: EVENT_ARGS) is
		external
			"IL signature (System.EventArgs): System.Void use System.Windows.Forms.Label"
		alias
			"OnTextAlignChanged"
		end

	on_visible_changed (e: EVENT_ARGS) is
		external
			"IL signature (System.EventArgs): System.Void use System.Windows.Forms.Label"
		alias
			"OnVisibleChanged"
		end

	get_default_ime_mode: WINFORMS_IME_MODE is
		external
			"IL signature (): System.Windows.Forms.ImeMode use System.Windows.Forms.Label"
		alias
			"get_DefaultImeMode"
		end

	on_auto_size_changed (e: EVENT_ARGS) is
		external
			"IL signature (System.EventArgs): System.Void use System.Windows.Forms.Label"
		alias
			"OnAutoSizeChanged"
		end

end -- class WINFORMS_LABEL
