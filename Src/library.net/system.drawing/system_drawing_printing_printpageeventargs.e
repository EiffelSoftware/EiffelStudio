indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Drawing.Printing.PrintPageEventArgs"

external class
	SYSTEM_DRAWING_PRINTING_PRINTPAGEEVENTARGS

inherit
	SYSTEM_EVENTARGS

create
	make_printpageeventargs

feature {NONE} -- Initialization

	frozen make_printpageeventargs (graphics: SYSTEM_DRAWING_GRAPHICS; margin_bounds: SYSTEM_DRAWING_RECTANGLE; page_bounds: SYSTEM_DRAWING_RECTANGLE; page_settings: SYSTEM_DRAWING_PRINTING_PAGESETTINGS) is
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

	frozen get_page_settings: SYSTEM_DRAWING_PRINTING_PAGESETTINGS is
		external
			"IL signature (): System.Drawing.Printing.PageSettings use System.Drawing.Printing.PrintPageEventArgs"
		alias
			"get_PageSettings"
		end

	frozen get_margin_bounds: SYSTEM_DRAWING_RECTANGLE is
		external
			"IL signature (): System.Drawing.Rectangle use System.Drawing.Printing.PrintPageEventArgs"
		alias
			"get_MarginBounds"
		end

	frozen get_graphics: SYSTEM_DRAWING_GRAPHICS is
		external
			"IL signature (): System.Drawing.Graphics use System.Drawing.Printing.PrintPageEventArgs"
		alias
			"get_Graphics"
		end

	frozen get_page_bounds: SYSTEM_DRAWING_RECTANGLE is
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

end -- class SYSTEM_DRAWING_PRINTING_PRINTPAGEEVENTARGS
