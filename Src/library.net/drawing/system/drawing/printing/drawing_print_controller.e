indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Drawing.Printing.PrintController"
	assembly: "System.Drawing", "1.0.3300.0", "neutral", "b03f5f7f11d5a3a"

deferred external class
	DRAWING_PRINT_CONTROLLER

inherit
	SYSTEM_OBJECT

feature -- Basic Operations

	on_start_print (document: DRAWING_PRINT_DOCUMENT; e: DRAWING_PRINT_EVENT_ARGS) is
		external
			"IL signature (System.Drawing.Printing.PrintDocument, System.Drawing.Printing.PrintEventArgs): System.Void use System.Drawing.Printing.PrintController"
		alias
			"OnStartPrint"
		end

	on_end_print (document: DRAWING_PRINT_DOCUMENT; e: DRAWING_PRINT_EVENT_ARGS) is
		external
			"IL signature (System.Drawing.Printing.PrintDocument, System.Drawing.Printing.PrintEventArgs): System.Void use System.Drawing.Printing.PrintController"
		alias
			"OnEndPrint"
		end

	on_start_page (document: DRAWING_PRINT_DOCUMENT; e: DRAWING_PRINT_PAGE_EVENT_ARGS): DRAWING_GRAPHICS is
		external
			"IL signature (System.Drawing.Printing.PrintDocument, System.Drawing.Printing.PrintPageEventArgs): System.Drawing.Graphics use System.Drawing.Printing.PrintController"
		alias
			"OnStartPage"
		end

	on_end_page (document: DRAWING_PRINT_DOCUMENT; e: DRAWING_PRINT_PAGE_EVENT_ARGS) is
		external
			"IL signature (System.Drawing.Printing.PrintDocument, System.Drawing.Printing.PrintPageEventArgs): System.Void use System.Drawing.Printing.PrintController"
		alias
			"OnEndPage"
		end

end -- class DRAWING_PRINT_CONTROLLER
