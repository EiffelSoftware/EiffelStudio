indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Windows.Forms.GroupBox"

external class
	SYSTEM_WINDOWS_FORMS_GROUPBOX

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
			wnd_proc,
			process_mnemonic,
			on_paint,
			on_font_changed,
			set_text,
			get_text,
			get_display_rectangle,
			get_default_size,
			set_cursor,
			get_cursor,
			get_create_params,
			set_allow_drop,
			get_allow_drop,
			to_string
		end
	SYSTEM_WINDOWS_FORMS_IWIN32WINDOW

create
	make_groupbox

feature {NONE} -- Initialization

	frozen make_groupbox is
		external
			"IL creator use System.Windows.Forms.GroupBox"
		end

feature -- Access

	get_cursor: SYSTEM_WINDOWS_FORMS_CURSOR is
		external
			"IL signature (): System.Windows.Forms.Cursor use System.Windows.Forms.GroupBox"
		alias
			"get_Cursor"
		end

	frozen get_tab_stop_boolean: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.GroupBox"
		alias
			"get_TabStop"
		end

	get_text: STRING is
		external
			"IL signature (): System.String use System.Windows.Forms.GroupBox"
		alias
			"get_Text"
		end

	get_allow_drop: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.GroupBox"
		alias
			"get_AllowDrop"
		end

	get_display_rectangle: SYSTEM_DRAWING_RECTANGLE is
		external
			"IL signature (): System.Drawing.Rectangle use System.Windows.Forms.GroupBox"
		alias
			"get_DisplayRectangle"
		end

	frozen get_flat_style: SYSTEM_WINDOWS_FORMS_FLATSTYLE is
		external
			"IL signature (): System.Windows.Forms.FlatStyle use System.Windows.Forms.GroupBox"
		alias
			"get_FlatStyle"
		end

feature -- Element Change

	frozen add_double_click_event_handler (value: SYSTEM_EVENTHANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.GroupBox"
		alias
			"add_DoubleClick"
		end

	frozen add_click_event_handler (value: SYSTEM_EVENTHANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.GroupBox"
		alias
			"add_Click"
		end

	frozen remove_double_click_event_handler (value: SYSTEM_EVENTHANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.GroupBox"
		alias
			"remove_DoubleClick"
		end

	frozen add_key_down_key_event_handler (value: SYSTEM_WINDOWS_FORMS_KEYEVENTHANDLER) is
		external
			"IL signature (System.Windows.Forms.KeyEventHandler): System.Void use System.Windows.Forms.GroupBox"
		alias
			"add_KeyDown"
		end

	frozen remove_click_event_handler (value: SYSTEM_EVENTHANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.GroupBox"
		alias
			"remove_Click"
		end

	frozen set_tab_stop_boolean (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Windows.Forms.GroupBox"
		alias
			"set_TabStop"
		end

	frozen add_mouse_move_mouse_event_handler (value: SYSTEM_WINDOWS_FORMS_MOUSEEVENTHANDLER) is
		external
			"IL signature (System.Windows.Forms.MouseEventHandler): System.Void use System.Windows.Forms.GroupBox"
		alias
			"add_MouseMove"
		end

	frozen add_key_press_key_press_event_handler (value: SYSTEM_WINDOWS_FORMS_KEYPRESSEVENTHANDLER) is
		external
			"IL signature (System.Windows.Forms.KeyPressEventHandler): System.Void use System.Windows.Forms.GroupBox"
		alias
			"add_KeyPress"
		end

	frozen add_mouse_enter_event_handler (value: SYSTEM_EVENTHANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.GroupBox"
		alias
			"add_MouseEnter"
		end

	set_allow_drop (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Windows.Forms.GroupBox"
		alias
			"set_AllowDrop"
		end

	set_cursor (value: SYSTEM_WINDOWS_FORMS_CURSOR) is
		external
			"IL signature (System.Windows.Forms.Cursor): System.Void use System.Windows.Forms.GroupBox"
		alias
			"set_Cursor"
		end

	frozen remove_mouse_up_mouse_event_handler (value: SYSTEM_WINDOWS_FORMS_MOUSEEVENTHANDLER) is
		external
			"IL signature (System.Windows.Forms.MouseEventHandler): System.Void use System.Windows.Forms.GroupBox"
		alias
			"remove_MouseUp"
		end

	frozen add_mouse_down_mouse_event_handler (value: SYSTEM_WINDOWS_FORMS_MOUSEEVENTHANDLER) is
		external
			"IL signature (System.Windows.Forms.MouseEventHandler): System.Void use System.Windows.Forms.GroupBox"
		alias
			"add_MouseDown"
		end

	frozen set_flat_style (value: SYSTEM_WINDOWS_FORMS_FLATSTYLE) is
		external
			"IL signature (System.Windows.Forms.FlatStyle): System.Void use System.Windows.Forms.GroupBox"
		alias
			"set_FlatStyle"
		end

	frozen remove_mouse_leave_event_handler (value: SYSTEM_EVENTHANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.GroupBox"
		alias
			"remove_MouseLeave"
		end

	frozen remove_key_press_key_press_event_handler (value: SYSTEM_WINDOWS_FORMS_KEYPRESSEVENTHANDLER) is
		external
			"IL signature (System.Windows.Forms.KeyPressEventHandler): System.Void use System.Windows.Forms.GroupBox"
		alias
			"remove_KeyPress"
		end

	set_text (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Windows.Forms.GroupBox"
		alias
			"set_Text"
		end

	frozen remove_mouse_move_mouse_event_handler (value: SYSTEM_WINDOWS_FORMS_MOUSEEVENTHANDLER) is
		external
			"IL signature (System.Windows.Forms.MouseEventHandler): System.Void use System.Windows.Forms.GroupBox"
		alias
			"remove_MouseMove"
		end

	frozen add_mouse_up_mouse_event_handler (value: SYSTEM_WINDOWS_FORMS_MOUSEEVENTHANDLER) is
		external
			"IL signature (System.Windows.Forms.MouseEventHandler): System.Void use System.Windows.Forms.GroupBox"
		alias
			"add_MouseUp"
		end

	frozen add_key_up_key_event_handler (value: SYSTEM_WINDOWS_FORMS_KEYEVENTHANDLER) is
		external
			"IL signature (System.Windows.Forms.KeyEventHandler): System.Void use System.Windows.Forms.GroupBox"
		alias
			"add_KeyUp"
		end

	frozen remove_key_up_key_event_handler (value: SYSTEM_WINDOWS_FORMS_KEYEVENTHANDLER) is
		external
			"IL signature (System.Windows.Forms.KeyEventHandler): System.Void use System.Windows.Forms.GroupBox"
		alias
			"remove_KeyUp"
		end

	frozen remove_mouse_down_mouse_event_handler (value: SYSTEM_WINDOWS_FORMS_MOUSEEVENTHANDLER) is
		external
			"IL signature (System.Windows.Forms.MouseEventHandler): System.Void use System.Windows.Forms.GroupBox"
		alias
			"remove_MouseDown"
		end

	frozen add_mouse_leave_event_handler (value: SYSTEM_EVENTHANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.GroupBox"
		alias
			"add_MouseLeave"
		end

	frozen remove_mouse_enter_event_handler (value: SYSTEM_EVENTHANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.GroupBox"
		alias
			"remove_MouseEnter"
		end

	frozen remove_key_down_key_event_handler (value: SYSTEM_WINDOWS_FORMS_KEYEVENTHANDLER) is
		external
			"IL signature (System.Windows.Forms.KeyEventHandler): System.Void use System.Windows.Forms.GroupBox"
		alias
			"remove_KeyDown"
		end

feature -- Basic Operations

	to_string: STRING is
		external
			"IL signature (): System.String use System.Windows.Forms.GroupBox"
		alias
			"ToString"
		end

feature {NONE} -- Implementation

	on_paint (e: SYSTEM_WINDOWS_FORMS_PAINTEVENTARGS) is
		external
			"IL signature (System.Windows.Forms.PaintEventArgs): System.Void use System.Windows.Forms.GroupBox"
		alias
			"OnPaint"
		end

	on_font_changed (e: SYSTEM_EVENTARGS) is
		external
			"IL signature (System.EventArgs): System.Void use System.Windows.Forms.GroupBox"
		alias
			"OnFontChanged"
		end

	process_mnemonic (char_code: CHARACTER): BOOLEAN is
		external
			"IL signature (System.Char): System.Boolean use System.Windows.Forms.GroupBox"
		alias
			"ProcessMnemonic"
		end

	wnd_proc (m: SYSTEM_WINDOWS_FORMS_MESSAGE) is
		external
			"IL signature (System.Windows.Forms.Message&): System.Void use System.Windows.Forms.GroupBox"
		alias
			"WndProc"
		end

	get_default_size: SYSTEM_DRAWING_SIZE is
		external
			"IL signature (): System.Drawing.Size use System.Windows.Forms.GroupBox"
		alias
			"get_DefaultSize"
		end

	get_create_params: SYSTEM_WINDOWS_FORMS_CREATEPARAMS is
		external
			"IL signature (): System.Windows.Forms.CreateParams use System.Windows.Forms.GroupBox"
		alias
			"get_CreateParams"
		end

end -- class SYSTEM_WINDOWS_FORMS_GROUPBOX
