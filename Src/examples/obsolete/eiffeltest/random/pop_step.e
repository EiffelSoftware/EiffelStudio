indexing
	description:
		"Pop operation on stack"
	legal: "See notice at end of class."

	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class POP_STEP inherit

	TEST_STEP
		redefine
			make
		end

	STACK_ACCESSOR [INTEGER]
		rename 
			make as accessor_make
		export
			{EVALUATOR} all
		undefine
			copy, is_equal
		end
		
create

	make

feature {NONE} -- Initialization

	make is
			-- Create step.
		do
			Precursor
			accessor_make (Current)
		end

feature -- Access

	Name: STRING is "POP"

feature -- Basic operations

	do_test is
			-- Do test action.
		do
			stack.remove
		end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"


end -- class POP_STEP

