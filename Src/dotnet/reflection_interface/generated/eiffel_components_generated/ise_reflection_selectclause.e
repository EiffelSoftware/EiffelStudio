indexing
	Generator: "Eiffel Emitter 2.3b"
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

	SelectKeyword: STRING is
		external
			"IL signature (): System.String use ISE.Reflection.SelectClause"
		alias
			"SelectKeyword"
		end

	ToString: STRING is
		external
			"IL signature (): System.String use ISE.Reflection.SelectClause"
		alias
			"ToString"
		end

	EiffelKeyword: STRING is
		external
			"IL signature (): System.String use ISE.Reflection.SelectClause"
		alias
			"EiffelKeyword"
		end

end -- class ISE_REFLECTION_SELECTCLAUSE
