indexing
	description: "EiffelBuild predefined command for%
				% minimizing a permanent window."
	status: "See notice at end of class"
	date: "$Date$"
	id: "$Id$"
	revision: "$Revision$"

class
	BUILD_MINIMIZE_CMD

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

	minimize_label: STRING is "minimize window"
			-- Text of label for Open transition

feature -- Execution

	execute is
			-- Set transition to `minimize_label' and minimize
			-- `argument1'.
		do
			set_transition_label (minimize_label)
			argument1.top_shell.set_iconic_state
		end

end -- class BUILD_MINIMIZE_CMD
