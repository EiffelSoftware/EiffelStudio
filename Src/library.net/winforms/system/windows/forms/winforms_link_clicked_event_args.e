indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Windows.Forms.LinkClickedEventArgs"
	assembly: "System.Windows.Forms", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	WINFORMS_LINK_CLICKED_EVENT_ARGS

inherit
	EVENT_ARGS

create
	make_winforms_link_clicked_event_args

feature {NONE} -- Initialization

	frozen make_winforms_link_clicked_event_args (link_text: SYSTEM_STRING) is
		external
			"IL creator signature (System.String) use System.Windows.Forms.LinkClickedEventArgs"
		end

feature -- Access

	frozen get_link_text: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Windows.Forms.LinkClickedEventArgs"
		alias
			"get_LinkText"
		end

end -- class WINFORMS_LINK_CLICKED_EVENT_ARGS
