indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Windows.Forms.MessageBox"

external class
	SYSTEM_WINDOWS_FORMS_MESSAGEBOX

create {NONE}

feature -- Basic Operations

	frozen show (text: STRING): SYSTEM_WINDOWS_FORMS_DIALOGRESULT is
		external
			"IL static signature (System.String): System.Windows.Forms.DialogResult use System.Windows.Forms.MessageBox"
		alias
			"Show"
		end

	frozen show_string_string (text: STRING; caption: STRING): SYSTEM_WINDOWS_FORMS_DIALOGRESULT is
		external
			"IL static signature (System.String, System.String): System.Windows.Forms.DialogResult use System.Windows.Forms.MessageBox"
		alias
			"Show"
		end

	frozen show_iwin32_window_string_string (owner: SYSTEM_WINDOWS_FORMS_IWIN32WINDOW; text: STRING; caption: STRING): SYSTEM_WINDOWS_FORMS_DIALOGRESULT is
		external
			"IL static signature (System.Windows.Forms.IWin32Window, System.String, System.String): System.Windows.Forms.DialogResult use System.Windows.Forms.MessageBox"
		alias
			"Show"
		end

	frozen show_iwin32_window_string (owner: SYSTEM_WINDOWS_FORMS_IWIN32WINDOW; text: STRING): SYSTEM_WINDOWS_FORMS_DIALOGRESULT is
		external
			"IL static signature (System.Windows.Forms.IWin32Window, System.String): System.Windows.Forms.DialogResult use System.Windows.Forms.MessageBox"
		alias
			"Show"
		end

	frozen show_iwin32_window_string_string_message_box_buttons_message_box_icon (owner: SYSTEM_WINDOWS_FORMS_IWIN32WINDOW; text: STRING; caption: STRING; buttons: SYSTEM_WINDOWS_FORMS_MESSAGEBOXBUTTONS; icon: SYSTEM_WINDOWS_FORMS_MESSAGEBOXICON): SYSTEM_WINDOWS_FORMS_DIALOGRESULT is
		external
			"IL static signature (System.Windows.Forms.IWin32Window, System.String, System.String, System.Windows.Forms.MessageBoxButtons, System.Windows.Forms.MessageBoxIcon): System.Windows.Forms.DialogResult use System.Windows.Forms.MessageBox"
		alias
			"Show"
		end

	frozen show_string_string_message_box_buttons_message_box_icon (text: STRING; caption: STRING; buttons: SYSTEM_WINDOWS_FORMS_MESSAGEBOXBUTTONS; icon: SYSTEM_WINDOWS_FORMS_MESSAGEBOXICON): SYSTEM_WINDOWS_FORMS_DIALOGRESULT is
		external
			"IL static signature (System.String, System.String, System.Windows.Forms.MessageBoxButtons, System.Windows.Forms.MessageBoxIcon): System.Windows.Forms.DialogResult use System.Windows.Forms.MessageBox"
		alias
			"Show"
		end

	frozen show_string_string_message_box_buttons_message_box_icon_message_box_default_button (text: STRING; caption: STRING; buttons: SYSTEM_WINDOWS_FORMS_MESSAGEBOXBUTTONS; icon: SYSTEM_WINDOWS_FORMS_MESSAGEBOXICON; default_button: SYSTEM_WINDOWS_FORMS_MESSAGEBOXDEFAULTBUTTON): SYSTEM_WINDOWS_FORMS_DIALOGRESULT is
		external
			"IL static signature (System.String, System.String, System.Windows.Forms.MessageBoxButtons, System.Windows.Forms.MessageBoxIcon, System.Windows.Forms.MessageBoxDefaultButton): System.Windows.Forms.DialogResult use System.Windows.Forms.MessageBox"
		alias
			"Show"
		end

	frozen show_iwin32_window_string_string_message_box_buttons_message_box_icon_message_box_default_button (owner: SYSTEM_WINDOWS_FORMS_IWIN32WINDOW; text: STRING; caption: STRING; buttons: SYSTEM_WINDOWS_FORMS_MESSAGEBOXBUTTONS; icon: SYSTEM_WINDOWS_FORMS_MESSAGEBOXICON; default_button: SYSTEM_WINDOWS_FORMS_MESSAGEBOXDEFAULTBUTTON): SYSTEM_WINDOWS_FORMS_DIALOGRESULT is
		external
			"IL static signature (System.Windows.Forms.IWin32Window, System.String, System.String, System.Windows.Forms.MessageBoxButtons, System.Windows.Forms.MessageBoxIcon, System.Windows.Forms.MessageBoxDefaultButton): System.Windows.Forms.DialogResult use System.Windows.Forms.MessageBox"
		alias
			"Show"
		end

	frozen show_iwin32_window_string_string_message_box_buttons_message_box_icon_message_box_default_button_message_box_options (owner: SYSTEM_WINDOWS_FORMS_IWIN32WINDOW; text: STRING; caption: STRING; buttons: SYSTEM_WINDOWS_FORMS_MESSAGEBOXBUTTONS; icon: SYSTEM_WINDOWS_FORMS_MESSAGEBOXICON; default_button: SYSTEM_WINDOWS_FORMS_MESSAGEBOXDEFAULTBUTTON; options: SYSTEM_WINDOWS_FORMS_MESSAGEBOXOPTIONS): SYSTEM_WINDOWS_FORMS_DIALOGRESULT is
		external
			"IL static signature (System.Windows.Forms.IWin32Window, System.String, System.String, System.Windows.Forms.MessageBoxButtons, System.Windows.Forms.MessageBoxIcon, System.Windows.Forms.MessageBoxDefaultButton, System.Windows.Forms.MessageBoxOptions): System.Windows.Forms.DialogResult use System.Windows.Forms.MessageBox"
		alias
			"Show"
		end

	frozen show_string_string_message_box_buttons (text: STRING; caption: STRING; buttons: SYSTEM_WINDOWS_FORMS_MESSAGEBOXBUTTONS): SYSTEM_WINDOWS_FORMS_DIALOGRESULT is
		external
			"IL static signature (System.String, System.String, System.Windows.Forms.MessageBoxButtons): System.Windows.Forms.DialogResult use System.Windows.Forms.MessageBox"
		alias
			"Show"
		end

	frozen show_iwin32_window_string_string_message_box_buttons (owner: SYSTEM_WINDOWS_FORMS_IWIN32WINDOW; text: STRING; caption: STRING; buttons: SYSTEM_WINDOWS_FORMS_MESSAGEBOXBUTTONS): SYSTEM_WINDOWS_FORMS_DIALOGRESULT is
		external
			"IL static signature (System.Windows.Forms.IWin32Window, System.String, System.String, System.Windows.Forms.MessageBoxButtons): System.Windows.Forms.DialogResult use System.Windows.Forms.MessageBox"
		alias
			"Show"
		end

	frozen show_string_string_message_box_buttons_message_box_icon_message_box_default_button_message_box_options (text: STRING; caption: STRING; buttons: SYSTEM_WINDOWS_FORMS_MESSAGEBOXBUTTONS; icon: SYSTEM_WINDOWS_FORMS_MESSAGEBOXICON; default_button: SYSTEM_WINDOWS_FORMS_MESSAGEBOXDEFAULTBUTTON; options: SYSTEM_WINDOWS_FORMS_MESSAGEBOXOPTIONS): SYSTEM_WINDOWS_FORMS_DIALOGRESULT is
		external
			"IL static signature (System.String, System.String, System.Windows.Forms.MessageBoxButtons, System.Windows.Forms.MessageBoxIcon, System.Windows.Forms.MessageBoxDefaultButton, System.Windows.Forms.MessageBoxOptions): System.Windows.Forms.DialogResult use System.Windows.Forms.MessageBox"
		alias
			"Show"
		end

end -- class SYSTEM_WINDOWS_FORMS_MESSAGEBOX
