indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Windows.Forms.KeyPressEventArgs"
	assembly: "System.Windows.Forms", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	WINFORMS_KEY_PRESS_EVENT_ARGS

inherit
	EVENT_ARGS

create
	make_winforms_key_press_event_args

feature {NONE} -- Initialization

	frozen make_winforms_key_press_event_args (key_char: CHARACTER) is
		external
			"IL creator signature (System.Char) use System.Windows.Forms.KeyPressEventArgs"
		end

feature -- Access

	frozen get_handled: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.KeyPressEventArgs"
		alias
			"get_Handled"
		end

	frozen get_key_char: CHARACTER is
		external
			"IL signature (): System.Char use System.Windows.Forms.KeyPressEventArgs"
		alias
			"get_KeyChar"
		end

feature -- Element Change

	frozen set_handled (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Windows.Forms.KeyPressEventArgs"
		alias
			"set_Handled"
		end

end -- class WINFORMS_KEY_PRESS_EVENT_ARGS
