indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Drawing.Printing.PageSettings"

external class
	SYSTEM_DRAWING_PRINTING_PAGESETTINGS

inherit
	ANY
		redefine
			finalize,
			get_hash_code,
			is_equal,
			to_string
		end
	SYSTEM_ICLONEABLE

create
	make,
	make_1

feature {NONE} -- Initialization

	frozen make is
		external
			"IL creator use System.Drawing.Printing.PageSettings"
		end

	frozen make_1 (printer_settings: SYSTEM_DRAWING_PRINTING_PRINTERSETTINGS) is
		external
			"IL creator signature (System.Drawing.Printing.PrinterSettings) use System.Drawing.Printing.PageSettings"
		end

feature -- Access

	frozen get_printer_settings: SYSTEM_DRAWING_PRINTING_PRINTERSETTINGS is
		external
			"IL signature (): System.Drawing.Printing.PrinterSettings use System.Drawing.Printing.PageSettings"
		alias
			"get_PrinterSettings"
		end

	frozen get_paper_size: SYSTEM_DRAWING_PRINTING_PAPERSIZE is
		external
			"IL signature (): System.Drawing.Printing.PaperSize use System.Drawing.Printing.PageSettings"
		alias
			"get_PaperSize"
		end

	frozen get_printer_resolution: SYSTEM_DRAWING_PRINTING_PRINTERRESOLUTION is
		external
			"IL signature (): System.Drawing.Printing.PrinterResolution use System.Drawing.Printing.PageSettings"
		alias
			"get_PrinterResolution"
		end

	frozen get_margins: SYSTEM_DRAWING_PRINTING_MARGINS is
		external
			"IL signature (): System.Drawing.Printing.Margins use System.Drawing.Printing.PageSettings"
		alias
			"get_Margins"
		end

	frozen get_bounds: SYSTEM_DRAWING_RECTANGLE is
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

	frozen get_paper_source: SYSTEM_DRAWING_PRINTING_PAPERSOURCE is
		external
			"IL signature (): System.Drawing.Printing.PaperSource use System.Drawing.Printing.PageSettings"
		alias
			"get_PaperSource"
		end

feature -- Element Change

	frozen set_margins (value: SYSTEM_DRAWING_PRINTING_MARGINS) is
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

	frozen set_paper_size (value: SYSTEM_DRAWING_PRINTING_PAPERSIZE) is
		external
			"IL signature (System.Drawing.Printing.PaperSize): System.Void use System.Drawing.Printing.PageSettings"
		alias
			"set_PaperSize"
		end

	frozen set_printer_settings (value: SYSTEM_DRAWING_PRINTING_PRINTERSETTINGS) is
		external
			"IL signature (System.Drawing.Printing.PrinterSettings): System.Void use System.Drawing.Printing.PageSettings"
		alias
			"set_PrinterSettings"
		end

	frozen set_paper_source (value: SYSTEM_DRAWING_PRINTING_PAPERSOURCE) is
		external
			"IL signature (System.Drawing.Printing.PaperSource): System.Void use System.Drawing.Printing.PageSettings"
		alias
			"set_PaperSource"
		end

	frozen set_printer_resolution (value: SYSTEM_DRAWING_PRINTING_PRINTERRESOLUTION) is
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

	frozen clone: ANY is
		external
			"IL signature (): System.Object use System.Drawing.Printing.PageSettings"
		alias
			"Clone"
		end

	to_string: STRING is
		external
			"IL signature (): System.String use System.Drawing.Printing.PageSettings"
		alias
			"ToString"
		end

	is_equal (obj: ANY): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Drawing.Printing.PageSettings"
		alias
			"Equals"
		end

	frozen set_hdevmode (hdevmode: POINTER) is
		external
			"IL signature (System.IntPtr): System.Void use System.Drawing.Printing.PageSettings"
		alias
			"SetHdevmode"
		end

feature {NONE} -- Implementation

	finalize is
		external
			"IL signature (): System.Void use System.Drawing.Printing.PageSettings"
		alias
			"Finalize"
		end

end -- class SYSTEM_DRAWING_PRINTING_PAGESETTINGS
