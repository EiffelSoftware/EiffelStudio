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
			make
		end

	EV_RADIO_IMP [EV_TOOL_BAR_RADIO_BUTTON]

create
	make

feature -- Initialization

	make is
			-- Create the tool-bar radio button.
		do
			{EV_TOOL_BAR_TOGGLE_BUTTON_IMP} Precursor
			enable_callbacks
		end


feature {NONE} -- Implementation

	cmd: EV_ROUTINE_COMMAND

	enable_callbacks is
		local
			ptr: POINTER
		do
			create cmd.make (~on_activate)
			add_command (widget, "radio_toggle", cmd, Void, c_gtk_integer_to_pointer (toggled_on_off_state))
		end
	
		
	on_activate (arg: EV_ARGUMENT; ev: EV_EVENT_DATA) is
			-- The button has been activated.
		do	if not reselected then

				if group /= Void then
					if  is_selected then
						group.set_last_selected(Current)
						group.set_selection_at_no_event (Current)
					else
						if group.just_selected (Current) then
							-- The button has been reselected
							reselected := True
							set_selected (True)
							-- This will make GTK recall the on_activate callback									
						end
					end
				end

			else
				reselected := False
			end	
		end

	reselected: BOOLEAN

	on_unselect (an_item: EV_RADIO_IMP [EV_ANY]) is
			-- Button's selected state set to flag.
		do
			if is_selected then
				set_selected(False)
			end	
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
