indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Drawing.Printing.PrinterSettings"
	assembly: "System.Drawing", "1.0.3300.0", "neutral", "b03f5f7f11d5a3a"

external class
	DRAWING_PRINTER_SETTINGS

inherit
	SYSTEM_OBJECT
		redefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end
	ICLONEABLE

create
	make

feature {NONE} -- Initialization

	frozen make is
		external
			"IL creator use System.Drawing.Printing.PrinterSettings"
		end

feature -- Access

	frozen get_is_plotter: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Drawing.Printing.PrinterSettings"
		alias
			"get_IsPlotter"
		end

	frozen get_print_range: DRAWING_PRINT_RANGE is
		external
			"IL signature (): System.Drawing.Printing.PrintRange use System.Drawing.Printing.PrinterSettings"
		alias
			"get_PrintRange"
		end

	frozen get_paper_sources: DRAWING_PAPER_SOURCE_COLLECTION_IN_DRAWING_PRINTER_SETTINGS is
		external
			"IL signature (): System.Drawing.Printing.PrinterSettings+PaperSourceCollection use System.Drawing.Printing.PrinterSettings"
		alias
			"get_PaperSources"
		end

	frozen get_from_page: INTEGER is
		external
			"IL signature (): System.Int32 use System.Drawing.Printing.PrinterSettings"
		alias
			"get_FromPage"
		end

	frozen get_copies: INTEGER_16 is
		external
			"IL signature (): System.Int16 use System.Drawing.Printing.PrinterSettings"
		alias
			"get_Copies"
		end

	frozen get_collate: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Drawing.Printing.PrinterSettings"
		alias
			"get_Collate"
		end

	frozen get_maximum_copies: INTEGER is
		external
			"IL signature (): System.Int32 use System.Drawing.Printing.PrinterSettings"
		alias
			"get_MaximumCopies"
		end

	frozen get_duplex: DRAWING_DUPLEX is
		external
			"IL signature (): System.Drawing.Printing.Duplex use System.Drawing.Printing.PrinterSettings"
		alias
			"get_Duplex"
		end

	frozen get_can_duplex: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Drawing.Printing.PrinterSettings"
		alias
			"get_CanDuplex"
		end

	frozen get_supports_color: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Drawing.Printing.PrinterSettings"
		alias
			"get_SupportsColor"
		end

	frozen get_to_page: INTEGER is
		external
			"IL signature (): System.Int32 use System.Drawing.Printing.PrinterSettings"
		alias
			"get_ToPage"
		end

	frozen get_is_valid: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Drawing.Printing.PrinterSettings"
		alias
			"get_IsValid"
		end

	frozen get_maximum_page: INTEGER is
		external
			"IL signature (): System.Int32 use System.Drawing.Printing.PrinterSettings"
		alias
			"get_MaximumPage"
		end

	frozen get_paper_sizes: DRAWING_PAPER_SIZE_COLLECTION_IN_DRAWING_PRINTER_SETTINGS is
		external
			"IL signature (): System.Drawing.Printing.PrinterSettings+PaperSizeCollection use System.Drawing.Printing.PrinterSettings"
		alias
			"get_PaperSizes"
		end

	frozen get_printer_resolutions: DRAWING_PRINTER_RESOLUTION_COLLECTION_IN_DRAWING_PRINTER_SETTINGS is
		external
			"IL signature (): System.Drawing.Printing.PrinterSettings+PrinterResolutionCollection use System.Drawing.Printing.PrinterSettings"
		alias
			"get_PrinterResolutions"
		end

	frozen get_landscape_angle: INTEGER is
		external
			"IL signature (): System.Int32 use System.Drawing.Printing.PrinterSettings"
		alias
			"get_LandscapeAngle"
		end

	frozen get_print_to_file: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Drawing.Printing.PrinterSettings"
		alias
			"get_PrintToFile"
		end

	frozen get_installed_printers: DRAWING_STRING_COLLECTION_IN_DRAWING_PRINTER_SETTINGS is
		external
			"IL static signature (): System.Drawing.Printing.PrinterSettings+StringCollection use System.Drawing.Printing.PrinterSettings"
		alias
			"get_InstalledPrinters"
		end

	frozen get_printer_name: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Drawing.Printing.PrinterSettings"
		alias
			"get_PrinterName"
		end

	frozen get_is_default_printer: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Drawing.Printing.PrinterSettings"
		alias
			"get_IsDefaultPrinter"
		end

	frozen get_minimum_page: INTEGER is
		external
			"IL signature (): System.Int32 use System.Drawing.Printing.PrinterSettings"
		alias
			"get_MinimumPage"
		end

	frozen get_default_page_settings: DRAWING_PAGE_SETTINGS is
		external
			"IL signature (): System.Drawing.Printing.PageSettings use System.Drawing.Printing.PrinterSettings"
		alias
			"get_DefaultPageSettings"
		end

feature -- Element Change

	frozen set_duplex (value: DRAWING_DUPLEX) is
		external
			"IL signature (System.Drawing.Printing.Duplex): System.Void use System.Drawing.Printing.PrinterSettings"
		alias
			"set_Duplex"
		end

	frozen set_printer_name (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Drawing.Printing.PrinterSettings"
		alias
			"set_PrinterName"
		end

	frozen set_collate (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Drawing.Printing.PrinterSettings"
		alias
			"set_Collate"
		end

	frozen set_to_page (value: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.Drawing.Printing.PrinterSettings"
		alias
			"set_ToPage"
		end

	frozen set_maximum_page (value: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.Drawing.Printing.PrinterSettings"
		alias
			"set_MaximumPage"
		end

	frozen set_from_page (value: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.Drawing.Printing.PrinterSettings"
		alias
			"set_FromPage"
		end

	frozen set_copies (value: INTEGER_16) is
		external
			"IL signature (System.Int16): System.Void use System.Drawing.Printing.PrinterSettings"
		alias
			"set_Copies"
		end

	frozen set_minimum_page (value: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.Drawing.Printing.PrinterSettings"
		alias
			"set_MinimumPage"
		end

	frozen set_print_to_file (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Drawing.Printing.PrinterSettings"
		alias
			"set_PrintToFile"
		end

	frozen set_print_range (value: DRAWING_PRINT_RANGE) is
		external
			"IL signature (System.Drawing.Printing.PrintRange): System.Void use System.Drawing.Printing.PrinterSettings"
		alias
			"set_PrintRange"
		end

feature -- Basic Operations

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Drawing.Printing.PrinterSettings"
		alias
			"ToString"
		end

	frozen set_hdevnames (hdevnames: POINTER) is
		external
			"IL signature (System.IntPtr): System.Void use System.Drawing.Printing.PrinterSettings"
		alias
			"SetHdevnames"
		end

	frozen get_hdevmode: POINTER is
		external
			"IL signature (): System.IntPtr use System.Drawing.Printing.PrinterSettings"
		alias
			"GetHdevmode"
		end

	frozen clone_: SYSTEM_OBJECT is
		external
			"IL signature (): System.Object use System.Drawing.Printing.PrinterSettings"
		alias
			"Clone"
		end

	frozen get_hdevnames: POINTER is
		external
			"IL signature (): System.IntPtr use System.Drawing.Printing.PrinterSettings"
		alias
			"GetHdevnames"
		end

	frozen create_measurement_graphics: DRAWING_GRAPHICS is
		external
			"IL signature (): System.Drawing.Graphics use System.Drawing.Printing.PrinterSettings"
		alias
			"CreateMeasurementGraphics"
		end

	frozen set_hdevmode (hdevmode: POINTER) is
		external
			"IL signature (System.IntPtr): System.Void use System.Drawing.Printing.PrinterSettings"
		alias
			"SetHdevmode"
		end

	equals (obj: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Drawing.Printing.PrinterSettings"
		alias
			"Equals"
		end

	frozen get_hdevmode_page_settings (page_settings: DRAWING_PAGE_SETTINGS): POINTER is
		external
			"IL signature (System.Drawing.Printing.PageSettings): System.IntPtr use System.Drawing.Printing.PrinterSettings"
		alias
			"GetHdevmode"
		end

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.Drawing.Printing.PrinterSettings"
		alias
			"GetHashCode"
		end

feature {NONE} -- Implementation

	finalize is
		external
			"IL signature (): System.Void use System.Drawing.Printing.PrinterSettings"
		alias
			"Finalize"
		end

end -- class DRAWING_PRINTER_SETTINGS
