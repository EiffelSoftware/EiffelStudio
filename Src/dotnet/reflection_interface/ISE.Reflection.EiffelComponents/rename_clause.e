indexing
	description: "Representation of a rename clause"
	external_name: "ISE.Reflection.RenameClause"
	attribute: create {SYSTEM_RUNTIME_INTEROPSERVICES_CLASSINTERFACEATTRIBUTE}.make_classinterfaceattribute ((create {SYSTEM_RUNTIME_INTEROPSERVICES_CLASSINTERFACETYPE}).auto_dual) end

class
	RENAME_CLAUSE
	
inherit
 	INHERITANCE_CLAUSE
 		redefine
 			is_equal
 		end
 
feature -- Access

	target_name: STRING 
		indexing
			description: "Target name"
			external_name: "TargetName"
		end

	eiffel_keyword: STRING is
		indexing
			description: "Eiffel keyword for inheritance clause"
			external_name: "EiffelKeyword"
		do
			Result := Rename_keyword
		end

	Rename_keyword: STRING is "rename"
		indexing
			description: "Rename keyword"
			external_name: "RenameKeyword"
		end
		
	As_keyword: STRING is "as"
		indexing
			description: "As keyword"
			external_name: "AsKeyword"
		end

	Space: STRING is " "
		indexing
			description: "Space"
			external_name: "Space"
		end

feature -- Status Report

	is_equal (obj: ANY): BOOLEAN is
		indexing
			description: "Is Current equal to `obj'?"
			external_name: "Equals"
		local
			a_clause: RENAME_CLAUSE
		do
			a_clause ?= obj
			if a_clause /= Void then
				Result := source_name.to_lower.equals_string (a_clause.source_name.to_lower) and target_name.to_lower.equals_string (a_clause.target_name.to_lower)
			end
		end

feature -- Status Setting
	
	set_target_name (a_target_name: like target_name) is
		indexing
			description: "Set `target_name' with `a_target_name'."
			external_name: "SetTargetName"
		require
			non_void_target_name: a_target_name /= Void
			not_empty_target_name: a_target_name.get_length > 0
		do
			target_name := a_target_name
		ensure
			target_name_set: target_name.equals_string (a_target_name)
		end
		
feature -- Basic Operations

	string_representation: STRING is
		indexing
			description: "Give a string representation of the inheritance clause."
			external_name: "StringRepresentation"
		do
			check
				non_void_target_name: target_name /= Void
				not_empty_target_name: target_name.get_length > 0
			end
			Result := source_name.concat_string_string_string_string (source_name, Space, As_keyword, Space)
			Result := Result.concat_string_string (Result, target_name)
		end
	
 end -- class RENAME_CLAUSE
 
