indexing
	description: "Dialog for confirming a save action"
	date: "$Date$"
	revision: "$Revision$"

class
	EB_CONFIRM_SAVE_DIALOG

-- Warning: All the clients of this class have a bug.
-- If they are called twice, the confirmer is not called.

inherit
	EV_WARNING_DIALOG

	EB_EDITOR_COMMAND
		rename
			make as init_command
		end

	NEW_EB_CONSTANTS

creation
	make_and_launch

feature {NONE} -- Initialization

	make_and_launch (ed: EB_EDITOR; cmd: EV_COMMAND; arg: EV_ARGUMENT) is
			-- Initialize and popup the dialog
			-- (number of arguments can be reduced from 3 to 2,
			-- if all callers are made EB_EDITOR_COMMAND)
		do
			init_command (ed)
			command := cmd
			argument := arg
			make_with_text (ed.parent, Interface_names.t_Warning, Warning_messages.w_File_changed)
			show_yes_no_cancel_buttons
			add_yes_command (Current, Ok_to_save)
			add_no_command (Current, Do_not_save)
			add_cancel_command (Current, Void)
			show
		ensure
			postcondition_clause: -- Your postcondition here
		end

feature -- Access

	command: EV_COMMAND
		-- command to be executed on success

	argument: EV_ARGUMENT
		-- argument to be passed to the command

feature {NONE} -- Constants

	Ok_to_save : EV_ARGUMENT1 [ANY] is
		once
			create Result.make (Void)
		end

	Do_not_save : EV_ARGUMENT1 [ANY] is
		once
			create Result.make (Void)
		end

feature -- Execution

	execute (arg: EV_ARGUMENT1 [ANY]; data: EV_EVENT_DATA) is
		do
			if arg /= Void then
				if arg = Ok_to_save then
					tool.save_text
				end
				command.execute (argument, Void)
			end
			destroy
		end

end -- class EB_CONFIRM_SAVE_DIALOG
