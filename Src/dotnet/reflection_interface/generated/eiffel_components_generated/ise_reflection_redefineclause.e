indexing
	generator: "Eiffel Emitter 2.8b2"
	external_name: "ISE.Reflection.RedefineClause"
	assembly: "ISE.Reflection.EiffelComponents", "0.0.0.0", "neutral", "2dffe28036ebcb3"

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

	eiffel_keyword: STRING is
		external
			"IL signature (): System.String use ISE.Reflection.RedefineClause"
		alias
			"EiffelKeyword"
		end

	string_representation: STRING is
		external
			"IL signature (): System.String use ISE.Reflection.RedefineClause"
		alias
			"StringRepresentation"
		end

	redefine_keyword: STRING is
		external
			"IL signature (): System.String use ISE.Reflection.RedefineClause"
		alias
			"RedefineKeyword"
		end

end -- class ISE_REFLECTION_REDEFINECLAUSE
