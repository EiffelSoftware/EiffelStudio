indexing

	description: 
		"EiffelVision button, gtk implementation.";
	status: "See notice at end of class";
	id: "$id: $";
	date: "$Date$";
	revision: "$Revision$"
	
deferred class
	
	BUTTON_IMP
	
inherit
	BUTTON_I
	
	COMPOSITE_IMP -- In gtk, button can be a container
	PRIMITIVE_IMP
		undefine
			show, hide, realize, unrealize -- We are using the features from COMPOSITE_IMP
		end
	
	FONTABLE_IMP


feature -- Element change

	add_activate_action (a_command: COMMAND; argument: ANY) is
			-- Add `a_command' to the list of action to
			-- execute when current push button is
			-- activated.
		deferred
		end;

	add_arm_action (a_command: COMMAND; argument: ANY) is
			-- Add `a_command' to the list of action to
			-- execute when current push button is armed.
		do
			check
				not_be_called: False
			end
		end;

	add_release_action (a_command: COMMAND; argument: ANY) is
			-- Add `a_command' to the list of action to
			-- execute when current push button is
			-- released.
		do
			check
				not_be_called: False
			end
		end;

feature -- Removal

	remove_activate_action (a_command: COMMAND; argument: ANY) is
			-- Remove `a_command' from the list of action
			-- to execute when current push button is
			-- activated.
		deferred
		end;

	remove_arm_action (a_command: COMMAND; argument: ANY) is
			-- Remove `a_command' from the list of action
			-- to execute when current push button is
			-- armed.
		do
			check
				not_be_called: False
			end
		end;

	remove_release_action (a_command: COMMAND; argument: ANY) is
			-- Remove `a_command' from the list of action
			-- to execute when current push button is
			-- released.
		do
			check
				not_be_called: False
			end
		end;

end -- class BUTTON_I



--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-1998 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------
