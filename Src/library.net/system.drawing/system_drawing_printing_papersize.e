indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Drawing.Printing.PaperSize"

external class
	SYSTEM_DRAWING_PRINTING_PAPERSIZE

inherit
	ANY
		redefine
			to_string
		end

create
	make

feature {NONE} -- Initialization

	frozen make (name: STRING; width: INTEGER; height: INTEGER) is
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

	frozen get_paper_name: STRING is
		external
			"IL signature (): System.String use System.Drawing.Printing.PaperSize"
		alias
			"get_PaperName"
		end

	frozen get_kind: SYSTEM_DRAWING_PRINTING_PAPERKIND is
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

	frozen set_paper_name (value: STRING) is
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

	to_string: STRING is
		external
			"IL signature (): System.String use System.Drawing.Printing.PaperSize"
		alias
			"ToString"
		end

end -- class SYSTEM_DRAWING_PRINTING_PAPERSIZE
