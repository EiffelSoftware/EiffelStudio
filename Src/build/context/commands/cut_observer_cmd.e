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
			if command_tool /= Void and then command_tool.realized then
				command_tool.remove_observed_command (observed_command)
			end
		end

	undo is
			-- Undo `command_work'.
		do
			observed_command.add_observer (observer)
			if command_tool /= Void and then command_tool.realized then
				command_tool.add_observed_command (observed_command)
			end
		end

	c_name: STRING is
		do
			Result := command_names.Cmd_remove_observer_cmd_name
		end
	
	action_symbol: STRING is "/"

end -- class CUT_OBSERVER_CMD
