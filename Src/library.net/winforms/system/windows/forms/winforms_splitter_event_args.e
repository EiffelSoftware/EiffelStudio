indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Windows.Forms.SplitterEventArgs"
	assembly: "System.Windows.Forms", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	WINFORMS_SPLITTER_EVENT_ARGS

inherit
	EVENT_ARGS

create
	make_winforms_splitter_event_args

feature {NONE} -- Initialization

	frozen make_winforms_splitter_event_args (x: INTEGER; y: INTEGER; split_x: INTEGER; split_y: INTEGER) is
		external
			"IL creator signature (System.Int32, System.Int32, System.Int32, System.Int32) use System.Windows.Forms.SplitterEventArgs"
		end

feature -- Access

	frozen get_split_x: INTEGER is
		external
			"IL signature (): System.Int32 use System.Windows.Forms.SplitterEventArgs"
		alias
			"get_SplitX"
		end

	frozen get_split_y: INTEGER is
		external
			"IL signature (): System.Int32 use System.Windows.Forms.SplitterEventArgs"
		alias
			"get_SplitY"
		end

	frozen get_y: INTEGER is
		external
			"IL signature (): System.Int32 use System.Windows.Forms.SplitterEventArgs"
		alias
			"get_Y"
		end

	frozen get_x: INTEGER is
		external
			"IL signature (): System.Int32 use System.Windows.Forms.SplitterEventArgs"
		alias
			"get_X"
		end

feature -- Element Change

	frozen set_split_x (value: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.Windows.Forms.SplitterEventArgs"
		alias
			"set_SplitX"
		end

	frozen set_split_y (value: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.Windows.Forms.SplitterEventArgs"
		alias
			"set_SplitY"
		end

end -- class WINFORMS_SPLITTER_EVENT_ARGS
