indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Windows.Forms.UpDownEventArgs"
	assembly: "System.Windows.Forms", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	WINFORMS_UP_DOWN_EVENT_ARGS

inherit
	EVENT_ARGS

create
	make_winforms_up_down_event_args

feature {NONE} -- Initialization

	frozen make_winforms_up_down_event_args (button_pushed: INTEGER) is
		external
			"IL creator signature (System.Int32) use System.Windows.Forms.UpDownEventArgs"
		end

feature -- Access

	frozen get_button_id: INTEGER is
		external
			"IL signature (): System.Int32 use System.Windows.Forms.UpDownEventArgs"
		alias
			"get_ButtonID"
		end

end -- class WINFORMS_UP_DOWN_EVENT_ARGS
