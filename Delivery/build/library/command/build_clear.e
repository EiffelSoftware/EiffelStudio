indexing
	description: "EiffelBuild predefined command clearing a drawing box."
	date: "$Date$"
	id: "$Id$"
	revision: "$Revision$"

class
	BUILD_CLEAR

inherit

	BUILD_CMD

creation

	make

feature -- Initialization

	make (arg1: DRAWING_BOX) is
			-- Initialize command relative to `arg1'.
		do
			argument1 := arg1
		end

feature -- Access

	argument1: DRAWING_BOX
			-- The command's argument

	clear_label: STRING is "clear"
			-- Text of label for clear transition

feature -- Execution

	execute is
			-- Set transition to `clear_label' and clear
			-- `argument1'.
		do
			set_transition_label (clear_label)
			argument1.clear
		end


end -- class BUILD_CLEAR

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

