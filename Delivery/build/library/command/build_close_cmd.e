indexing
	description: "EiffelBuild predefined command for%
				% closing a permanent window."
	status: "See notice at end of class"
	date: "$Date$"
	id: "$Id$"
	revision: "$Revision$"

class
	BUILD_CLOSE_CMD

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

	close_label: STRING is "close window"
			-- Text of label for Close transition

feature -- Execution

	execute is
			-- Set transition to `close_label' and close
			-- `argument1'.
		do
			set_transition_label (close_label)
			argument1.hide
		end

end -- class BUILD_CLOSE_CMD

--|----------------------------------------------------------------
--| eiffelbuild library.
--| copyright (c) 1995 interactive software engineering inc.
--| all rights reserved. duplication and distribution prohibited.
--|
--| 270 storke road, suite 7, goleta, ca 93117 usa
--| telephone 805-685-1006
--| fax 805-685-6869
--| electronic mail <info@eiffel.com>
--| customer support e-mail <support@eiffel.com>
--|----------------------------------------------------------------

