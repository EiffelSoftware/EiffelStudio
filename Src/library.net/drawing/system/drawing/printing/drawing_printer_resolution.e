indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Drawing.Printing.PrinterResolution"
	assembly: "System.Drawing", "1.0.3300.0", "neutral", "b03f5f7f11d5a3a"

external class
	DRAWING_PRINTER_RESOLUTION

inherit
	SYSTEM_OBJECT
		redefine
			to_string
		end

create {NONE}

feature -- Access

	frozen get_kind: DRAWING_PRINTER_RESOLUTION_KIND is
		external
			"IL signature (): System.Drawing.Printing.PrinterResolutionKind use System.Drawing.Printing.PrinterResolution"
		alias
			"get_Kind"
		end

	frozen get_y: INTEGER is
		external
			"IL signature (): System.Int32 use System.Drawing.Printing.PrinterResolution"
		alias
			"get_Y"
		end

	frozen get_x: INTEGER is
		external
			"IL signature (): System.Int32 use System.Drawing.Printing.PrinterResolution"
		alias
			"get_X"
		end

feature -- Basic Operations

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Drawing.Printing.PrinterResolution"
		alias
			"ToString"
		end

end -- class DRAWING_PRINTER_RESOLUTION
