indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "ISE.Reflection.SelectClause"

external class
	ISE_REFLECTION_SELECTCLAUSE

inherit
	ISE_REFLECTION_INHERITANCECLAUSE

create
	make_selectclause

feature {NONE} -- Initialization

	frozen make_selectclause is
		external
			"IL creator use ISE.Reflection.SelectClause"
		end

feature -- Basic Operations

	eiffel_keyword: STRING is
		external
			"IL signature (): System.String use ISE.Reflection.SelectClause"
		alias
			"EiffelKeyword"
		end

	select_keyword: STRING is
		external
			"IL signature (): System.String use ISE.Reflection.SelectClause"
		alias
			"SelectKeyword"
		end

	string_representation: STRING is
		external
			"IL signature (): System.String use ISE.Reflection.SelectClause"
		alias
			"StringRepresentation"
		end

end -- class ISE_REFLECTION_SELECTCLAUSE
