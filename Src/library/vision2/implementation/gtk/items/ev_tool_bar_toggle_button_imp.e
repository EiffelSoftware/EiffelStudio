indexing
	description:
		"EiffelVision toogle tool bar, implementation interface."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_TOOL_BAR_TOGGLE_BUTTON_IMP

inherit
	EV_TOOL_BAR_TOGGLE_BUTTON_I

	EV_TOOL_BAR_BUTTON_IMP

feature -- Status report

	is_selected: BOOLEAN is
			-- Is the current button selected?
		do
		end

feature -- Status setting

	set_selected (flag: BOOLEAN) is
			-- Select the current button if `flag', deselect it
			-- otherwise.
		do
		end

feature -- Event : command association

	add_unselect_command (cmd: EV_COMMAND; arg: EV_ARGUMENT) is
			-- Add `cmd' to the list of commands to be executed
			-- when the item is unselected.
		do
		end

feature -- Event -- removing command association

	remove_unselect_commands is
			-- Empty the list of commands to be executed when
			-- the item is unselected.
		do	
		end	

end -- class EV_TOOL_BAR_TOGGLE_BUTTON_IMP

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
