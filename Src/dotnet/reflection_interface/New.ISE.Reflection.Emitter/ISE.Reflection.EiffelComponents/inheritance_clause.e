indexing
	description: "Representation of an inheritance clause"
--	attribute: create {CLASS_INTERFACE_ATTRIBUTE}.make_class_interface_attribute ((create {CLASS_INTERFACE_TYPE}).auto_dual) end

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
 		end

	eiffel_keyword: STRING is
		indexing
			description: "Eiffel keyword for inheritance clause"
		deferred		
		ensure
			non_void_eiffel_keyword: Result /= Void
			not_empty_eiffel_keyword: Result.count > 0
		end

feature -- Status Report

	is_equal (other: like Current): BOOLEAN is
		indexing
			description: "Is Current equals to `obj'?"
		local
			compare, comparer: STRING
		do
			compare := clone(other.source_name)
			compare.to_lower
			
			comparer := clone(other.source_name)
			comparer.to_lower
			
			Result := comparer.is_equal (compare)
		end
		
feature -- Status Setting

	set_source_name (a_source_name: like source_name) is
		indexing
			description: "Set `source_name' with `a_source_name'."
 		require
 			non_void_source_name: a_source_name /= Void
 			not_empty_source_name: a_source_name.count > 0
 		do
  			source_name := a_source_name
 		ensure
 			source_name_set: source_name.is_equal (a_source_name)
 		end
			
feature -- Basic Operations

	string_representation: STRING is
		indexing
			description: "Give a string representation of the inheritance clause."
		require
			non_void_source_name: source_name /= Void
		deferred
		ensure
			non_void_result: Result /= Void
			not_empty_result: Result.count > 0
		end
		
invariant
	source_name_not_void: source_name /= Void
	eiffel_keyword_not_void: eiffel_keyword /= Void

 end -- class INHERITANCE_CLAUSE
 
