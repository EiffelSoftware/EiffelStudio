indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Windows.Forms.PrintControllerWithStatusDialog"

external class
	SYSTEM_WINDOWS_FORMS_PRINTCONTROLLERWITHSTATUSDIALOG

inherit
	SYSTEM_DRAWING_PRINTING_PRINTCONTROLLER
		redefine
			on_end_print,
			on_end_page,
			on_start_page,
			on_start_print
		end

create
	make_printcontrollerwithstatusdialog_1,
	make_printcontrollerwithstatusdialog

feature {NONE} -- Initialization

	frozen make_printcontrollerwithstatusdialog_1 (underlying_controller: SYSTEM_DRAWING_PRINTING_PRINTCONTROLLER; dialog_title: STRING) is
		external
			"IL creator signature (System.Drawing.Printing.PrintController, System.String) use System.Windows.Forms.PrintControllerWithStatusDialog"
		end

	frozen make_printcontrollerwithstatusdialog (underlying_controller: SYSTEM_DRAWING_PRINTING_PRINTCONTROLLER) is
		external
			"IL creator signature (System.Drawing.Printing.PrintController) use System.Windows.Forms.PrintControllerWithStatusDialog"
		end

feature -- Basic Operations

	on_start_print (document: SYSTEM_DRAWING_PRINTING_PRINTDOCUMENT; e: SYSTEM_DRAWING_PRINTING_PRINTEVENTARGS) is
		external
			"IL signature (System.Drawing.Printing.PrintDocument, System.Drawing.Printing.PrintEventArgs): System.Void use System.Windows.Forms.PrintControllerWithStatusDialog"
		alias
			"OnStartPrint"
		end

	on_end_print (document: SYSTEM_DRAWING_PRINTING_PRINTDOCUMENT; e: SYSTEM_DRAWING_PRINTING_PRINTEVENTARGS) is
		external
			"IL signature (System.Drawing.Printing.PrintDocument, System.Drawing.Printing.PrintEventArgs): System.Void use System.Windows.Forms.PrintControllerWithStatusDialog"
		alias
			"OnEndPrint"
		end

	on_start_page (document: SYSTEM_DRAWING_PRINTING_PRINTDOCUMENT; e: SYSTEM_DRAWING_PRINTING_PRINTPAGEEVENTARGS): SYSTEM_DRAWING_GRAPHICS is
		external
			"IL signature (System.Drawing.Printing.PrintDocument, System.Drawing.Printing.PrintPageEventArgs): System.Drawing.Graphics use System.Windows.Forms.PrintControllerWithStatusDialog"
		alias
			"OnStartPage"
		end

	on_end_page (document: SYSTEM_DRAWING_PRINTING_PRINTDOCUMENT; e: SYSTEM_DRAWING_PRINTING_PRINTPAGEEVENTARGS) is
		external
			"IL signature (System.Drawing.Printing.PrintDocument, System.Drawing.Printing.PrintPageEventArgs): System.Void use System.Windows.Forms.PrintControllerWithStatusDialog"
		alias
			"OnEndPage"
		end

end -- class SYSTEM_WINDOWS_FORMS_PRINTCONTROLLERWITHSTATUSDIALOG
