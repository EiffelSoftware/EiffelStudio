indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Windows.Forms.PrintDialog"

frozen external class
	SYSTEM_WINDOWS_FORMS_PRINTDIALOG

inherit
	SYSTEM_COMPONENTMODEL_ICOMPONENT
	SYSTEM_IDISPOSABLE
	SYSTEM_WINDOWS_FORMS_COMMONDIALOG

create
	make_printdialog

feature {NONE} -- Initialization

	frozen make_printdialog is
		external
			"IL creator use System.Windows.Forms.PrintDialog"
		end

feature -- Access

	frozen get_allow_print_to_file: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.PrintDialog"
		alias
			"get_AllowPrintToFile"
		end

	frozen get_allow_selection: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.PrintDialog"
		alias
			"get_AllowSelection"
		end

	frozen get_show_network: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.PrintDialog"
		alias
			"get_ShowNetwork"
		end

	frozen get_printer_settings: SYSTEM_DRAWING_PRINTING_PRINTERSETTINGS is
		external
			"IL signature (): System.Drawing.Printing.PrinterSettings use System.Windows.Forms.PrintDialog"
		alias
			"get_PrinterSettings"
		end

	frozen get_show_help: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.PrintDialog"
		alias
			"get_ShowHelp"
		end

	frozen get_allow_some_pages: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.PrintDialog"
		alias
			"get_AllowSomePages"
		end

	frozen get_document: SYSTEM_DRAWING_PRINTING_PRINTDOCUMENT is
		external
			"IL signature (): System.Drawing.Printing.PrintDocument use System.Windows.Forms.PrintDialog"
		alias
			"get_Document"
		end

	frozen get_print_to_file: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.PrintDialog"
		alias
			"get_PrintToFile"
		end

feature -- Element Change

	frozen set_printer_settings (value: SYSTEM_DRAWING_PRINTING_PRINTERSETTINGS) is
		external
			"IL signature (System.Drawing.Printing.PrinterSettings): System.Void use System.Windows.Forms.PrintDialog"
		alias
			"set_PrinterSettings"
		end

	frozen set_show_network (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Windows.Forms.PrintDialog"
		alias
			"set_ShowNetwork"
		end

	frozen set_show_help (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Windows.Forms.PrintDialog"
		alias
			"set_ShowHelp"
		end

	frozen set_document (value: SYSTEM_DRAWING_PRINTING_PRINTDOCUMENT) is
		external
			"IL signature (System.Drawing.Printing.PrintDocument): System.Void use System.Windows.Forms.PrintDialog"
		alias
			"set_Document"
		end

	frozen set_allow_print_to_file (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Windows.Forms.PrintDialog"
		alias
			"set_AllowPrintToFile"
		end

	frozen set_allow_some_pages (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Windows.Forms.PrintDialog"
		alias
			"set_AllowSomePages"
		end

	frozen set_print_to_file (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Windows.Forms.PrintDialog"
		alias
			"set_PrintToFile"
		end

	frozen set_allow_selection (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Windows.Forms.PrintDialog"
		alias
			"set_AllowSelection"
		end

feature -- Basic Operations

	reset is
		external
			"IL signature (): System.Void use System.Windows.Forms.PrintDialog"
		alias
			"Reset"
		end

feature {NONE} -- Implementation

	run_dialog (hwnd_owner: POINTER): BOOLEAN is
		external
			"IL signature (System.IntPtr): System.Boolean use System.Windows.Forms.PrintDialog"
		alias
			"RunDialog"
		end

end -- class SYSTEM_WINDOWS_FORMS_PRINTDIALOG
