indexing

	description: "Pulldown for option button implementation";
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

deferred class

	OPT_PULL_I 

inherit

	PULLDOWN_I
	
feature -- Access

	option_button: OPTION_B;
			-- option button which contains the pulldown

	selected_button: BUTTON is
		-- Current Push Button selected in the option menu
		deferred
		end;

	caption: STRING is
		deferred
		end;

feature -- Element change

   	set_selected_button (button: BUTTON) is
		-- Set `selected_button' to `button'
		deferred
		ensure
			same_button: button.same (selected_button)
		end;

	set_caption (a_caption: STRING) is
		deferred
		end;

	add_activate_action (a_command: COMMAND; argument: ANY) is
		do
		end;

	add_arm_action (a_command: COMMAND; argument: ANY) is
		do
		end;

	add_release_action (a_command: COMMAND; argument: ANY) is
		do
		end;

feature -- Removal

	remove_activate_action (a_command: COMMAND; argument: ANY) is
		do
		end;

	remove_arm_action (a_command: COMMAND; argument: ANY) is
		do
		end;

	remove_release_action (a_command: COMMAND; argument: ANY) is
		do
		end;

end -- class OPT_PULL_I



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

