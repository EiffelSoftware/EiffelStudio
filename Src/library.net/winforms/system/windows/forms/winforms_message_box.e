indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Windows.Forms.MessageBox"
	assembly: "System.Windows.Forms", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	WINFORMS_MESSAGE_BOX

inherit
	SYSTEM_OBJECT

create {NONE}

feature -- Basic Operations

	frozen show (text: SYSTEM_STRING): WINFORMS_DIALOG_RESULT is
		external
			"IL static signature (System.String): System.Windows.Forms.DialogResult use System.Windows.Forms.MessageBox"
		alias
			"Show"
		end

	frozen show_string_string (text: SYSTEM_STRING; caption: SYSTEM_STRING): WINFORMS_DIALOG_RESULT is
		external
			"IL static signature (System.String, System.String): System.Windows.Forms.DialogResult use System.Windows.Forms.MessageBox"
		alias
			"Show"
		end

	frozen show_iwin32_window_string_string (owner: WINFORMS_IWIN32_WINDOW; text: SYSTEM_STRING; caption: SYSTEM_STRING): WINFORMS_DIALOG_RESULT is
		external
			"IL static signature (System.Windows.Forms.IWin32Window, System.String, System.String): System.Windows.Forms.DialogResult use System.Windows.Forms.MessageBox"
		alias
			"Show"
		end

	frozen show_iwin32_window_string (owner: WINFORMS_IWIN32_WINDOW; text: SYSTEM_STRING): WINFORMS_DIALOG_RESULT is
		external
			"IL static signature (System.Windows.Forms.IWin32Window, System.String): System.Windows.Forms.DialogResult use System.Windows.Forms.MessageBox"
		alias
			"Show"
		end

	frozen show_iwin32_window_string_string_message_box_buttons_message_box_icon (owner: WINFORMS_IWIN32_WINDOW; text: SYSTEM_STRING; caption: SYSTEM_STRING; buttons: WINFORMS_MESSAGE_BOX_BUTTONS; icon: WINFORMS_MESSAGE_BOX_ICON): WINFORMS_DIALOG_RESULT is
		external
			"IL static signature (System.Windows.Forms.IWin32Window, System.String, System.String, System.Windows.Forms.MessageBoxButtons, System.Windows.Forms.MessageBoxIcon): System.Windows.Forms.DialogResult use System.Windows.Forms.MessageBox"
		alias
			"Show"
		end

	frozen show_string_string_message_box_buttons_message_box_icon (text: SYSTEM_STRING; caption: SYSTEM_STRING; buttons: WINFORMS_MESSAGE_BOX_BUTTONS; icon: WINFORMS_MESSAGE_BOX_ICON): WINFORMS_DIALOG_RESULT is
		external
			"IL static signature (System.String, System.String, System.Windows.Forms.MessageBoxButtons, System.Windows.Forms.MessageBoxIcon): System.Windows.Forms.DialogResult use System.Windows.Forms.MessageBox"
		alias
			"Show"
		end

	frozen show_string_string_message_box_buttons_message_box_icon_message_box_default_button (text: SYSTEM_STRING; caption: SYSTEM_STRING; buttons: WINFORMS_MESSAGE_BOX_BUTTONS; icon: WINFORMS_MESSAGE_BOX_ICON; default_button: WINFORMS_MESSAGE_BOX_DEFAULT_BUTTON): WINFORMS_DIALOG_RESULT is
		external
			"IL static signature (System.String, System.String, System.Windows.Forms.MessageBoxButtons, System.Windows.Forms.MessageBoxIcon, System.Windows.Forms.MessageBoxDefaultButton): System.Windows.Forms.DialogResult use System.Windows.Forms.MessageBox"
		alias
			"Show"
		end

	frozen show_iwin32_window_string_string_message_box_buttons_message_box_icon_message_box_default_button (owner: WINFORMS_IWIN32_WINDOW; text: SYSTEM_STRING; caption: SYSTEM_STRING; buttons: WINFORMS_MESSAGE_BOX_BUTTONS; icon: WINFORMS_MESSAGE_BOX_ICON; default_button: WINFORMS_MESSAGE_BOX_DEFAULT_BUTTON): WINFORMS_DIALOG_RESULT is
		external
			"IL static signature (System.Windows.Forms.IWin32Window, System.String, System.String, System.Windows.Forms.MessageBoxButtons, System.Windows.Forms.MessageBoxIcon, System.Windows.Forms.MessageBoxDefaultButton): System.Windows.Forms.DialogResult use System.Windows.Forms.MessageBox"
		alias
			"Show"
		end

	frozen show_iwin32_window_string_string_message_box_buttons_message_box_icon_message_box_default_button_message_box_options (owner: WINFORMS_IWIN32_WINDOW; text: SYSTEM_STRING; caption: SYSTEM_STRING; buttons: WINFORMS_MESSAGE_BOX_BUTTONS; icon: WINFORMS_MESSAGE_BOX_ICON; default_button: WINFORMS_MESSAGE_BOX_DEFAULT_BUTTON; options: WINFORMS_MESSAGE_BOX_OPTIONS): WINFORMS_DIALOG_RESULT is
		external
			"IL static signature (System.Windows.Forms.IWin32Window, System.String, System.String, System.Windows.Forms.MessageBoxButtons, System.Windows.Forms.MessageBoxIcon, System.Windows.Forms.MessageBoxDefaultButton, System.Windows.Forms.MessageBoxOptions): System.Windows.Forms.DialogResult use System.Windows.Forms.MessageBox"
		alias
			"Show"
		end

	frozen show_string_string_message_box_buttons (text: SYSTEM_STRING; caption: SYSTEM_STRING; buttons: WINFORMS_MESSAGE_BOX_BUTTONS): WINFORMS_DIALOG_RESULT is
		external
			"IL static signature (System.String, System.String, System.Windows.Forms.MessageBoxButtons): System.Windows.Forms.DialogResult use System.Windows.Forms.MessageBox"
		alias
			"Show"
		end

	frozen show_iwin32_window_string_string_message_box_buttons (owner: WINFORMS_IWIN32_WINDOW; text: SYSTEM_STRING; caption: SYSTEM_STRING; buttons: WINFORMS_MESSAGE_BOX_BUTTONS): WINFORMS_DIALOG_RESULT is
		external
			"IL static signature (System.Windows.Forms.IWin32Window, System.String, System.String, System.Windows.Forms.MessageBoxButtons): System.Windows.Forms.DialogResult use System.Windows.Forms.MessageBox"
		alias
			"Show"
		end

	frozen show_string_string_message_box_buttons_message_box_icon_message_box_default_button_message_box_options (text: SYSTEM_STRING; caption: SYSTEM_STRING; buttons: WINFORMS_MESSAGE_BOX_BUTTONS; icon: WINFORMS_MESSAGE_BOX_ICON; default_button: WINFORMS_MESSAGE_BOX_DEFAULT_BUTTON; options: WINFORMS_MESSAGE_BOX_OPTIONS): WINFORMS_DIALOG_RESULT is
		external
			"IL static signature (System.String, System.String, System.Windows.Forms.MessageBoxButtons, System.Windows.Forms.MessageBoxIcon, System.Windows.Forms.MessageBoxDefaultButton, System.Windows.Forms.MessageBoxOptions): System.Windows.Forms.DialogResult use System.Windows.Forms.MessageBox"
		alias
			"Show"
		end

end -- class WINFORMS_MESSAGE_BOX
