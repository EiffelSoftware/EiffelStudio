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
		export
			{NONE} all
			{GB_OBJECT_EDITOR} default_create
		end
	
	EV_ANY_HANDLER
		export
			{NONE} all
		end

feature -- Access

	default_object_by_type (a_type: STRING): EV_ANY is
			-- `Result' as a Vision2 object correesponding to `a_type'.
		require
			a_type_not_void: a_type /= Void
		local
			suceeded: BOOLEAN
		do
			if all_objects.has (a_type) then
					-- Retrieve an already created object.
				Result := all_objects @ (a_type)
			else
				suceeded := (create {ISE_RUNTIME}).check_assert (False)
					-- Create the object and store it for later queries.
				Result ?= new_instance_of (dynamic_type_from_string (a_type))
				Result.default_create
				suceeded := (create {ISE_RUNTIME}).check_assert (True)
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
