indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Windows.Forms.UICuesEventArgs"
	assembly: "System.Windows.Forms", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	WINFORMS_UICUES_EVENT_ARGS

inherit
	EVENT_ARGS

create
	make_winforms_uicues_event_args

feature {NONE} -- Initialization

	frozen make_winforms_uicues_event_args (uicues: WINFORMS_UICUES) is
		external
			"IL creator signature (System.Windows.Forms.UICues) use System.Windows.Forms.UICuesEventArgs"
		end

feature -- Access

	frozen get_changed: WINFORMS_UICUES is
		external
			"IL signature (): System.Windows.Forms.UICues use System.Windows.Forms.UICuesEventArgs"
		alias
			"get_Changed"
		end

	frozen get_show_keyboard: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.UICuesEventArgs"
		alias
			"get_ShowKeyboard"
		end

	frozen get_show_focus: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.UICuesEventArgs"
		alias
			"get_ShowFocus"
		end

	frozen get_change_keyboard: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.UICuesEventArgs"
		alias
			"get_ChangeKeyboard"
		end

	frozen get_change_focus: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.UICuesEventArgs"
		alias
			"get_ChangeFocus"
		end

end -- class WINFORMS_UICUES_EVENT_ARGS
