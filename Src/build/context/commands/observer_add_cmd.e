indexing
	description: "Command executed when one adds an observer to a command.";
	date: "$Date$";
	revision: "$Revision$"

class
	ADD_OBSERVER_CMD

inherit
	OBSERVER_COMMAND
	SHARED_INSTANTIATOR

creation
	make

feature {NONE}

	command_work is
			-- Add `observer' to `observed_command'
		do
			observed_command.add_observer (observer)
		end

	undo is
			-- Undo `command_work'.
		do
			observed_command.remove_observer (observer)
		end

	c_name: STRING is
		do
			Result := command_names.Cmd_add_observer_cmd_name
		end

	action_symbol: STRING is "-"

end -- class ADD_OBSERVER_CMD
