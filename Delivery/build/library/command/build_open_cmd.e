indexing
	description: "EiffelBuild predefined command for%
				% opening a permanent window."
	status: "See notice at end of class"
	date: "$Date$"
	id: "$Id$"
	revision: "$Revision$"

class

	BUILD_OPEN_CMD

inherit

	BUILD_CMD

creation

	make

feature -- Initialization

	make (arg1: PERM_WIND) is
			-- Initialize command relative to `arg1'.
		do
			argument1 := arg1
		end

feature -- Access

	argument1: PERM_WIND
			-- The command's argument

	open_label: STRING is "open window"
			-- Text of label for Open transition

feature -- Execution

	execute is
			-- Set transition to `open_label' and open
			-- `argument1'.
		do
			set_transition_label (open_label)
			if not argument1.realized then
				argument1.realize
			else
				argument1.show
			end
			argument1.raise
		end


end -- class BUILD_OPEN_CMD

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

