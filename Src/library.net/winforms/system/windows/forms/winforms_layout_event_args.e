indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Windows.Forms.LayoutEventArgs"
	assembly: "System.Windows.Forms", "1.0.3300.0", "neutral", "b77a5c561934e089"

frozen external class
	WINFORMS_LAYOUT_EVENT_ARGS

inherit
	EVENT_ARGS

create
	make_winforms_layout_event_args

feature {NONE} -- Initialization

	frozen make_winforms_layout_event_args (affected_control: WINFORMS_CONTROL; affected_property: SYSTEM_STRING) is
		external
			"IL creator signature (System.Windows.Forms.Control, System.String) use System.Windows.Forms.LayoutEventArgs"
		end

feature -- Access

	frozen get_affected_property: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Windows.Forms.LayoutEventArgs"
		alias
			"get_AffectedProperty"
		end

	frozen get_affected_control: WINFORMS_CONTROL is
		external
			"IL signature (): System.Windows.Forms.Control use System.Windows.Forms.LayoutEventArgs"
		alias
			"get_AffectedControl"
		end

end -- class WINFORMS_LAYOUT_EVENT_ARGS
