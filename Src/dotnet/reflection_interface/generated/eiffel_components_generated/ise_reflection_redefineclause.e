indexing
	Generator: "Eiffel Emitter 2.3b"
	external_name: "ISE.Reflection.RedefineClause"

external class
	ISE_REFLECTION_REDEFINECLAUSE

inherit
	ISE_REFLECTION_INHERITANCECLAUSE

create
	make_redefineclause

feature {NONE} -- Initialization

	frozen make_redefineclause is
		external
			"IL creator use ISE.Reflection.RedefineClause"
		end

feature -- Basic Operations

	RedefineKeyword: STRING is
		external
			"IL signature (): System.String use ISE.Reflection.RedefineClause"
		alias
			"RedefineKeyword"
		end

	ToString: STRING is
		external
			"IL signature (): System.String use ISE.Reflection.RedefineClause"
		alias
			"ToString"
		end

	EiffelKeyword: STRING is
		external
			"IL signature (): System.String use ISE.Reflection.RedefineClause"
		alias
			"EiffelKeyword"
		end

end -- class ISE_REFLECTION_REDEFINECLAUSE
