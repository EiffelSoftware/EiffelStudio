indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Windows.Forms.Design.ComponentEditorForm"
	assembly: "System.Windows.Forms", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	WINFORMS_COMPONENT_EDITOR_FORM

inherit
	WINFORMS_FORM
		redefine
			on_activated,
			pre_process_message,
			on_help_requested
		end
	SYSTEM_DLL_ICOMPONENT
	IDISPOSABLE
	SYSTEM_DLL_ISYNCHRONIZE_INVOKE
		rename
			invoke as invoke_delegate_array_object,
			begin_invoke as begin_invoke_delegate_array_object
		end
	WINFORMS_IWIN32_WINDOW
	WINFORMS_ICONTAINER_CONTROL
		rename
			activate_control as system_windows_forms_icontainer_control_activate_control
		end

create
	make_winforms_component_editor_form

feature {NONE} -- Initialization

	frozen make_winforms_component_editor_form (component: SYSTEM_OBJECT; page_types: NATIVE_ARRAY [TYPE]) is
		external
			"IL creator signature (System.Object, System.Type[]) use System.Windows.Forms.Design.ComponentEditorForm"
		end

feature -- Basic Operations

	pre_process_message (msg: WINFORMS_MESSAGE): BOOLEAN is
		external
			"IL signature (System.Windows.Forms.Message&): System.Boolean use System.Windows.Forms.Design.ComponentEditorForm"
		alias
			"PreProcessMessage"
		end

	show_form_int32 (page: INTEGER): WINFORMS_DIALOG_RESULT is
		external
			"IL signature (System.Int32): System.Windows.Forms.DialogResult use System.Windows.Forms.Design.ComponentEditorForm"
		alias
			"ShowForm"
		end

	show_form_iwin32_window_int32 (owner: WINFORMS_IWIN32_WINDOW; page: INTEGER): WINFORMS_DIALOG_RESULT is
		external
			"IL signature (System.Windows.Forms.IWin32Window, System.Int32): System.Windows.Forms.DialogResult use System.Windows.Forms.Design.ComponentEditorForm"
		alias
			"ShowForm"
		end

	show_form_iwin32_window (owner: WINFORMS_IWIN32_WINDOW): WINFORMS_DIALOG_RESULT is
		external
			"IL signature (System.Windows.Forms.IWin32Window): System.Windows.Forms.DialogResult use System.Windows.Forms.Design.ComponentEditorForm"
		alias
			"ShowForm"
		end

	show_form: WINFORMS_DIALOG_RESULT is
		external
			"IL signature (): System.Windows.Forms.DialogResult use System.Windows.Forms.Design.ComponentEditorForm"
		alias
			"ShowForm"
		end

feature {NONE} -- Implementation

	on_help_requested (e: WINFORMS_HELP_EVENT_ARGS) is
		external
			"IL signature (System.Windows.Forms.HelpEventArgs): System.Void use System.Windows.Forms.Design.ComponentEditorForm"
		alias
			"OnHelpRequested"
		end

	on_activated (e: EVENT_ARGS) is
		external
			"IL signature (System.EventArgs): System.Void use System.Windows.Forms.Design.ComponentEditorForm"
		alias
			"OnActivated"
		end

	on_sel_change_selector (source: SYSTEM_OBJECT; e: WINFORMS_TREE_VIEW_EVENT_ARGS) is
		external
			"IL signature (System.Object, System.Windows.Forms.TreeViewEventArgs): System.Void use System.Windows.Forms.Design.ComponentEditorForm"
		alias
			"OnSelChangeSelector"
		end

end -- class WINFORMS_COMPONENT_EDITOR_FORM
