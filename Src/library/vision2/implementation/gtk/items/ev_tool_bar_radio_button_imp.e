indexing
	description:
		" EiffelVision tool-bar radio button. implementation%
		% interface."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_TOOL_BAR_RADIO_BUTTON_IMP

inherit
	EV_TOOL_BAR_RADIO_BUTTON_I
		redefine
			parent_imp
		end

	EV_TOOL_BAR_TOGGLE_BUTTON_IMP
		redefine
			parent_imp,
			set_selected,
			remove_select_commands,
			make
		end

	EV_RADIO_IMP [EV_TOOL_BAR_RADIO_BUTTON]

create
	make

feature -- Initialization

	make is
			-- Create the tool-bar radio button
		local
			cmd: EV_ROUTINE_COMMAND
		do
			{EV_TOOL_BAR_TOGGLE_BUTTON_IMP} Precursor
			-- Add selected event to event list
			remove_select_commands
		end

	set_selected (flag: BOOLEAN) is
			-- Set the selection to the state of `flag'
		do
			{EV_TOOL_BAR_TOGGLE_BUTTON_IMP} Precursor (flag)
			if group /= Void then
				group.set_selection_at_no_event (Current)
			end
		end

feature {NONE} -- Implementation

	remove_select_commands is
			-- Empty the list of commands to be executed
			-- whilst retaining the on_activate command
		local
			cmd: EV_ROUTINE_COMMAND
		do
			remove_commands (widget, toggled_on_id)
			create cmd.make(~on_activate)
			add_select_command(cmd, Void)
		end

	on_activate (arg: EV_ARGUMENT; ev: EV_EVENT_DATA) is
			-- The button has been activated.
		do
			if group /= Void then
				group.set_selection_at_no_event (Current)
			end
		end

	on_unselect is
			-- called when the button is to be unselected
		do
			gtk_toggle_button_set_active (widget, False)
		end

feature -- Access

	parent_imp: EV_TOOL_BAR_IMP

end -- class EV_TOOL_BAR_RADIO_BUTTON_IMP

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
