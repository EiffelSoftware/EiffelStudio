indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Windows.Forms.KeyEventArgs"
	assembly: "System.Windows.Forms", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	WINFORMS_KEY_EVENT_ARGS

inherit
	EVENT_ARGS

create
	make_winforms_key_event_args

feature {NONE} -- Initialization

	frozen make_winforms_key_event_args (key_data: WINFORMS_KEYS) is
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

	frozen get_key_code: WINFORMS_KEYS is
		external
			"IL signature (): System.Windows.Forms.Keys use System.Windows.Forms.KeyEventArgs"
		alias
			"get_KeyCode"
		end

	frozen get_key_data: WINFORMS_KEYS is
		external
			"IL signature (): System.Windows.Forms.Keys use System.Windows.Forms.KeyEventArgs"
		alias
			"get_KeyData"
		end

	frozen get_modifiers: WINFORMS_KEYS is
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

end -- class WINFORMS_KEY_EVENT_ARGS
