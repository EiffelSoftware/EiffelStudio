indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Windows.Forms.Design.IUIService"
	assembly: "System.Windows.Forms", "1.0.3300.0", "neutral", "b77a5c561934e089"

deferred external class
	WINFORMS_IUISERVICE

inherit
	SYSTEM_OBJECT
		undefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end

feature -- Access

	get_styles: IDICTIONARY is
		external
			"IL deferred signature (): System.Collections.IDictionary use System.Windows.Forms.Design.IUIService"
		alias
			"get_Styles"
		end

feature -- Basic Operations

	show_message_string_string (message: SYSTEM_STRING; caption: SYSTEM_STRING) is
		external
			"IL deferred signature (System.String, System.String): System.Void use System.Windows.Forms.Design.IUIService"
		alias
			"ShowMessage"
		end

	set_uidirty is
		external
			"IL deferred signature (): System.Void use System.Windows.Forms.Design.IUIService"
		alias
			"SetUIDirty"
		end

	show_dialog (form: WINFORMS_FORM): WINFORMS_DIALOG_RESULT is
		external
			"IL deferred signature (System.Windows.Forms.Form): System.Windows.Forms.DialogResult use System.Windows.Forms.Design.IUIService"
		alias
			"ShowDialog"
		end

	show_component_editor (component: SYSTEM_OBJECT; parent: WINFORMS_IWIN32_WINDOW): BOOLEAN is
		external
			"IL deferred signature (System.Object, System.Windows.Forms.IWin32Window): System.Boolean use System.Windows.Forms.Design.IUIService"
		alias
			"ShowComponentEditor"
		end

	get_dialog_owner_window: WINFORMS_IWIN32_WINDOW is
		external
			"IL deferred signature (): System.Windows.Forms.IWin32Window use System.Windows.Forms.Design.IUIService"
		alias
			"GetDialogOwnerWindow"
		end

	show_tool_window (tool_window: GUID): BOOLEAN is
		external
			"IL deferred signature (System.Guid): System.Boolean use System.Windows.Forms.Design.IUIService"
		alias
			"ShowToolWindow"
		end

	show_error_exception (ex: EXCEPTION) is
		external
			"IL deferred signature (System.Exception): System.Void use System.Windows.Forms.Design.IUIService"
		alias
			"ShowError"
		end

	can_show_component_editor (component: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL deferred signature (System.Object): System.Boolean use System.Windows.Forms.Design.IUIService"
		alias
			"CanShowComponentEditor"
		end

	show_message_string_string_message_box_buttons (message: SYSTEM_STRING; caption: SYSTEM_STRING; buttons: WINFORMS_MESSAGE_BOX_BUTTONS): WINFORMS_DIALOG_RESULT is
		external
			"IL deferred signature (System.String, System.String, System.Windows.Forms.MessageBoxButtons): System.Windows.Forms.DialogResult use System.Windows.Forms.Design.IUIService"
		alias
			"ShowMessage"
		end

	show_message (message: SYSTEM_STRING) is
		external
			"IL deferred signature (System.String): System.Void use System.Windows.Forms.Design.IUIService"
		alias
			"ShowMessage"
		end

	show_error (message: SYSTEM_STRING) is
		external
			"IL deferred signature (System.String): System.Void use System.Windows.Forms.Design.IUIService"
		alias
			"ShowError"
		end

	show_error_exception_string (ex: EXCEPTION; message: SYSTEM_STRING) is
		external
			"IL deferred signature (System.Exception, System.String): System.Void use System.Windows.Forms.Design.IUIService"
		alias
			"ShowError"
		end

end -- class WINFORMS_IUISERVICE
