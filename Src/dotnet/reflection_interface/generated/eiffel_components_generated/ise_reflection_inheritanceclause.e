indexing
	Generator: "Eiffel Emitter 2.6b2"
	external_name: "ISE.Reflection.InheritanceClause"
deferred external class
	ISE_REFLECTION_INHERITANCECLAUSE

feature -- Access

	frozen source_name: STRING is
		external
			"IL field signature :System.String use ISE.Reflection.InheritanceClause"
		alias
			"SourceName"
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

	make (a_source_name: STRING) is
		external
			"IL signature (System.String): System.Void use ISE.Reflection.InheritanceClause"
		alias
			"Make"
		end

	set_source_name (a_source_name: STRING) is
		external
			"IL signature (System.String): System.Void use ISE.Reflection.InheritanceClause"
		alias
			"SetSourceName"
		end

end -- class ISE_REFLECTION_INHERITANCECLAUSE
