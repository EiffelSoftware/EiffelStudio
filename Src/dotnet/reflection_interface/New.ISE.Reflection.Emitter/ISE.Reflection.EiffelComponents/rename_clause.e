indexing
	description: "Representation of a rename clause"
--	attribute: create {CLASS_INTERFACE_ATTRIBUTE}.make_class_interface_attribute ((create {CLASS_INTERFACE_TYPE}).auto_dual) end

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
		end

	eiffel_keyword: STRING is
		indexing
			description: "Eiffel keyword for inheritance clause"
		do
			Result := Rename_keyword
		end

	Rename_keyword: STRING is "rename"
		indexing
			description: "Rename keyword"
		end
		
	As_keyword: STRING is "as"
		indexing
			description: "As keyword"
		end

	Space: STRING is " "
		indexing
			description: "Space"
		end

	Empty_String: STRING is ""
		indexing
			description: "Empty string"
		end

feature -- Status Report

	is_equal (obj: like Current): BOOLEAN is
		indexing
			description: "Is Current equal to `obj'?"
		local
			compare, comparer: STRING
			clause_compare, target_comparer: STRING
			a_clause: RENAME_CLAUSE
		do
			a_clause ?= obj
			if a_clause /= Void then
				compare := clone(obj.source_name)
				compare.to_lower
				comparer := clone(obj.source_name)
				comparer.to_lower
				clause_compare := clone(a_clause.target_name)
				clause_compare.to_lower
				target_comparer := clone(target_name)
				target_comparer.to_lower

				Result := comparer.is_equal (compare) and target_comparer.is_equal (clause_compare)
			end
		end

feature -- Status Setting
	
	set_target_name (a_target_name: like target_name) is
		indexing
			description: "Set `target_name' with `a_target_name'."
		require
			non_void_target_name: a_target_name /= Void
			not_empty_target_name: a_target_name.count > 0
		do
			target_name := a_target_name
		ensure
			target_name_set: target_name.is_equal (a_target_name)
		end
		
feature -- Basic Operations

	string_representation: STRING is
		indexing
			description: "Give a string representation of the inheritance clause."
		do
			check
				non_void_target_name: target_name /= Void
				not_empty_target_name: target_name.count > 0
			end
			Result := Empty_String
			Result.append (source_name)
			Result.append (Space)
			Result.append (As_keyword)
			Result.append (Space)
			Result.append (target_name)
		end
	
 end -- class RENAME_CLAUSE
 
