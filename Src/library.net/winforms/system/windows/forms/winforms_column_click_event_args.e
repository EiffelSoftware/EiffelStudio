indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Windows.Forms.ColumnClickEventArgs"
	assembly: "System.Windows.Forms", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	WINFORMS_COLUMN_CLICK_EVENT_ARGS

inherit
	EVENT_ARGS

create
	make_winforms_column_click_event_args

feature {NONE} -- Initialization

	frozen make_winforms_column_click_event_args (column: INTEGER) is
		external
			"IL creator signature (System.Int32) use System.Windows.Forms.ColumnClickEventArgs"
		end

feature -- Access

	frozen get_column: INTEGER is
		external
			"IL signature (): System.Int32 use System.Windows.Forms.ColumnClickEventArgs"
		alias
			"get_Column"
		end

end -- class WINFORMS_COLUMN_CLICK_EVENT_ARGS
