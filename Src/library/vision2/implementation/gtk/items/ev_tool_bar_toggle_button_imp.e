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
		redefine
			parent_imp
		end

	EV_TOOL_BAR_BUTTON_IMP
		redefine
			make,
			remove_select_commands,
			add_select_command,
			parent_imp
		end

create
	make

feature -- Initialization

	make is
		-- Create the tool-bar toggle button
		do
			widget := gtk_toggle_button_new
			gtk_object_ref (widget)
			-- Create the box (for caption and pixmap)
			initialize
		end

feature -- Status report

	parent_imp: EV_TOOL_BAR_IMP

	is_selected: BOOLEAN is
			-- Is the current button selected?
		do
			Result := c_gtk_toggle_button_active (widget)
		end

feature -- Status setting

	set_selected (flag: BOOLEAN) is
			-- Select the current button if `flag', deselect it
			-- otherwise.
		do
			gtk_toggle_button_set_active (widget, flag)
		end

feature -- Event : command association

	add_toggle_command (cmd: EV_COMMAND; arg: EV_ARGUMENT) is
			-- Add `cmd' to the list of commands to be executed
			-- when the item is `toggled'.
		do
			add_command (widget, "toggled_on_off", cmd, arg, c_gtk_integer_to_pointer (toggled_on_off_state))
		end

	add_select_command (cmd: EV_COMMAND; arg: EV_ARGUMENT) is
			-- Add 'cmd' to the list of commands to be executed
			-- when the item is `selected'.
		do
			add_command (widget, "toggled_on", cmd, arg, c_gtk_integer_to_pointer (toggled_on_state))
		end

	add_unselect_command (cmd: EV_COMMAND; arg: EV_ARGUMENT) is
			-- Add `cmd' to the list of commands to be executed
			-- when the item is `unselected'.
		do
			add_command (widget, "toggled_off", cmd, arg, c_gtk_integer_to_pointer (toggled_off_state))
		end

	-- State id's for tool bar toggle button states

	toggled_on_off_state: INTEGER is 1
	toggled_on_state: INTEGER is 2
	toggled_off_state: INTEGER is 3


feature -- Event -- removing command association

	remove_toggle_commands is
			-- Empty the list of commands to be executed when
			-- the item is `toggled'.
		do	
			remove_commands (widget, toggled_on_off_id)
		end

	remove_select_commands is
			-- Empty the list of commands to be executed when
			-- the item is `selected'.
		do	
			remove_commands (widget, toggled_on_id)
		end

	remove_unselect_commands is
			-- Empty the list of commands to be executed when
			-- the item is `unselected'.
		do	
			remove_commands (widget, toggled_off_id)
		end	

end -- class EV_TOOL_BAR_TOGGLE_BUTTON_IMP

--!----------------------------------------------------------------
--! EiffelVision2: library of reusable components for ISE Eiffel.
--! Copyright (C) 1986-1999 Interactive Software Engineering Inc.
--! All rights reserved. Duplication and distribution prohibited.
--! May be used only with ISE Eiffel, under terms of user license. 
--! Contact ISE for any other use.
--!
--! Interactive Software Engineering Inc.
--! ISE Building, 2nd floor
--! 270 Storke Road, Goleta, CA 93117 USA
--! Telephone 805-685-1006, Fax 805-685-6869
--! Electronic mail <info@eiffel.com>
--! Customer support e-mail <support@eiffel.com>
--! For latest info see award-winning pages: http://www.eiffel.com
--!----------------------------------------------------------------
