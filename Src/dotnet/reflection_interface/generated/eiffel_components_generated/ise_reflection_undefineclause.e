indexing
	generator: "Eiffel Emitter 2.8b2"
	external_name: "ISE.Reflection.UndefineClause"
	assembly: "ISE.Reflection.EiffelComponents", "0.0.0.0", "neutral", "e0f9d13739fa815f"

external class
	ISE_REFLECTION_UNDEFINECLAUSE

inherit
	ISE_REFLECTION_INHERITANCECLAUSE

create
	make_undefineclause

feature {NONE} -- Initialization

	frozen make_undefineclause is
		external
			"IL creator use ISE.Reflection.UndefineClause"
		end

feature -- Basic Operations

	eiffel_keyword: STRING is
		external
			"IL signature (): System.String use ISE.Reflection.UndefineClause"
		alias
			"EiffelKeyword"
		end

	string_representation: STRING is
		external
			"IL signature (): System.String use ISE.Reflection.UndefineClause"
		alias
			"StringRepresentation"
		end

	undefine_keyword: STRING is
		external
			"IL signature (): System.String use ISE.Reflection.UndefineClause"
		alias
			"UndefineKeyword"
		end

end -- class ISE_REFLECTION_UNDEFINECLAUSE
