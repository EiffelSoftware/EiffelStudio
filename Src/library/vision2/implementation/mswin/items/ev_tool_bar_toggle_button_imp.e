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

	EV_TOOL_BAR_BUTTON_IMP
		redefine
			type,
			on_activate
		end

creation
	make

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
			Result := parent_imp.toolbar.button_checked (id)
		end

feature -- Status setting

	set_selected (flag: BOOLEAN) is
			-- Select the current button if `flag', deselect it
			-- otherwise.
		do
			if flag then
				parent_imp.toolbar.check_button (id)
			else
				parent_imp.toolbar.uncheck_button (id)
			end
		end

feature -- Event : command association

	add_unselect_command (cmd: EV_COMMAND; arg: EV_ARGUMENT) is
			-- Add `cmd' to the list of commands to be executed
			-- when the item is unselected.
		do
			add_command (Cmd_item_deactivate, cmd, arg)		
		end

feature -- Event -- removing command association

	remove_unselect_commands is
			-- Empty the list of commands to be executed when
			-- the item is unselected.
		do
			remove_command (Cmd_item_deactivate)		
		end

feature {EV_TOOL_BAR_IMP} -- Implementation

	on_activate is
			-- Is called by the menu when the item is activated.
		do
			if is_selected then
				execute_command (Cmd_item_activate, Void)
			else
				execute_command (Cmd_item_deactivate, Void)
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
