indexing
	description:
		"Pop operation on stack"

	status:	"See note at end of class"
	author: "Patrick Schoenbach"
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

end -- class POP_STEP

--|----------------------------------------------------------------
--| EiffelTest: Reusable components for developing unit tests.
--| Copyright (C) 2000 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------
