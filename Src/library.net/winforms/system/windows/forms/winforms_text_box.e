indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Windows.Forms.TextBox"
	assembly: "System.Windows.Forms", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	WINFORMS_TEXT_BOX

inherit
	WINFORMS_TEXT_BOX_BASE
		redefine
			wnd_proc,
			on_mouse_up,
			on_handle_created,
			is_input_key,
			get_default_ime_mode,
			get_create_params
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
	make_winforms_text_box

feature {NONE} -- Initialization

	frozen make_winforms_text_box is
		external
			"IL creator use System.Windows.Forms.TextBox"
		end

feature -- Access

	frozen get_scroll_bars: WINFORMS_SCROLL_BARS is
		external
			"IL signature (): System.Windows.Forms.ScrollBars use System.Windows.Forms.TextBox"
		alias
			"get_ScrollBars"
		end

	frozen get_text_align: WINFORMS_HORIZONTAL_ALIGNMENT is
		external
			"IL signature (): System.Windows.Forms.HorizontalAlignment use System.Windows.Forms.TextBox"
		alias
			"get_TextAlign"
		end

	frozen get_password_char: CHARACTER is
		external
			"IL signature (): System.Char use System.Windows.Forms.TextBox"
		alias
			"get_PasswordChar"
		end

	frozen get_accepts_return: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.TextBox"
		alias
			"get_AcceptsReturn"
		end

	frozen get_character_casing: WINFORMS_CHARACTER_CASING is
		external
			"IL signature (): System.Windows.Forms.CharacterCasing use System.Windows.Forms.TextBox"
		alias
			"get_CharacterCasing"
		end

feature -- Element Change

	frozen set_scroll_bars (value: WINFORMS_SCROLL_BARS) is
		external
			"IL signature (System.Windows.Forms.ScrollBars): System.Void use System.Windows.Forms.TextBox"
		alias
			"set_ScrollBars"
		end

	frozen remove_text_align_changed (value: EVENT_HANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.TextBox"
		alias
			"remove_TextAlignChanged"
		end

	frozen set_accepts_return (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Windows.Forms.TextBox"
		alias
			"set_AcceptsReturn"
		end

	frozen set_character_casing (value: WINFORMS_CHARACTER_CASING) is
		external
			"IL signature (System.Windows.Forms.CharacterCasing): System.Void use System.Windows.Forms.TextBox"
		alias
			"set_CharacterCasing"
		end

	frozen set_text_align (value: WINFORMS_HORIZONTAL_ALIGNMENT) is
		external
			"IL signature (System.Windows.Forms.HorizontalAlignment): System.Void use System.Windows.Forms.TextBox"
		alias
			"set_TextAlign"
		end

	frozen add_text_align_changed (value: EVENT_HANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.TextBox"
		alias
			"add_TextAlignChanged"
		end

	frozen set_password_char (value: CHARACTER) is
		external
			"IL signature (System.Char): System.Void use System.Windows.Forms.TextBox"
		alias
			"set_PasswordChar"
		end

feature {NONE} -- Implementation

	get_default_ime_mode: WINFORMS_IME_MODE is
		external
			"IL signature (): System.Windows.Forms.ImeMode use System.Windows.Forms.TextBox"
		alias
			"get_DefaultImeMode"
		end

	on_handle_created (e: EVENT_ARGS) is
		external
			"IL signature (System.EventArgs): System.Void use System.Windows.Forms.TextBox"
		alias
			"OnHandleCreated"
		end

	on_mouse_up (mevent: WINFORMS_MOUSE_EVENT_ARGS) is
		external
			"IL signature (System.Windows.Forms.MouseEventArgs): System.Void use System.Windows.Forms.TextBox"
		alias
			"OnMouseUp"
		end

	get_create_params: WINFORMS_CREATE_PARAMS is
		external
			"IL signature (): System.Windows.Forms.CreateParams use System.Windows.Forms.TextBox"
		alias
			"get_CreateParams"
		end

	on_text_align_changed (e: EVENT_ARGS) is
		external
			"IL signature (System.EventArgs): System.Void use System.Windows.Forms.TextBox"
		alias
			"OnTextAlignChanged"
		end

	wnd_proc (m: WINFORMS_MESSAGE) is
		external
			"IL signature (System.Windows.Forms.Message&): System.Void use System.Windows.Forms.TextBox"
		alias
			"WndProc"
		end

	is_input_key (key_data: WINFORMS_KEYS): BOOLEAN is
		external
			"IL signature (System.Windows.Forms.Keys): System.Boolean use System.Windows.Forms.TextBox"
		alias
			"IsInputKey"
		end

end -- class WINFORMS_TEXT_BOX
