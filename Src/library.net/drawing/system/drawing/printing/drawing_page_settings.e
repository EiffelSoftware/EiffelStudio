indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Drawing.Printing.PageSettings"
	assembly: "System.Drawing", "1.0.3300.0", "neutral", "b03f5f7f11d5a3a"

external class
	DRAWING_PAGE_SETTINGS

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
	make,
	make_1

feature {NONE} -- Initialization

	frozen make is
		external
			"IL creator use System.Drawing.Printing.PageSettings"
		end

	frozen make_1 (printer_settings: DRAWING_PRINTER_SETTINGS) is
		external
			"IL creator signature (System.Drawing.Printing.PrinterSettings) use System.Drawing.Printing.PageSettings"
		end

feature -- Access

	frozen get_printer_settings: DRAWING_PRINTER_SETTINGS is
		external
			"IL signature (): System.Drawing.Printing.PrinterSettings use System.Drawing.Printing.PageSettings"
		alias
			"get_PrinterSettings"
		end

	frozen get_paper_size: DRAWING_PAPER_SIZE is
		external
			"IL signature (): System.Drawing.Printing.PaperSize use System.Drawing.Printing.PageSettings"
		alias
			"get_PaperSize"
		end

	frozen get_printer_resolution: DRAWING_PRINTER_RESOLUTION is
		external
			"IL signature (): System.Drawing.Printing.PrinterResolution use System.Drawing.Printing.PageSettings"
		alias
			"get_PrinterResolution"
		end

	frozen get_margins: DRAWING_MARGINS is
		external
			"IL signature (): System.Drawing.Printing.Margins use System.Drawing.Printing.PageSettings"
		alias
			"get_Margins"
		end

	frozen get_bounds: DRAWING_RECTANGLE is
		external
			"IL signature (): System.Drawing.Rectangle use System.Drawing.Printing.PageSettings"
		alias
			"get_Bounds"
		end

	frozen get_landscape: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Drawing.Printing.PageSettings"
		alias
			"get_Landscape"
		end

	frozen get_color: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Drawing.Printing.PageSettings"
		alias
			"get_Color"
		end

	frozen get_paper_source: DRAWING_PAPER_SOURCE is
		external
			"IL signature (): System.Drawing.Printing.PaperSource use System.Drawing.Printing.PageSettings"
		alias
			"get_PaperSource"
		end

feature -- Element Change

	frozen set_margins (value: DRAWING_MARGINS) is
		external
			"IL signature (System.Drawing.Printing.Margins): System.Void use System.Drawing.Printing.PageSettings"
		alias
			"set_Margins"
		end

	frozen set_landscape (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Drawing.Printing.PageSettings"
		alias
			"set_Landscape"
		end

	frozen set_paper_size (value: DRAWING_PAPER_SIZE) is
		external
			"IL signature (System.Drawing.Printing.PaperSize): System.Void use System.Drawing.Printing.PageSettings"
		alias
			"set_PaperSize"
		end

	frozen set_printer_settings (value: DRAWING_PRINTER_SETTINGS) is
		external
			"IL signature (System.Drawing.Printing.PrinterSettings): System.Void use System.Drawing.Printing.PageSettings"
		alias
			"set_PrinterSettings"
		end

	frozen set_paper_source (value: DRAWING_PAPER_SOURCE) is
		external
			"IL signature (System.Drawing.Printing.PaperSource): System.Void use System.Drawing.Printing.PageSettings"
		alias
			"set_PaperSource"
		end

	frozen set_printer_resolution (value: DRAWING_PRINTER_RESOLUTION) is
		external
			"IL signature (System.Drawing.Printing.PrinterResolution): System.Void use System.Drawing.Printing.PageSettings"
		alias
			"set_PrinterResolution"
		end

	frozen set_color (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Drawing.Printing.PageSettings"
		alias
			"set_Color"
		end

feature -- Basic Operations

	frozen copy_to_hdevmode (hdevmode: POINTER) is
		external
			"IL signature (System.IntPtr): System.Void use System.Drawing.Printing.PageSettings"
		alias
			"CopyToHdevmode"
		end

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.Drawing.Printing.PageSettings"
		alias
			"GetHashCode"
		end

	frozen set_hdevmode (hdevmode: POINTER) is
		external
			"IL signature (System.IntPtr): System.Void use System.Drawing.Printing.PageSettings"
		alias
			"SetHdevmode"
		end

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Drawing.Printing.PageSettings"
		alias
			"ToString"
		end

	frozen clone_: SYSTEM_OBJECT is
		external
			"IL signature (): System.Object use System.Drawing.Printing.PageSettings"
		alias
			"Clone"
		end

	equals (obj: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Drawing.Printing.PageSettings"
		alias
			"Equals"
		end

feature {NONE} -- Implementation

	finalize is
		external
			"IL signature (): System.Void use System.Drawing.Printing.PageSettings"
		alias
			"Finalize"
		end

end -- class DRAWING_PAGE_SETTINGS
