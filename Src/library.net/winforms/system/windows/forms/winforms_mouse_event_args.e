indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Windows.Forms.MouseEventArgs"
	assembly: "System.Windows.Forms", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	WINFORMS_MOUSE_EVENT_ARGS

inherit
	EVENT_ARGS

create
	make_winforms_mouse_event_args

feature {NONE} -- Initialization

	frozen make_winforms_mouse_event_args (button: WINFORMS_MOUSE_BUTTONS; clicks: INTEGER; x: INTEGER; y: INTEGER; delta: INTEGER) is
		external
			"IL creator signature (System.Windows.Forms.MouseButtons, System.Int32, System.Int32, System.Int32, System.Int32) use System.Windows.Forms.MouseEventArgs"
		end

feature -- Access

	frozen get_clicks: INTEGER is
		external
			"IL signature (): System.Int32 use System.Windows.Forms.MouseEventArgs"
		alias
			"get_Clicks"
		end

	frozen get_y: INTEGER is
		external
			"IL signature (): System.Int32 use System.Windows.Forms.MouseEventArgs"
		alias
			"get_Y"
		end

	frozen get_delta: INTEGER is
		external
			"IL signature (): System.Int32 use System.Windows.Forms.MouseEventArgs"
		alias
			"get_Delta"
		end

	frozen get_button: WINFORMS_MOUSE_BUTTONS is
		external
			"IL signature (): System.Windows.Forms.MouseButtons use System.Windows.Forms.MouseEventArgs"
		alias
			"get_Button"
		end

	frozen get_x: INTEGER is
		external
			"IL signature (): System.Int32 use System.Windows.Forms.MouseEventArgs"
		alias
			"get_X"
		end

end -- class WINFORMS_MOUSE_EVENT_ARGS
