indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Windows.Forms.ContainerControl"

external class
	SYSTEM_WINDOWS_FORMS_CONTAINERCONTROL

inherit
	SYSTEM_WINDOWS_FORMS_SCROLLABLECONTROL
		redefine
			adjust_form_scrollbars,
			wnd_proc,
			select__boolean,
			process_mnemonic,
			process_dialog_key,
			process_dialog_char,
			on_create_control,
			on_control_removed,
			get_create_params,
			set_binding_context,
			get_binding_context,
			dispose_boolean
		end
	SYSTEM_WINDOWS_FORMS_ICONTAINERCONTROL
		rename
			activate_control as system_windows_forms_icontainer_control_activate_control
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
	make_containercontrol

feature {NONE} -- Initialization

	frozen make_containercontrol is
		external
			"IL creator use System.Windows.Forms.ContainerControl"
		end

feature -- Access

	frozen get_parent_form: SYSTEM_WINDOWS_FORMS_FORM is
		external
			"IL signature (): System.Windows.Forms.Form use System.Windows.Forms.ContainerControl"
		alias
			"get_ParentForm"
		end

	frozen get_active_control: SYSTEM_WINDOWS_FORMS_CONTROL is
		external
			"IL signature (): System.Windows.Forms.Control use System.Windows.Forms.ContainerControl"
		alias
			"get_ActiveControl"
		end

	get_binding_context: SYSTEM_WINDOWS_FORMS_BINDINGCONTEXT is
		external
			"IL signature (): System.Windows.Forms.BindingContext use System.Windows.Forms.ContainerControl"
		alias
			"get_BindingContext"
		end

feature -- Element Change

	frozen set_active_control (value: SYSTEM_WINDOWS_FORMS_CONTROL) is
		external
			"IL signature (System.Windows.Forms.Control): System.Void use System.Windows.Forms.ContainerControl"
		alias
			"set_ActiveControl"
		end

	set_binding_context (value: SYSTEM_WINDOWS_FORMS_BINDINGCONTEXT) is
		external
			"IL signature (System.Windows.Forms.BindingContext): System.Void use System.Windows.Forms.ContainerControl"
		alias
			"set_BindingContext"
		end

feature -- Basic Operations

	frozen validate: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.ContainerControl"
		alias
			"Validate"
		end

feature {NONE} -- Implementation

	dispose_boolean (disposing: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Windows.Forms.ContainerControl"
		alias
			"Dispose"
		end

	adjust_form_scrollbars (display_scrollbars: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Windows.Forms.ContainerControl"
		alias
			"AdjustFormScrollbars"
		end

	wnd_proc (m: SYSTEM_WINDOWS_FORMS_MESSAGE) is
		external
			"IL signature (System.Windows.Forms.Message&): System.Void use System.Windows.Forms.ContainerControl"
		alias
			"WndProc"
		end

	on_control_removed (e: SYSTEM_WINDOWS_FORMS_CONTROLEVENTARGS) is
		external
			"IL signature (System.Windows.Forms.ControlEventArgs): System.Void use System.Windows.Forms.ContainerControl"
		alias
			"OnControlRemoved"
		end

	process_dialog_key (key_data: SYSTEM_WINDOWS_FORMS_KEYS): BOOLEAN is
		external
			"IL signature (System.Windows.Forms.Keys): System.Boolean use System.Windows.Forms.ContainerControl"
		alias
			"ProcessDialogKey"
		end

	process_mnemonic (char_code: CHARACTER): BOOLEAN is
		external
			"IL signature (System.Char): System.Boolean use System.Windows.Forms.ContainerControl"
		alias
			"ProcessMnemonic"
		end

	select__boolean (directed: BOOLEAN; forward: BOOLEAN) is
		external
			"IL signature (System.Boolean, System.Boolean): System.Void use System.Windows.Forms.ContainerControl"
		alias
			"Select"
		end

	process_dialog_char (char_code: CHARACTER): BOOLEAN is
		external
			"IL signature (System.Char): System.Boolean use System.Windows.Forms.ContainerControl"
		alias
			"ProcessDialogChar"
		end

	process_tab_key (forward: BOOLEAN): BOOLEAN is
		external
			"IL signature (System.Boolean): System.Boolean use System.Windows.Forms.ContainerControl"
		alias
			"ProcessTabKey"
		end

	update_default_button is
		external
			"IL signature (): System.Void use System.Windows.Forms.ContainerControl"
		alias
			"UpdateDefaultButton"
		end

	on_create_control is
		external
			"IL signature (): System.Void use System.Windows.Forms.ContainerControl"
		alias
			"OnCreateControl"
		end

	frozen system_windows_forms_icontainer_control_activate_control (control: SYSTEM_WINDOWS_FORMS_CONTROL): BOOLEAN is
		external
			"IL signature (System.Windows.Forms.Control): System.Boolean use System.Windows.Forms.ContainerControl"
		alias
			"System.Windows.Forms.IContainerControl.ActivateControl"
		end

	get_create_params: SYSTEM_WINDOWS_FORMS_CREATEPARAMS is
		external
			"IL signature (): System.Windows.Forms.CreateParams use System.Windows.Forms.ContainerControl"
		alias
			"get_CreateParams"
		end

end -- class SYSTEM_WINDOWS_FORMS_CONTAINERCONTROL
