indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Windows.Forms.InvalidateEventArgs"
	assembly: "System.Windows.Forms", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	WINFORMS_INVALIDATE_EVENT_ARGS

inherit
	EVENT_ARGS

create
	make_winforms_invalidate_event_args

feature {NONE} -- Initialization

	frozen make_winforms_invalidate_event_args (invalid_rect: DRAWING_RECTANGLE) is
		external
			"IL creator signature (System.Drawing.Rectangle) use System.Windows.Forms.InvalidateEventArgs"
		end

feature -- Access

	frozen get_invalid_rect: DRAWING_RECTANGLE is
		external
			"IL signature (): System.Drawing.Rectangle use System.Windows.Forms.InvalidateEventArgs"
		alias
			"get_InvalidRect"
		end

end -- class WINFORMS_INVALIDATE_EVENT_ARGS
