indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Windows.Forms.LabelEditEventArgs"
	assembly: "System.Windows.Forms", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	WINFORMS_LABEL_EDIT_EVENT_ARGS

inherit
	EVENT_ARGS

create
	make_winforms_label_edit_event_args_1,
	make_winforms_label_edit_event_args

feature {NONE} -- Initialization

	frozen make_winforms_label_edit_event_args_1 (item: INTEGER; label: SYSTEM_STRING) is
		external
			"IL creator signature (System.Int32, System.String) use System.Windows.Forms.LabelEditEventArgs"
		end

	frozen make_winforms_label_edit_event_args (item: INTEGER) is
		external
			"IL creator signature (System.Int32) use System.Windows.Forms.LabelEditEventArgs"
		end

feature -- Access

	frozen get_cancel_edit: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.LabelEditEventArgs"
		alias
			"get_CancelEdit"
		end

	frozen get_item: INTEGER is
		external
			"IL signature (): System.Int32 use System.Windows.Forms.LabelEditEventArgs"
		alias
			"get_Item"
		end

	frozen get_label: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Windows.Forms.LabelEditEventArgs"
		alias
			"get_Label"
		end

feature -- Element Change

	frozen set_cancel_edit (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Windows.Forms.LabelEditEventArgs"
		alias
			"set_CancelEdit"
		end

end -- class WINFORMS_LABEL_EDIT_EVENT_ARGS
