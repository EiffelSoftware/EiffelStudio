indexing
	Generator: "Eiffel Emitter 2.6b2"
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
			"ExportationList"
		end

feature -- Basic Operations

	add_exportation (a_class_name: STRING) is
		external
			"IL signature (System.String): System.Void use ISE.Reflection.ExportClause"
		alias
			"AddExportation"
		end

	closing_curl_bracket: STRING is
		external
			"IL signature (): System.String use ISE.Reflection.ExportClause"
		alias
			"ClosingCurlBracket"
		end

	space: STRING is
		external
			"IL signature (): System.String use ISE.Reflection.ExportClause"
		alias
			"Space"
		end

	set_exportation_list (a_list: SYSTEM_COLLECTIONS_ARRAYLIST) is
		external
			"IL signature (System.Collections.ArrayList): System.Void use ISE.Reflection.ExportClause"
		alias
			"SetExportationList"
		end

	string_representation: STRING is
		external
			"IL signature (): System.String use ISE.Reflection.ExportClause"
		alias
			"StringRepresentation"
		end

	opening_curl_bracket: STRING is
		external
			"IL signature (): System.String use ISE.Reflection.ExportClause"
		alias
			"OpeningCurlBracket"
		end

	comma: STRING is
		external
			"IL signature (): System.String use ISE.Reflection.ExportClause"
		alias
			"Comma"
		end

	eiffel_keyword: STRING is
		external
			"IL signature (): System.String use ISE.Reflection.ExportClause"
		alias
			"EiffelKeyword"
		end

	export_keyword: STRING is
		external
			"IL signature (): System.String use ISE.Reflection.ExportClause"
		alias
			"ExportKeyword"
		end

end -- class ISE_REFLECTION_EXPORTCLAUSE
