indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Windows.Forms.CheckBox"
	assembly: "System.Windows.Forms", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	WINFORMS_CHECK_BOX

inherit
	WINFORMS_BUTTON_BASE
		redefine
			set_text_align,
			get_text_align,
			process_mnemonic,
			on_mouse_up,
			on_handle_created,
			on_click,
			create_accessibility_instance,
			get_default_size,
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

create
	make_winforms_check_box

feature {NONE} -- Initialization

	frozen make_winforms_check_box is
		external
			"IL creator use System.Windows.Forms.CheckBox"
		end

feature -- Access

	frozen get_three_state: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.CheckBox"
		alias
			"get_ThreeState"
		end

	get_text_align: DRAWING_CONTENT_ALIGNMENT is
		external
			"IL signature (): System.Drawing.ContentAlignment use System.Windows.Forms.CheckBox"
		alias
			"get_TextAlign"
		end

	frozen get_appearance: WINFORMS_APPEARANCE is
		external
			"IL signature (): System.Windows.Forms.Appearance use System.Windows.Forms.CheckBox"
		alias
			"get_Appearance"
		end

	frozen get_check_state: WINFORMS_CHECK_STATE is
		external
			"IL signature (): System.Windows.Forms.CheckState use System.Windows.Forms.CheckBox"
		alias
			"get_CheckState"
		end

	frozen get_auto_check: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.CheckBox"
		alias
			"get_AutoCheck"
		end

	frozen get_check_align: DRAWING_CONTENT_ALIGNMENT is
		external
			"IL signature (): System.Drawing.ContentAlignment use System.Windows.Forms.CheckBox"
		alias
			"get_CheckAlign"
		end

	frozen get_checked: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.CheckBox"
		alias
			"get_Checked"
		end

feature -- Element Change

	frozen set_auto_check (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Windows.Forms.CheckBox"
		alias
			"set_AutoCheck"
		end

	frozen remove_checked_changed (value: EVENT_HANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.CheckBox"
		alias
			"remove_CheckedChanged"
		end

	frozen set_check_state (value: WINFORMS_CHECK_STATE) is
		external
			"IL signature (System.Windows.Forms.CheckState): System.Void use System.Windows.Forms.CheckBox"
		alias
			"set_CheckState"
		end

	frozen add_appearance_changed (value: EVENT_HANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.CheckBox"
		alias
			"add_AppearanceChanged"
		end

	set_text_align (value: DRAWING_CONTENT_ALIGNMENT) is
		external
			"IL signature (System.Drawing.ContentAlignment): System.Void use System.Windows.Forms.CheckBox"
		alias
			"set_TextAlign"
		end

	frozen set_three_state (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Windows.Forms.CheckBox"
		alias
			"set_ThreeState"
		end

	frozen add_checked_changed (value: EVENT_HANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.CheckBox"
		alias
			"add_CheckedChanged"
		end

	frozen remove_appearance_changed (value: EVENT_HANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.CheckBox"
		alias
			"remove_AppearanceChanged"
		end

	frozen set_check_align (value: DRAWING_CONTENT_ALIGNMENT) is
		external
			"IL signature (System.Drawing.ContentAlignment): System.Void use System.Windows.Forms.CheckBox"
		alias
			"set_CheckAlign"
		end

	frozen add_check_state_changed (value: EVENT_HANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.CheckBox"
		alias
			"add_CheckStateChanged"
		end

	frozen set_checked (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Windows.Forms.CheckBox"
		alias
			"set_Checked"
		end

	frozen set_appearance (value: WINFORMS_APPEARANCE) is
		external
			"IL signature (System.Windows.Forms.Appearance): System.Void use System.Windows.Forms.CheckBox"
		alias
			"set_Appearance"
		end

	frozen remove_check_state_changed (value: EVENT_HANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.CheckBox"
		alias
			"remove_CheckStateChanged"
		end

feature -- Basic Operations

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Windows.Forms.CheckBox"
		alias
			"ToString"
		end

feature {NONE} -- Implementation

	get_default_size: DRAWING_SIZE is
		external
			"IL signature (): System.Drawing.Size use System.Windows.Forms.CheckBox"
		alias
			"get_DefaultSize"
		end

	on_checked_changed (e: EVENT_ARGS) is
		external
			"IL signature (System.EventArgs): System.Void use System.Windows.Forms.CheckBox"
		alias
			"OnCheckedChanged"
		end

	on_check_state_changed (e: EVENT_ARGS) is
		external
			"IL signature (System.EventArgs): System.Void use System.Windows.Forms.CheckBox"
		alias
			"OnCheckStateChanged"
		end

	process_mnemonic (char_code: CHARACTER): BOOLEAN is
		external
			"IL signature (System.Char): System.Boolean use System.Windows.Forms.CheckBox"
		alias
			"ProcessMnemonic"
		end

	on_click (e: EVENT_ARGS) is
		external
			"IL signature (System.EventArgs): System.Void use System.Windows.Forms.CheckBox"
		alias
			"OnClick"
		end

	on_mouse_up (mevent: WINFORMS_MOUSE_EVENT_ARGS) is
		external
			"IL signature (System.Windows.Forms.MouseEventArgs): System.Void use System.Windows.Forms.CheckBox"
		alias
			"OnMouseUp"
		end

	on_appearance_changed (e: EVENT_ARGS) is
		external
			"IL signature (System.EventArgs): System.Void use System.Windows.Forms.CheckBox"
		alias
			"OnAppearanceChanged"
		end

	on_handle_created (e: EVENT_ARGS) is
		external
			"IL signature (System.EventArgs): System.Void use System.Windows.Forms.CheckBox"
		alias
			"OnHandleCreated"
		end

	get_create_params: WINFORMS_CREATE_PARAMS is
		external
			"IL signature (): System.Windows.Forms.CreateParams use System.Windows.Forms.CheckBox"
		alias
			"get_CreateParams"
		end

	create_accessibility_instance: WINFORMS_ACCESSIBLE_OBJECT is
		external
			"IL signature (): System.Windows.Forms.AccessibleObject use System.Windows.Forms.CheckBox"
		alias
			"CreateAccessibilityInstance"
		end

end -- class WINFORMS_CHECK_BOX
