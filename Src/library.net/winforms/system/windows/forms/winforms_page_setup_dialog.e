indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Windows.Forms.PageSetupDialog"
	assembly: "System.Windows.Forms", "1.0.3300.0", "neutral", "b77a5c561934e089"

frozen external class
	WINFORMS_PAGE_SETUP_DIALOG

inherit
	WINFORMS_COMMON_DIALOG
	SYSTEM_DLL_ICOMPONENT
	IDISPOSABLE

create
	make_winforms_page_setup_dialog

feature {NONE} -- Initialization

	frozen make_winforms_page_setup_dialog is
		external
			"IL creator use System.Windows.Forms.PageSetupDialog"
		end

feature -- Access

	frozen get_printer_settings: DRAWING_PRINTER_SETTINGS is
		external
			"IL signature (): System.Drawing.Printing.PrinterSettings use System.Windows.Forms.PageSetupDialog"
		alias
			"get_PrinterSettings"
		end

	frozen get_page_settings: DRAWING_PAGE_SETTINGS is
		external
			"IL signature (): System.Drawing.Printing.PageSettings use System.Windows.Forms.PageSetupDialog"
		alias
			"get_PageSettings"
		end

	frozen get_min_margins: DRAWING_MARGINS is
		external
			"IL signature (): System.Drawing.Printing.Margins use System.Windows.Forms.PageSetupDialog"
		alias
			"get_MinMargins"
		end

	frozen get_show_network: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.PageSetupDialog"
		alias
			"get_ShowNetwork"
		end

	frozen get_allow_margins: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.PageSetupDialog"
		alias
			"get_AllowMargins"
		end

	frozen get_allow_printer: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.PageSetupDialog"
		alias
			"get_AllowPrinter"
		end

	frozen get_document: DRAWING_PRINT_DOCUMENT is
		external
			"IL signature (): System.Drawing.Printing.PrintDocument use System.Windows.Forms.PageSetupDialog"
		alias
			"get_Document"
		end

	frozen get_allow_orientation: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.PageSetupDialog"
		alias
			"get_AllowOrientation"
		end

	frozen get_show_help: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.PageSetupDialog"
		alias
			"get_ShowHelp"
		end

	frozen get_allow_paper: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.PageSetupDialog"
		alias
			"get_AllowPaper"
		end

feature -- Element Change

	frozen set_allow_printer (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Windows.Forms.PageSetupDialog"
		alias
			"set_AllowPrinter"
		end

	frozen set_printer_settings (value: DRAWING_PRINTER_SETTINGS) is
		external
			"IL signature (System.Drawing.Printing.PrinterSettings): System.Void use System.Windows.Forms.PageSetupDialog"
		alias
			"set_PrinterSettings"
		end

	frozen set_show_network (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Windows.Forms.PageSetupDialog"
		alias
			"set_ShowNetwork"
		end

	frozen set_min_margins (value: DRAWING_MARGINS) is
		external
			"IL signature (System.Drawing.Printing.Margins): System.Void use System.Windows.Forms.PageSetupDialog"
		alias
			"set_MinMargins"
		end

	frozen set_allow_paper (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Windows.Forms.PageSetupDialog"
		alias
			"set_AllowPaper"
		end

	frozen set_show_help (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Windows.Forms.PageSetupDialog"
		alias
			"set_ShowHelp"
		end

	frozen set_document (value: DRAWING_PRINT_DOCUMENT) is
		external
			"IL signature (System.Drawing.Printing.PrintDocument): System.Void use System.Windows.Forms.PageSetupDialog"
		alias
			"set_Document"
		end

	frozen set_allow_margins (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Windows.Forms.PageSetupDialog"
		alias
			"set_AllowMargins"
		end

	frozen set_allow_orientation (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Windows.Forms.PageSetupDialog"
		alias
			"set_AllowOrientation"
		end

	frozen set_page_settings (value: DRAWING_PAGE_SETTINGS) is
		external
			"IL signature (System.Drawing.Printing.PageSettings): System.Void use System.Windows.Forms.PageSetupDialog"
		alias
			"set_PageSettings"
		end

feature -- Basic Operations

	reset is
		external
			"IL signature (): System.Void use System.Windows.Forms.PageSetupDialog"
		alias
			"Reset"
		end

feature {NONE} -- Implementation

	run_dialog (hwnd_owner: POINTER): BOOLEAN is
		external
			"IL signature (System.IntPtr): System.Boolean use System.Windows.Forms.PageSetupDialog"
		alias
			"RunDialog"
		end

end -- class WINFORMS_PAGE_SETUP_DIALOG
