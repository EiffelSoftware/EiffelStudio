indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Windows.Forms.Button"
	assembly: "System.Windows.Forms", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	WINFORMS_BUTTON

inherit
	WINFORMS_BUTTON_BASE
		redefine
			wnd_proc,
			process_mnemonic,
			on_mouse_up,
			on_click,
			get_create_params,
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
	WINFORMS_IBUTTON_CONTROL

create
	make_winforms_button

feature {NONE} -- Initialization

	frozen make_winforms_button is
		external
			"IL creator use System.Windows.Forms.Button"
		end

feature -- Access

	get_dialog_result: WINFORMS_DIALOG_RESULT is
		external
			"IL signature (): System.Windows.Forms.DialogResult use System.Windows.Forms.Button"
		alias
			"get_DialogResult"
		end

feature -- Element Change

	frozen add_double_click_event_handler (value: EVENT_HANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.Button"
		alias
			"add_DoubleClick"
		end

	frozen remove_double_click_event_handler (value: EVENT_HANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.Button"
		alias
			"remove_DoubleClick"
		end

	set_dialog_result (value: WINFORMS_DIALOG_RESULT) is
		external
			"IL signature (System.Windows.Forms.DialogResult): System.Void use System.Windows.Forms.Button"
		alias
			"set_DialogResult"
		end

feature -- Basic Operations

	notify_default (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Windows.Forms.Button"
		alias
			"NotifyDefault"
		end

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Windows.Forms.Button"
		alias
			"ToString"
		end

	frozen perform_click is
		external
			"IL signature (): System.Void use System.Windows.Forms.Button"
		alias
			"PerformClick"
		end

feature {NONE} -- Implementation

	on_click (e: EVENT_ARGS) is
		external
			"IL signature (System.EventArgs): System.Void use System.Windows.Forms.Button"
		alias
			"OnClick"
		end

	on_mouse_up (mevent: WINFORMS_MOUSE_EVENT_ARGS) is
		external
			"IL signature (System.Windows.Forms.MouseEventArgs): System.Void use System.Windows.Forms.Button"
		alias
			"OnMouseUp"
		end

	process_mnemonic (char_code: CHARACTER): BOOLEAN is
		external
			"IL signature (System.Char): System.Boolean use System.Windows.Forms.Button"
		alias
			"ProcessMnemonic"
		end

	wnd_proc (m: WINFORMS_MESSAGE) is
		external
			"IL signature (System.Windows.Forms.Message&): System.Void use System.Windows.Forms.Button"
		alias
			"WndProc"
		end

	get_create_params: WINFORMS_CREATE_PARAMS is
		external
			"IL signature (): System.Windows.Forms.CreateParams use System.Windows.Forms.Button"
		alias
			"get_CreateParams"
		end

end -- class WINFORMS_BUTTON
