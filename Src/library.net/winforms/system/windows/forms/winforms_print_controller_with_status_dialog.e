indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Windows.Forms.PrintControllerWithStatusDialog"
	assembly: "System.Windows.Forms", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	WINFORMS_PRINT_CONTROLLER_WITH_STATUS_DIALOG

inherit
	DRAWING_PRINT_CONTROLLER
		redefine
			on_end_print,
			on_end_page,
			on_start_page,
			on_start_print
		end

create
	make_winforms_print_controller_with_status_dialog_1,
	make_winforms_print_controller_with_status_dialog

feature {NONE} -- Initialization

	frozen make_winforms_print_controller_with_status_dialog_1 (underlying_controller: DRAWING_PRINT_CONTROLLER; dialog_title: SYSTEM_STRING) is
		external
			"IL creator signature (System.Drawing.Printing.PrintController, System.String) use System.Windows.Forms.PrintControllerWithStatusDialog"
		end

	frozen make_winforms_print_controller_with_status_dialog (underlying_controller: DRAWING_PRINT_CONTROLLER) is
		external
			"IL creator signature (System.Drawing.Printing.PrintController) use System.Windows.Forms.PrintControllerWithStatusDialog"
		end

feature -- Basic Operations

	on_start_print (document: DRAWING_PRINT_DOCUMENT; e: DRAWING_PRINT_EVENT_ARGS) is
		external
			"IL signature (System.Drawing.Printing.PrintDocument, System.Drawing.Printing.PrintEventArgs): System.Void use System.Windows.Forms.PrintControllerWithStatusDialog"
		alias
			"OnStartPrint"
		end

	on_end_print (document: DRAWING_PRINT_DOCUMENT; e: DRAWING_PRINT_EVENT_ARGS) is
		external
			"IL signature (System.Drawing.Printing.PrintDocument, System.Drawing.Printing.PrintEventArgs): System.Void use System.Windows.Forms.PrintControllerWithStatusDialog"
		alias
			"OnEndPrint"
		end

	on_start_page (document: DRAWING_PRINT_DOCUMENT; e: DRAWING_PRINT_PAGE_EVENT_ARGS): DRAWING_GRAPHICS is
		external
			"IL signature (System.Drawing.Printing.PrintDocument, System.Drawing.Printing.PrintPageEventArgs): System.Drawing.Graphics use System.Windows.Forms.PrintControllerWithStatusDialog"
		alias
			"OnStartPage"
		end

	on_end_page (document: DRAWING_PRINT_DOCUMENT; e: DRAWING_PRINT_PAGE_EVENT_ARGS) is
		external
			"IL signature (System.Drawing.Printing.PrintDocument, System.Drawing.Printing.PrintPageEventArgs): System.Void use System.Windows.Forms.PrintControllerWithStatusDialog"
		alias
			"OnEndPage"
		end

end -- class WINFORMS_PRINT_CONTROLLER_WITH_STATUS_DIALOG
