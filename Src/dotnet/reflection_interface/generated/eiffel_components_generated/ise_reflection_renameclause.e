indexing
	Generator: "Eiffel Emitter 2.4b2"
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

	frozen TargetName: STRING is
		external
			"IL field signature :System.String use ISE.Reflection.RenameClause"
		alias
			"TargetName"
		end

feature -- Basic Operations

	Space: STRING is
		external
			"IL signature (): System.String use ISE.Reflection.RenameClause"
		alias
			"Space"
		end

	SetTargetName (a_target_name: STRING) is
		external
			"IL signature (System.String): System.Void use ISE.Reflection.RenameClause"
		alias
			"SetTargetName"
		end

	MakeFromInfo (a_source_name: STRING; a_target_name: STRING) is
		external
			"IL signature (System.String, System.String): System.Void use ISE.Reflection.RenameClause"
		alias
			"MakeFromInfo"
		end

	ToString: STRING is
		external
			"IL signature (): System.String use ISE.Reflection.RenameClause"
		alias
			"ToString"
		end

	RenameKeyword: STRING is
		external
			"IL signature (): System.String use ISE.Reflection.RenameClause"
		alias
			"RenameKeyword"
		end

	AsKeyword: STRING is
		external
			"IL signature (): System.String use ISE.Reflection.RenameClause"
		alias
			"AsKeyword"
		end

	EiffelKeyword: STRING is
		external
			"IL signature (): System.String use ISE.Reflection.RenameClause"
		alias
			"EiffelKeyword"
		end

end -- class ISE_REFLECTION_RENAMECLAUSE
