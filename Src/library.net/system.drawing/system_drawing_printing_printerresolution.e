indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Drawing.Printing.PrinterResolution"

external class
	SYSTEM_DRAWING_PRINTING_PRINTERRESOLUTION

inherit
	ANY
		redefine
			to_string
		end

create {NONE}

feature -- Access

	frozen get_kind: SYSTEM_DRAWING_PRINTING_PRINTERRESOLUTIONKIND is
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

	to_string: STRING is
		external
			"IL signature (): System.String use System.Drawing.Printing.PrinterResolution"
		alias
			"ToString"
		end

end -- class SYSTEM_DRAWING_PRINTING_PRINTERRESOLUTION
