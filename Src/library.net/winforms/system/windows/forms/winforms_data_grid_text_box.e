indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Windows.Forms.DataGridTextBox"
	assembly: "System.Windows.Forms", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	WINFORMS_DATA_GRID_TEXT_BOX

inherit
	WINFORMS_TEXT_BOX
		redefine
			wnd_proc,
			process_key_message,
			on_mouse_wheel,
			on_key_press
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
	make_winforms_data_grid_text_box

feature {NONE} -- Initialization

	frozen make_winforms_data_grid_text_box is
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

	frozen set_data_grid (parent_grid: WINFORMS_DATA_GRID) is
		external
			"IL signature (System.Windows.Forms.DataGrid): System.Void use System.Windows.Forms.DataGridTextBox"
		alias
			"SetDataGrid"
		end

feature {NONE} -- Implementation

	on_mouse_wheel (e: WINFORMS_MOUSE_EVENT_ARGS) is
		external
			"IL signature (System.Windows.Forms.MouseEventArgs): System.Void use System.Windows.Forms.DataGridTextBox"
		alias
			"OnMouseWheel"
		end

	wnd_proc (m: WINFORMS_MESSAGE) is
		external
			"IL signature (System.Windows.Forms.Message&): System.Void use System.Windows.Forms.DataGridTextBox"
		alias
			"WndProc"
		end

	on_key_press (e: WINFORMS_KEY_PRESS_EVENT_ARGS) is
		external
			"IL signature (System.Windows.Forms.KeyPressEventArgs): System.Void use System.Windows.Forms.DataGridTextBox"
		alias
			"OnKeyPress"
		end

	process_key_message (m: WINFORMS_MESSAGE): BOOLEAN is
		external
			"IL signature (System.Windows.Forms.Message&): System.Boolean use System.Windows.Forms.DataGridTextBox"
		alias
			"ProcessKeyMessage"
		end

end -- class WINFORMS_DATA_GRID_TEXT_BOX
