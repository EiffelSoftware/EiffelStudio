indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Windows.Forms.KeyEventArgs"

external class
	SYSTEM_WINDOWS_FORMS_KEYEVENTARGS

inherit
	SYSTEM_EVENTARGS

create
	make_keyeventargs

feature {NONE} -- Initialization

	frozen make_keyeventargs (key_data: SYSTEM_WINDOWS_FORMS_KEYS) is
		external
			"IL creator signature (System.Windows.Forms.Keys) use System.Windows.Forms.KeyEventArgs"
		end

feature -- Access

	frozen get_control: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.KeyEventArgs"
		alias
			"get_Control"
		end

	frozen get_key_value: INTEGER is
		external
			"IL signature (): System.Int32 use System.Windows.Forms.KeyEventArgs"
		alias
			"get_KeyValue"
		end

	get_shift: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.KeyEventArgs"
		alias
			"get_Shift"
		end

	frozen get_handled: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.KeyEventArgs"
		alias
			"get_Handled"
		end

	get_alt: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.KeyEventArgs"
		alias
			"get_Alt"
		end

	frozen get_key_code: SYSTEM_WINDOWS_FORMS_KEYS is
		external
			"IL signature (): System.Windows.Forms.Keys use System.Windows.Forms.KeyEventArgs"
		alias
			"get_KeyCode"
		end

	frozen get_key_data: SYSTEM_WINDOWS_FORMS_KEYS is
		external
			"IL signature (): System.Windows.Forms.Keys use System.Windows.Forms.KeyEventArgs"
		alias
			"get_KeyData"
		end

	frozen get_modifiers: SYSTEM_WINDOWS_FORMS_KEYS is
		external
			"IL signature (): System.Windows.Forms.Keys use System.Windows.Forms.KeyEventArgs"
		alias
			"get_Modifiers"
		end

feature -- Element Change

	frozen set_handled (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Windows.Forms.KeyEventArgs"
		alias
			"set_Handled"
		end

end -- class SYSTEM_WINDOWS_FORMS_KEYEVENTARGS
