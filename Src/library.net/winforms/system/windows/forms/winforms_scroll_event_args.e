indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Windows.Forms.ScrollEventArgs"
	assembly: "System.Windows.Forms", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	WINFORMS_SCROLL_EVENT_ARGS

inherit
	EVENT_ARGS

create
	make_winforms_scroll_event_args

feature {NONE} -- Initialization

	frozen make_winforms_scroll_event_args (type: WINFORMS_SCROLL_EVENT_TYPE; new_value: INTEGER) is
		external
			"IL creator signature (System.Windows.Forms.ScrollEventType, System.Int32) use System.Windows.Forms.ScrollEventArgs"
		end

feature -- Access

	frozen get_type_scroll_event_type: WINFORMS_SCROLL_EVENT_TYPE is
		external
			"IL signature (): System.Windows.Forms.ScrollEventType use System.Windows.Forms.ScrollEventArgs"
		alias
			"get_Type"
		end

	frozen get_new_value: INTEGER is
		external
			"IL signature (): System.Int32 use System.Windows.Forms.ScrollEventArgs"
		alias
			"get_NewValue"
		end

feature -- Element Change

	frozen set_new_value (value: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.Windows.Forms.ScrollEventArgs"
		alias
			"set_NewValue"
		end

end -- class WINFORMS_SCROLL_EVENT_ARGS
