indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Drawing.Printing.PrintPageEventArgs"
	assembly: "System.Drawing", "1.0.3300.0", "neutral", "b03f5f7f11d5a3a"

external class
	DRAWING_PRINT_PAGE_EVENT_ARGS

inherit
	EVENT_ARGS

create
	make_drawing_print_page_event_args

feature {NONE} -- Initialization

	frozen make_drawing_print_page_event_args (graphics: DRAWING_GRAPHICS; margin_bounds: DRAWING_RECTANGLE; page_bounds: DRAWING_RECTANGLE; page_settings: DRAWING_PAGE_SETTINGS) is
		external
			"IL creator signature (System.Drawing.Graphics, System.Drawing.Rectangle, System.Drawing.Rectangle, System.Drawing.Printing.PageSettings) use System.Drawing.Printing.PrintPageEventArgs"
		end

feature -- Access

	frozen get_has_more_pages: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Drawing.Printing.PrintPageEventArgs"
		alias
			"get_HasMorePages"
		end

	frozen get_page_settings: DRAWING_PAGE_SETTINGS is
		external
			"IL signature (): System.Drawing.Printing.PageSettings use System.Drawing.Printing.PrintPageEventArgs"
		alias
			"get_PageSettings"
		end

	frozen get_margin_bounds: DRAWING_RECTANGLE is
		external
			"IL signature (): System.Drawing.Rectangle use System.Drawing.Printing.PrintPageEventArgs"
		alias
			"get_MarginBounds"
		end

	frozen get_graphics: DRAWING_GRAPHICS is
		external
			"IL signature (): System.Drawing.Graphics use System.Drawing.Printing.PrintPageEventArgs"
		alias
			"get_Graphics"
		end

	frozen get_page_bounds: DRAWING_RECTANGLE is
		external
			"IL signature (): System.Drawing.Rectangle use System.Drawing.Printing.PrintPageEventArgs"
		alias
			"get_PageBounds"
		end

	frozen get_cancel: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Drawing.Printing.PrintPageEventArgs"
		alias
			"get_Cancel"
		end

feature -- Element Change

	frozen set_has_more_pages (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Drawing.Printing.PrintPageEventArgs"
		alias
			"set_HasMorePages"
		end

	frozen set_cancel (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Drawing.Printing.PrintPageEventArgs"
		alias
			"set_Cancel"
		end

end -- class DRAWING_PRINT_PAGE_EVENT_ARGS
