indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Windows.Forms.MeasureItemEventArgs"
	assembly: "System.Windows.Forms", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	WINFORMS_MEASURE_ITEM_EVENT_ARGS

inherit
	EVENT_ARGS

create
	make_winforms_measure_item_event_args,
	make_winforms_measure_item_event_args_1

feature {NONE} -- Initialization

	frozen make_winforms_measure_item_event_args (graphics: DRAWING_GRAPHICS; index: INTEGER; item_height: INTEGER) is
		external
			"IL creator signature (System.Drawing.Graphics, System.Int32, System.Int32) use System.Windows.Forms.MeasureItemEventArgs"
		end

	frozen make_winforms_measure_item_event_args_1 (graphics: DRAWING_GRAPHICS; index: INTEGER) is
		external
			"IL creator signature (System.Drawing.Graphics, System.Int32) use System.Windows.Forms.MeasureItemEventArgs"
		end

feature -- Access

	frozen get_item_height: INTEGER is
		external
			"IL signature (): System.Int32 use System.Windows.Forms.MeasureItemEventArgs"
		alias
			"get_ItemHeight"
		end

	frozen get_index: INTEGER is
		external
			"IL signature (): System.Int32 use System.Windows.Forms.MeasureItemEventArgs"
		alias
			"get_Index"
		end

	frozen get_graphics: DRAWING_GRAPHICS is
		external
			"IL signature (): System.Drawing.Graphics use System.Windows.Forms.MeasureItemEventArgs"
		alias
			"get_Graphics"
		end

	frozen get_item_width: INTEGER is
		external
			"IL signature (): System.Int32 use System.Windows.Forms.MeasureItemEventArgs"
		alias
			"get_ItemWidth"
		end

feature -- Element Change

	frozen set_item_height (value: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.Windows.Forms.MeasureItemEventArgs"
		alias
			"set_ItemHeight"
		end

	frozen set_item_width (value: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.Windows.Forms.MeasureItemEventArgs"
		alias
			"set_ItemWidth"
		end

end -- class WINFORMS_MEASURE_ITEM_EVENT_ARGS
