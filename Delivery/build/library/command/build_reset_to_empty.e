indexing
	description: "EiffelBuild predefined command clearing a text field." 
	date: "$Date$"
	id: "$Id$"
	revision: "$Revision$"

class
	BUILD_RESET_TO_EMPTY

inherit

	BUILD_CMD

creation

	make

feature -- Initialization

	make (arg1: TEXT_FIELD) is
			-- Initialize command relative to `arg1'.
		do
			argument1 := arg1
		end

feature -- Access

	argument1: TEXT_FIELD
			-- The command's argument

	reset_label: STRING is "reset to empty"
			-- Text of label for reset transition

feature -- Execution

	execute is
			-- Set transition to `reset_label' and clear
			-- `argument1'.
		do
			set_transition_label (reset_label)
			argument1.clear
		end


end -- class BUILD_RESET_TO_EMPTY

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

