indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Windows.Forms.DataGridTextBox"

external class
	SYSTEM_WINDOWS_FORMS_DATAGRIDTEXTBOX

inherit
	SYSTEM_COMPONENTMODEL_ICOMPONENT
	SYSTEM_WINDOWS_FORMS_TEXTBOX
		redefine
			wnd_proc,
			process_key_message,
			on_mouse_wheel,
			on_key_press
		end
	SYSTEM_COMPONENTMODEL_ISYNCHRONIZEINVOKE
		rename
			invoke as invoke_delegate_array_object,
			begin_invoke as begin_invoke_delegate_array_object
		end
	SYSTEM_IDISPOSABLE
	SYSTEM_WINDOWS_FORMS_IWIN32WINDOW

create
	make_datagridtextbox

feature {NONE} -- Initialization

	frozen make_datagridtextbox is
		external
			"IL creator use System.Windows.Forms.DataGridTextBox"
		end

feature -- Access

	frozen get_is_in_edit_or_navigate_mode: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.DataGridTextBox"
		alias
			"get_IsInEditOrNavigateMode"
		end

feature -- Element Change

	frozen set_is_in_edit_or_navigate_mode (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Windows.Forms.DataGridTextBox"
		alias
			"set_IsInEditOrNavigateMode"
		end

feature -- Basic Operations

	frozen set_data_grid (parent_grid: SYSTEM_WINDOWS_FORMS_DATAGRID) is
		external
			"IL signature (System.Windows.Forms.DataGrid): System.Void use System.Windows.Forms.DataGridTextBox"
		alias
			"SetDataGrid"
		end

feature {NONE} -- Implementation

	on_mouse_wheel (e: SYSTEM_WINDOWS_FORMS_MOUSEEVENTARGS) is
		external
			"IL signature (System.Windows.Forms.MouseEventArgs): System.Void use System.Windows.Forms.DataGridTextBox"
		alias
			"OnMouseWheel"
		end

	wnd_proc (m: SYSTEM_WINDOWS_FORMS_MESSAGE) is
		external
			"IL signature (System.Windows.Forms.Message&): System.Void use System.Windows.Forms.DataGridTextBox"
		alias
			"WndProc"
		end

	on_key_press (e: SYSTEM_WINDOWS_FORMS_KEYPRESSEVENTARGS) is
		external
			"IL signature (System.Windows.Forms.KeyPressEventArgs): System.Void use System.Windows.Forms.DataGridTextBox"
		alias
			"OnKeyPress"
		end

	process_key_message (m: SYSTEM_WINDOWS_FORMS_MESSAGE): BOOLEAN is
		external
			"IL signature (System.Windows.Forms.Message&): System.Boolean use System.Windows.Forms.DataGridTextBox"
		alias
			"ProcessKeyMessage"
		end

end -- class SYSTEM_WINDOWS_FORMS_DATAGRIDTEXTBOX
