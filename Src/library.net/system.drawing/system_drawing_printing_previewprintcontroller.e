indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Drawing.Printing.PreviewPrintController"

external class
	SYSTEM_DRAWING_PRINTING_PREVIEWPRINTCONTROLLER

inherit
	SYSTEM_DRAWING_PRINTING_PRINTCONTROLLER
		redefine
			on_end_print,
			on_end_page,
			on_start_page,
			on_start_print
		end

create
	make_previewprintcontroller

feature {NONE} -- Initialization

	frozen make_previewprintcontroller is
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

	frozen get_preview_page_info: ARRAY [SYSTEM_DRAWING_PRINTING_PREVIEWPAGEINFO] is
		external
			"IL signature (): System.Drawing.Printing.PreviewPageInfo[] use System.Drawing.Printing.PreviewPrintController"
		alias
			"GetPreviewPageInfo"
		end

	on_start_print (document: SYSTEM_DRAWING_PRINTING_PRINTDOCUMENT; e: SYSTEM_DRAWING_PRINTING_PRINTEVENTARGS) is
		external
			"IL signature (System.Drawing.Printing.PrintDocument, System.Drawing.Printing.PrintEventArgs): System.Void use System.Drawing.Printing.PreviewPrintController"
		alias
			"OnStartPrint"
		end

	on_end_print (document: SYSTEM_DRAWING_PRINTING_PRINTDOCUMENT; e: SYSTEM_DRAWING_PRINTING_PRINTEVENTARGS) is
		external
			"IL signature (System.Drawing.Printing.PrintDocument, System.Drawing.Printing.PrintEventArgs): System.Void use System.Drawing.Printing.PreviewPrintController"
		alias
			"OnEndPrint"
		end

	on_start_page (document: SYSTEM_DRAWING_PRINTING_PRINTDOCUMENT; e: SYSTEM_DRAWING_PRINTING_PRINTPAGEEVENTARGS): SYSTEM_DRAWING_GRAPHICS is
		external
			"IL signature (System.Drawing.Printing.PrintDocument, System.Drawing.Printing.PrintPageEventArgs): System.Drawing.Graphics use System.Drawing.Printing.PreviewPrintController"
		alias
			"OnStartPage"
		end

	on_end_page (document: SYSTEM_DRAWING_PRINTING_PRINTDOCUMENT; e: SYSTEM_DRAWING_PRINTING_PRINTPAGEEVENTARGS) is
		external
			"IL signature (System.Drawing.Printing.PrintDocument, System.Drawing.Printing.PrintPageEventArgs): System.Void use System.Drawing.Printing.PreviewPrintController"
		alias
			"OnEndPage"
		end

end -- class SYSTEM_DRAWING_PRINTING_PREVIEWPRINTCONTROLLER
