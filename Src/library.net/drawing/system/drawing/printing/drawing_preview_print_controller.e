indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Drawing.Printing.PreviewPrintController"
	assembly: "System.Drawing", "1.0.3300.0", "neutral", "b03f5f7f11d5a3a"

external class
	DRAWING_PREVIEW_PRINT_CONTROLLER

inherit
	DRAWING_PRINT_CONTROLLER
		redefine
			on_end_print,
			on_end_page,
			on_start_page,
			on_start_print
		end

create
	make_drawing_preview_print_controller

feature {NONE} -- Initialization

	frozen make_drawing_preview_print_controller is
		external
			"IL creator use System.Drawing.Printing.PreviewPrintController"
		end

feature -- Access

	get_use_anti_alias: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Drawing.Printing.PreviewPrintController"
		alias
			"get_UseAntiAlias"
		end

feature -- Element Change

	set_use_anti_alias (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Drawing.Printing.PreviewPrintController"
		alias
			"set_UseAntiAlias"
		end

feature -- Basic Operations

	frozen get_preview_page_info: NATIVE_ARRAY [DRAWING_PREVIEW_PAGE_INFO] is
		external
			"IL signature (): System.Drawing.Printing.PreviewPageInfo[] use System.Drawing.Printing.PreviewPrintController"
		alias
			"GetPreviewPageInfo"
		end

	on_start_print (document: DRAWING_PRINT_DOCUMENT; e: DRAWING_PRINT_EVENT_ARGS) is
		external
			"IL signature (System.Drawing.Printing.PrintDocument, System.Drawing.Printing.PrintEventArgs): System.Void use System.Drawing.Printing.PreviewPrintController"
		alias
			"OnStartPrint"
		end

	on_end_print (document: DRAWING_PRINT_DOCUMENT; e: DRAWING_PRINT_EVENT_ARGS) is
		external
			"IL signature (System.Drawing.Printing.PrintDocument, System.Drawing.Printing.PrintEventArgs): System.Void use System.Drawing.Printing.PreviewPrintController"
		alias
			"OnEndPrint"
		end

	on_start_page (document: DRAWING_PRINT_DOCUMENT; e: DRAWING_PRINT_PAGE_EVENT_ARGS): DRAWING_GRAPHICS is
		external
			"IL signature (System.Drawing.Printing.PrintDocument, System.Drawing.Printing.PrintPageEventArgs): System.Drawing.Graphics use System.Drawing.Printing.PreviewPrintController"
		alias
			"OnStartPage"
		end

	on_end_page (document: DRAWING_PRINT_DOCUMENT; e: DRAWING_PRINT_PAGE_EVENT_ARGS) is
		external
			"IL signature (System.Drawing.Printing.PrintDocument, System.Drawing.Printing.PrintPageEventArgs): System.Void use System.Drawing.Printing.PreviewPrintController"
		alias
			"OnEndPage"
		end

end -- class DRAWING_PREVIEW_PRINT_CONTROLLER
