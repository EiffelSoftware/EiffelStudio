indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Windows.Forms.Design.ComponentEditorForm"

external class
	SYSTEM_WINDOWS_FORMS_DESIGN_COMPONENTEDITORFORM

inherit
	SYSTEM_COMPONENTMODEL_ICOMPONENT
	SYSTEM_WINDOWS_FORMS_ICONTAINERCONTROL
		rename
			activate_control as system_windows_forms_icontainer_control_activate_control
		end
	SYSTEM_COMPONENTMODEL_ISYNCHRONIZEINVOKE
		rename
			invoke as invoke_delegate_array_object,
			begin_invoke as begin_invoke_delegate_array_object
		end
	SYSTEM_WINDOWS_FORMS_FORM
		redefine
			on_activated,
			pre_process_message,
			on_help_requested
		end
	SYSTEM_IDISPOSABLE
	SYSTEM_WINDOWS_FORMS_IWIN32WINDOW

create
	make_componenteditorform

feature {NONE} -- Initialization

	frozen make_componenteditorform (component: ANY; page_types: ARRAY [SYSTEM_TYPE]) is
		external
			"IL creator signature (System.Object, System.Type[]) use System.Windows.Forms.Design.ComponentEditorForm"
		end

feature -- Basic Operations

	pre_process_message (msg: SYSTEM_WINDOWS_FORMS_MESSAGE): BOOLEAN is
		external
			"IL signature (System.Windows.Forms.Message&): System.Boolean use System.Windows.Forms.Design.ComponentEditorForm"
		alias
			"PreProcessMessage"
		end

	show_form_int32 (page: INTEGER): SYSTEM_WINDOWS_FORMS_DIALOGRESULT is
		external
			"IL signature (System.Int32): System.Windows.Forms.DialogResult use System.Windows.Forms.Design.ComponentEditorForm"
		alias
			"ShowForm"
		end

	show_form_iwin32_window_int32 (owner: SYSTEM_WINDOWS_FORMS_IWIN32WINDOW; page: INTEGER): SYSTEM_WINDOWS_FORMS_DIALOGRESULT is
		external
			"IL signature (System.Windows.Forms.IWin32Window, System.Int32): System.Windows.Forms.DialogResult use System.Windows.Forms.Design.ComponentEditorForm"
		alias
			"ShowForm"
		end

	show_form_iwin32_window (owner: SYSTEM_WINDOWS_FORMS_IWIN32WINDOW): SYSTEM_WINDOWS_FORMS_DIALOGRESULT is
		external
			"IL signature (System.Windows.Forms.IWin32Window): System.Windows.Forms.DialogResult use System.Windows.Forms.Design.ComponentEditorForm"
		alias
			"ShowForm"
		end

	show_form: SYSTEM_WINDOWS_FORMS_DIALOGRESULT is
		external
			"IL signature (): System.Windows.Forms.DialogResult use System.Windows.Forms.Design.ComponentEditorForm"
		alias
			"ShowForm"
		end

feature {NONE} -- Implementation

	on_help_requested (e: SYSTEM_WINDOWS_FORMS_HELPEVENTARGS) is
		external
			"IL signature (System.Windows.Forms.HelpEventArgs): System.Void use System.Windows.Forms.Design.ComponentEditorForm"
		alias
			"OnHelpRequested"
		end

	on_activated (e: SYSTEM_EVENTARGS) is
		external
			"IL signature (System.EventArgs): System.Void use System.Windows.Forms.Design.ComponentEditorForm"
		alias
			"OnActivated"
		end

	on_sel_change_selector (source: ANY; e: SYSTEM_WINDOWS_FORMS_TREEVIEWEVENTARGS) is
		external
			"IL signature (System.Object, System.Windows.Forms.TreeViewEventArgs): System.Void use System.Windows.Forms.Design.ComponentEditorForm"
		alias
			"OnSelChangeSelector"
		end

end -- class SYSTEM_WINDOWS_FORMS_DESIGN_COMPONENTEDITORFORM
