indexing
	generator: "Eiffel Emitter 2.8b2"
	external_name: "ISE.Reflection.InheritanceClause"
	assembly: "ISE.Reflection.EiffelComponents", "0.0.0.0", "neutral", "2dffe28036ebcb3"

deferred external class
	ISE_REFLECTION_INHERITANCECLAUSE

inherit
	ANY
		redefine
			is_equal
		end

feature -- Access

	get_source_name: STRING is
		external
			"IL signature (): System.String use ISE.Reflection.InheritanceClause"
		alias
			"get_SourceName"
		end

	frozen a_internal_source_name: STRING is
		external
			"IL field signature :System.String use ISE.Reflection.InheritanceClause"
		alias
			"_internal_SourceName"
		end

feature -- Basic Operations

	eiffel_keyword: STRING is
		external
			"IL deferred signature (): System.String use ISE.Reflection.InheritanceClause"
		alias
			"EiffelKeyword"
		end

	string_representation: STRING is
		external
			"IL deferred signature (): System.String use ISE.Reflection.InheritanceClause"
		alias
			"StringRepresentation"
		end

	is_equal (obj: ANY): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use ISE.Reflection.InheritanceClause"
		alias
			"Equals"
		end

	frozen a_invariant (current_object: ISE_REFLECTION_INHERITANCECLAUSE) is
		external
			"IL static signature (ISE.Reflection.InheritanceClause): System.Void use ISE.Reflection.InheritanceClause"
		alias
			"_invariant"
		end

	set_source_name (a_source_name: STRING) is
		external
			"IL signature (System.String): System.Void use ISE.Reflection.InheritanceClause"
		alias
			"SetSourceName"
		end

end -- class ISE_REFLECTION_INHERITANCECLAUSE
