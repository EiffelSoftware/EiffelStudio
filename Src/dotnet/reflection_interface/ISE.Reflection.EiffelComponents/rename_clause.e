indexing
	description: "Representation of a rename clause"
	external_name: "ISE.Reflection.RenameClause"
	attribute: create {SYSTEM_RUNTIME_INTEROPSERVICES_CLASSINTERFACEATTRIBUTE}.make_classinterfaceattribute ((create {SYSTEM_RUNTIME_INTEROPSERVICES_CLASSINTERFACETYPE}).auto_dual) end

class
	RENAME_CLAUSE
	
inherit
 	INHERITANCE_CLAUSE
 
create
 	make,
 	make_from_info
 
feature {NONE} -- Implementation

 	make_from_info (a_source_name: like source_name; a_target_name: like target_name) is 
 		indexing
 			description: "[
 						Set `source_name' with `a_source_name'.
 						Set `target_name' with `a_target_name'.
 					  ]"
 			external_name: "MakeFromInfo"
 		require
 			non_void_source_name: a_source_name /= Void
 			not_empty_source_name: a_source_name.get_length > 0		
 	 		non_void_target_name: a_target_name /= Void
 			not_empty_target_name: a_target_name.get_length > 0		
 		do
 			set_source_name (a_source_name)
 			set_target_name (a_target_name)
 		ensure
 			source_name_set: source_name.equals_string (a_source_name)
 			target_name_set: target_name.equals_string (a_target_name)
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
 
