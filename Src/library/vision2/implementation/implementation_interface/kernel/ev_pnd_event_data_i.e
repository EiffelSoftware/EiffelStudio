--| FIXME Not for release
--| FIXME NOT_REVIEWED this file has not been reviewed
indexing
	description: "EiffelVision pick and drop event data, implementation interface."
	status: "See notice at end of class";
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_PND_EVENT_DATA_I

inherit
	EV_BUTTON_EVENT_DATA_I

feature -- Access	
	
	data: ANY
			-- Transported data

	target: EV_PICK_AND_DROPABLE
			-- Target Widget of the Pick And Drop event.

feature -- Element change
	
	set_data (value: like data) is
			-- Make `value' the new data.
		do
			data := value
		end

	set_target (targ: EV_PICK_AND_DROPABLE) is
			-- Make `targ' the target of the PND action.
		do
			target := targ
		end

	set_absolute_x (value: INTEGER) is
			-- Make `value' the absolute x coordinate
		deferred
		end

	set_absolute_y (value: INTEGER) is
			-- Make `value' the absolute y coordinate
		deferred
		end


end -- class EV_PND_EVENT_DATA_I

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
--| Revision 1.7  2000/02/14 11:40:34  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.4.4.2.2.4  2000/01/27 19:29:55  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.4.4.2.2.3  1999/12/17 18:47:06  rogers
--| EV_PICK_AND_DROPABLE replaces EV_PND_TARGET.
--|
--| Revision 1.4.4.2.2.2  1999/12/09 01:28:20  oconnor
--| king: removed feature source
--|
--| Revision 1.4.4.2.2.1  1999/11/24 17:30:05  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.4.2.2  1999/11/02 17:20:05  oconnor
--| Added CVS log, redoing creation sequence
--|
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
