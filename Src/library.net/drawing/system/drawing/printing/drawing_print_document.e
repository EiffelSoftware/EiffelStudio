indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Drawing.Printing.PrintDocument"
	assembly: "System.Drawing", "1.0.3300.0", "neutral", "b03f5f7f11d5a3a"

external class
	DRAWING_PRINT_DOCUMENT

inherit
	SYSTEM_DLL_COMPONENT
		redefine
			to_string
		end
	SYSTEM_DLL_ICOMPONENT
	IDISPOSABLE

create
	make_drawing_print_document

feature {NONE} -- Initialization

	frozen make_drawing_print_document is
		external
			"IL creator use System.Drawing.Printing.PrintDocument"
		end

feature -- Access

	frozen get_printer_settings: DRAWING_PRINTER_SETTINGS is
		external
			"IL signature (): System.Drawing.Printing.PrinterSettings use System.Drawing.Printing.PrintDocument"
		alias
			"get_PrinterSettings"
		end

	frozen get_default_page_settings: DRAWING_PAGE_SETTINGS is
		external
			"IL signature (): System.Drawing.Printing.PageSettings use System.Drawing.Printing.PrintDocument"
		alias
			"get_DefaultPageSettings"
		end

	frozen get_print_controller: DRAWING_PRINT_CONTROLLER is
		external
			"IL signature (): System.Drawing.Printing.PrintController use System.Drawing.Printing.PrintDocument"
		alias
			"get_PrintController"
		end

	frozen get_document_name: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Drawing.Printing.PrintDocument"
		alias
			"get_DocumentName"
		end

feature -- Element Change

	frozen set_printer_settings (value: DRAWING_PRINTER_SETTINGS) is
		external
			"IL signature (System.Drawing.Printing.PrinterSettings): System.Void use System.Drawing.Printing.PrintDocument"
		alias
			"set_PrinterSettings"
		end

	frozen add_begin_print (value: DRAWING_PRINT_EVENT_HANDLER) is
		external
			"IL signature (System.Drawing.Printing.PrintEventHandler): System.Void use System.Drawing.Printing.PrintDocument"
		alias
			"add_BeginPrint"
		end

	frozen remove_print_page (value: DRAWING_PRINT_PAGE_EVENT_HANDLER) is
		external
			"IL signature (System.Drawing.Printing.PrintPageEventHandler): System.Void use System.Drawing.Printing.PrintDocument"
		alias
			"remove_PrintPage"
		end

	frozen set_print_controller (value: DRAWING_PRINT_CONTROLLER) is
		external
			"IL signature (System.Drawing.Printing.PrintController): System.Void use System.Drawing.Printing.PrintDocument"
		alias
			"set_PrintController"
		end

	frozen remove_begin_print (value: DRAWING_PRINT_EVENT_HANDLER) is
		external
			"IL signature (System.Drawing.Printing.PrintEventHandler): System.Void use System.Drawing.Printing.PrintDocument"
		alias
			"remove_BeginPrint"
		end

	frozen add_print_page (value: DRAWING_PRINT_PAGE_EVENT_HANDLER) is
		external
			"IL signature (System.Drawing.Printing.PrintPageEventHandler): System.Void use System.Drawing.Printing.PrintDocument"
		alias
			"add_PrintPage"
		end

	frozen remove_end_print (value: DRAWING_PRINT_EVENT_HANDLER) is
		external
			"IL signature (System.Drawing.Printing.PrintEventHandler): System.Void use System.Drawing.Printing.PrintDocument"
		alias
			"remove_EndPrint"
		end

	frozen add_query_page_settings (value: DRAWING_QUERY_PAGE_SETTINGS_EVENT_HANDLER) is
		external
			"IL signature (System.Drawing.Printing.QueryPageSettingsEventHandler): System.Void use System.Drawing.Printing.PrintDocument"
		alias
			"add_QueryPageSettings"
		end

	frozen remove_query_page_settings (value: DRAWING_QUERY_PAGE_SETTINGS_EVENT_HANDLER) is
		external
			"IL signature (System.Drawing.Printing.QueryPageSettingsEventHandler): System.Void use System.Drawing.Printing.PrintDocument"
		alias
			"remove_QueryPageSettings"
		end

	frozen set_default_page_settings (value: DRAWING_PAGE_SETTINGS) is
		external
			"IL signature (System.Drawing.Printing.PageSettings): System.Void use System.Drawing.Printing.PrintDocument"
		alias
			"set_DefaultPageSettings"
		end

	frozen add_end_print (value: DRAWING_PRINT_EVENT_HANDLER) is
		external
			"IL signature (System.Drawing.Printing.PrintEventHandler): System.Void use System.Drawing.Printing.PrintDocument"
		alias
			"add_EndPrint"
		end

	frozen set_document_name (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Drawing.Printing.PrintDocument"
		alias
			"set_DocumentName"
		end

feature -- Basic Operations

	frozen print is
		external
			"IL signature (): System.Void use System.Drawing.Printing.PrintDocument"
		alias
			"Print"
		end

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Drawing.Printing.PrintDocument"
		alias
			"ToString"
		end

feature {NONE} -- Implementation

	on_query_page_settings (e: DRAWING_QUERY_PAGE_SETTINGS_EVENT_ARGS) is
		external
			"IL signature (System.Drawing.Printing.QueryPageSettingsEventArgs): System.Void use System.Drawing.Printing.PrintDocument"
		alias
			"OnQueryPageSettings"
		end

	on_print_page (e: DRAWING_PRINT_PAGE_EVENT_ARGS) is
		external
			"IL signature (System.Drawing.Printing.PrintPageEventArgs): System.Void use System.Drawing.Printing.PrintDocument"
		alias
			"OnPrintPage"
		end

	on_end_print (e: DRAWING_PRINT_EVENT_ARGS) is
		external
			"IL signature (System.Drawing.Printing.PrintEventArgs): System.Void use System.Drawing.Printing.PrintDocument"
		alias
			"OnEndPrint"
		end

	on_begin_print (e: DRAWING_PRINT_EVENT_ARGS) is
		external
			"IL signature (System.Drawing.Printing.PrintEventArgs): System.Void use System.Drawing.Printing.PrintDocument"
		alias
			"OnBeginPrint"
		end

end -- class DRAWING_PRINT_DOCUMENT
