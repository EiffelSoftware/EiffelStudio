indexing
	description: "Command executed when one removes an observer %
				% from a command."
	id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"

class
	CUT_OBSERVER_CMD

inherit
	OBSERVER_COMMAND

creation
	make

feature {NONE}

	command_work is
			-- Remove `observer' from `observed_command'
		do
			observed_command.remove_observer (observer)
		end

	undo is
			-- Undo `command_work'.
		do
			observed_command.add_observer (observer)
		end

	c_name: STRING is
		do
			Result := command_names.Cmd_remove_observer_cmd_name
		end
	
	action_symbol: STRING is "/"

end -- class CUT_OBSERVER_CMD
