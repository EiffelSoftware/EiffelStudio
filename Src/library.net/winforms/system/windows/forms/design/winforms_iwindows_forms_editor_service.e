indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Windows.Forms.Design.IWindowsFormsEditorService"
	assembly: "System.Windows.Forms", "1.0.3300.0", "neutral", "b77a5c561934e089"

deferred external class
	WINFORMS_IWINDOWS_FORMS_EDITOR_SERVICE

inherit
	SYSTEM_OBJECT
		undefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end

feature -- Basic Operations

	show_dialog (dialog: WINFORMS_FORM): WINFORMS_DIALOG_RESULT is
		external
			"IL deferred signature (System.Windows.Forms.Form): System.Windows.Forms.DialogResult use System.Windows.Forms.Design.IWindowsFormsEditorService"
		alias
			"ShowDialog"
		end

	drop_down_control (control: WINFORMS_CONTROL) is
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

end -- class WINFORMS_IWINDOWS_FORMS_EDITOR_SERVICE
