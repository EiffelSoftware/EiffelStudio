indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Drawing.Printing.PaperSource"

external class
	SYSTEM_DRAWING_PRINTING_PAPERSOURCE

inherit
	ANY
		redefine
			to_string
		end

create {NONE}

feature -- Access

	frozen get_kind: SYSTEM_DRAWING_PRINTING_PAPERSOURCEKIND is
		external
			"IL signature (): System.Drawing.Printing.PaperSourceKind use System.Drawing.Printing.PaperSource"
		alias
			"get_Kind"
		end

	frozen get_source_name: STRING is
		external
			"IL signature (): System.String use System.Drawing.Printing.PaperSource"
		alias
			"get_SourceName"
		end

feature -- Basic Operations

	to_string: STRING is
		external
			"IL signature (): System.String use System.Drawing.Printing.PaperSource"
		alias
			"ToString"
		end

end -- class SYSTEM_DRAWING_PRINTING_PAPERSOURCE
