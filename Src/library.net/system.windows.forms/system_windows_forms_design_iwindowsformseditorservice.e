indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Windows.Forms.Design.IWindowsFormsEditorService"

deferred external class
	SYSTEM_WINDOWS_FORMS_DESIGN_IWINDOWSFORMSEDITORSERVICE

inherit
	ANY
		undefine
			finalize,
			get_hash_code,
			is_equal,
			to_string
		end

feature -- Basic Operations

	show_dialog (dialog: SYSTEM_WINDOWS_FORMS_FORM): SYSTEM_WINDOWS_FORMS_DIALOGRESULT is
		external
			"IL deferred signature (System.Windows.Forms.Form): System.Windows.Forms.DialogResult use System.Windows.Forms.Design.IWindowsFormsEditorService"
		alias
			"ShowDialog"
		end

	drop_down_control (control: SYSTEM_WINDOWS_FORMS_CONTROL) is
		external
			"IL deferred signature (System.Windows.Forms.Control): System.Void use System.Windows.Forms.Design.IWindowsFormsEditorService"
		alias
			"DropDownControl"
		end

	close_drop_down is
		external
			"IL deferred signature (): System.Void use System.Windows.Forms.Design.IWindowsFormsEditorService"
		alias
			"CloseDropDown"
		end

end -- class SYSTEM_WINDOWS_FORMS_DESIGN_IWINDOWSFORMSEDITORSERVICE
