indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "ISE.Reflection.RenameClause"

external class
	ISE_REFLECTION_RENAMECLAUSE

inherit
	ISE_REFLECTION_INHERITANCECLAUSE

create
	make_renameclause

feature {NONE} -- Initialization

	frozen make_renameclause is
		external
			"IL creator use ISE.Reflection.RenameClause"
		end

feature -- Access

	frozen a_internal_target_name: STRING is
		external
			"IL field signature :System.String use ISE.Reflection.RenameClause"
		alias
			"_internal_TargetName"
		end

	get_target_name: STRING is
		external
			"IL signature (): System.String use ISE.Reflection.RenameClause"
		alias
			"get_TargetName"
		end

feature -- Basic Operations

	equals_rename_clause (obj: ISE_REFLECTION_RENAMECLAUSE): BOOLEAN is
		external
			"IL signature (ISE.Reflection.RenameClause): System.Boolean use ISE.Reflection.RenameClause"
		alias
			"Equals"
		end

	space: STRING is
		external
			"IL signature (): System.String use ISE.Reflection.RenameClause"
		alias
			"Space"
		end

	make_from_info (a_source_name: STRING; a_target_name: STRING) is
		external
			"IL signature (System.String, System.String): System.Void use ISE.Reflection.RenameClause"
		alias
			"MakeFromInfo"
		end

	string_representation: STRING is
		external
			"IL signature (): System.String use ISE.Reflection.RenameClause"
		alias
			"StringRepresentation"
		end

	set_target_name (a_target_name: STRING) is
		external
			"IL signature (System.String): System.Void use ISE.Reflection.RenameClause"
		alias
			"SetTargetName"
		end

	rename_keyword: STRING is
		external
			"IL signature (): System.String use ISE.Reflection.RenameClause"
		alias
			"RenameKeyword"
		end

	eiffel_keyword: STRING is
		external
			"IL signature (): System.String use ISE.Reflection.RenameClause"
		alias
			"EiffelKeyword"
		end

	as_keyword: STRING is
		external
			"IL signature (): System.String use ISE.Reflection.RenameClause"
		alias
			"AsKeyword"
		end

end -- class ISE_REFLECTION_RENAMECLAUSE
