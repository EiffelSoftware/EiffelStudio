indexing
	description: "Transportable entity."
	date: "$Date$"
	revision: "$Revision $"

class
	STONE_TYPES

feature -- Access

--	Any_type: INTEGER is 1

	System_type, Class_type, Feature_type,
	Object_type, Explain_type, Triangle_type,
	Custom_type, Shell_type, Breakable_type,
	Call_stack_type, Dynamic_lib_type: INTEGER is unique

end -- class STONE_TYPES
