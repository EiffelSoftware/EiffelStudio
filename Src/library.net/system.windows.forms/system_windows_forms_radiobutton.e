indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Windows.Forms.RadioButton"

external class
	SYSTEM_WINDOWS_FORMS_RADIOBUTTON

inherit
	SYSTEM_WINDOWS_FORMS_BUTTONBASE
		redefine
			set_text_align,
			get_text_align,
			process_mnemonic,
			on_mouse_up,
			on_mouse_down,
			on_enter,
			on_handle_created,
			on_click,
			create_accessibility_instance,
			get_default_size,
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
	SYSTEM_WINDOWS_FORMS_IWIN32WINDOW

create
	make_radiobutton

feature {NONE} -- Initialization

	frozen make_radiobutton is
		external
			"IL creator use System.Windows.Forms.RadioButton"
		end

feature -- Access

	frozen get_tab_stop_boolean: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.RadioButton"
		alias
			"get_TabStop"
		end

	get_text_align: SYSTEM_DRAWING_CONTENTALIGNMENT is
		external
			"IL signature (): System.Drawing.ContentAlignment use System.Windows.Forms.RadioButton"
		alias
			"get_TextAlign"
		end

	frozen get_appearance: SYSTEM_WINDOWS_FORMS_APPEARANCE is
		external
			"IL signature (): System.Windows.Forms.Appearance use System.Windows.Forms.RadioButton"
		alias
			"get_Appearance"
		end

	frozen get_auto_check: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.RadioButton"
		alias
			"get_AutoCheck"
		end

	frozen get_check_align: SYSTEM_DRAWING_CONTENTALIGNMENT is
		external
			"IL signature (): System.Drawing.ContentAlignment use System.Windows.Forms.RadioButton"
		alias
			"get_CheckAlign"
		end

	frozen get_checked: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.RadioButton"
		alias
			"get_Checked"
		end

feature -- Element Change

	frozen set_auto_check (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Windows.Forms.RadioButton"
		alias
			"set_AutoCheck"
		end

	frozen remove_checked_changed (value: SYSTEM_EVENTHANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.RadioButton"
		alias
			"remove_CheckedChanged"
		end

	frozen add_appearance_changed (value: SYSTEM_EVENTHANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.RadioButton"
		alias
			"add_AppearanceChanged"
		end

	set_text_align (value: SYSTEM_DRAWING_CONTENTALIGNMENT) is
		external
			"IL signature (System.Drawing.ContentAlignment): System.Void use System.Windows.Forms.RadioButton"
		alias
			"set_TextAlign"
		end

	frozen add_checked_changed (value: SYSTEM_EVENTHANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.RadioButton"
		alias
			"add_CheckedChanged"
		end

	frozen remove_appearance_changed (value: SYSTEM_EVENTHANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.RadioButton"
		alias
			"remove_AppearanceChanged"
		end

	frozen set_check_align (value: SYSTEM_DRAWING_CONTENTALIGNMENT) is
		external
			"IL signature (System.Drawing.ContentAlignment): System.Void use System.Windows.Forms.RadioButton"
		alias
			"set_CheckAlign"
		end

	frozen set_tab_stop_boolean (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Windows.Forms.RadioButton"
		alias
			"set_TabStop"
		end

	frozen set_checked (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Windows.Forms.RadioButton"
		alias
			"set_Checked"
		end

	frozen set_appearance (value: SYSTEM_WINDOWS_FORMS_APPEARANCE) is
		external
			"IL signature (System.Windows.Forms.Appearance): System.Void use System.Windows.Forms.RadioButton"
		alias
			"set_Appearance"
		end

feature -- Basic Operations

	to_string: STRING is
		external
			"IL signature (): System.String use System.Windows.Forms.RadioButton"
		alias
			"ToString"
		end

	frozen perform_click is
		external
			"IL signature (): System.Void use System.Windows.Forms.RadioButton"
		alias
			"PerformClick"
		end

feature {NONE} -- Implementation

	get_default_size: SYSTEM_DRAWING_SIZE is
		external
			"IL signature (): System.Drawing.Size use System.Windows.Forms.RadioButton"
		alias
			"get_DefaultSize"
		end

	on_checked_changed (e: SYSTEM_EVENTARGS) is
		external
			"IL signature (System.EventArgs): System.Void use System.Windows.Forms.RadioButton"
		alias
			"OnCheckedChanged"
		end

	create_accessibility_instance: SYSTEM_WINDOWS_FORMS_ACCESSIBLEOBJECT is
		external
			"IL signature (): System.Windows.Forms.AccessibleObject use System.Windows.Forms.RadioButton"
		alias
			"CreateAccessibilityInstance"
		end

	process_mnemonic (char_code: CHARACTER): BOOLEAN is
		external
			"IL signature (System.Char): System.Boolean use System.Windows.Forms.RadioButton"
		alias
			"ProcessMnemonic"
		end

	on_click (e: SYSTEM_EVENTARGS) is
		external
			"IL signature (System.EventArgs): System.Void use System.Windows.Forms.RadioButton"
		alias
			"OnClick"
		end

	on_enter (e: SYSTEM_EVENTARGS) is
		external
			"IL signature (System.EventArgs): System.Void use System.Windows.Forms.RadioButton"
		alias
			"OnEnter"
		end

	on_mouse_up (mevent: SYSTEM_WINDOWS_FORMS_MOUSEEVENTARGS) is
		external
			"IL signature (System.Windows.Forms.MouseEventArgs): System.Void use System.Windows.Forms.RadioButton"
		alias
			"OnMouseUp"
		end

	on_handle_created (e: SYSTEM_EVENTARGS) is
		external
			"IL signature (System.EventArgs): System.Void use System.Windows.Forms.RadioButton"
		alias
			"OnHandleCreated"
		end

	get_create_params: SYSTEM_WINDOWS_FORMS_CREATEPARAMS is
		external
			"IL signature (): System.Windows.Forms.CreateParams use System.Windows.Forms.RadioButton"
		alias
			"get_CreateParams"
		end

	on_mouse_down (mevent: SYSTEM_WINDOWS_FORMS_MOUSEEVENTARGS) is
		external
			"IL signature (System.Windows.Forms.MouseEventArgs): System.Void use System.Windows.Forms.RadioButton"
		alias
			"OnMouseDown"
		end

end -- class SYSTEM_WINDOWS_FORMS_RADIOBUTTON
