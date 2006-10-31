indexing
	description:
		"Evaluator to check if stack is empty"
	legal: "See notice at end of class."

	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class EMPTY_STACK_EVALUATOR inherit

	EVALUATOR
		rename
			is_true as empty
		redefine
			test_step
		end

feature -- Status report

	empty: BOOLEAN is
			-- Is stack empty?
		do
			Result := test_step.stack.empty
		end

feature {NONE} -- Implementation

	test_step: POP_STEP;
			-- Callback to test step

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


end -- class EMPTY_STACK_EVALUATOR

