indexing
	Generator: "Eiffel Emitter 2.4b2"
	external_name: "ISE.Reflection.UndefineClause"

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

	UndefineKeyword: STRING is
		external
			"IL signature (): System.String use ISE.Reflection.UndefineClause"
		alias
			"UndefineKeyword"
		end

	ToString: STRING is
		external
			"IL signature (): System.String use ISE.Reflection.UndefineClause"
		alias
			"ToString"
		end

	EiffelKeyword: STRING is
		external
			"IL signature (): System.String use ISE.Reflection.UndefineClause"
		alias
			"EiffelKeyword"
		end

end -- class ISE_REFLECTION_UNDEFINECLAUSE
