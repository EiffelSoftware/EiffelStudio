indexing
	description: "Transportable entity."
	date: "$Date$"
	revision: "$Revision $"

class
	STONE_TYPES

feature -- Access

	Any_type: INTEGER is 1
	System_type: INTEGER is 2
	Class_type: INTEGER is 3
	Dynamic_lib_type: INTEGER is 12
	Routine_type: INTEGER is 4
	Object_type: INTEGER is 5
	Explain_type: INTEGER is 6
	Triangle_type: INTEGER is 7
	Custom_type: INTEGER is 8
	Shell_type: INTEGER is 9
	Breakable_type: INTEGER is 10
	Call_stack_type: INTEGER is 11

end -- class STONE_TYPES
