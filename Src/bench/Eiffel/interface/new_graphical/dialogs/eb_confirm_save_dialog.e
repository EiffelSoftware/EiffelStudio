indexing
	description: "Dialog for confirming a save action"
	date: "$Date$"
	revision: "$Revision$"

class
	EB_CONFIRM_SAVE_DIALOG

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

	make_and_launch (ed: like tool; a_caller: EB_CONFIRM_SAVE_CALLBACK) is
			-- Initialize and popup the dialog
		do
			init_command (ed)
			caller := a_caller
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

	caller: EB_CONFIRM_SAVE_CALLBACK
		-- object whose `process' feature will be executed on success

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
				caller.process
			end
			destroy
		end

end -- class EB_CONFIRM_SAVE_DIALOG
