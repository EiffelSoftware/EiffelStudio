indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Drawing.Printing.PaperSource"
	assembly: "System.Drawing", "1.0.3300.0", "neutral", "b03f5f7f11d5a3a"

external class
	DRAWING_PAPER_SOURCE

inherit
	SYSTEM_OBJECT
		redefine
			to_string
		end

create {NONE}

feature -- Access

	frozen get_kind: DRAWING_PAPER_SOURCE_KIND is
		external
			"IL signature (): System.Drawing.Printing.PaperSourceKind use System.Drawing.Printing.PaperSource"
		alias
			"get_Kind"
		end

	frozen get_source_name: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Drawing.Printing.PaperSource"
		alias
			"get_SourceName"
		end

feature -- Basic Operations

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Drawing.Printing.PaperSource"
		alias
			"ToString"
		end

end -- class DRAWING_PAPER_SOURCE
