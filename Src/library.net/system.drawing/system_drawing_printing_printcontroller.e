indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Drawing.Printing.PrintController"

deferred external class
	SYSTEM_DRAWING_PRINTING_PRINTCONTROLLER

feature -- Basic Operations

	on_start_print (document: SYSTEM_DRAWING_PRINTING_PRINTDOCUMENT; e: SYSTEM_DRAWING_PRINTING_PRINTEVENTARGS) is
		external
			"IL signature (System.Drawing.Printing.PrintDocument, System.Drawing.Printing.PrintEventArgs): System.Void use System.Drawing.Printing.PrintController"
		alias
			"OnStartPrint"
		end

	on_end_print (document: SYSTEM_DRAWING_PRINTING_PRINTDOCUMENT; e: SYSTEM_DRAWING_PRINTING_PRINTEVENTARGS) is
		external
			"IL signature (System.Drawing.Printing.PrintDocument, System.Drawing.Printing.PrintEventArgs): System.Void use System.Drawing.Printing.PrintController"
		alias
			"OnEndPrint"
		end

	on_start_page (document: SYSTEM_DRAWING_PRINTING_PRINTDOCUMENT; e: SYSTEM_DRAWING_PRINTING_PRINTPAGEEVENTARGS): SYSTEM_DRAWING_GRAPHICS is
		external
			"IL signature (System.Drawing.Printing.PrintDocument, System.Drawing.Printing.PrintPageEventArgs): System.Drawing.Graphics use System.Drawing.Printing.PrintController"
		alias
			"OnStartPage"
		end

	on_end_page (document: SYSTEM_DRAWING_PRINTING_PRINTDOCUMENT; e: SYSTEM_DRAWING_PRINTING_PRINTPAGEEVENTARGS) is
		external
			"IL signature (System.Drawing.Printing.PrintDocument, System.Drawing.Printing.PrintPageEventArgs): System.Void use System.Drawing.Printing.PrintController"
		alias
			"OnEndPage"
		end

end -- class SYSTEM_DRAWING_PRINTING_PRINTCONTROLLER
