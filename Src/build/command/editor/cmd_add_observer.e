indexing
	description: "Command to add a new observer to a CMD_INSTANCE.";
	date: "$Date$";
	revision: "$Revision$"

class
	CMD_ADD_OBSERVER

inherit
	CMD_ADD
		redefine
			undo,
			command_work,
			element
		end

feature {NONE}

	element: CMD_INSTANCE

	c_name: STRING is
			-- Name of this command.
		do
			Result := Command_names.cmd_add_observer_cmd_name
		end

	list: EB_LINKED_LIST [CMD_INSTANCE] 


end -- class CMD_ADD_OBSERVER
