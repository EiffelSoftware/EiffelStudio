indexing
	description: "EiffelBuild predefined command resetting a scale."
	date: "$Date$"
	id: "$Id$"
	revision: "$Revision$"

class
	BUILD_RESET_TO_ZERO

inherit

	BUILD_CMD

creation

	make

feature -- Initialization

	make (arg1: SCALE) is
			-- Initialize command relative to `arg1'.
		do
			argument1 := arg1
		end

feature -- Access

	argument1: SCALE
			-- The command's argument

	reset_label: STRING is "reset scale"
			-- Text of label for reset transition

feature -- Execution

	execute is
			-- Set transition to `reset_label' and reset
			-- `argument1'.
		do
			set_transition_label (reset_label)
			argument1.set_value (0)
		end



end -- class BUILD_RESET_TO_ZERO

--|----------------------------------------------------------------
--| EiffelBuild library.
--| Copyright (C) 1995 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--|----------------------------------------------------------------

