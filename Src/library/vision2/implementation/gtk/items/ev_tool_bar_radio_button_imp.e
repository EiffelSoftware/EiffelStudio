--| FIXME NOT_REVIEWED this file has not been reviewed
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
			interface
		end

	EV_TOOL_BAR_TOGGLE_BUTTON_IMP
		redefine
			interface,
			make,
			connect_signals
		end

	EV_RADIO [EV_TOOL_BAR_RADIO_BUTTON]

create
	make

feature -- Initialization

	make (an_interface: like interface) is
			-- Create the tool-bar radio button.
		do
			{EV_TOOL_BAR_TOGGLE_BUTTON_IMP} Precursor (an_interface)
		end


feature {NONE} -- Implementation

	connect_signals is
			-- Connect on_activate to toggled signal
		do
			signal_connect ("toggled", ~on_activate)
		end
		
	on_activate is
			-- The button has been activated by the user (pushed).
		do		
			if group /= Void then
				if  is_selected then
						-- The radio button has been depressed.
					if not group.just_selected (Current) then
						interface.press_actions.call ([])
					end
					group.set_last_selected(Current)
					group.set_selection_at_no_event (Current)
				else
						-- The radio button has been deselected.
					if group.just_selected (Current) then
						-- The button has been reselected
						set_selected (True)
						-- This will make GTK recall the on_activate callback									
					end
				end
			end
		end

	on_unselect (an_item: EV_RADIO [EV_TOOL_BAR_RADIO_BUTTON]) is
			-- Button's selected state set to flag.
		do
			if is_selected and not group.just_selected (Current) then
				set_selected(False)
			end	
		end

feature {EV_ANY_I} -- Implementation

	interface: EV_TOOL_BAR_RADIO_BUTTON

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

--|-----------------------------------------------------------------------------
--| CVS log
--|-----------------------------------------------------------------------------
--|
--| $Log$
--| Revision 1.9  2000/02/14 13:48:37  oconnor
--| release
--|
--| Revision 1.8  2000/02/14 11:40:27  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.7.4.4  2000/02/02 00:42:06  king
--| Removed parent_imp as it is correctly implemented higher up in ev_item_imp
--|
--| Revision 1.7.4.3  2000/02/01 20:04:11  king
--| Implemented radio button to fit in with new structure
--|
--| Revision 1.7.4.2  2000/01/27 19:29:26  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.7.4.1  1999/11/24 17:29:43  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.5.2.2  1999/11/02 17:20:02  oconnor
--| Added CVS log, redoing creation sequence
--|
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
