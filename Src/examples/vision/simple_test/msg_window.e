indexing
	legal: "See notice at end of class."
	status: "See notice at end of class."
class MSG_WINDOW

inherit


	MESSAGE_D
		rename
			make as message_d_make
		end;

	COMMAND

create

	make

feature

	make (a_name: STRING; a_parent: COMPOSITE) is
			-- Create interface.
		do
			message_d_make (a_name, a_parent);
			set_values;
			set_callbacks
		end;

	set_values is
			-- Set values (resources).
		do
			hide_cancel_button;
			hide_help_button;
			set_message ("This is a message");
		end;

	set_callbacks is
			-- Associate a command (in this
			-- case Current) with the OK button.
		local
			Nothing: ANY
		do
			add_ok_action (Current, Nothing);
		end;

	execute (argument: ANY) is
			-- Action: popdown the window
		do
			popdown
		end;

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


end

