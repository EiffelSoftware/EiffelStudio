indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Windows.Forms.Panel"

external class
	SYSTEM_WINDOWS_FORMS_PANEL

inherit
	SYSTEM_WINDOWS_FORMS_SCROLLABLECONTROL
		redefine
			on_resize,
			set_text,
			get_text,
			get_default_size,
			get_create_params,
			to_string
		end
	SYSTEM_COMPONENTMODEL_ISYNCHRONIZEINVOKE
		rename
			invoke as invoke_delegate_array_object,
			begin_invoke as begin_invoke_delegate_array_object
		end
	SYSTEM_IDISPOSABLE
	SYSTEM_COMPONENTMODEL_ICOMPONENT
	SYSTEM_WINDOWS_FORMS_IWIN32WINDOW

create
	make_panel

feature {NONE} -- Initialization

	frozen make_panel is
		external
			"IL creator use System.Windows.Forms.Panel"
		end

feature -- Access

	frozen get_tab_stop_boolean: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.Panel"
		alias
			"get_TabStop"
		end

	get_text: STRING is
		external
			"IL signature (): System.String use System.Windows.Forms.Panel"
		alias
			"get_Text"
		end

	frozen get_border_style: SYSTEM_WINDOWS_FORMS_BORDERSTYLE is
		external
			"IL signature (): System.Windows.Forms.BorderStyle use System.Windows.Forms.Panel"
		alias
			"get_BorderStyle"
		end

feature -- Element Change

	frozen set_border_style (value: SYSTEM_WINDOWS_FORMS_BORDERSTYLE) is
		external
			"IL signature (System.Windows.Forms.BorderStyle): System.Void use System.Windows.Forms.Panel"
		alias
			"set_BorderStyle"
		end

	set_text (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Windows.Forms.Panel"
		alias
			"set_Text"
		end

	frozen set_tab_stop_boolean (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Windows.Forms.Panel"
		alias
			"set_TabStop"
		end

	frozen remove_key_down_key_event_handler (value: SYSTEM_WINDOWS_FORMS_KEYEVENTHANDLER) is
		external
			"IL signature (System.Windows.Forms.KeyEventHandler): System.Void use System.Windows.Forms.Panel"
		alias
			"remove_KeyDown"
		end

	frozen add_key_press_key_press_event_handler (value: SYSTEM_WINDOWS_FORMS_KEYPRESSEVENTHANDLER) is
		external
			"IL signature (System.Windows.Forms.KeyPressEventHandler): System.Void use System.Windows.Forms.Panel"
		alias
			"add_KeyPress"
		end

	frozen remove_key_up_key_event_handler (value: SYSTEM_WINDOWS_FORMS_KEYEVENTHANDLER) is
		external
			"IL signature (System.Windows.Forms.KeyEventHandler): System.Void use System.Windows.Forms.Panel"
		alias
			"remove_KeyUp"
		end

	frozen remove_key_press_key_press_event_handler (value: SYSTEM_WINDOWS_FORMS_KEYPRESSEVENTHANDLER) is
		external
			"IL signature (System.Windows.Forms.KeyPressEventHandler): System.Void use System.Windows.Forms.Panel"
		alias
			"remove_KeyPress"
		end

	frozen add_key_down_key_event_handler (value: SYSTEM_WINDOWS_FORMS_KEYEVENTHANDLER) is
		external
			"IL signature (System.Windows.Forms.KeyEventHandler): System.Void use System.Windows.Forms.Panel"
		alias
			"add_KeyDown"
		end

	frozen add_key_up_key_event_handler (value: SYSTEM_WINDOWS_FORMS_KEYEVENTHANDLER) is
		external
			"IL signature (System.Windows.Forms.KeyEventHandler): System.Void use System.Windows.Forms.Panel"
		alias
			"add_KeyUp"
		end

feature -- Basic Operations

	to_string: STRING is
		external
			"IL signature (): System.String use System.Windows.Forms.Panel"
		alias
			"ToString"
		end

feature {NONE} -- Implementation

	on_resize (eventargs: SYSTEM_EVENTARGS) is
		external
			"IL signature (System.EventArgs): System.Void use System.Windows.Forms.Panel"
		alias
			"OnResize"
		end

	get_default_size: SYSTEM_DRAWING_SIZE is
		external
			"IL signature (): System.Drawing.Size use System.Windows.Forms.Panel"
		alias
			"get_DefaultSize"
		end

	get_create_params: SYSTEM_WINDOWS_FORMS_CREATEPARAMS is
		external
			"IL signature (): System.Windows.Forms.CreateParams use System.Windows.Forms.Panel"
		alias
			"get_CreateParams"
		end

end -- class SYSTEM_WINDOWS_FORMS_PANEL
