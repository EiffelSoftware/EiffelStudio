--| FIXME Not for release
--| FIXME NOT_REVIEWED this file has not been reviewed
indexing
	description:
		"EiffelVision toogle tool bar, mswindows implementation."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_TOOL_BAR_TOGGLE_BUTTON_IMP

inherit
	EV_TOOL_BAR_TOGGLE_BUTTON_I
		redefine
			parent_imp
		select
			interface
		end

	EV_TOOL_BAR_BUTTON_IMP
		rename
			interface as ev_tool_bar_button_imp_interface
		redefine
			type,
			on_activate,
			parent_imp
		end

creation
	make

feature --  Access
	
	parent_imp: EV_TOOL_BAR_IMP
		-- The implementation of the parent.

feature -- Status report

	type: INTEGER is
			-- Type of the button.
			-- See `add_button' of EV_TOOL_BAR_IMP for values
			-- explanation.
		do
			Result := 2
		end

	is_selected: BOOLEAN is
			-- Is the current button selected?
		do
			Result := parent_imp.button_checked (id)
		end

feature -- Status setting

	set_selected (flag: BOOLEAN) is
			-- Select the current button if `flag', deselect it
			-- otherwise.
		do
			if flag then
				parent_imp.check_button (id)
			else
				parent_imp.uncheck_button (id)
			end
		end

feature -- Event : command association

	add_unselect_command (cmd: EV_COMMAND; arg: EV_ARGUMENT) is
			-- Add `cmd' to the list of commands to be executed
			-- when the item is unselected.
		do
			add_command (Cmd_item_deactivate, cmd, arg)		
		end

	add_toggle_command (cmd: EV_COMMAND; arg: EV_ARGUMENT) is
			-- Add `cmd' to the list of commands to be executed
			-- when the item is toggled.
		do
			add_command (Cmd_item_toggle, cmd, arg)
		end
	

feature -- Event -- removing command association

	remove_unselect_commands is
			-- Empty the list of commands to be executed when
			-- the item is unselected.
		do
			remove_command (Cmd_item_deactivate)		
		end

	remove_toggle_commands is
			-- Add `cmd' to the list of commands to be executed
			-- when the item is toggled.
		do
			remove_command (Cmd_item_toggle)
		end

feature {EV_TOOL_BAR_IMP} -- Implementation

	on_activate is
			-- Is called by the menu when the item is activated.
		do
			if is_selected then
				--|FIXME Need to use the new events.
				--execute_command (Cmd_item_activate, Void)
			else
				--execute_command (Cmd_item_deactivate, Void)
			end
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

--|-----------------------------------------------------------------------------
--| CVS log
--|-----------------------------------------------------------------------------
--|
--| $Log$
--| Revision 1.6  2000/02/14 11:40:39  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.5.4.4  2000/01/27 19:30:09  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.5.4.3  2000/01/27 01:08:17  rogers
--| Commented out the old event execution and added a FIXME.
--|
--| Revision 1.5.4.2  2000/01/21 20:28:07  rogers
--| selected interface from EV_TOOL_BAR_TOGGLE_BUTTON_I and renamed interface from EV_TOOL_BAR_BUTTON_IMP to ev_tool_bar_button_imp_interface.
--|
--| Revision 1.5.4.1  1999/11/24 17:30:17  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.4.2.2  1999/11/02 17:20:07  oconnor
--| Added CVS log, redoing creation sequence
--|
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
