indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Drawing.Printing.PrintDocument"

external class
	SYSTEM_DRAWING_PRINTING_PRINTDOCUMENT

inherit
	SYSTEM_COMPONENTMODEL_ICOMPONENT
	SYSTEM_COMPONENTMODEL_COMPONENT
		redefine
			to_string
		end
	SYSTEM_IDISPOSABLE

create
	make_printdocument

feature {NONE} -- Initialization

	frozen make_printdocument is
		external
			"IL creator use System.Drawing.Printing.PrintDocument"
		end

feature -- Access

	frozen get_printer_settings: SYSTEM_DRAWING_PRINTING_PRINTERSETTINGS is
		external
			"IL signature (): System.Drawing.Printing.PrinterSettings use System.Drawing.Printing.PrintDocument"
		alias
			"get_PrinterSettings"
		end

	frozen get_default_page_settings: SYSTEM_DRAWING_PRINTING_PAGESETTINGS is
		external
			"IL signature (): System.Drawing.Printing.PageSettings use System.Drawing.Printing.PrintDocument"
		alias
			"get_DefaultPageSettings"
		end

	frozen get_print_controller: SYSTEM_DRAWING_PRINTING_PRINTCONTROLLER is
		external
			"IL signature (): System.Drawing.Printing.PrintController use System.Drawing.Printing.PrintDocument"
		alias
			"get_PrintController"
		end

	frozen get_document_name: STRING is
		external
			"IL signature (): System.String use System.Drawing.Printing.PrintDocument"
		alias
			"get_DocumentName"
		end

feature -- Element Change

	frozen set_printer_settings (value: SYSTEM_DRAWING_PRINTING_PRINTERSETTINGS) is
		external
			"IL signature (System.Drawing.Printing.PrinterSettings): System.Void use System.Drawing.Printing.PrintDocument"
		alias
			"set_PrinterSettings"
		end

	frozen add_begin_print (value: SYSTEM_DRAWING_PRINTING_PRINTEVENTHANDLER) is
		external
			"IL signature (System.Drawing.Printing.PrintEventHandler): System.Void use System.Drawing.Printing.PrintDocument"
		alias
			"add_BeginPrint"
		end

	frozen remove_print_page (value: SYSTEM_DRAWING_PRINTING_PRINTPAGEEVENTHANDLER) is
		external
			"IL signature (System.Drawing.Printing.PrintPageEventHandler): System.Void use System.Drawing.Printing.PrintDocument"
		alias
			"remove_PrintPage"
		end

	frozen set_print_controller (value: SYSTEM_DRAWING_PRINTING_PRINTCONTROLLER) is
		external
			"IL signature (System.Drawing.Printing.PrintController): System.Void use System.Drawing.Printing.PrintDocument"
		alias
			"set_PrintController"
		end

	frozen remove_begin_print (value: SYSTEM_DRAWING_PRINTING_PRINTEVENTHANDLER) is
		external
			"IL signature (System.Drawing.Printing.PrintEventHandler): System.Void use System.Drawing.Printing.PrintDocument"
		alias
			"remove_BeginPrint"
		end

	frozen add_print_page (value: SYSTEM_DRAWING_PRINTING_PRINTPAGEEVENTHANDLER) is
		external
			"IL signature (System.Drawing.Printing.PrintPageEventHandler): System.Void use System.Drawing.Printing.PrintDocument"
		alias
			"add_PrintPage"
		end

	frozen remove_end_print (value: SYSTEM_DRAWING_PRINTING_PRINTEVENTHANDLER) is
		external
			"IL signature (System.Drawing.Printing.PrintEventHandler): System.Void use System.Drawing.Printing.PrintDocument"
		alias
			"remove_EndPrint"
		end

	frozen add_query_page_settings (value: SYSTEM_DRAWING_PRINTING_QUERYPAGESETTINGSEVENTHANDLER) is
		external
			"IL signature (System.Drawing.Printing.QueryPageSettingsEventHandler): System.Void use System.Drawing.Printing.PrintDocument"
		alias
			"add_QueryPageSettings"
		end

	frozen remove_query_page_settings (value: SYSTEM_DRAWING_PRINTING_QUERYPAGESETTINGSEVENTHANDLER) is
		external
			"IL signature (System.Drawing.Printing.QueryPageSettingsEventHandler): System.Void use System.Drawing.Printing.PrintDocument"
		alias
			"remove_QueryPageSettings"
		end

	frozen set_default_page_settings (value: SYSTEM_DRAWING_PRINTING_PAGESETTINGS) is
		external
			"IL signature (System.Drawing.Printing.PageSettings): System.Void use System.Drawing.Printing.PrintDocument"
		alias
			"set_DefaultPageSettings"
		end

	frozen add_end_print (value: SYSTEM_DRAWING_PRINTING_PRINTEVENTHANDLER) is
		external
			"IL signature (System.Drawing.Printing.PrintEventHandler): System.Void use System.Drawing.Printing.PrintDocument"
		alias
			"add_EndPrint"
		end

	frozen set_document_name (value: STRING) is
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

	to_string: STRING is
		external
			"IL signature (): System.String use System.Drawing.Printing.PrintDocument"
		alias
			"ToString"
		end

feature {NONE} -- Implementation

	on_query_page_settings (e: SYSTEM_DRAWING_PRINTING_QUERYPAGESETTINGSEVENTARGS) is
		external
			"IL signature (System.Drawing.Printing.QueryPageSettingsEventArgs): System.Void use System.Drawing.Printing.PrintDocument"
		alias
			"OnQueryPageSettings"
		end

	on_print_page (e: SYSTEM_DRAWING_PRINTING_PRINTPAGEEVENTARGS) is
		external
			"IL signature (System.Drawing.Printing.PrintPageEventArgs): System.Void use System.Drawing.Printing.PrintDocument"
		alias
			"OnPrintPage"
		end

	on_end_print (e: SYSTEM_DRAWING_PRINTING_PRINTEVENTARGS) is
		external
			"IL signature (System.Drawing.Printing.PrintEventArgs): System.Void use System.Drawing.Printing.PrintDocument"
		alias
			"OnEndPrint"
		end

	on_begin_print (e: SYSTEM_DRAWING_PRINTING_PRINTEVENTARGS) is
		external
			"IL signature (System.Drawing.Printing.PrintEventArgs): System.Void use System.Drawing.Printing.PrintDocument"
		alias
			"OnBeginPrint"
		end

end -- class SYSTEM_DRAWING_PRINTING_PRINTDOCUMENT
