indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Windows.Forms.TextBox"

external class
	SYSTEM_WINDOWS_FORMS_TEXTBOX

inherit
	SYSTEM_COMPONENTMODEL_ICOMPONENT
	SYSTEM_WINDOWS_FORMS_TEXTBOXBASE
		redefine
			wnd_proc,
			on_handle_created,
			is_input_key,
			get_default_ime_mode,
			get_create_params
		end
	SYSTEM_COMPONENTMODEL_ISYNCHRONIZEINVOKE
		rename
			invoke as invoke_delegate_array_object,
			begin_invoke as begin_invoke_delegate_array_object
		end
	SYSTEM_IDISPOSABLE
	SYSTEM_WINDOWS_FORMS_IWIN32WINDOW

create
	make_textbox

feature {NONE} -- Initialization

	frozen make_textbox is
		external
			"IL creator use System.Windows.Forms.TextBox"
		end

feature -- Access

	frozen get_scroll_bars: SYSTEM_WINDOWS_FORMS_SCROLLBARS is
		external
			"IL signature (): System.Windows.Forms.ScrollBars use System.Windows.Forms.TextBox"
		alias
			"get_ScrollBars"
		end

	frozen get_text_align: SYSTEM_WINDOWS_FORMS_HORIZONTALALIGNMENT is
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

	frozen get_character_casing: SYSTEM_WINDOWS_FORMS_CHARACTERCASING is
		external
			"IL signature (): System.Windows.Forms.CharacterCasing use System.Windows.Forms.TextBox"
		alias
			"get_CharacterCasing"
		end

feature -- Element Change

	frozen set_scroll_bars (value: SYSTEM_WINDOWS_FORMS_SCROLLBARS) is
		external
			"IL signature (System.Windows.Forms.ScrollBars): System.Void use System.Windows.Forms.TextBox"
		alias
			"set_ScrollBars"
		end

	frozen remove_text_align_changed (value: SYSTEM_EVENTHANDLER) is
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

	frozen set_character_casing (value: SYSTEM_WINDOWS_FORMS_CHARACTERCASING) is
		external
			"IL signature (System.Windows.Forms.CharacterCasing): System.Void use System.Windows.Forms.TextBox"
		alias
			"set_CharacterCasing"
		end

	frozen set_text_align (value: SYSTEM_WINDOWS_FORMS_HORIZONTALALIGNMENT) is
		external
			"IL signature (System.Windows.Forms.HorizontalAlignment): System.Void use System.Windows.Forms.TextBox"
		alias
			"set_TextAlign"
		end

	frozen add_text_align_changed (value: SYSTEM_EVENTHANDLER) is
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

	on_handle_created (e: SYSTEM_EVENTARGS) is
		external
			"IL signature (System.EventArgs): System.Void use System.Windows.Forms.TextBox"
		alias
			"OnHandleCreated"
		end

	get_default_ime_mode: SYSTEM_WINDOWS_FORMS_IMEMODE is
		external
			"IL signature (): System.Windows.Forms.ImeMode use System.Windows.Forms.TextBox"
		alias
			"get_DefaultImeMode"
		end

	get_create_params: SYSTEM_WINDOWS_FORMS_CREATEPARAMS is
		external
			"IL signature (): System.Windows.Forms.CreateParams use System.Windows.Forms.TextBox"
		alias
			"get_CreateParams"
		end

	on_text_align_changed (e: SYSTEM_EVENTARGS) is
		external
			"IL signature (System.EventArgs): System.Void use System.Windows.Forms.TextBox"
		alias
			"OnTextAlignChanged"
		end

	wnd_proc (m: SYSTEM_WINDOWS_FORMS_MESSAGE) is
		external
			"IL signature (System.Windows.Forms.Message&): System.Void use System.Windows.Forms.TextBox"
		alias
			"WndProc"
		end

	is_input_key (key_data: SYSTEM_WINDOWS_FORMS_KEYS): BOOLEAN is
		external
			"IL signature (System.Windows.Forms.Keys): System.Boolean use System.Windows.Forms.TextBox"
		alias
			"IsInputKey"
		end

end -- class SYSTEM_WINDOWS_FORMS_TEXTBOX
