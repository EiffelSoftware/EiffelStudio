indexing

	description: 
		"Information about a call in the calling stack.";
	date: "$Date$";
	revision: "$Revision $"

class CALL_STACK_ELEMENT

creation
	make

feature {NONE} -- Initialization

	make is
			-- Creation routine
		do
		end;

feature -- Properties

	routine_name: STRING is
			-- Associated routine name
		do
		end

	dynamic_class: CLASS_C is
			-- Dynamic class where routine is called from
		do
		end

	origin_class: CLASS_C is
			-- Class where routine is written in
		do
		end

	routine: E_FEATURE is
			-- Routine being called
		do
		end;

	object_address: STRING is
		do
		end

end -- class CALL_STACK_ELEMENT
