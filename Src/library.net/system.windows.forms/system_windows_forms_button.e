indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Windows.Forms.Button"

external class
	SYSTEM_WINDOWS_FORMS_BUTTON

inherit
	SYSTEM_WINDOWS_FORMS_BUTTONBASE
		redefine
			wnd_proc,
			process_mnemonic,
			on_mouse_up,
			on_mouse_down,
			on_click,
			get_create_params,
			to_string
		end
	SYSTEM_COMPONENTMODEL_ICOMPONENT
	SYSTEM_COMPONENTMODEL_ISYNCHRONIZEINVOKE
		rename
			invoke as invoke_delegate_array_object,
			begin_invoke as begin_invoke_delegate_array_object
		end
	SYSTEM_IDISPOSABLE
	SYSTEM_WINDOWS_FORMS_IBUTTONCONTROL
	SYSTEM_WINDOWS_FORMS_IWIN32WINDOW

create
	make_button

feature {NONE} -- Initialization

	frozen make_button is
		external
			"IL creator use System.Windows.Forms.Button"
		end

feature -- Access

	get_dialog_result: SYSTEM_WINDOWS_FORMS_DIALOGRESULT is
		external
			"IL signature (): System.Windows.Forms.DialogResult use System.Windows.Forms.Button"
		alias
			"get_DialogResult"
		end

feature -- Element Change

	frozen add_double_click_event_handler (value: SYSTEM_EVENTHANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.Button"
		alias
			"add_DoubleClick"
		end

	frozen remove_double_click_event_handler (value: SYSTEM_EVENTHANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.Button"
		alias
			"remove_DoubleClick"
		end

	set_dialog_result (value: SYSTEM_WINDOWS_FORMS_DIALOGRESULT) is
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

	to_string: STRING is
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

	on_click (e: SYSTEM_EVENTARGS) is
		external
			"IL signature (System.EventArgs): System.Void use System.Windows.Forms.Button"
		alias
			"OnClick"
		end

	on_mouse_up (mevent: SYSTEM_WINDOWS_FORMS_MOUSEEVENTARGS) is
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

	wnd_proc (m: SYSTEM_WINDOWS_FORMS_MESSAGE) is
		external
			"IL signature (System.Windows.Forms.Message&): System.Void use System.Windows.Forms.Button"
		alias
			"WndProc"
		end

	on_mouse_down (mevent: SYSTEM_WINDOWS_FORMS_MOUSEEVENTARGS) is
		external
			"IL signature (System.Windows.Forms.MouseEventArgs): System.Void use System.Windows.Forms.Button"
		alias
			"OnMouseDown"
		end

	get_create_params: SYSTEM_WINDOWS_FORMS_CREATEPARAMS is
		external
			"IL signature (): System.Windows.Forms.CreateParams use System.Windows.Forms.Button"
		alias
			"get_CreateParams"
		end

end -- class SYSTEM_WINDOWS_FORMS_BUTTON
