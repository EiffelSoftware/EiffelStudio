indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Windows.Forms.HelpEventArgs"
	assembly: "System.Windows.Forms", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	WINFORMS_HELP_EVENT_ARGS

inherit
	EVENT_ARGS

create
	make_winforms_help_event_args

feature {NONE} -- Initialization

	frozen make_winforms_help_event_args (mouse_pos: DRAWING_POINT) is
		external
			"IL creator signature (System.Drawing.Point) use System.Windows.Forms.HelpEventArgs"
		end

feature -- Access

	frozen get_mouse_pos: DRAWING_POINT is
		external
			"IL signature (): System.Drawing.Point use System.Windows.Forms.HelpEventArgs"
		alias
			"get_MousePos"
		end

	frozen get_handled: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.HelpEventArgs"
		alias
			"get_Handled"
		end

feature -- Element Change

	frozen set_handled (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Windows.Forms.HelpEventArgs"
		alias
			"set_Handled"
		end

end -- class WINFORMS_HELP_EVENT_ARGS
