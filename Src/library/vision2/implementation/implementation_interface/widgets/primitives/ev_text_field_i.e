indexing

	description: 
		"EiffelVision text field, implementation interface."
	status: "See notice at end of class"
	id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"
	
deferred class
	
	EV_TEXT_FIELD_I
	
inherit
	
	EV_TEXT_COMPONENT_I

	EV_BAR_ITEM_I
		undefine
			build
		end
	
feature -- Event - command association

	add_activate_command (cmd: EV_COMMAND; arg: EV_ARGUMENTS) is
			-- Add 'cmd' to the list of commands to be executed 
			-- when the text field is activated, ie when the user
			-- press the enter key.
		require
			exists: not destroyed
			valid_command: cmd /= Void
		deferred
		end
	
end --class EV_TEXT_FIELD_I


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
