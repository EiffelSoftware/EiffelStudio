indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Windows.Forms.ButtonBase"
	assembly: "System.Windows.Forms", "1.0.3300.0", "neutral", "b77a5c561934e089"

deferred external class
	WINFORMS_BUTTON_BASE

inherit
	WINFORMS_CONTROL
		redefine
			wnd_proc,
			on_paint,
			on_mouse_up,
			on_mouse_move,
			on_mouse_leave,
			on_mouse_enter,
			on_mouse_down,
			on_lost_focus,
			on_key_up,
			on_key_down,
			on_got_focus,
			on_parent_changed,
			on_visible_changed,
			on_text_changed,
			on_enabled_changed,
			create_accessibility_instance,
			get_default_size,
			get_default_ime_mode,
			get_create_params,
			dispose_boolean
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

	frozen get_ime_mode_ime_mode: WINFORMS_IME_MODE is
		external
			"IL signature (): System.Windows.Forms.ImeMode use System.Windows.Forms.ButtonBase"
		alias
			"get_ImeMode"
		end

	frozen get_image_list: WINFORMS_IMAGE_LIST is
		external
			"IL signature (): System.Windows.Forms.ImageList use System.Windows.Forms.ButtonBase"
		alias
			"get_ImageList"
		end

	get_text_align: DRAWING_CONTENT_ALIGNMENT is
		external
			"IL signature (): System.Drawing.ContentAlignment use System.Windows.Forms.ButtonBase"
		alias
			"get_TextAlign"
		end

	frozen get_image: DRAWING_IMAGE is
		external
			"IL signature (): System.Drawing.Image use System.Windows.Forms.ButtonBase"
		alias
			"get_Image"
		end

	frozen get_image_index: INTEGER is
		external
			"IL signature (): System.Int32 use System.Windows.Forms.ButtonBase"
		alias
			"get_ImageIndex"
		end

	frozen get_flat_style: WINFORMS_FLAT_STYLE is
		external
			"IL signature (): System.Windows.Forms.FlatStyle use System.Windows.Forms.ButtonBase"
		alias
			"get_FlatStyle"
		end

	frozen get_image_align: DRAWING_CONTENT_ALIGNMENT is
		external
			"IL signature (): System.Drawing.ContentAlignment use System.Windows.Forms.ButtonBase"
		alias
			"get_ImageAlign"
		end

feature -- Element Change

	frozen set_image_align (value: DRAWING_CONTENT_ALIGNMENT) is
		external
			"IL signature (System.Drawing.ContentAlignment): System.Void use System.Windows.Forms.ButtonBase"
		alias
			"set_ImageAlign"
		end

	set_text_align (value: DRAWING_CONTENT_ALIGNMENT) is
		external
			"IL signature (System.Drawing.ContentAlignment): System.Void use System.Windows.Forms.ButtonBase"
		alias
			"set_TextAlign"
		end

	frozen set_image_list (value: WINFORMS_IMAGE_LIST) is
		external
			"IL signature (System.Windows.Forms.ImageList): System.Void use System.Windows.Forms.ButtonBase"
		alias
			"set_ImageList"
		end

	frozen set_ime_mode_ime_mode (value: WINFORMS_IME_MODE) is
		external
			"IL signature (System.Windows.Forms.ImeMode): System.Void use System.Windows.Forms.ButtonBase"
		alias
			"set_ImeMode"
		end

	frozen set_image_index (value: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.Windows.Forms.ButtonBase"
		alias
			"set_ImageIndex"
		end

	frozen set_image (value: DRAWING_IMAGE) is
		external
			"IL signature (System.Drawing.Image): System.Void use System.Windows.Forms.ButtonBase"
		alias
			"set_Image"
		end

	frozen set_flat_style (value: WINFORMS_FLAT_STYLE) is
		external
			"IL signature (System.Windows.Forms.FlatStyle): System.Void use System.Windows.Forms.ButtonBase"
		alias
			"set_FlatStyle"
		end

feature {NONE} -- Implementation

	frozen reset_flagsand_paint is
		external
			"IL signature (): System.Void use System.Windows.Forms.ButtonBase"
		alias
			"ResetFlagsandPaint"
		end

	on_mouse_down (mevent: WINFORMS_MOUSE_EVENT_ARGS) is
		external
			"IL signature (System.Windows.Forms.MouseEventArgs): System.Void use System.Windows.Forms.ButtonBase"
		alias
			"OnMouseDown"
		end

	on_lost_focus (e: EVENT_ARGS) is
		external
			"IL signature (System.EventArgs): System.Void use System.Windows.Forms.ButtonBase"
		alias
			"OnLostFocus"
		end

	get_create_params: WINFORMS_CREATE_PARAMS is
		external
			"IL signature (): System.Windows.Forms.CreateParams use System.Windows.Forms.ButtonBase"
		alias
			"get_CreateParams"
		end

	on_enabled_changed (e: EVENT_ARGS) is
		external
			"IL signature (System.EventArgs): System.Void use System.Windows.Forms.ButtonBase"
		alias
			"OnEnabledChanged"
		end

	wnd_proc (m: WINFORMS_MESSAGE) is
		external
			"IL signature (System.Windows.Forms.Message&): System.Void use System.Windows.Forms.ButtonBase"
		alias
			"WndProc"
		end

	on_visible_changed (e: EVENT_ARGS) is
		external
			"IL signature (System.EventArgs): System.Void use System.Windows.Forms.ButtonBase"
		alias
			"OnVisibleChanged"
		end

	on_parent_changed (e: EVENT_ARGS) is
		external
			"IL signature (System.EventArgs): System.Void use System.Windows.Forms.ButtonBase"
		alias
			"OnParentChanged"
		end

	on_mouse_enter (eventargs: EVENT_ARGS) is
		external
			"IL signature (System.EventArgs): System.Void use System.Windows.Forms.ButtonBase"
		alias
			"OnMouseEnter"
		end

	on_key_down (kevent: WINFORMS_KEY_EVENT_ARGS) is
		external
			"IL signature (System.Windows.Forms.KeyEventArgs): System.Void use System.Windows.Forms.ButtonBase"
		alias
			"OnKeyDown"
		end

	create_accessibility_instance: WINFORMS_ACCESSIBLE_OBJECT is
		external
			"IL signature (): System.Windows.Forms.AccessibleObject use System.Windows.Forms.ButtonBase"
		alias
			"CreateAccessibilityInstance"
		end

	on_paint (pevent: WINFORMS_PAINT_EVENT_ARGS) is
		external
			"IL signature (System.Windows.Forms.PaintEventArgs): System.Void use System.Windows.Forms.ButtonBase"
		alias
			"OnPaint"
		end

	get_default_size: DRAWING_SIZE is
		external
			"IL signature (): System.Drawing.Size use System.Windows.Forms.ButtonBase"
		alias
			"get_DefaultSize"
		end

	frozen get_is_default: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.ButtonBase"
		alias
			"get_IsDefault"
		end

	frozen set_is_default (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Windows.Forms.ButtonBase"
		alias
			"set_IsDefault"
		end

	on_got_focus (e: EVENT_ARGS) is
		external
			"IL signature (System.EventArgs): System.Void use System.Windows.Forms.ButtonBase"
		alias
			"OnGotFocus"
		end

	on_text_changed (e: EVENT_ARGS) is
		external
			"IL signature (System.EventArgs): System.Void use System.Windows.Forms.ButtonBase"
		alias
			"OnTextChanged"
		end

	on_mouse_move (mevent: WINFORMS_MOUSE_EVENT_ARGS) is
		external
			"IL signature (System.Windows.Forms.MouseEventArgs): System.Void use System.Windows.Forms.ButtonBase"
		alias
			"OnMouseMove"
		end

	dispose_boolean (disposing: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Windows.Forms.ButtonBase"
		alias
			"Dispose"
		end

	on_mouse_up (mevent: WINFORMS_MOUSE_EVENT_ARGS) is
		external
			"IL signature (System.Windows.Forms.MouseEventArgs): System.Void use System.Windows.Forms.ButtonBase"
		alias
			"OnMouseUp"
		end

	on_key_up (kevent: WINFORMS_KEY_EVENT_ARGS) is
		external
			"IL signature (System.Windows.Forms.KeyEventArgs): System.Void use System.Windows.Forms.ButtonBase"
		alias
			"OnKeyUp"
		end

	get_default_ime_mode: WINFORMS_IME_MODE is
		external
			"IL signature (): System.Windows.Forms.ImeMode use System.Windows.Forms.ButtonBase"
		alias
			"get_DefaultImeMode"
		end

	on_mouse_leave (eventargs: EVENT_ARGS) is
		external
			"IL signature (System.EventArgs): System.Void use System.Windows.Forms.ButtonBase"
		alias
			"OnMouseLeave"
		end

end -- class WINFORMS_BUTTON_BASE
