indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Drawing.Printing.StandardPrintController"

external class
	SYSTEM_DRAWING_PRINTING_STANDARDPRINTCONTROLLER

inherit
	SYSTEM_DRAWING_PRINTING_PRINTCONTROLLER
		redefine
			on_end_print,
			on_end_page,
			on_start_page,
			on_start_print
		end

create
	make_standardprintcontroller

feature {NONE} -- Initialization

	frozen make_standardprintcontroller is
		external
			"IL creator use System.Drawing.Printing.StandardPrintController"
		end

feature -- Basic Operations

	on_start_print (document: SYSTEM_DRAWING_PRINTING_PRINTDOCUMENT; e: SYSTEM_DRAWING_PRINTING_PRINTEVENTARGS) is
		external
			"IL signature (System.Drawing.Printing.PrintDocument, System.Drawing.Printing.PrintEventArgs): System.Void use System.Drawing.Printing.StandardPrintController"
		alias
			"OnStartPrint"
		end

	on_end_print (document: SYSTEM_DRAWING_PRINTING_PRINTDOCUMENT; e: SYSTEM_DRAWING_PRINTING_PRINTEVENTARGS) is
		external
			"IL signature (System.Drawing.Printing.PrintDocument, System.Drawing.Printing.PrintEventArgs): System.Void use System.Drawing.Printing.StandardPrintController"
		alias
			"OnEndPrint"
		end

	on_start_page (document: SYSTEM_DRAWING_PRINTING_PRINTDOCUMENT; e: SYSTEM_DRAWING_PRINTING_PRINTPAGEEVENTARGS): SYSTEM_DRAWING_GRAPHICS is
		external
			"IL signature (System.Drawing.Printing.PrintDocument, System.Drawing.Printing.PrintPageEventArgs): System.Drawing.Graphics use System.Drawing.Printing.StandardPrintController"
		alias
			"OnStartPage"
		end

	on_end_page (document: SYSTEM_DRAWING_PRINTING_PRINTDOCUMENT; e: SYSTEM_DRAWING_PRINTING_PRINTPAGEEVENTARGS) is
		external
			"IL signature (System.Drawing.Printing.PrintDocument, System.Drawing.Printing.PrintPageEventArgs): System.Void use System.Drawing.Printing.StandardPrintController"
		alias
			"OnEndPage"
		end

end -- class SYSTEM_DRAWING_PRINTING_STANDARDPRINTCONTROLLER
