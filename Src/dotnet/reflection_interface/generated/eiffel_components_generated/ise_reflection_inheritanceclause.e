indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "ISE.Reflection.InheritanceClause"

deferred external class
	ISE_REFLECTION_INHERITANCECLAUSE

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
