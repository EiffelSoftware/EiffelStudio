indexing
	description: "Command executed when one adds an observer to a command.";
	date: "$Date$";
	revision: "$Revision$"

class
	ADD_OBSERVER_CMD

inherit
	OBSERVER_COMMAND

creation
	make

feature {NONE}

	command_work is
			-- Add `observer' to `observed_command'
		do
			observed_command.add_observer (observer)
			if command_tool /= Void and then command_tool.realized then
				command_tool.add_observed_command (observed_command)
			end
		end

	undo is
			-- Undo `command_work'.
		do
			observed_command.remove_observer (observer)
			if command_tool /= Void and then command_tool.realized then
				command_tool.remove_observed_command (observed_command)
			end
		end

	c_name: STRING is
		do
			Result := command_names.Cmd_add_observer_cmd_name
		end

	action_symbol: STRING is "-"

end -- class ADD_OBSERVER_CMD
