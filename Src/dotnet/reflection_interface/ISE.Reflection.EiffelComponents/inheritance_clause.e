indexing
	description: "Representation of an inheritance clause"
	external_name: "ISE.Reflection.InheritanceClause"
	attribute: create {SYSTEM_RUNTIME_INTEROPSERVICES_CLASSINTERFACEATTRIBUTE}.make_classinterfaceattribute ((create {SYSTEM_RUNTIME_INTEROPSERVICES_CLASSINTERFACETYPE}).auto_dual) end

deferred class
 	INHERITANCE_CLAUSE

inherit
	ANY
		redefine
			is_equal
		end
 
 feature -- Access
 
 	source_name: STRING
 		indexing
 			description: "Source name"
 			external_name: "SourceName"
 		end

	eiffel_keyword: STRING is
		indexing
			description: "Eiffel keyword for inheritance clause"
			external_name: "EiffelKeyword"
		deferred		
		ensure
			non_void_eiffel_keyword: Result /= Void
			not_empty_eiffel_keyword: Result.get_length > 0
		end

feature -- Status Report

	is_equal (obj: ANY): BOOLEAN is
		indexing
			description: "Is Current equals to `obj'?"
			external_name: "Equals"
		local
			a_clause: INHERITANCE_CLAUSE
		do
			a_clause ?= obj
			if a_clause /= Void then
				Result := source_name.to_lower.equals_string (a_clause.source_name.to_lower)
			end
		end
		
feature -- Status Setting

	set_source_name (a_source_name: like source_name) is
		indexing
			description: "Set `source_name' with `a_source_name'."
			external_name: "SetSourceName"
 		require
 			non_void_source_name: a_source_name /= Void
 			not_empty_source_name: a_source_name.get_length > 0
 		do
  			source_name := a_source_name
 		ensure
 			source_name_set: source_name.equals_string (a_source_name)
 		end
			
feature -- Basic Operations

	string_representation: STRING is
		indexing
			description: "Give a string representation of the inheritance clause."
			external_name: "StringRepresentation"
		require
			non_void_source_name: source_name /= Void
		deferred
		ensure
			non_void_result: Result /= Void
			not_empty_result: Result.get_length > 0
		end
		
invariant
	source_name_not_void: source_name /= Void
	eiffel_keyword_not_void: eiffel_keyword /= Void

 end -- class INHERITANCE_CLAUSE
 
