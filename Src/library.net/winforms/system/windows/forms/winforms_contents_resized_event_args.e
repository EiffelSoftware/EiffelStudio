indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Windows.Forms.ContentsResizedEventArgs"
	assembly: "System.Windows.Forms", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	WINFORMS_CONTENTS_RESIZED_EVENT_ARGS

inherit
	EVENT_ARGS

create
	make_winforms_contents_resized_event_args

feature {NONE} -- Initialization

	frozen make_winforms_contents_resized_event_args (new_rectangle: DRAWING_RECTANGLE) is
		external
			"IL creator signature (System.Drawing.Rectangle) use System.Windows.Forms.ContentsResizedEventArgs"
		end

feature -- Access

	frozen get_new_rectangle: DRAWING_RECTANGLE is
		external
			"IL signature (): System.Drawing.Rectangle use System.Windows.Forms.ContentsResizedEventArgs"
		alias
			"get_NewRectangle"
		end

end -- class WINFORMS_CONTENTS_RESIZED_EVENT_ARGS
