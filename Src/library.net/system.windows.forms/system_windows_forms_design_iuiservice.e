indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Windows.Forms.Design.IUIService"

deferred external class
	SYSTEM_WINDOWS_FORMS_DESIGN_IUISERVICE

inherit
	ANY
		undefine
			finalize,
			get_hash_code,
			is_equal,
			to_string
		end

feature -- Access

	get_styles: SYSTEM_COLLECTIONS_IDICTIONARY is
		external
			"IL deferred signature (): System.Collections.IDictionary use System.Windows.Forms.Design.IUIService"
		alias
			"get_Styles"
		end

feature -- Basic Operations

	show_message_string_string (message: STRING; caption: STRING) is
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

	show_dialog (form: SYSTEM_WINDOWS_FORMS_FORM): SYSTEM_WINDOWS_FORMS_DIALOGRESULT is
		external
			"IL deferred signature (System.Windows.Forms.Form): System.Windows.Forms.DialogResult use System.Windows.Forms.Design.IUIService"
		alias
			"ShowDialog"
		end

	show_component_editor (component: ANY; parent: SYSTEM_WINDOWS_FORMS_IWIN32WINDOW): BOOLEAN is
		external
			"IL deferred signature (System.Object, System.Windows.Forms.IWin32Window): System.Boolean use System.Windows.Forms.Design.IUIService"
		alias
			"ShowComponentEditor"
		end

	get_dialog_owner_window: SYSTEM_WINDOWS_FORMS_IWIN32WINDOW is
		external
			"IL deferred signature (): System.Windows.Forms.IWin32Window use System.Windows.Forms.Design.IUIService"
		alias
			"GetDialogOwnerWindow"
		end

	show_tool_window (tool_window: SYSTEM_GUID): BOOLEAN is
		external
			"IL deferred signature (System.Guid): System.Boolean use System.Windows.Forms.Design.IUIService"
		alias
			"ShowToolWindow"
		end

	show_error_exception (ex: SYSTEM_EXCEPTION) is
		external
			"IL deferred signature (System.Exception): System.Void use System.Windows.Forms.Design.IUIService"
		alias
			"ShowError"
		end

	can_show_component_editor (component: ANY): BOOLEAN is
		external
			"IL deferred signature (System.Object): System.Boolean use System.Windows.Forms.Design.IUIService"
		alias
			"CanShowComponentEditor"
		end

	show_message_string_string_message_box_buttons (message: STRING; caption: STRING; buttons: SYSTEM_WINDOWS_FORMS_MESSAGEBOXBUTTONS): SYSTEM_WINDOWS_FORMS_DIALOGRESULT is
		external
			"IL deferred signature (System.String, System.String, System.Windows.Forms.MessageBoxButtons): System.Windows.Forms.DialogResult use System.Windows.Forms.Design.IUIService"
		alias
			"ShowMessage"
		end

	show_message (message: STRING) is
		external
			"IL deferred signature (System.String): System.Void use System.Windows.Forms.Design.IUIService"
		alias
			"ShowMessage"
		end

	show_error (message: STRING) is
		external
			"IL deferred signature (System.String): System.Void use System.Windows.Forms.Design.IUIService"
		alias
			"ShowError"
		end

	show_error_exception_string (ex: SYSTEM_EXCEPTION; message: STRING) is
		external
			"IL deferred signature (System.Exception, System.String): System.Void use System.Windows.Forms.Design.IUIService"
		alias
			"ShowError"
		end

end -- class SYSTEM_WINDOWS_FORMS_DESIGN_IUISERVICE
