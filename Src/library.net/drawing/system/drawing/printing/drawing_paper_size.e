indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Drawing.Printing.PaperSize"
	assembly: "System.Drawing", "1.0.3300.0", "neutral", "b03f5f7f11d5a3a"

external class
	DRAWING_PAPER_SIZE

inherit
	SYSTEM_OBJECT
		redefine
			to_string
		end

create
	make

feature {NONE} -- Initialization

	frozen make (name: SYSTEM_STRING; width: INTEGER; height: INTEGER) is
		external
			"IL creator signature (System.String, System.Int32, System.Int32) use System.Drawing.Printing.PaperSize"
		end

feature -- Access

	frozen get_height: INTEGER is
		external
			"IL signature (): System.Int32 use System.Drawing.Printing.PaperSize"
		alias
			"get_Height"
		end

	frozen get_width: INTEGER is
		external
			"IL signature (): System.Int32 use System.Drawing.Printing.PaperSize"
		alias
			"get_Width"
		end

	frozen get_paper_name: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Drawing.Printing.PaperSize"
		alias
			"get_PaperName"
		end

	frozen get_kind: DRAWING_PAPER_KIND is
		external
			"IL signature (): System.Drawing.Printing.PaperKind use System.Drawing.Printing.PaperSize"
		alias
			"get_Kind"
		end

feature -- Element Change

	frozen set_height (value: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.Drawing.Printing.PaperSize"
		alias
			"set_Height"
		end

	frozen set_paper_name (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Drawing.Printing.PaperSize"
		alias
			"set_PaperName"
		end

	frozen set_width (value: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.Drawing.Printing.PaperSize"
		alias
			"set_Width"
		end

feature -- Basic Operations

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Drawing.Printing.PaperSize"
		alias
			"ToString"
		end

end -- class DRAWING_PAPER_SIZE
