indexing
	description:
		" EiffelVision tool-bar radio button, mswindows%
		% implementation."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_TOOL_BAR_RADIO_BUTTON_IMP

inherit
	EV_TOOL_BAR_RADIO_BUTTON_I

	EV_TOOL_BAR_TOGGLE_BUTTON_IMP
		redefine
			type,
			set_selected,
			on_activate
		end

	EV_RADIO_IMP [EV_TOOL_BAR_RADIO_BUTTON]

creation
	make

feature -- Status report

	type: INTEGER is
			-- Type of the button.
			-- See `add_button' of EV_TOOL_BAR_IMP for values
			-- explanation.
		do
			Result := 3
		end

	set_selected (flag: BOOLEAN) is
			-- Select the current button if `flag', deselect it
			-- otherwise.
		do
			{EV_TOOL_BAR_TOGGLE_BUTTON_IMP} Precursor (flag)
			if group /= Void then
				group.set_selection_at_no_event (Current)
			end
		end

feature {NONE} -- Implementation

	on_activate is
			-- The button has been activated.
		do
			{EV_TOOL_BAR_TOGGLE_BUTTON_IMP} Precursor
			if group /= Void then
				group.set_selection_at (Current)
			end
		end

	on_unselect is
			-- The button has been unselected.
		do
			execute_command (Cmd_item_deactivate, Void)
		end

end -- class EV_TOOL_BAR_RADIO_BUTTON_IMP

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
