class MSG_WINDOW

inherit


	MESSAGE_D
		rename
			make as message_d_make
		end;

	COMMAND

creation

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

end
