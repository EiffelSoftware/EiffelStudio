indexing
	Generator: "Eiffel Emitter 2.3b"
	external_name: "ISE.Reflection.ExportClause"

external class
	ISE_REFLECTION_EXPORTCLAUSE

inherit
	ISE_REFLECTION_INHERITANCECLAUSE

create
	make_exportclause

feature {NONE} -- Initialization

	frozen make_exportclause is
		external
			"IL creator use ISE.Reflection.ExportClause"
		end

feature -- Access

	frozen exportation_list: SYSTEM_COLLECTIONS_ARRAYLIST is
		external
			"IL field signature :System.Collections.ArrayList use ISE.Reflection.ExportClause"
		alias
			"exportation_list"
		end

feature -- Basic Operations

	ClosingCurlBracket: STRING is
		external
			"IL signature (): System.String use ISE.Reflection.ExportClause"
		alias
			"ClosingCurlBracket"
		end

	AddExportation (a_class_name: STRING) is
		external
			"IL signature (System.String): System.Void use ISE.Reflection.ExportClause"
		alias
			"AddExportation"
		end

	EiffelKeyword: STRING is
		external
			"IL signature (): System.String use ISE.Reflection.ExportClause"
		alias
			"EiffelKeyword"
		end

	SetExportationList (a_list: SYSTEM_COLLECTIONS_ARRAYLIST) is
		external
			"IL signature (System.Collections.ArrayList): System.Void use ISE.Reflection.ExportClause"
		alias
			"SetExportationList"
		end

	Space: STRING is
		external
			"IL signature (): System.String use ISE.Reflection.ExportClause"
		alias
			"Space"
		end

	OpeningCurlBracket: STRING is
		external
			"IL signature (): System.String use ISE.Reflection.ExportClause"
		alias
			"OpeningCurlBracket"
		end

	ExportKeyword: STRING is
		external
			"IL signature (): System.String use ISE.Reflection.ExportClause"
		alias
			"ExportKeyword"
		end

	ToString: STRING is
		external
			"IL signature (): System.String use ISE.Reflection.ExportClause"
		alias
			"ToString"
		end

	Comma: STRING is
		external
			"IL signature (): System.String use ISE.Reflection.ExportClause"
		alias
			"Comma"
		end

end -- class ISE_REFLECTION_EXPORTCLAUSE
