indexing
	Generator: "Eiffel Emitter 2.3b"
	external_name: "ISE.Reflection.InheritanceClause"

deferred external class
	ISE_REFLECTION_INHERITANCECLAUSE

inherit
	ANY
		undefine
			ToString
		end

feature -- Access

	frozen SourceName: STRING is
		external
			"IL field signature :System.String use ISE.Reflection.InheritanceClause"
		alias
			"SourceName"
		end

feature -- Basic Operations

	Make (a_source_name: STRING) is
		external
			"IL signature (System.String): System.Void use ISE.Reflection.InheritanceClause"
		alias
			"Make"
		end

	SetSourceName (a_source_name: STRING) is
		external
			"IL signature (System.String): System.Void use ISE.Reflection.InheritanceClause"
		alias
			"SetSourceName"
		end

	ToString: STRING is
		external
			"IL deferred signature (): System.String use ISE.Reflection.InheritanceClause"
		alias
			"ToString"
		end

	EiffelKeyword: STRING is
		external
			"IL deferred signature (): System.String use ISE.Reflection.InheritanceClause"
		alias
			"EiffelKeyword"
		end

end -- class ISE_REFLECTION_INHERITANCECLAUSE
