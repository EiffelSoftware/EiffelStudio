indexing
	description:
		"[
			Objects that provide access to widgets in their default state.
		]"
	date: "$Date$"
	revision: "$Revision$"

class
	DEFAULT_OBJECT_STATE_CHECKER

inherit
	INTERNAL
	
	EV_ANY_HANDLER

feature -- Access

	default_object_by_type (a_type: STRING): EV_ANY is
			-- `Result' as a Vision2 object correesponding to `a_type'.
		require
			a_type_not_void: a_type /= Void
		do
			if all_objects.has (a_type) then
					-- Retrieve an already created object.
				Result := all_objects @ (a_type)
			else
					-- Create the object and store it for later queries.
				Result ?= new_instance_of (dynamic_type_from_string (a_type))
				Result.default_create
				all_objects.put (Result, a_type)
			end
		ensure
			result_not_void: Result /= Void
		end
		
feature {NONE} -- Implementation

	all_objects: HASH_TABLE [EV_ANY, STRING] is
			-- All objects that have been already queried by `Current'.
		once
			create Result.make (20)
		ensure
			Result_not_void: Result /= Void
		end

end -- class DEFAULT_OBJECT_STATE_CHECKER
