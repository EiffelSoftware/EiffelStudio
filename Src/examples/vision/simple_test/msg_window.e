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

--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support: http://support.eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

