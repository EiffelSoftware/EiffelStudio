indexing
	description: "EiffelBuild predefined command for%
				% restoring a permanent window."
	status: "See notice at end of class"
	date: "$Date$"
	id: "$Id$"
	revision: "$Revision$"


class
	BUILD_RESTORE_CMD

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

	restore_label: STRING is "restore window"
			-- Text of label for Open transition

feature -- Execution

	execute is
			-- Set transition to `restore_label' and restore
			-- `argument1'.
		do
			set_transition_label (restore_label)
			argument1.top_shell.set_normal_state
		end

end -- class BUILD_RESTORE_CMD
