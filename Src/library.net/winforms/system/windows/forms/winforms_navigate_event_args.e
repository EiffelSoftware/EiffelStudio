indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Windows.Forms.NavigateEventArgs"
	assembly: "System.Windows.Forms", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	WINFORMS_NAVIGATE_EVENT_ARGS

inherit
	EVENT_ARGS

create
	make_winforms_navigate_event_args

feature {NONE} -- Initialization

	frozen make_winforms_navigate_event_args (is_forward: BOOLEAN) is
		external
			"IL creator signature (System.Boolean) use System.Windows.Forms.NavigateEventArgs"
		end

feature -- Access

	frozen get_forward: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.NavigateEventArgs"
		alias
			"get_Forward"
		end

end -- class WINFORMS_NAVIGATE_EVENT_ARGS
