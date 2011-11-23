note
	description:
		"Push operation on stack"
	legal: "See notice at end of class."

	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class PUSH_STEP inherit

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

create {PUSH_STEP}
	list_make

feature {NONE} -- Initialization

	make
			-- Create step.
		do
			Precursor
			accessor_make (Current)
		end

	new_filled_list (n: INTEGER): like Current
		do
			create Result.list_make (n)
		end

feature -- Access

	Name: STRING = "PUSH"

feature -- Basic operations

	do_test
			-- Do test action.
		do
			stack.put (1)
		end

note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"


end -- class PUSH_STEP

