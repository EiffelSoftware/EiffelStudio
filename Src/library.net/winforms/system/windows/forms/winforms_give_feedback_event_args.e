indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Windows.Forms.GiveFeedbackEventArgs"
	assembly: "System.Windows.Forms", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	WINFORMS_GIVE_FEEDBACK_EVENT_ARGS

inherit
	EVENT_ARGS

create
	make_winforms_give_feedback_event_args

feature {NONE} -- Initialization

	frozen make_winforms_give_feedback_event_args (effect: WINFORMS_DRAG_DROP_EFFECTS; use_default_cursors: BOOLEAN) is
		external
			"IL creator signature (System.Windows.Forms.DragDropEffects, System.Boolean) use System.Windows.Forms.GiveFeedbackEventArgs"
		end

feature -- Access

	frozen get_use_default_cursors: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.GiveFeedbackEventArgs"
		alias
			"get_UseDefaultCursors"
		end

	frozen get_effect: WINFORMS_DRAG_DROP_EFFECTS is
		external
			"IL signature (): System.Windows.Forms.DragDropEffects use System.Windows.Forms.GiveFeedbackEventArgs"
		alias
			"get_Effect"
		end

feature -- Element Change

	frozen set_use_default_cursors (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Windows.Forms.GiveFeedbackEventArgs"
		alias
			"set_UseDefaultCursors"
		end

end -- class WINFORMS_GIVE_FEEDBACK_EVENT_ARGS
