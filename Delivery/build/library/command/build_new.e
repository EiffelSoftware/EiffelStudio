indexing
	description: "EiffelBuild predefined command clearing a scrolled text"
	date: "$Date$"
	id: "$Id$"
	revision: "$Revision$"

class
	BUILD_NEW

inherit

	BUILD_CMD

creation

	make

feature -- Initialization

	make (arg1: SCROLLED_T) is
			-- Initialize command relative to `arg1'.
		do
			argument1 := arg1
		end

feature -- Access

	argument1: SCROLLED_T
			-- The command's argument

	new_label: STRING is "new file"
			-- Text of label for new file transition

feature -- Execution

	execute is
			-- Set transition to `new_label' and clear
			-- `argument1'.
		do
			set_transition_label (new_label)
			argument1.clear
		end

end -- class BUILD_NEW

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
