indexing

	description:
		"Delayed command to popup the label to tell the command name."
	date: "$Date$";
	revision: "$Revision$"

class DELAYED_FOCUS_COMMAND

inherit
	COMMAND

creation
	make

feature -- Initialization

	make (a_command: FOCUS_COMMAND) is
			-- Initialize Current with `parent_command' as `a_command'.
		require
			non_void_command: a_command /= Void
		do
			parent_command := a_command;
		ensure
			parent_command_set: parent_command = a_command;
		end;

feature -- Execution

	execute (arg: FOCUSABLE) is
		do
			if arg /= Void then
				parent_command.popup_label (arg);
			else
				parent_command.uninitialize_timer;
			end;
		end;

feature {NONE} -- Properties

	parent_command: FOCUS_COMMAND
			-- Parent of Current.

end -- class DELAYED_FOCUS_COMMAND
