indexing
	description: "Actions."
	date: "$Date$"
	revision: "$Revision$"

class
	CONF_ACTION

inherit
	CONF_CONDITIONED

create
	make

feature {NONE} -- Initialization

	make (a_command: STRING) is
			-- Create with `a_command'.
		require
			a_command_ok: a_command /= Void and then not a_command.is_empty
		do
			command := a_command
		ensure
			command_set: command = a_command
		end


feature -- Access, stored in configuration file

	command: STRING
			-- The command to execute.

	description: STRING
			-- A description about the command.

feature {CONF_ACCESS} -- Update, stored in configuration file

	set_command (a_command: like command) is
			-- Set `command' to `a_command'.
		require
			a_command_ok: a_command /= Void and then not a_command.is_empty
		do
			command := a_command
		ensure
			command_set: command = a_command
		end

	set_description (a_description: like description) is
			-- Set `description' to `a_description'.
		do
			description := a_description
		ensure
			description_set: description = a_description
		end

invariant
	command_ok: command /= Void and then not command.is_empty

end
