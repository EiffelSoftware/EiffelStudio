indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Windows.Forms.ControlEventArgs"
	assembly: "System.Windows.Forms", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	WINFORMS_CONTROL_EVENT_ARGS

inherit
	EVENT_ARGS

create
	make_winforms_control_event_args

feature {NONE} -- Initialization

	frozen make_winforms_control_event_args (control: WINFORMS_CONTROL) is
		external
			"IL creator signature (System.Windows.Forms.Control) use System.Windows.Forms.ControlEventArgs"
		end

feature -- Access

	frozen get_control: WINFORMS_CONTROL is
		external
			"IL signature (): System.Windows.Forms.Control use System.Windows.Forms.ControlEventArgs"
		alias
			"get_Control"
		end

end -- class WINFORMS_CONTROL_EVENT_ARGS
