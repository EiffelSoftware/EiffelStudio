indexing

	description: "Delayed command to popup the label for focusables."
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class DELAYED_FOCUS_COMMAND

inherit
	COMMAND

create
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

	parent_command: FOCUS_COMMAND;
			-- Parent of Current.

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class DELAYED_FOCUS_COMMAND

