indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Windows.Forms.QueryContinueDragEventArgs"
	assembly: "System.Windows.Forms", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	WINFORMS_QUERY_CONTINUE_DRAG_EVENT_ARGS

inherit
	EVENT_ARGS

create
	make_winforms_query_continue_drag_event_args

feature {NONE} -- Initialization

	frozen make_winforms_query_continue_drag_event_args (key_state: INTEGER; escape_pressed: BOOLEAN; action: WINFORMS_DRAG_ACTION) is
		external
			"IL creator signature (System.Int32, System.Boolean, System.Windows.Forms.DragAction) use System.Windows.Forms.QueryContinueDragEventArgs"
		end

feature -- Access

	frozen get_escape_pressed: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.QueryContinueDragEventArgs"
		alias
			"get_EscapePressed"
		end

	frozen get_key_state: INTEGER is
		external
			"IL signature (): System.Int32 use System.Windows.Forms.QueryContinueDragEventArgs"
		alias
			"get_KeyState"
		end

	frozen get_action: WINFORMS_DRAG_ACTION is
		external
			"IL signature (): System.Windows.Forms.DragAction use System.Windows.Forms.QueryContinueDragEventArgs"
		alias
			"get_Action"
		end

feature -- Element Change

	frozen set_action (value: WINFORMS_DRAG_ACTION) is
		external
			"IL signature (System.Windows.Forms.DragAction): System.Void use System.Windows.Forms.QueryContinueDragEventArgs"
		alias
			"set_Action"
		end

end -- class WINFORMS_QUERY_CONTINUE_DRAG_EVENT_ARGS
